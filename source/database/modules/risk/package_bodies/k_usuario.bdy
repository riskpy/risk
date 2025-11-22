create or replace package body k_usuario is

  -- Tiempo de expiración de la suscripción en días
  c_tiempo_expiracion_suscripcion constant pls_integer := 30;

  function f_buscar_id(i_usuario in varchar2) return number is
    l_id_usuario t_usuarios.id_usuario%type;
  begin
    begin
      select id_usuario
        into l_id_usuario
        from t_usuarios
       where (upper(alias) = upper(i_usuario) or
             upper(direccion_correo) = upper(i_usuario) or
             id_externo = i_usuario);
    exception
      when no_data_found then
        l_id_usuario := null;
      when others then
        l_id_usuario := null;
    end;
    return l_id_usuario;
  end;

  function f_id_usuario(i_alias in varchar2) return number is
    l_id_usuario t_usuarios.id_usuario%type;
  begin
    begin
      select id_usuario
        into l_id_usuario
        from t_usuarios
       where upper(alias) = upper(i_alias);
    exception
      when no_data_found then
        l_id_usuario := null;
      when others then
        l_id_usuario := null;
    end;
    return l_id_usuario;
  end;

  function f_id_persona(i_id_usuario in number) return number is
    l_id_persona t_usuarios.id_persona%type;
  begin
    begin
      select u.id_persona
        into l_id_persona
        from t_usuarios u
       where u.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_id_persona := null;
      when others then
        l_id_persona := null;
    end;
    return l_id_persona;
  end;

  function f_alias(i_id_usuario in number) return varchar2 is
    l_alias t_usuarios.alias%type;
  begin
    begin
      select u.alias
        into l_alias
        from t_usuarios u
       where u.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_alias := null;
      when others then
        l_alias := null;
    end;
    return l_alias;
  end;

  function f_estado(i_id_usuario in number) return varchar2 is
    l_estado t_usuarios.estado%type;
  begin
    begin
      select u.estado
        into l_estado
        from t_usuarios u
       where u.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_estado := null;
      when others then
        l_estado := null;
    end;
    return l_estado;
  end;

  function f_origen(i_id_usuario in number) return varchar2 is
    l_origen t_usuarios.origen%type;
  begin
    begin
      select u.origen
        into l_origen
        from t_usuarios u
       where u.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_origen := null;
      when others then
        l_origen := null;
    end;
    return l_origen;
  end;

  function f_validar_alias(i_alias varchar2) return boolean is
  begin
    return nvl(regexp_like(i_alias,
                           k_util.f_valor_parametro('REGEXP_VALIDAR_ALIAS_USUARIO')),
               true);
  end;

  function f_version_avatar(i_alias in varchar2) return number is
    l_version t_archivos.version_actual%type;
  begin
    begin
      select k_archivo.f_version_archivo('T_USUARIOS', 'AVATAR', alias)
        into l_version
        from t_usuarios
       where upper(alias) = upper(i_alias);
    exception
      when no_data_found then
        l_version := null;
      when others then
        l_version := null;
    end;
    return l_version;
  end;

  function f_datos_usuario(i_id_usuario in number) return y_usuario is
    l_usuario y_usuario;
    l_roles   y_objetos;
    l_rol     y_rol;
  
    cursor cr_roles(i_id_usuario in number) is
      select r.id_rol, r.nombre, r.activo, r.detalle
        from t_rol_usuarios ru, t_roles r
       where r.id_rol = ru.id_rol
         and r.activo = 'S'
         and ru.id_usuario = i_id_usuario;
  begin
    -- Inicializa respuesta
    l_usuario := new y_usuario();
    l_roles   := new y_objetos();
  
    -- Buscando datos del usuario
    begin
      select u.id_usuario,
             u.alias,
             p.nombre,
             p.apellido,
             p.tipo_persona,
             u.estado,
             u.direccion_correo,
             u.numero_telefono,
             k_archivo.f_version_archivo('T_USUARIOS', 'AVATAR', u.alias),
             u.origen
        into l_usuario.id_usuario,
             l_usuario.alias,
             l_usuario.nombre,
             l_usuario.apellido,
             l_usuario.tipo_persona,
             l_usuario.estado,
             l_usuario.direccion_correo,
             l_usuario.numero_telefono,
             l_usuario.version_avatar,
             l_usuario.origen
        from t_usuarios u, t_personas p
       where p.id_persona(+) = u.id_persona
         and u.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Usuario inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al buscar datos del usuario');
    end;
  
    -- Buscando roles del usuario
    for c in cr_roles(l_usuario.id_usuario) loop
      l_rol         := new y_rol();
      l_rol.id_rol  := c.id_rol;
      l_rol.nombre  := c.nombre;
      l_rol.activo  := c.activo;
      l_rol.detalle := c.detalle;
    
      l_roles.extend;
      l_roles(l_roles.count) := l_rol;
    end loop;
    l_usuario.roles := l_roles;
  
    return l_usuario;
  end;

  function f_existe_usuario_externo(i_origen     in varchar2,
                                    i_id_externo in varchar2) return boolean is
    l_existe_usuario varchar2(1) := 'N';
  begin
    select decode(nvl(count(1), 0), 0, 'N', 'S')
      into l_existe_usuario
      from t_usuarios us
     where us.origen = i_origen
       and us.id_externo = i_id_externo;
  
    if l_existe_usuario = 'S' then
      return true;
    else
      return false;
    end if;
  end;

  procedure p_cambiar_estado(i_id_usuario in number,
                             i_estado     in varchar2) is
    l_estado_anterior t_usuarios.estado%type;
  begin
    -- Obtiene estado anterior del usuario
    select estado
      into l_estado_anterior
      from t_usuarios
     where id_usuario = i_id_usuario;
  
    -- Actualiza usuario
    update t_usuarios
       set estado = i_estado
     where id_usuario = i_id_usuario
       and estado <> i_estado;
  
    -- Actualiza rol por defecto para el nuevo estado
    update t_rol_usuarios a
       set a.id_rol =
           (select id_rol
              from t_roles
             where nombre =
                   nvl(k_significado.f_referencia_codigo('ESTADO_USUARIO',
                                                         i_estado),
                       k_util.f_valor_parametro('NOMBRE_ROL_DEFECTO')))
     where a.id_usuario = i_id_usuario
       and a.id_rol =
           (select id_rol
              from t_roles
             where nombre =
                   nvl(k_significado.f_referencia_codigo('ESTADO_USUARIO',
                                                         l_estado_anterior),
                       k_util.f_valor_parametro('NOMBRE_ROL_DEFECTO')));
  
    -- Si no existe, inserta rol por defecto para el nuevo estado
    if sql%notfound then
      begin
        insert into t_rol_usuarios
          (id_rol, id_usuario)
          select id_rol, i_id_usuario
            from t_roles
           where nombre =
                 nvl(k_significado.f_referencia_codigo('ESTADO_USUARIO',
                                                       i_estado),
                     k_util.f_valor_parametro('NOMBRE_ROL_DEFECTO'));
      exception
        when dup_val_on_index then
          null;
      end;
    end if;
  end;

  $if k_modulo.c_instalado_msj $then
  procedure p_suscribir_notificacion(i_id_usuario       in number,
                                     i_suscripcion_alta in varchar2) is
  begin
    -- Actualiza suscripción
    update t_usuario_suscripciones s
       set s.suscripcion      = lower(i_suscripcion_alta),
           s.fecha_expiracion = sysdate + c_tiempo_expiracion_suscripcion
     where s.id_usuario = i_id_usuario
       and lower(s.suscripcion) = lower(i_suscripcion_alta);
  
    if sql%notfound then
      -- Inserta suscripción
      insert into t_usuario_suscripciones
        (id_usuario, suscripcion, fecha_expiracion)
      values
        (i_id_usuario,
         lower(i_suscripcion_alta),
         sysdate + c_tiempo_expiracion_suscripcion);
    end if;
  end;

  procedure p_desuscribir_notificacion(i_id_usuario       in number,
                                       i_suscripcion_baja in varchar2) is
  begin
    delete t_usuario_suscripciones s
     where s.id_usuario = i_id_usuario
       and lower(s.suscripcion) = lower(i_suscripcion_baja);
  end;
  $end

  procedure p_guardar_dato_string(i_alias in varchar2,
                                  i_campo in varchar2,
                                  i_dato  in varchar2) is
    l_id_persona t_personas.id_persona%type;
    l_alias      t_usuarios.alias%type;
  begin
    -- Verifica que exista usuario
    begin
      select alias into l_alias from t_usuarios where alias = i_alias;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Usuario inexistente');
    end;
  
    -- Guarda dato del usuario
    if i_dato is not null then
      k_dato.p_guardar_dato_string('T_USUARIOS', i_campo, l_alias, i_dato);
    end if;
  end;

end;
/
