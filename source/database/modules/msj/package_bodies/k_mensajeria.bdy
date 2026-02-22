create or replace package body k_mensajeria is

  function f_validar_direccion_correo(i_direccion_correo varchar2)
    return boolean is
  begin
    return regexp_like(i_direccion_correo,
                       k_util.f_valor_parametro('REGEXP_VALIDAR_DIRECCION_CORREO'));
  end;

  function f_validar_numero_telefono(i_numero_telefono varchar2)
    return boolean is
  begin
    return regexp_like(i_numero_telefono,
                       k_util.f_valor_parametro('REGEXP_VALIDAR_NUMERO_TELEFONO'));
  end;

  function f_direccion_correo_usuario(i_id_usuario in number) return varchar2 is
    l_direccion_correo t_usuarios.direccion_correo%type;
  begin
    begin
      select direccion_correo
        into l_direccion_correo
        from t_usuarios
       where id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_direccion_correo := null;
    end;
    return l_direccion_correo;
  end;

  function f_numero_telefono_usuario(i_id_usuario in number) return varchar2 is
    l_numero_telefono t_usuarios.numero_telefono%type;
  begin
    begin
      select numero_telefono
        into l_numero_telefono
        from t_usuarios
       where id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_numero_telefono := null;
    end;
    return l_numero_telefono;
  end;

  function f_correo_html(i_contenido      in varchar2,
                         i_titulo         in varchar2 default null,
                         i_encabezado     in varchar2 default null,
                         i_pie            in varchar2 default null,
                         i_boton_etiqueta in varchar2 default null,
                         i_boton_accion   in varchar2 default null)
    return clob is
    l_html      clob;
    l_contenido clob;
    l_archivo   y_archivo;
  begin
    l_archivo := k_archivo.f_recuperar_archivo(k_archivo.c_carpeta_textos,
                                               'ARCHIVO',
                                               'email-inlined.html');
  
    if l_archivo.contenido is null or
       dbms_lob.getlength(l_archivo.contenido) = 0 then
      raise_application_error(-20000, 'Template de correo no definido');
    end if;
  
    l_html := k_util.blob_to_clob(l_archivo.contenido);
  
    -- Reemplaza CRLF por <br> en el contenido
    l_contenido := replace(i_contenido, utl_tcp.crlf, '<br>');
  
    l_html := replace(l_html, '&CONTENIDO', l_contenido);
    l_html := replace(l_html, '&TITULO', i_titulo);
    l_html := replace(l_html, '&ENCABEZADO', i_encabezado);
    l_html := replace(l_html, '&PIE', i_pie);
  
    if i_boton_etiqueta is not null and i_boton_accion is not null then
      l_html := replace(l_html, '&BOTON_ETIQUETA', i_boton_etiqueta);
      l_html := replace(l_html, '&BOTON_ACCION', i_boton_accion);
      l_html := replace(l_html, '&BOTON_HIDDEN');
    else
      l_html := replace(l_html, '&BOTON_HIDDEN', 'style="display: none;"');
    end if;
  
    return l_html;
  end;

  function f_correo_tabla_html(i_tabla      in varchar2,
                               i_titulo     in varchar2 default null,
                               i_encabezado in varchar2 default null,
                               i_pie        in varchar2 default null)
    return clob is
    l_html    clob;
    l_tabla   clob;
    l_archivo y_archivo;
  begin
    l_archivo := k_archivo.f_recuperar_archivo(k_archivo.c_carpeta_textos,
                                               'ARCHIVO',
                                               'email-table-inlined.html');
  
    if l_archivo.contenido is null or
       dbms_lob.getlength(l_archivo.contenido) = 0 then
      raise_application_error(-20000, 'Template de correo no definido');
    end if;
  
    l_html := k_util.blob_to_clob(l_archivo.contenido);
  
    -- Reemplaza CRLF por <br> en el contenido
    l_tabla := replace(i_tabla, utl_tcp.crlf, '<br>');
  
    l_html := replace(l_html, '&TITULO_TABLA', i_titulo);
    l_html := replace(l_html, '&TABLA', l_tabla);
    l_html := replace(l_html, '&PIE_TABLA', i_pie);
    l_html := replace(l_html, '&TITULO', i_titulo);
    l_html := replace(l_html, '&ENCABEZADO', i_encabezado);
  
    return l_html;
  end;

  function f_correo_tabla_aux_html(i_tabla       in varchar2,
                                   i_tabla_aux_1 in varchar2 default null,
                                   i_tabla_aux_2 in varchar2 default null,
                                   i_tabla_aux_3 in varchar2 default null,
                                   i_titulo      in varchar2 default null,
                                   i_encabezado  in varchar2 default null,
                                   i_pie         in varchar2 default null)
    return clob is
    l_html        clob;
    l_tabla       clob;
    l_tabla_aux_1 clob;
    l_tabla_aux_2 clob;
    l_tabla_aux_3 clob;
    l_archivo     y_archivo;
  begin
    l_archivo := k_archivo.f_recuperar_archivo(k_archivo.c_carpeta_textos,
                                               'ARCHIVO',
                                               'email-table-aux-inlined.html');
  
    if l_archivo.contenido is null or
       dbms_lob.getlength(l_archivo.contenido) = 0 then
      raise_application_error(-20000, 'Template de correo no definido');
    end if;
  
    l_html := k_util.blob_to_clob(l_archivo.contenido);
  
    -- Reemplaza CRLF por <br> en el contenido
    l_tabla       := replace(i_tabla, utl_tcp.crlf, '<br>');
    l_tabla_aux_1 := replace(i_tabla_aux_1, utl_tcp.crlf, '<br>');
    l_tabla_aux_2 := replace(i_tabla_aux_2, utl_tcp.crlf, '<br>');
    l_tabla_aux_3 := replace(i_tabla_aux_3, utl_tcp.crlf, '<br>');
  
    l_html := replace(l_html, '&TITULO_TABLA', i_titulo);
    l_html := replace(l_html, '&TABLA', l_tabla);
    l_html := replace(l_html, '&AUX_TABLA1', l_tabla_aux_1);
    l_html := replace(l_html, '&AUX_TABLA2', l_tabla_aux_2);
    l_html := replace(l_html, '&AUX_TABLA3', l_tabla_aux_3);
    l_html := replace(l_html, '&PIE_TABLA', i_pie);
    l_html := replace(l_html, '&TITULO', i_titulo);
    l_html := replace(l_html, '&ENCABEZADO', i_encabezado);
  
    return l_html;
  end;

  procedure p_enviar_correo(i_subject         in varchar2,
                            i_body            in clob,
                            i_id_usuario      in number default null,
                            i_to              in varchar2 default null,
                            i_reply_to        in varchar2 default null,
                            i_cc              in varchar2 default null,
                            i_bcc             in varchar2 default null,
                            i_adjuntos        in y_objetos default null,
                            i_prioridad_envio in number default null) is
    l_mensaje_to        t_correos.mensaje_to%type;
    l_id_correo         t_correos.id_correo%type;
    l_id_correo_adjunto t_correo_adjuntos.id_correo_adjunto%type;
    i                   integer;
  begin
    l_mensaje_to := i_to;
  
    if i_id_usuario is not null and l_mensaje_to is null then
      l_mensaje_to := f_direccion_correo_usuario(i_id_usuario);
    end if;
  
    if l_mensaje_to is null then
      raise_application_error(-20000,
                              'Dirección de correo destino obligatorio');
    end if;
  
    if i_subject is null then
      raise_application_error(-20000, 'Asunto del mensaje obligatorio');
    end if;
  
    if i_body is null then
      raise_application_error(-20000, 'Cuerpo del mensaje obligatorio');
    end if;
  
    if not k_sistema.f_es_produccion then
      l_mensaje_to := k_util.f_valor_parametro('DIRECCION_CORREO_PRUEBAS');
    end if;
  
    insert into t_correos
      (id_usuario,
       mensaje_to,
       mensaje_subject,
       mensaje_body,
       mensaje_from,
       mensaje_reply_to,
       mensaje_cc,
       mensaje_bcc,
       estado,
       prioridad_envio)
    values
      (i_id_usuario,
       l_mensaje_to,
       i_subject,
       i_body,
       k_util.f_valor_parametro('DIRECCION_CORREO_REMITENTE'),
       i_reply_to,
       i_cc,
       i_bcc,
       'P',
       nvl(i_prioridad_envio, c_prioridad_media))
    returning id_correo into l_id_correo;
  
    if i_adjuntos is not null then
      i := i_adjuntos.first;
      while i is not null loop
        insert into t_correo_adjuntos
          (id_correo)
        values
          (l_id_correo)
        returning id_correo_adjunto into l_id_correo_adjunto;
      
        k_archivo.p_guardar_archivo('T_CORREO_ADJUNTOS',
                                    'ARCHIVO',
                                    to_char(l_id_correo_adjunto),
                                    treat(i_adjuntos(i) as y_archivo));
      
        i := i_adjuntos.next(i);
      end loop;
    end if;
  end;

  procedure p_enviar_mensaje(i_contenido       in varchar2,
                             i_id_usuario      in number default null,
                             i_numero_telefono in varchar2 default null,
                             i_prioridad_envio in number default null) is
    l_numero_telefono t_mensajes.numero_telefono%type;
  begin
    l_numero_telefono := i_numero_telefono;
  
    if i_id_usuario is not null and l_numero_telefono is null then
      l_numero_telefono := f_numero_telefono_usuario(i_id_usuario);
    end if;
  
    if l_numero_telefono is null then
      raise_application_error(-20000,
                              'Número de teléfono destino obligatorio');
    end if;
  
    if i_contenido is null then
      raise_application_error(-20000, 'Contenido del mensaje obligatorio');
    end if;
  
    if not k_sistema.f_es_produccion then
      l_numero_telefono := k_util.f_valor_parametro('NUMERO_TELEFONO_PRUEBAS');
    end if;
  
    insert into t_mensajes
      (id_usuario, numero_telefono, contenido, estado, prioridad_envio)
    values
      (i_id_usuario,
       l_numero_telefono,
       substr(i_contenido, 1, 160),
       'P',
       nvl(i_prioridad_envio, c_prioridad_media));
  end;

  procedure p_enviar_notificacion(i_titulo          in varchar2,
                                  i_contenido       in varchar2,
                                  i_id_usuario      in number default null,
                                  i_suscripcion     in varchar2 default null,
                                  i_prioridad_envio in number default null,
                                  i_datos_extra     in varchar2 default null) is
    l_suscripcion t_notificaciones.suscripcion%type;
  begin
    l_suscripcion := i_suscripcion;
  
    if i_id_usuario is not null then
      if l_suscripcion is null then
        l_suscripcion := k_dispositivo.c_suscripcion_usuario || '_' ||
                         to_char(i_id_usuario);
      else
        l_suscripcion := l_suscripcion || '&&' ||
                         k_dispositivo.c_suscripcion_usuario || '_' ||
                         to_char(i_id_usuario);
      end if;
    end if;
  
    if l_suscripcion is null then
      raise_application_error(-20000,
                              'Tag o expresión destino obligatorio');
    end if;
  
    if not k_sistema.f_es_produccion then
      l_suscripcion := k_util.f_valor_parametro('SUSCRIPCION_PRUEBAS');
    end if;
  
    insert into t_notificaciones
      (id_usuario,
       suscripcion,
       titulo,
       contenido,
       estado,
       prioridad_envio,
       datos_extra)
    values
      (i_id_usuario,
       l_suscripcion,
       substr(i_titulo, 1, 160),
       substr(i_contenido, 1, 500),
       'P',
       nvl(i_prioridad_envio, c_prioridad_media),
       i_datos_extra);
  end;

  function f_enviar_correo(i_subject         in varchar2,
                           i_body            in clob,
                           i_id_usuario      in number default null,
                           i_to              in varchar2 default null,
                           i_reply_to        in varchar2 default null,
                           i_cc              in varchar2 default null,
                           i_bcc             in varchar2 default null,
                           i_adjuntos        in y_objetos default null,
                           i_prioridad_envio in number default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_correo(i_subject,
                    i_body,
                    i_id_usuario,
                    i_to,
                    i_reply_to,
                    i_cc,
                    i_bcc,
                    i_adjuntos,
                    i_prioridad_envio);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

  function f_enviar_mensaje(i_contenido       in varchar2,
                            i_id_usuario      in number default null,
                            i_numero_telefono in varchar2 default null,
                            i_prioridad_envio in number default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_mensaje(i_contenido,
                     i_id_usuario,
                     i_numero_telefono,
                     i_prioridad_envio);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

  function f_enviar_notificacion(i_titulo          in varchar2,
                                 i_contenido       in varchar2,
                                 i_id_usuario      in number default null,
                                 i_suscripcion     in varchar2 default null,
                                 i_prioridad_envio in number default null,
                                 i_datos_extra     in varchar2 default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_notificacion(i_titulo,
                          i_contenido,
                          i_id_usuario,
                          i_suscripcion,
                          i_prioridad_envio,
                          i_datos_extra);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

end;
/

