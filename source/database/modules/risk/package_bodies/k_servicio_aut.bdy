create or replace package body k_servicio_aut is

  function registrar_usuario(i_parametros in y_parametros) return y_respuesta is
    l_rsp    y_respuesta;
    l_dato   y_dato;
    l_origen varchar2(1);
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Obteniendo origen';
    l_origen    := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                            'origen'),
                       k_autenticacion.c_origen_risk);
  
    l_rsp.lugar := 'Validando parametros';
    if l_origen = k_autenticacion.c_origen_risk then
      k_operacion.p_validar_parametro(l_rsp,
                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                           'clave') is not null,
                                      'Debe ingresar clave');
    end if;
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'nombre') is not null,
                                    'Debe ingresar nombre');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'apellido') is not null,
                                    'Debe ingresar apellido');
  
    l_rsp.lugar      := 'Registrando usuario';
    l_dato.contenido := k_autenticacion.f_registrar_usuario(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'usuario'),
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'clave'),
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'nombre'),
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'apellido'),
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'direccion_correo'),
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'numero_telefono'),
                                                            l_origen,
                                                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                 'id_externo'));
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_usuario.ex_usuario_existente then
      if l_origen <> k_autenticacion.c_origen_risk then
        l_dato.contenido := k_usuario.f_alias(k_usuario.f_buscar_id(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                         'id_externo')));
      else
        l_dato := null;
      end if;
      k_operacion.p_respuesta_error(l_rsp,
                                    c_usuario_externo_existente,
                                    'Usuario externo ya existe',
                                    null,
                                    l_dato);
      return l_rsp;
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function cambiar_estado_usuario(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'estado') is not null,
                                    'Debe ingresar estado');
  
    l_rsp.lugar := 'Cambiando estado de usuario';
    k_usuario.p_cambiar_estado(k_usuario.f_buscar_id(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                          'usuario')),
                               k_operacion.f_valor_parametro_string(i_parametros,
                                                                    'estado'));
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function registrar_clave(i_parametros in y_parametros) return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    -- l_rsp.lugar := 'Validando parametros';
  
    l_rsp.lugar := 'Registrando clave';
    k_clave.p_registrar_clave(k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'usuario'),
                              k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'clave'),
                              k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'tipo_clave'));
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function cambiar_clave(i_parametros in y_parametros) return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    -- l_rsp.lugar := 'Validando parametros';
  
    l_rsp.lugar := 'Cambiando clave';
    k_clave.p_cambiar_clave(k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'usuario'),
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'clave_antigua'),
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'clave_nueva'),
                            k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'tipo_clave'));
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function validar_credenciales(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'clave') is not null,
                                    'Debe ingresar clave');
  
    l_rsp.lugar := 'Validando credenciales';
    if not
        k_autenticacion.f_validar_credenciales(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                    'usuario'),
                                               k_operacion.f_valor_parametro_string(i_parametros,
                                                                                    'clave'),
                                               k_operacion.f_valor_parametro_string(i_parametros,
                                                                                    'tipo_clave')) then
      k_operacion.p_respuesta_error(l_rsp,
                                    'aut0003',
                                    'Credenciales inválidas');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function validar_clave_aplicacion(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'clave_aplicacion') is not null,
                                    'Debe ingresar clave_aplicacion');
  
    l_rsp.lugar := 'Validando clave de aplicacion';
    if not
        k_aplicacion.f_validar_clave(k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'clave_aplicacion')) then
      k_operacion.p_respuesta_error(l_rsp,
                                    'aut0002',
                                    'Clave de aplicacion invalida');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function validar_sesion(i_parametros in y_parametros) return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'access_token') is not null,
                                    'Debe ingresar access_token');
  
    l_rsp.lugar := 'Validando sesion';
    if not
        k_sesion.f_validar_sesion(k_operacion.f_valor_parametro_string(i_parametros,
                                                                       'access_token')) then
      k_operacion.p_respuesta_error(l_rsp,
                                    'aut0002',
                                    'Sesion finalizada o expirada');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function iniciar_sesion(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_sesion    y_sesion;
    l_id_sesion t_sesiones.id_sesion%type;
    l_origen    varchar2(1);
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Obteniendo origen';
    l_origen    := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                            'origen'),
                       k_autenticacion.c_origen_risk);
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'access_token') is not null,
                                    'Debe ingresar access_token');
  
    if l_origen = k_autenticacion.c_origen_risk then
      k_operacion.p_validar_parametro(l_rsp,
                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                           'refresh_token') is not null,
                                      'Debe ingresar refresh_token');
    end if;
  
    l_rsp.lugar := 'Iniciando sesion';
    l_id_sesion := k_autenticacion.f_iniciar_sesion(k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion),
                                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                                         'usuario'),
                                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                                         'access_token'),
                                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                                         'refresh_token'),
                                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                                         'token_dispositivo'),
                                                    l_origen,
                                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                                         'dato_externo'));
  
    l_rsp.lugar := 'Cargando datos de la sesion';
    l_sesion    := k_sesion.f_datos_sesion(l_id_sesion);
  
    k_operacion.p_respuesta_ok(l_rsp, l_sesion);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function refrescar_sesion(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_sesion    y_sesion;
    l_id_sesion t_sesiones.id_sesion%type;
    l_origen    varchar2(1);
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Obteniendo origen';
    l_origen    := nvl(k_operacion.f_valor_parametro_string(i_parametros,
                                                            'origen'),
                       k_autenticacion.c_origen_risk);
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'access_token_antiguo') is not null,
                                    'Debe ingresar antiguo Access Token');
  
    if l_origen = k_autenticacion.c_origen_risk then
      k_operacion.p_validar_parametro(l_rsp,
                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                           'refresh_token_antiguo') is not null,
                                      'Debe ingresar antiguo Refresh Token');
    end if;
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'access_token_nuevo') is not null,
                                    'Debe ingresar nuevo Access Token');
  
    if l_origen = k_autenticacion.c_origen_risk then
      k_operacion.p_validar_parametro(l_rsp,
                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                           'refresh_token_nuevo') is not null,
                                      'Debe ingresar nuevo Refresh Token');
    end if;
  
    l_rsp.lugar := 'Refrescando sesion';
    l_id_sesion := k_autenticacion.f_refrescar_sesion(k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion),
                                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                                           'access_token_antiguo'),
                                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                                           'refresh_token_antiguo'),
                                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                                           'access_token_nuevo'),
                                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                                           'refresh_token_nuevo'),
                                                      l_origen,
                                                      k_operacion.f_valor_parametro_string(i_parametros,
                                                                                           'dato_externo'));
  
    l_rsp.lugar := 'Cargando datos de la sesion';
    l_sesion    := k_sesion.f_datos_sesion(l_id_sesion);
  
    k_operacion.p_respuesta_ok(l_rsp, l_sesion);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function cambiar_estado_sesion(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'access_token') is not null,
                                    'Debe ingresar access_token');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'estado') is not null,
                                    'Debe ingresar estado');
  
    l_rsp.lugar := 'Cambiando estado de sesion';
    k_sesion.p_cambiar_estado(k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'access_token'),
                              k_operacion.f_valor_parametro_string(i_parametros,
                                                                   'estado'));
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function datos_usuario(i_parametros in y_parametros) return y_respuesta is
    l_rsp     y_respuesta;
    l_usuario y_usuario;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
  
    l_rsp.lugar := 'Cargando datos del usuario';
    l_usuario   := k_usuario.f_datos_usuario(k_usuario.f_buscar_id(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                        'usuario')));
  
    k_operacion.p_respuesta_ok(l_rsp, l_usuario);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function registrar_dispositivo(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp            y_respuesta;
    l_dato           y_dato;
    l_dispositivo    y_dispositivo;
    l_id_dispositivo t_dispositivos.id_dispositivo%type;
    i                integer;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_object(i_parametros,
                                                                         'dispositivo') is not null,
                                    'Debe ingresar dispositivo');
    l_dispositivo := treat(k_operacion.f_valor_parametro_object(i_parametros,
                                                                'dispositivo') as
                           y_dispositivo);
  
    l_rsp.lugar      := 'Registrando dispositivo';
    l_id_dispositivo := k_dispositivo.f_registrar_dispositivo(k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion),
                                                              l_dispositivo.token_dispositivo,
                                                              l_dispositivo.token_notificacion,
                                                              l_dispositivo.nombre_sistema_operativo,
                                                              l_dispositivo.version_sistema_operativo,
                                                              l_dispositivo.tipo,
                                                              l_dispositivo.nombre_navegador,
                                                              l_dispositivo.version_navegador,
                                                              l_dispositivo.version_aplicacion,
                                                              l_dispositivo.id_pais_iso2,
                                                              l_dispositivo.zona_horaria,
                                                              l_dispositivo.id_idioma_iso369_1);
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Agregando suscripciones';
    i           := l_dispositivo.suscripciones.first;
    while i is not null loop
      l_dato := treat(l_dispositivo.suscripciones(i) as y_dato);
      k_dispositivo.p_suscribir_notificacion(l_id_dispositivo,
                                             l_dato.contenido);
      i := l_dispositivo.suscripciones.next(i);
    end loop;
    $end
  
    l_rsp.lugar := 'Buscando token del dispositivo';
    begin
      select token_dispositivo
        into l_dato.contenido
        from t_dispositivos
       where id_dispositivo = l_id_dispositivo;
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      'aut0001',
                                      'Error al obtener token del dispositivo');
        raise k_operacion.ex_error_general;
    end;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function datos_dispositivo(i_parametros in y_parametros) return y_respuesta is
    l_rsp         y_respuesta;
    l_dispositivo y_dispositivo;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'token_dispositivo') is not null,
                                    'Debe ingresar token_dispositivo');
  
    l_rsp.lugar   := 'Cargando datos del dispositivo';
    l_dispositivo := k_dispositivo.f_datos_dispositivo(k_dispositivo.f_id_dispositivo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                                           'token_dispositivo')));
  
    k_operacion.p_respuesta_ok(l_rsp, l_dispositivo);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function registrar_ubicacion(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'token_dispositivo') is not null,
                                    'Debe ingresar token_dispositivo');
  
    l_rsp.lugar := 'Registrando ubicación del dispositivo';
    k_dispositivo.p_registrar_ubicacion(k_dispositivo.f_id_dispositivo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                            'token_dispositivo')),
                                        k_operacion.f_valor_parametro_number(i_parametros,
                                                                             'latitud'),
                                        k_operacion.f_valor_parametro_number(i_parametros,
                                                                             'longitud'));
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function tiempo_expiracion_token(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tipo_token') is not null,
                                    'Debe ingresar tipo_token');
  
    l_rsp.lugar      := 'Obteniendo tiempo de expiración';
    l_dato.contenido := to_char(k_sesion.f_tiempo_expiracion_token(k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion),
                                                                   k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                        'tipo_token')));
  
    if l_dato.contenido is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    'aut0003',
                                    'Error al obtener tiempo de expiración');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function editar_usuario(i_parametros in y_parametros) return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parámetros';
    /* TODO: text="Implementar validación de parámetros" */
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario_antiguo') is not null,
                                    'Debe ingresar usuario_antiguo');
  
    l_rsp.lugar := 'Editando usuario';
    k_autenticacion.p_editar_usuario(k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'usuario_antiguo'),
                                     k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'usuario_nuevo'),
                                     k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'nombre'),
                                     k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'apellido'),
                                     k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'direccion_correo'),
                                     k_operacion.f_valor_parametro_string(i_parametros,
                                                                          'numero_telefono'));
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function editar_dato_usuario(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario') is not null,
                                    'Debe ingresar usuario');
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'campo') is not null,
                                    'Debe ingresar campo');
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'dato') is not null,
                                    'Debe ingresar dato');
  
    l_rsp.lugar := 'Editando dato del usuario';
    k_usuario.p_guardar_dato_string(k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'usuario'),
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'campo'),
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'dato'));
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function generar_otp(i_parametros in y_parametros) return y_respuesta is
    l_rsp    y_respuesta;
    l_dato   y_dato;
    l_secret varchar2(100);
    l_otp    varchar2(100);
    l_body   clob;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tipo_mensajeria') is not null,
                                    'Debe ingresar tipo_mensajeria');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tipo_mensajeria') in
                                    ('M', 'S', 'P'),
                                    'Valor no válido para tipo_mensajeria');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'destino') is not null,
                                    'Debe ingresar destino');
  
    l_rsp.lugar := 'Generando secret';
    l_secret    := oos_util_totp.generate_secret;
  
    l_rsp.lugar := 'Generando OTP';
    l_otp       := oos_util_totp.generate_otp(l_secret);
  
    $if k_modulo.c_instalado_msj $then
    l_rsp.lugar := 'Enviando mensajería';
    case
     k_operacion.f_valor_parametro_string(i_parametros, 'tipo_mensajeria')
    
      when 'M' then
        -- Mail
        l_body := k_mensajeria.f_correo_html('Tu clave de validación es ' ||
                                             l_otp,
                                             'Clave de validación',
                                             'Clave de validación');
      
        if k_mensajeria.f_enviar_correo('Clave de validación',
                                        l_body,
                                        null,
                                        k_operacion.f_valor_parametro_string(i_parametros,
                                                                             'destino'),
                                        null,
                                        null,
                                        null,
                                        null,
                                        k_mensajeria.c_prioridad_urgente) <>
           k_mensajeria.c_ok then
          k_operacion.p_respuesta_error(l_rsp,
                                        'aut0001',
                                        'Error al enviar Mail');
          raise k_operacion.ex_error_general;
        end if;
      
      when 'S' then
        -- SMS
        if k_mensajeria.f_enviar_mensaje('Tu clave de validación es ' ||
                                         l_otp,
                                         null,
                                         k_operacion.f_valor_parametro_string(i_parametros,
                                                                              'destino'),
                                         k_mensajeria.c_prioridad_urgente) <>
           k_mensajeria.c_ok then
          k_operacion.p_respuesta_error(l_rsp,
                                        'aut0002',
                                        'Error al enviar SMS');
          raise k_operacion.ex_error_general;
        end if;
      
      when 'P' then
        -- Push
        null;
      
    end case;
    $end
  
    l_dato.contenido := l_secret;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function validar_otp(i_parametros in y_parametros) return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'secret') is not null,
                                    'Debe ingresar secret');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_number(i_parametros,
                                                                         'otp') is not null,
                                    'Debe ingresar otp');
  
    l_rsp.lugar := 'Validando OTP';
    begin
      if oos_util_totp.validate_otp(k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'secret'),
                                    k_operacion.f_valor_parametro_number(i_parametros,
                                                                         'otp'),
                                    to_number(k_util.f_valor_parametro('TIEMPO_TOLERANCIA_VALIDAR_OTP'))) <> 1 then
        k_operacion.p_respuesta_error(l_rsp, 'aut0001', 'OTP inválido');
        raise k_operacion.ex_error_general;
      end if;
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp, 'aut0002', 'OTP inválido');
        raise k_operacion.ex_error_general;
    end;
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function validar_permiso(i_parametros in y_parametros) return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'id_permiso') is not null,
                                    'Debe ingresar permiso');
  
    l_rsp.lugar := 'Validando permiso';
    if not
        k_autorizacion.f_validar_permiso(k_usuario.f_id_usuario(k_sistema.f_usuario),
                                         k_operacion.f_valor_parametro_string(i_parametros,
                                                                              'id_permiso'),
                                         k_operacion.f_valor_parametro_string(i_parametros,
                                                                              'accion')) then
      k_operacion.p_respuesta_error(l_rsp, 'aut0001', 'Sin autorización');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

end;
/
