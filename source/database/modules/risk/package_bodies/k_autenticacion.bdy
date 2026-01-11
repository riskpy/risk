create or replace package body k_autenticacion is

  function f_registrar_usuario(i_alias            in varchar2,
                               i_clave            in varchar2,
                               i_nombre           in varchar2,
                               i_apellido         in varchar2,
                               i_direccion_correo in varchar2,
                               i_numero_telefono  in varchar2 default null,
                               i_origen           in varchar2 default null,
                               i_id_externo       in varchar2 default null)
    return varchar2 is
    l_id_persona          t_personas.id_persona%type;
    l_id_usuario          t_usuarios.id_usuario%type;
    l_alias               t_usuarios.alias%type := i_alias;
    l_confirmacion_activa varchar2(1);
    l_estado_usuario      t_usuarios.estado%type;
    l_body                clob;
    l_plantilla           varchar2(20) := 'PLANTILLA_DEMO';
    l_datos_extra         json_object_t := new json_object_t;
    l_origen              t_usuarios.origen%type;
  begin
    l_origen := nvl(i_origen, c_origen_risk);
  
    -- Valida que no exista el usuario externo
    if l_origen <> c_origen_risk then
      if k_usuario.f_existe_usuario_externo(l_origen, i_id_externo) then
        raise k_usuario.ex_usuario_existente;
      end if;
    
      l_alias := translate(l_alias,
                           'áéíóúàèìòùäëïöüñÁÉÍÓÚÝÄËÏÖÜÀÈÌÒÙÑ'' ',
                           'aeiouaeiouaeiounAEIOUYAEIOUAEIOUN__');
    
      select l_alias ||
             to_char(max(to_number(nvl(regexp_substr(a.alias, '\d+'), '0'))) + 1) alias
        into l_alias
        from t_usuarios a
       where (upper(a.alias) = upper(l_alias) or
             regexp_like(a.alias, '(' || l_alias || ')\d+', 'i'));
    end if;
  
    -- Valida políticas
    if l_origen = c_origen_risk then
      k_clave.p_validar_politicas(l_alias, i_clave, k_clave.c_clave_acceso);
    end if;
  
    -- Inserta persona
    insert into t_personas
      (nombre,
       apellido,
       nombre_completo,
       tipo_persona,
       tipo_documento,
       numero_documento,
       id_pais,
       fecha_nacimiento,
       id_externo_1,
       id_externo_2)
    values
      (i_nombre,
       i_apellido,
       i_nombre || ' ' || i_apellido,
       'F',
       null,
       null,
       null,
       null,
       i_id_externo,
       null)
    returning id_persona into l_id_persona;
  
    l_confirmacion_activa := case l_origen
                               when c_origen_risk then
                                nvl(k_util.f_valor_parametro('CONFIRMACION_DIRECCION_CORREO'),
                                    'N')
                               else
                                'N'
                             end;
    l_estado_usuario      := case l_confirmacion_activa
                               when 'S' then
                                'P' -- PENDIENTE DE ACTIVACIÓN
                               else
                                'A' -- ACTIVO
                             end;
  
    -- Inserta usuario
    insert into t_usuarios
      (alias,
       id_persona,
       estado,
       direccion_correo,
       numero_telefono,
       origen,
       id_externo)
    values
      (l_alias,
       l_id_persona,
       l_estado_usuario,
       i_direccion_correo,
       i_numero_telefono,
       l_origen,
       i_id_externo)
    returning id_usuario into l_id_usuario;
  
    insert into t_rol_usuarios
      (id_rol, id_usuario)
      select id_rol, l_id_usuario
        from t_roles
       where nombre =
             nvl(k_significado.f_referencia_codigo('ESTADO_USUARIO',
                                                   l_estado_usuario),
                 k_util.f_valor_parametro('NOMBRE_ROL_DEFECTO'));
  
    -- Registra clave
    if l_origen = c_origen_risk then
      k_clave.p_registrar_clave(l_alias, i_clave, k_clave.c_clave_acceso);
    end if;
  
    $if k_modulo.c_instalado_msj $then
    -- Inserta o actualiza suscripción básica del usuario
    k_usuario.p_suscribir_notificacion(l_id_usuario,
                                       k_dispositivo.f_suscripcion_usuario(l_id_usuario));
    $end
  
    $if k_modulo.c_instalado_msj $then
    if l_confirmacion_activa = 'S' then
      -- Envía correo de verificación
      l_body := k_mensajeria.f_correo_html('Para activar tu cuenta, por favor verifica tu dirección de correo.' ||
                                           utl_tcp.crlf ||
                                           'Tu cuenta no será creada hasta que tu dirección de correo sea confirmada.' ||
                                           utl_tcp.crlf ||
                                           'Confirma tu dirección de correo con el botón o con la siguiente URL:' ||
                                           utl_tcp.crlf ||
                                           f_generar_url_activacion(l_alias),
                                           'Confirmación de correo',
                                           'Confirmación de correo',
                                           null,
                                           'Confirmar',
                                           f_generar_url_activacion(l_alias));
    
      l_datos_extra.put('asunto', 'Confirmación de correo');
      l_datos_extra.put('contenido', l_body);
    
      if k_mensajeria.f_enviar_correo(l_plantilla,
                                      l_datos_extra.to_clob,
                                      null,
                                      i_direccion_correo,
                                      null,
                                      null) <> k_mensajeria.c_ok then
        raise_application_error(-20000,
                                'Error al enviar correo de verificación');
      end if;
    end if;
    $end
  
    return l_alias;
  exception
    when k_usuario.ex_usuario_existente then
      raise_application_error(-20000, 'Usuario ya existe');
    when dup_val_on_index then
      raise_application_error(-20000, 'Usuario ya existe');
  end;

  procedure p_editar_usuario(i_alias_antiguo    in varchar2,
                             i_alias_nuevo      in varchar2,
                             i_nombre           in varchar2,
                             i_apellido         in varchar2,
                             i_direccion_correo in varchar2,
                             i_numero_telefono  in varchar2 default null) is
    l_id_persona t_personas.id_persona%type;
  begin
    -- Actualiza usuario
    update t_usuarios
       set alias            = nvl(i_alias_nuevo, alias),
           direccion_correo = nvl(i_direccion_correo, direccion_correo),
           numero_telefono  = nvl(i_numero_telefono, numero_telefono)
     where alias = i_alias_antiguo
    returning id_persona into l_id_persona;
  
    if sql%notfound then
      raise_application_error(-20000, 'Usuario inexistente');
    end if;
  
    -- Actualiza persona
    update t_personas
       set nombre          = nvl(i_nombre, nombre),
           apellido        = nvl(i_apellido, apellido),
           nombre_completo = nvl(i_nombre || ' ' || i_apellido,
                                 nombre_completo)
     where id_persona = l_id_persona;
  
    if sql%notfound then
      raise_application_error(-20000, 'Persona inexistente');
    end if;
  end;

  function f_validar_credenciales_risk(i_id_usuario in number,
                                       i_clave      in varchar2,
                                       i_parametros in y_parametros)
    return boolean is
    l_tipo_clave varchar2(50);
  begin
    l_tipo_clave := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'tipo_clave');
  
    if not k_clave.f_validar_clave(i_id_usuario, i_clave, l_tipo_clave) then
      raise ex_credenciales_invalidas;
    end if;
  
    k_clave.p_registrar_autenticacion(i_id_usuario, l_tipo_clave);
    return true;
  exception
    when ex_credenciales_invalidas then
      k_clave.p_registrar_intento_fallido(i_id_usuario, l_tipo_clave);
      return false;
    when others then
      k_clave.p_registrar_intento_fallido(i_id_usuario, l_tipo_clave);
      return false;
  end;

  -- https://stackoverflow.com/a/33043760
  function f_validar_credenciales_oracle(i_usuario    in varchar2,
                                         i_clave      in varchar2,
                                         i_parametros in y_parametros)
    return boolean is
    l_dblink varchar2(1000);
  
    l_dominio t_autenticacion_origenes.prefijo_dominio%type;
    l_usuario t_usuarios.alias%type;
  begin
    l_dblink := k_operacion.f_valor_parametro_string(i_parametros, 'dblink');
  
    begin
      execute immediate 'DROP DATABASE LINK ' || l_dblink;
    exception
      when others then
        null;
    end;
  
    k_usuario.p_separar_dominio_usuario(i_usuario, l_dominio, l_usuario);
  
    execute immediate 'CREATE DATABASE LINK ' || l_dblink || ' CONNECT TO ' ||
                      l_usuario || ' IDENTIFIED BY ' || i_clave ||
                      ' USING ''' ||
                      k_operacion.f_valor_parametro_string(i_parametros,
                                                           'connect_string') || '''';
  
    execute immediate 'SELECT * FROM dual@' || l_dblink;
  
    execute immediate 'DROP DATABASE LINK ' || l_dblink;
  
    return true;
  exception
    when others then
      console.error('Error al validar credenciales ' ||
                    c_metodo_validacion_oracle || ': ' || sqlerrm);
      return false;
  end;

  -- https://oracle-base.com/articles/misc/oracle-application-express-apex-ldap-authentication
  function f_validar_credenciales_ldap(i_usuario    in varchar2,
                                       i_clave      in varchar2,
                                       i_parametros in y_parametros)
    return boolean is
    l_ldap_host  varchar2(256);
    l_ldap_port  pls_integer;
    l_ldap_base  varchar2(256);
    l_dn_prefix  varchar2(100); -- Amend as desired'.
    l_auth_group varchar2(100); -- Amend as desired'.
  
    l_retval      pls_integer;
    l_session     dbms_ldap.session;
    l_attrs       dbms_ldap.string_collection;
    l_message     dbms_ldap.message;
    l_entry       dbms_ldap.message;
    l_attr_name   varchar2(256);
    l_ber_element dbms_ldap.ber_element;
    l_vals        dbms_ldap.string_collection;
    l_ok          boolean;
  
    l_dominio t_autenticacion_origenes.prefijo_dominio%type;
    l_usuario t_usuarios.alias%type;
  begin
    if i_usuario is null or i_clave is null then
      raise_application_error(-20000, 'Credentials must be specified.');
    end if;
  
    l_ldap_host  := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'ldap_host');
    l_ldap_port  := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'ldap_port');
    l_ldap_base  := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'ldap_base');
    l_dn_prefix  := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'dn_prefix');
    l_auth_group := k_operacion.f_valor_parametro_string(i_parametros,
                                                         'auth_group');
  
    k_usuario.p_separar_dominio_usuario(i_usuario, l_dominio, l_usuario);
    if l_dominio is null and l_dn_prefix is not null then
      l_dominio := l_dn_prefix;
    end if;
  
    -- Choose to raise exceptions.
    dbms_ldap.use_exception := true;
  
    -- Connect to the LDAP server.
    l_session := dbms_ldap.init(hostname => l_ldap_host,
                                portnum  => l_ldap_port);
  
    l_retval := dbms_ldap.simple_bind_s(ld     => l_session,
                                        dn     => l_dominio || l_usuario,
                                        passwd => i_clave);
  
    if l_auth_group is null then
      -- No exceptions mean you are authenticated.
      l_ok := true;
    else
      -- No exceptions mean you are authenticated. Now check if authorized.
    
      -- Get all "memberOf" attributes
      l_attrs(1) := 'memberOf';
    
      -- Searching for the user info using his samaccount (windows login)
      l_retval := dbms_ldap.search_s(ld       => l_session,
                                     base     => l_ldap_base,
                                     scope    => dbms_ldap.scope_subtree,
                                     filter   => '(&(objectClass=*)(sAMAccountName=' ||
                                                 l_usuario || '))',
                                     attrs    => l_attrs,
                                     attronly => 0,
                                     res      => l_message);
    
      -- Get the first and only entry.
      l_entry := dbms_ldap.first_entry(ld => l_session, msg => l_message);
    
      -- Get the first Attribute for the entry.
      l_attr_name := dbms_ldap.first_attribute(ld        => l_session,
                                               ldapentry => l_entry,
                                               ber_elem  => l_ber_element);
    
      -- Loop through all "memberOf" attributes
      while l_attr_name is not null loop
        -- Get the values of the attribute
        l_vals := dbms_ldap.get_values(ld        => l_session,
                                       ldapentry => l_entry,
                                       attr      => l_attr_name);
      
        -- Check the contents of the value
        for i in l_vals.first .. l_vals.last loop
          -- Check the user is a member of the required group.
          l_ok := instr(upper(l_vals(i)), upper(l_auth_group)) > 0;
          exit when l_ok;
        end loop;
        exit when l_ok;
      
        l_attr_name := dbms_ldap.next_attribute(ld        => l_session,
                                                ldapentry => l_entry,
                                                ber_elem  => l_ber_element);
      end loop;
    end if;
  
    l_retval := dbms_ldap.unbind_s(ld => l_session);
  
    --if not l_ok then
    --apex_util.set_custom_auth_status(p_status => 'You are not in the correct LDAP group to use this application.');
    --end if;
  
    -- Return authentication + authorization result.
    return l_ok;
  exception
    when others then
      -- Exception means authentication failed.
      begin
        l_retval := dbms_ldap.unbind_s(ld => l_session);
      exception
        when others then
          null;
      end;
      console.error('Error al validar credenciales ' ||
                    c_metodo_validacion_ldap || ': ' || sqlerrm);
      --apex_util.set_custom_auth_status(p_status => 'Incorrect username and/or password');
      return false;
  end;

  function f_validar_credenciales(i_usuario in varchar2,
                                  i_clave   in varchar2,
                                  i_origen  in varchar2 default null)
    return boolean is
    l_id_usuario            t_usuarios.id_usuario%type;
    l_origen                t_usuarios.origen%type;
    l_metodo_validacion     t_autenticacion_origenes.metodo_validacion_credenciales%type;
    l_parametros_validacion t_autenticacion_origenes.parametros_validacion_credenciales%type;
    l_prms                  y_parametros;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_buscar_id(i_usuario);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    l_origen := coalesce(i_origen,
                         k_usuario.f_origen(l_id_usuario),
                         c_origen_risk);
  
    begin
      select a.metodo_validacion_credenciales,
             a.parametros_validacion_credenciales
        into l_metodo_validacion, l_parametros_validacion
        from t_autenticacion_origenes a
       where a.id_autenticacion_origen = l_origen;
    exception
      when others then
        l_metodo_validacion     := k_util.f_valor_parametro('METODO_VALIDACION_CREDENCIALES');
        l_parametros_validacion := k_json_util.c_json_object_vacio;
    end;
  
    case l_metodo_validacion
      when c_metodo_validacion_risk then
        l_prms := k_operacion.f_procesar_parametros(k_significado.f_referencia_codigo('METODO_VALIDACION_CREDENCIALES',
                                                                                      c_metodo_validacion_risk),
                                                    l_parametros_validacion);
        if not f_validar_credenciales_risk(l_id_usuario, i_clave, l_prms) then
          raise ex_credenciales_invalidas;
        end if;
      when c_metodo_validacion_oracle then
        l_prms := k_operacion.f_procesar_parametros(k_significado.f_referencia_codigo('METODO_VALIDACION_CREDENCIALES',
                                                                                      c_metodo_validacion_oracle),
                                                    l_parametros_validacion);
        if not f_validar_credenciales_oracle(i_usuario, i_clave, l_prms) then
          raise ex_credenciales_invalidas;
        end if;
      when c_metodo_validacion_ldap then
        l_prms := k_operacion.f_procesar_parametros(k_significado.f_referencia_codigo('METODO_VALIDACION_CREDENCIALES',
                                                                                      c_metodo_validacion_ldap),
                                                    l_parametros_validacion);
        if not f_validar_credenciales_ldap(i_usuario, i_clave, l_prms) then
          raise ex_credenciales_invalidas;
        end if;
      when c_metodo_validacion_externo then
        null; -- Valida externamente
      else
        raise ex_credenciales_invalidas;
    end case;
  
    return true;
  exception
    when k_usuario.ex_usuario_inexistente then
      return false;
    when ex_credenciales_invalidas then
      return false;
    when others then
      return false;
  end;

  procedure p_validar_credenciales(i_usuario in varchar2,
                                   i_clave   in varchar2,
                                   i_origen  in varchar2 default null) is
  begin
    if not f_validar_credenciales(i_usuario, i_clave, i_origen) then
      raise_application_error(-20000, 'Credenciales inválidas');
    end if;
  end;

  function f_obtener_prefijo_origen(i_origen in varchar2) return varchar2 is
    vl_prefijo_origen t_autenticacion_origenes.prefijo_dominio%type;
    vl_origen_activo  t_autenticacion_origenes.activo%type;
    -- Verificamos el origen especificado para el usuario.
  begin
    select ori.prefijo_dominio, ori.activo
      into vl_prefijo_origen, vl_origen_activo
      from t_autenticacion_origenes ori
     where ori.id_autenticacion_origen = i_origen;
  
    if vl_origen_activo = 'N' then
      raise_application_error(-20302,
                              'El origen especificado para el usuario no está activo!!');
    else
      return vl_prefijo_origen;
    end if;
  exception
    when no_data_found then
      raise_application_error(-20301,
                              'No existe el origen específicado para el usuario');
  end;

  function f_iniciar_sesion(i_id_aplicacion     in varchar2,
                            i_usuario           in varchar2,
                            i_access_token      in varchar2,
                            i_refresh_token     in varchar2,
                            i_token_dispositivo in varchar2 default null,
                            i_origen            in varchar2 default null,
                            i_dato_externo      in varchar2 default null)
    return number is
    l_id_sesion                      t_sesiones.id_sesion%type;
    l_id_usuario                     t_usuarios.id_usuario%type;
    l_estado_usuario                 t_usuarios.estado%type;
    l_tipo_aplicacion                t_aplicaciones.tipo%type;
    l_id_dispositivo                 t_dispositivos.id_dispositivo%type;
    l_cantidad                       number(3);
    l_fecha_expiracion_access_token  date;
    l_fecha_expiracion_refresh_token date;
    --
    l_origen t_sesiones.origen%type;
    l_alias  t_usuarios.alias%type;
  
  begin
    -- Valida aplicacion
    if i_id_aplicacion is null then
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    end if;
  
    -- Busca usuario
    l_id_usuario := k_usuario.f_buscar_id(i_usuario);
  
    if l_id_usuario is null then
      /*si se autentica por backoffice y no existe el usuario, insertamos*/
      if i_id_aplicacion = 108 then
        l_alias := f_obtener_prefijo_origen(i_origen) || i_usuario;
        begin
          insert into t_usuarios
            (alias, estado, origen, id_externo)
          values
            (l_alias, 'A', i_origen, i_usuario) return id_usuario into l_id_usuario;
        exception
          when others then
            raise k_usuario.ex_usuario_inexistente;
        end;
      else
        raise k_usuario.ex_usuario_inexistente;
      end if;
    end if;
  
    l_origen := coalesce(i_origen,
                         k_usuario.f_origen(l_id_usuario),
                         c_origen_risk);
  
    -- Valida estado de usuario
    l_estado_usuario := k_usuario.f_estado(l_id_usuario);
    begin
      select trim(column_value) estado
        into l_estado_usuario
        from k_cadena.f_separar_cadenas(k_util.f_valor_parametro('ESTADOS_ACTIVOS_USUARIO'),
                                        ',')
       where trim(column_value) = l_estado_usuario;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Usuario ' ||
                                k_cadena.f_formatear_titulo(k_significado.f_significado_codigo('ESTADO_USUARIO',
                                                                                               l_estado_usuario)));
      when others then
        null;
    end;
  
    -- Busca dispositivo
    l_id_dispositivo := coalesce(k_sistema.f_valor_parametro_number(k_sistema.c_id_dispositivo),
                                 k_dispositivo.f_id_dispositivo(i_token_dispositivo));
  
    -- Obtiene tipo de aplicacion
    begin
      select tipo
        into l_tipo_aplicacion
        from t_aplicaciones
       where id_aplicacion = i_id_aplicacion;
    exception
      when others then
        l_tipo_aplicacion := null;
    end;
  
    -- Cambia estado de las sesiones expiradas
    k_sesion.p_expirar_sesiones(l_id_usuario);
  
    if l_origen = c_origen_risk then
      -- Si el origen de la sesion es R-RISK
      if l_tipo_aplicacion <> 'S' then
        -- Si es de tipo S-SERVICIO no valida cantidad de sesiones activas
      
        -- Obtiene cantidad de sesiones activas del usuario
        select count(id_sesion)
          into l_cantidad
          from t_sesiones
         where estado = 'A'
           and id_usuario = l_id_usuario;
      
        if l_cantidad >=
           to_number(k_util.f_valor_parametro('CANTIDAD_MAXIMA_SESIONES_USUARIO')) then
          raise_application_error(-20000,
                                  'Usuario ha alcanzado la cantidad máxima de sesiones activas');
        end if;
      
      end if;
    
      -- Obtiene la fecha de expiracion del Access Token y Refresh Token
      l_fecha_expiracion_access_token := k_sesion.f_fecha_expiracion_access_token(i_access_token);
      if i_refresh_token is not null then
        l_fecha_expiracion_refresh_token := k_sesion.f_fecha_expiracion_refresh_token(i_id_aplicacion);
      end if;
    end if;
  
    begin
      -- Inserta sesion
      insert into t_sesiones
        (id_usuario,
         id_aplicacion,
         estado,
         fecha_autenticacion,
         access_token,
         fecha_expiracion_access_token,
         refresh_token,
         fecha_expiracion_refresh_token,
         direccion_ip,
         host,
         terminal,
         id_dispositivo,
         origen,
         dato_externo)
      values
        (l_id_usuario,
         i_id_aplicacion,
         'A',
         sysdate,
         i_access_token,
         l_fecha_expiracion_access_token,
         i_refresh_token,
         l_fecha_expiracion_refresh_token,
         k_sistema.f_valor_parametro_string(k_sistema.c_direccion_ip),
         k_util.f_host,
         k_util.f_terminal,
         l_id_dispositivo,
         l_origen,
         i_dato_externo)
      returning id_sesion into l_id_sesion;
    exception
      when dup_val_on_index then
        -- Actualiza sesion
        update t_sesiones
           set id_usuario                     = l_id_usuario,
               id_aplicacion                  = i_id_aplicacion,
               estado                         = 'A',
               fecha_autenticacion            = sysdate,
               fecha_expiracion_access_token  = l_fecha_expiracion_access_token,
               refresh_token                  = i_refresh_token,
               fecha_expiracion_refresh_token = l_fecha_expiracion_refresh_token,
               direccion_ip                   = k_sistema.f_valor_parametro_string(k_sistema.c_direccion_ip),
               host                           = k_util.f_host,
               terminal                       = k_util.f_terminal,
               id_dispositivo                 = l_id_dispositivo,
               origen                         = l_origen,
               dato_externo                   = i_dato_externo
         where access_token = i_access_token
        returning id_sesion into l_id_sesion;
    end;
  
    $if k_modulo.c_instalado_msj $then
    if l_id_dispositivo is not null then
      -- Inserta o actualiza suscripciones del usuario en el dispositivo
      k_dispositivo.p_suscribir_notificacion_usuario(l_id_dispositivo,
                                                     l_id_usuario);
    end if;
    $end
  
    return l_id_sesion;
  exception
    when k_usuario.ex_usuario_inexistente then
      raise_application_error(-20000, 'Usuario inexistente');
  end;

  function f_refrescar_sesion(i_id_aplicacion         in varchar2,
                              i_access_token_antiguo  in varchar2,
                              i_refresh_token_antiguo in varchar2,
                              i_access_token_nuevo    in varchar2,
                              i_refresh_token_nuevo   in varchar2,
                              i_origen                in varchar2 default null,
                              i_dato_externo          in varchar2 default null)
    return number is
    l_id_sesion                      t_sesiones.id_sesion%type;
    l_fecha_expiracion_access_token  date;
    l_fecha_expiracion_refresh_token date;
    --
    l_origen t_sesiones.origen%type;
  begin
    -- Valida aplicacion
    if i_id_aplicacion is null then
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    end if;
  
    -- Busca sesion
    l_id_sesion := k_sesion.f_id_sesion(i_access_token_antiguo);
  
    if l_id_sesion is null then
      raise ex_tokens_invalidos;
    end if;
  
    l_origen := coalesce(i_origen,
                         k_sesion.f_origen(l_id_sesion),
                         c_origen_risk);
  
    if l_origen = c_origen_risk then
      -- Obtiene la fecha de expiracion del Access Token y Refresh Token
      l_fecha_expiracion_access_token := k_sesion.f_fecha_expiracion_access_token(i_access_token_nuevo);
      if i_refresh_token_nuevo is not null then
        l_fecha_expiracion_refresh_token := k_sesion.f_fecha_expiracion_refresh_token(i_id_aplicacion);
      end if;
    
      -- Actualiza sesion
      update t_sesiones
         set access_token                   = i_access_token_nuevo,
             refresh_token                  = i_refresh_token_nuevo,
             fecha_expiracion_access_token  = l_fecha_expiracion_access_token,
             fecha_expiracion_refresh_token = l_fecha_expiracion_refresh_token,
             estado                         = 'A',
             fecha_estado                   = sysdate
       where id_sesion = l_id_sesion
         and access_token = i_access_token_antiguo
         and refresh_token = i_refresh_token_antiguo
         and estado in ('A', 'X')
         and fecha_expiracion_refresh_token >= sysdate;
      if sql%notfound then
        raise ex_tokens_invalidos;
      end if;
    
    else
    
      -- Actualiza sesion
      update t_sesiones
         set access_token = i_access_token_nuevo,
             estado       = 'A',
             fecha_estado = sysdate,
             dato_externo = i_dato_externo
       where id_sesion = l_id_sesion
         and access_token = i_access_token_antiguo
         and estado in ('A', 'X')
         and origen = l_origen;
      if sql%notfound then
        raise ex_tokens_invalidos;
      end if;
    
    end if;
  
    return l_id_sesion;
  exception
    when ex_tokens_invalidos then
      raise_application_error(-20000, 'Tokens inválidos');
  end;

  function f_generar_url_activacion(i_alias in varchar2) return varchar2 is
    l_json_object json_object_t;
    l_key         varchar2(1000);
  begin
    l_json_object := new json_object_t();
    l_json_object.put('usuario', i_alias);
    l_json_object.put('hash', k_util.f_hash(i_alias, as_crypto.hash_sh1));
  
    l_key := utl_url.escape(k_util.base64encode(k_util.clob_to_blob(l_json_object.to_clob)),
                            true);
  
    return k_util.f_valor_parametro('URL_SERVICIOS_PRODUCCION') || '/Aut/ActivarUsuario?key=' || l_key;
  end;

  procedure p_importar_usuarios_ldap(i_origen  in varchar2,
                                     i_usuario in varchar2,
                                     i_clave   in varchar2) is
    l_session   dbms_ldap.session;
    l_ret       pls_integer;
    l_ldap_host varchar2(256);
    l_ldap_port pls_integer;
    l_base_dn   varchar2(256);
    l_dn_prefix varchar2(100);
    l_filter    varchar2(256);
    l_attrs     dbms_ldap.string_collection;
    l_message   dbms_ldap.message;
    l_entry     dbms_ldap.message;
    l_vals      dbms_ldap.string_collection;
  
    l_alias  varchar2(300);
    l_nombre varchar2(200);
    l_email  varchar2(200);
    --
    l_dominio t_autenticacion_origenes.prefijo_dominio%type;
    l_usuario t_usuarios.alias%type;
  
    l_metodo_validacion     t_autenticacion_origenes.metodo_validacion_credenciales%type;
    l_parametros_validacion t_autenticacion_origenes.parametros_validacion_credenciales%type;
    l_prms                  y_parametros;
  begin
    begin
      select a.metodo_validacion_credenciales,
             a.parametros_validacion_credenciales
        into l_metodo_validacion, l_parametros_validacion
        from t_autenticacion_origenes a
       where a.id_autenticacion_origen = i_origen;
    exception
      when others then
        l_metodo_validacion     := k_util.f_valor_parametro('METODO_VALIDACION_CREDENCIALES');
        l_parametros_validacion := k_json_util.c_json_object_vacio;
    end;
  
    if l_metodo_validacion <> c_metodo_validacion_ldap then
      raise_application_error(-20000,
                              'Método de validación de credenciales del origen no es LDAP');
    end if;
  
    l_prms := k_operacion.f_procesar_parametros(k_significado.f_referencia_codigo('METODO_VALIDACION_CREDENCIALES',
                                                                                  c_metodo_validacion_ldap),
                                                l_parametros_validacion);
  
    --
    l_ldap_host := k_operacion.f_valor_parametro_string(l_prms, 'ldap_host');
    l_ldap_port := k_operacion.f_valor_parametro_number(l_prms, 'ldap_port');
    l_base_dn   := k_operacion.f_valor_parametro_string(l_prms, 'ldap_base');
    l_dn_prefix := k_operacion.f_valor_parametro_string(l_prms, 'dn_prefix');
    l_filter    := k_operacion.f_valor_parametro_string(l_prms,
                                                        'search_filter');
  
    k_usuario.p_separar_dominio_usuario(i_usuario, l_dominio, l_usuario);
    if l_dominio is null and l_dn_prefix is not null then
      l_dominio := l_dn_prefix;
    end if;
  
    -- Inicializar
    dbms_ldap.use_exception := true;
    l_attrs(1) := 'sAMAccountName';
    l_attrs(2) := 'cn';
    l_attrs(3) := 'mail';
  
    -- Conectar
    l_session := dbms_ldap.init(l_ldap_host, l_ldap_port);
    l_ret     := dbms_ldap.simple_bind_s(l_session,
                                         l_dominio || l_usuario,
                                         i_clave);
  
    -- Buscar usuarios del grupo
    l_ret := dbms_ldap.search_s(ld       => l_session,
                                base     => l_base_dn,
                                scope    => dbms_ldap.scope_subtree,
                                filter   => l_filter,
                                attrs    => l_attrs,
                                attronly => 0,
                                res      => l_message);
  
    -- Procesar resultados
    l_entry := dbms_ldap.first_entry(l_session, l_message);
    while l_entry is not null loop
      -- Alias
      l_vals := dbms_ldap.get_values(l_session, l_entry, 'sAMAccountName');
      if l_vals.count > 0 then
        l_alias := l_vals(0);
      end if;
    
      -- Nombre
      l_vals := dbms_ldap.get_values(l_session, l_entry, 'cn');
      if l_vals.count > 0 then
        l_nombre := l_vals(0);
      end if;
    
      -- Email
      l_vals := dbms_ldap.get_values(l_session, l_entry, 'mail');
      if l_vals.count > 0 then
        l_email := l_vals(0);
      end if;
    
      -- Upsert en tabla
      merge into t_usuarios u
      using (select l_dn_prefix || l_alias as alias from dual) s
      on (u.alias = s.alias)
      when matched then
        update
           set estado           = 'A',
               direccion_correo = l_email,
               origen           = i_origen,
               id_externo       = l_alias
      when not matched then
        insert
          (alias, estado, direccion_correo, origen, id_externo)
        values
          (l_dn_prefix || l_alias, 'A', l_email, i_origen, l_alias);
    
      -- Siguiente entrada
      l_entry := dbms_ldap.next_entry(l_session, l_entry);
    end loop;
  
    -- Desconectar
    l_ret := dbms_ldap.unbind_s(l_session);
  exception
    when others then
      begin
        l_ret := dbms_ldap.unbind_s(l_session);
      exception
        when others then
          null;
      end;
      raise_application_error(-20000,
                              'Error al importar usuarios ' ||
                              c_metodo_validacion_ldap || ': ' || sqlerrm);
  end;

end;
/
