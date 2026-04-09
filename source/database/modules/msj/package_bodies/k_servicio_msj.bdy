create or replace package body k_servicio_msj is

  function lf_adjuntos(i_id_correo in number) return y_objetos is
    l_adjuntos y_objetos;
    l_archivo  y_archivo;
  
    cursor cr_elementos is
      select id_correo_adjunto
        from t_correo_adjuntos
       where id_correo = i_id_correo
       order by id_correo_adjunto;
  begin
    -- Inicializa respuesta
    l_adjuntos := new y_objetos();
  
    for ele in cr_elementos loop
      l_archivo := k_archivo.f_recuperar_archivo('T_CORREO_ADJUNTOS',
                                                 'ARCHIVO',
                                                 to_char(ele.id_correo_adjunto));
      if (l_archivo.contenido is null or
         dbms_lob.getlength(l_archivo.contenido) = 0) and
         l_archivo.url is null then
        continue;
      end if;
      l_adjuntos.extend;
      l_adjuntos(l_adjuntos.count) := l_archivo;
    end loop;
  
    return l_adjuntos;
  end;

  function listar_correos_pendientes(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_correo;
  
    cursor cr_elementos is
      select id_correo,
             id_usuario,
             destinatario,
             asunto,
             contenido,
             remitente,
             destino_respuesta,
             destinatario_cc,
             destinatario_bcc,
             estado,
             fecha_envio,
             respuesta_envio
        from t_correos
       where estado in ('P', 'R')
      -- P-PENDIENTE DE ENVÍO
      -- R-PROCESADO CON ERROR
       order by k_mensajeria.c_prioridad_media, id_correo
         for update of estado;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    l_rsp.lugar := 'Validando parametros';
  
    -- Sólo si está activo el envío
    if k_util.string_to_bool(k_util.f_valor_parametro('ENVIO_CORREOS_ACTIVO')) then
      for ele in cr_elementos loop
        l_elemento                  := new y_correo();
        l_elemento.id_correo        := ele.id_correo;
        l_elemento.destinatario      := ele.destinatario;
        l_elemento.asunto            := ele.asunto;
        l_elemento.contenido         := ele.contenido;
        l_elemento.remitente         := ele.remitente;
        l_elemento.destino_respuesta := ele.destino_respuesta;
        l_elemento.destinatario_cc   := ele.destinatario_cc;
        l_elemento.destinatario_bcc  := ele.destinatario_bcc;
        l_elemento.adjuntos         := lf_adjuntos(ele.id_correo);
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        update t_correos
           set estado = 'N' -- N-EN PROCESO DE ENVÍO
         where current of cr_elementos;
      end loop;
    end if;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               k_servicio.f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  function listar_mensajes_pendientes(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_mensaje;
  
    cursor cr_elementos is
      select id_mensaje, numero_telefono, contenido, estado
        from t_mensajes
       where estado in ('P', 'R')
      -- P-PENDIENTE DE ENVÍO
      -- R-PROCESADO CON ERROR
       order by k_mensajeria.c_prioridad_media, id_mensaje
         for update of estado;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    l_rsp.lugar := 'Validando parametros';
  
    -- Sólo si está activo el envío
    if k_util.string_to_bool(k_util.f_valor_parametro('ENVIO_MENSAJES_ACTIVO')) then
      for ele in cr_elementos loop
        l_elemento                 := new y_mensaje();
        l_elemento.id_mensaje      := ele.id_mensaje;
        l_elemento.numero_telefono := ele.numero_telefono;
        l_elemento.contenido       := ele.contenido;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        update t_mensajes
           set estado = 'N' -- N-EN PROCESO DE ENVÍO
         where current of cr_elementos;
      end loop;
    end if;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               k_servicio.f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  function listar_notificaciones_pendientes(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_notificacion;
  
    cursor cr_elementos is
      select id_notificacion,
             suscripcion,
             titulo,
             contenido,
             estado,
             datos_extra
        from t_notificaciones
       where estado in ('P', 'R')
      -- P-PENDIENTE DE ENVÍO
      -- R-PROCESADO CON ERROR
       order by k_mensajeria.c_prioridad_media, id_notificacion
         for update of estado;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    l_rsp.lugar := 'Validando parametros';
  
    -- Sólo si está activo el envío
    if k_util.string_to_bool(k_util.f_valor_parametro('ENVIO_NOTIFICACIONES_ACTIVO')) then
      for ele in cr_elementos loop
        l_elemento                 := new y_notificacion();
        l_elemento.id_notificacion := ele.id_notificacion;
        l_elemento.suscripcion     := ele.suscripcion;
        l_elemento.titulo          := ele.titulo;
        l_elemento.contenido       := ele.contenido;
        l_elemento.datos_extra     := ele.datos_extra;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        update t_notificaciones
           set estado = 'N' -- N-EN PROCESO DE ENVÍO
         where current of cr_elementos;
      end loop;
    end if;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               k_servicio.f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  function cambiar_estado_mensajeria(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp                          y_respuesta;
    l_cantidad_intentos_permitidos pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
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
                                    k_operacion.f_valor_parametro_number(i_parametros,
                                                                         'id_mensajeria') is not null,
                                    'Debe ingresar id_mensajeria');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'estado') is not null,
                                    'Debe ingresar estado');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'respuesta_envio') is not null,
                                    'Debe ingresar respuesta_envio');
  
    l_cantidad_intentos_permitidos := to_number(k_util.f_valor_parametro('MENSAJERIA_CANTIDAD_INTENTOS_PERMITIDOS'));
  
    l_rsp.lugar := 'Cambiando estado de mensajería';
    case
     k_operacion.f_valor_parametro_string(i_parametros, 'tipo_mensajeria')
    
      when 'M' then
        -- Mail
        update t_correos m
           set m.cantidad_intentos_envio = nvl(m.cantidad_intentos_envio, 0) + 1,
               m.estado                  = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('R') and
                                                  nvl(m.cantidad_intentos_envio, 0) >= l_cantidad_intentos_permitidos then
                                              'A' -- ANULADO
                                             else
                                              k_operacion.f_valor_parametro_string(i_parametros, 'estado')
                                           end,
               m.respuesta_envio         = substr(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                       'respuesta_envio'),
                                                  1,
                                                  1000),
               m.fecha_envio             = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('E', 'R') then
                                              sysdate
                                             else
                                              null
                                           end
         where m.id_correo =
               k_operacion.f_valor_parametro_number(i_parametros,
                                                    'id_mensajeria');
      
      when 'S' then
        -- SMS
        update t_mensajes m
           set m.cantidad_intentos_envio = nvl(m.cantidad_intentos_envio, 0) + 1,
               m.estado                  = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('R') and
                                                  nvl(m.cantidad_intentos_envio, 0) >= l_cantidad_intentos_permitidos then
                                              'A' -- ANULADO
                                             else
                                              k_operacion.f_valor_parametro_string(i_parametros, 'estado')
                                           end,
               m.respuesta_envio         = substr(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                       'respuesta_envio'),
                                                  1,
                                                  1000),
               m.fecha_envio             = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('E', 'R') then
                                              sysdate
                                             else
                                              null
                                           end
         where m.id_mensaje =
               k_operacion.f_valor_parametro_number(i_parametros,
                                                    'id_mensajeria');
      
      when 'P' then
        -- Push
        update t_notificaciones m
           set m.cantidad_intentos_envio = nvl(m.cantidad_intentos_envio, 0) + 1,
               m.estado                  = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('R') and
                                                  nvl(m.cantidad_intentos_envio, 0) >= l_cantidad_intentos_permitidos then
                                              'A' -- ANULADO
                                             else
                                              k_operacion.f_valor_parametro_string(i_parametros, 'estado')
                                           end,
               m.respuesta_envio         = substr(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                       'respuesta_envio'),
                                                  1,
                                                  1000),
               m.fecha_envio             = case
                                             when k_operacion.f_valor_parametro_string(i_parametros, 'estado') in
                                                  ('E', 'R') then
                                              sysdate
                                             else
                                              null
                                           end
         where m.id_notificacion =
               k_operacion.f_valor_parametro_number(i_parametros,
                                                    'id_mensajeria');
      
    end case;
  
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

  function activar_desactivar_mensajeria(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp y_respuesta;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
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
                                                                         'estado') is not null,
                                    'Debe ingresar estado');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'estado') in
                                    ('S', 'N'),
                                    'Valor no válido para estado');
  
    l_rsp.lugar := 'Cambiando valor del parámetro';
    k_util.p_actualizar_valor_parametro(case
                                        k_operacion.f_valor_parametro_string(i_parametros,
                                                                             'tipo_mensajeria') when 'M' then
                                        'ENVIO_CORREOS_ACTIVO' when 'S' then
                                        'ENVIO_MENSAJES_ACTIVO' when 'P' then
                                        'ENVIO_NOTIFICACIONES_ACTIVO' end,
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

end;
/

