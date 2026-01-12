create or replace package body k_sesion is

  function f_id_sesion(i_access_token in varchar2,
                       i_estado       in varchar2 default null) return number is
    l_id_sesion t_sesiones.id_sesion%type;
  begin
    begin
      select id_sesion
        into l_id_sesion
        from t_sesiones
       where access_token = i_access_token
         and estado = nvl(i_estado, estado);
    exception
      when no_data_found then
        l_id_sesion := null;
      when others then
        l_id_sesion := null;
    end;
    return l_id_sesion;
  end;

  function f_origen(i_id_sesion in number) return varchar2 is
    l_origen t_sesiones.origen %type;
  begin
    begin
      select s.origen
        into l_origen
        from t_sesiones s
       where s.id_sesion = i_id_sesion;
    exception
      when no_data_found then
        l_origen := null;
      when others then
        l_origen := null;
    end;
    return l_origen;
  end;

  function f_validar_sesion(i_access_token in varchar2) return boolean is
  begin
    if f_id_sesion(i_access_token, 'A') is null then
      return false;
    else
      return true;
    end if;
  exception
    when others then
      return false;
  end;

  function f_datos_sesion(i_id_sesion in number) return y_sesion is
    l_sesion y_sesion;
  begin
    -- Inicializa respuesta
    l_sesion := new y_sesion();
  
    -- Buscando datos de la sesion
    begin
      select id_sesion,
             estado,
             access_token,
             refresh_token,
             f_tiempo_expiracion_token(id_aplicacion, c_access_token),
             f_tiempo_expiracion_token(id_aplicacion, c_refresh_token)
        into l_sesion.id_sesion,
             l_sesion.estado,
             l_sesion.access_token,
             l_sesion.refresh_token,
             l_sesion.tiempo_expiracion_access_token,
             l_sesion.tiempo_expiracion_refresh_token
        from t_sesiones
       where id_sesion = i_id_sesion;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Sesión inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al buscar datos de la sesión');
    end;
  
    return l_sesion;
  end;

  function f_dispositivo_sesion(i_id_sesion in number) return varchar2 is
    l_id_dispositivo t_sesiones.id_dispositivo%type;
  begin
    -- Buscando datos de la sesion
    begin
      select id_dispositivo
        into l_id_dispositivo
        from t_sesiones
       where id_sesion = i_id_sesion;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Sesión inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al buscar datos de la sesión');
    end;
  
    return l_id_dispositivo;
  end;

  function f_tiempo_expiracion_token(i_id_aplicacion in varchar2,
                                     i_tipo_token    in varchar2)
    return number is
    l_tiempo_expiracion_token number;
  begin
    -- Busca el tiempo de expiración configurado para la aplicación
    begin
      select case i_tipo_token
               when c_refresh_token then -- Refresh Token
                to_number(k_parametro.f_valor_parametro(k_parametro.c_tabla_aplicaciones,
                                                        'TIEMPO_EXPIRACION_REFRESH_TOKEN',
                                                        id_aplicacion))
               when c_access_token then -- Access Token
                to_number(k_parametro.f_valor_parametro(k_parametro.c_tabla_aplicaciones,
                                                        'TIEMPO_EXPIRACION_ACCESS_TOKEN',
                                                        id_aplicacion))
               else
                null
             end
        into l_tiempo_expiracion_token
        from t_aplicaciones
       where id_aplicacion = i_id_aplicacion;
    exception
      when no_data_found then
        l_tiempo_expiracion_token := null;
      when others then
        l_tiempo_expiracion_token := null;
    end;
  
    -- Si no encuentra, busca el tiempo de expiración configurado a nivel general
    if l_tiempo_expiracion_token is null then
      l_tiempo_expiracion_token := case i_tipo_token
                                     when c_refresh_token then -- Refresh Token
                                      to_number(k_util.f_valor_parametro('TIEMPO_EXPIRACION_REFRESH_TOKEN'))
                                     when c_access_token then -- Access Token
                                      to_number(k_util.f_valor_parametro('TIEMPO_EXPIRACION_ACCESS_TOKEN'))
                                     else
                                      null
                                   end;
    end if;
  
    return l_tiempo_expiracion_token;
  end;

  function f_fecha_expiracion_access_token(i_access_token in varchar2)
    return date is
    l_exp          number;
    l_payload_json json_object_t;
  begin
    l_payload_json := json_object_t.parse(utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(k_cadena.f_valor_posicion(i_access_token,
                                                                                                                                          2,
                                                                                                                                          '.')))));
    l_exp          := l_payload_json.get_number('exp');
    return to_date('19700101', 'YYYYMMDD') +((l_exp +
                                             ((to_number(substr(tz_offset(sessiontimezone),
                                                                 1,
                                                                 3)) + 0) * 3600)) /
                                             86400);
  exception
    when others then
      return null;
  end;

  function f_fecha_expiracion_refresh_token(i_id_aplicacion in varchar2)
    return date is
  begin
    return sysdate +(f_tiempo_expiracion_token(i_id_aplicacion,
                                               c_refresh_token) / 24);
  exception
    when others then
      return null;
  end;

  function f_usuario_access_token(i_access_token in varchar2) return varchar2 is
    l_payload_json json_object_t;
  begin
    l_payload_json := json_object_t.parse(utl_raw.cast_to_varchar2(utl_encode.base64_decode(utl_raw.cast_to_raw(k_cadena.f_valor_posicion(i_access_token,
                                                                                                                                          2,
                                                                                                                                          '.')))));
    return l_payload_json.get_string('unique_name');
  exception
    when others then
      return null;
  end;

  procedure p_validar_sesion(i_access_token in varchar2) is
  begin
    if not f_validar_sesion(i_access_token) then
      raise_application_error(-20000, 'Sesión finalizada o expirada');
    end if;
  end;

  procedure p_cambiar_estado(i_access_token in varchar2,
                             i_estado       in varchar2) is
    l_id_sesion      t_sesiones.id_sesion%type;
    l_id_dispositivo t_sesiones.id_dispositivo%type;
    l_id_usuario     t_usuarios.id_usuario%type;
  begin
    -- Busca sesion
    l_id_sesion      := f_id_sesion(i_access_token);
    l_id_dispositivo := f_dispositivo_sesion(l_id_sesion);
  
    if l_id_sesion is null then
      raise ex_sesion_inexistente;
    end if;
  
    -- Actualiza sesion
    update t_sesiones
       set estado = i_estado
     where id_sesion = l_id_sesion
       and estado <> i_estado
    returning id_usuario into l_id_usuario;
  
    $if k_modulo.c_instalado_msj $then
    if l_id_usuario is not null and i_estado in ('X', 'I', 'F') then
      k_dispositivo.p_desuscribir_notificacion_usuario(l_id_dispositivo,
                                                       l_id_usuario);
    end if;
    $end
  exception
    when ex_sesion_inexistente then
      /*raise_application_error(-20000, 'Sesion inexistente');*/
      null;
  end;

  procedure p_expirar_sesiones(i_id_usuario in number) is
  begin
    update t_sesiones a
       set a.estado = 'X' -- EXPIRADO
     where a.estado = 'A' -- ACTIVO
       and a.fecha_expiracion_access_token < sysdate
       and a.id_usuario = nvl(i_id_usuario, a.id_usuario);
  end;

end;
/

