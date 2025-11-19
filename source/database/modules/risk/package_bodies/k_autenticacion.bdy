create or replace package body k_autenticacion is

  -- Excepciones
  ex_credenciales_invalidas exception;
  ex_tokens_invalidos       exception;

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
    l_origen              varchar2(1) := nvl(i_origen, c_origen_risk);
  begin
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
       fecha_nacimiento)
    values
      (i_nombre,
       i_apellido,
       i_nombre || ' ' || i_apellido,
       'F',
       null,
       null,
       null,
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
    
      if k_mensajeria.f_enviar_correo('Confirmación de correo',
                                      l_body,
                                      null,
                                      i_direccion_correo,
                                      null,
                                      null,
                                      null,
                                      null,
                                      k_mensajeria.c_prioridad_importante) <>
         k_mensajeria.c_ok then
        raise_application_error(-20000,
                                'Error al enviar correo de verificación');
      end if;
    end if;
    $end
  
    return l_alias;
  exception
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
                                       i_tipo_clave in char default 'A')
    return boolean is
  begin
    return k_clave.f_validar_clave(i_id_usuario, i_clave, i_tipo_clave);
  end;

  -- https://stackoverflow.com/a/33043760
  function f_validar_credenciales_oracle(i_usuario in varchar2,
                                         i_clave   in varchar2)
    return boolean is
  begin
    begin
      execute immediate 'DROP DATABASE LINK password_test_loopback';
    exception
      when others then
        null;
    end;
  
    execute immediate 'CREATE DATABASE LINK password_test_loopback CONNECT TO ' ||
                      i_usuario || ' IDENTIFIED BY ' || i_clave ||
                      ' USING ''' || k_util.f_base_datos || '''';
  
    execute immediate 'SELECT * FROM dual@password_test_loopback';
  
    execute immediate 'DROP DATABASE LINK password_test_loopback';
  
    return true;
  exception
    when others then
      return false;
  end;

  function f_validar_credenciales(i_usuario    in varchar2,
                                  i_clave      in varchar2,
                                  i_tipo_clave in char default 'A',
                                  i_metodo     in varchar2 default null)
    return boolean is
    l_id_usuario t_usuarios.id_usuario%type;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_buscar_id(i_usuario);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    case nvl(i_metodo,
         k_util.f_valor_parametro('METODO_VALIDACION_CREDENCIALES'))
      when c_metodo_validacion_risk then
        if not
            f_validar_credenciales_risk(l_id_usuario, i_clave, i_tipo_clave) then
          raise ex_credenciales_invalidas;
        end if;
      when c_metodo_validacion_oracle then
        if not f_validar_credenciales_oracle(i_usuario, i_clave) then
          raise ex_credenciales_invalidas;
        end if;
      else
        raise ex_credenciales_invalidas;
    end case;
  
    k_clave.p_registrar_autenticacion(l_id_usuario, i_tipo_clave);
    return true;
  exception
    when k_usuario.ex_usuario_inexistente then
      return false;
    when ex_credenciales_invalidas then
      k_clave.p_registrar_intento_fallido(l_id_usuario, i_tipo_clave);
      return false;
    when others then
      k_clave.p_registrar_intento_fallido(l_id_usuario, i_tipo_clave);
      return false;
  end;

  procedure p_validar_credenciales(i_usuario    in varchar2,
                                   i_clave      in varchar2,
                                   i_tipo_clave in char default 'A',
                                   i_metodo     in varchar2 default null) is
  begin
    if not
        f_validar_credenciales(i_usuario, i_clave, i_tipo_clave, i_metodo) then
      raise_application_error(-20000, 'Credenciales inválidas');
    end if;
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
    l_origen varchar2(1) := nvl(i_origen, c_origen_risk);
  begin
    -- Valida aplicacion
    if i_id_aplicacion is null then
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    end if;
  
    -- Busca usuario
    l_id_usuario := k_usuario.f_buscar_id(i_usuario);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
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
    l_origen varchar2(1) := nvl(i_origen, c_origen_risk);
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

end;
/
