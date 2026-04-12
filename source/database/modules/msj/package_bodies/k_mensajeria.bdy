create or replace package body k_mensajeria is

  function fl_reemplazar_expresion(i_plantilla   in varchar2,
                                   i_datos_extra in clob default null)
    return clob is
    l_resultado clob;
    l_variables varchar2(4000);
  
    cursor cl_variables_pendientes(i_texto in varchar2) is
      select column_value as variable
        from table(k_cadena.f_extraer_cadenas(i_texto,
                                              c_encapsulador_inicial,
                                              c_encapsulador_final,
                                              'S'));
  
  begin
    if i_datos_extra is not null then
      l_resultado := k_json_util.f_reemplazar_expresion_clob(i_expresion            => i_plantilla,
                                                             i_valores              => i_datos_extra,
                                                             i_encapsulador_inicial => c_encapsulador_inicial,
                                                             i_encapsulador_final   => c_encapsulador_final);
    else
      l_resultado := i_plantilla;
    end if;
  
    if l_resultado like
       '%' || c_encapsulador_inicial || '%' || c_encapsulador_final || '%' then
      for c in cl_variables_pendientes(l_resultado) loop
      
        if c.variable = c_variable_entidad then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_entidad || c_encapsulador_final,
                                 k_util.f_valor_parametro('NOMBRE_FANTASIA_ENTIDAD'));
        
        elsif c.variable = c_variable_nombre_entidad then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_nombre_entidad ||
                                 c_encapsulador_final,
                                 k_util.f_valor_parametro('NOMBRE_ENTIDAD'));
        
        elsif c.variable = c_variable_url_logo then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_url_logo || c_encapsulador_final,
                                 k_util.f_valor_parametro('URL_LOGO_ENTIDAD'));
        
        elsif c.variable = c_variable_telefono_entidad then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_telefono_entidad ||
                                 c_encapsulador_final,
                                 k_util.f_valor_parametro('NUMERO_TELEFONO_ENTIDAD'));
        
        elsif c.variable = c_variable_telefono_corto_entidad then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_telefono_corto_entidad ||
                                 c_encapsulador_final,
                                 k_util.f_valor_parametro('NUMERO_TELEFONO_CORTO_ENTIDAD'));
        
        elsif c.variable = c_variable_whatsapp_entidad then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_whatsapp_entidad ||
                                 c_encapsulador_final,
                                 k_util.f_valor_parametro('NUMERO_WHATSAPP_ENTIDAD'));
        
        elsif c.variable = c_variable_base_datos then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_base_datos ||
                                 c_encapsulador_final,
                                 upper(k_contexto.f_base_datos));
        
        elsif c.variable = c_variable_fecha then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial || c_variable_fecha ||
                                 c_encapsulador_final,
                                 to_char(sysdate, 'DD/MM/YYYY'));
        
        elsif c.variable = c_variable_fecha_hora then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_fecha_hora ||
                                 c_encapsulador_final,
                                 to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS'));
        
        elsif c.variable = c_variable_fecha_sistema then
          l_resultado := replace(l_resultado,
                                 c_encapsulador_inicial ||
                                 c_variable_fecha_sistema ||
                                 c_encapsulador_final,
                                 k_sistema.f_fecha);
        
        end if;
      
      end loop;
    end if;
  
    if l_resultado like
       '%' || c_encapsulador_inicial || '%' || c_encapsulador_final || '%' then
      select substr(listagg(column_value, ', '), 1, 4000) as variables
        into l_variables
        from table(k_cadena.f_extraer_cadenas(l_resultado,
                                              c_encapsulador_inicial,
                                              c_encapsulador_final,
                                              'N'));
    
      raise_application_error(-20000,
                              'No todas las variables han sido enlazadas: ' ||
                              l_variables || '.');
    end if;
    return l_resultado;
  end;

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
  begin
    return k_usuario.f_direccion_correo_usuario(i_id_usuario);
  end;

  function f_numero_telefono_usuario(i_id_usuario in number) return varchar2 is
  begin
    return k_usuario.f_numero_telefono_usuario(i_id_usuario);
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

  function f_correo_tabla_html_clob(i_tabla      in clob,
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
  
    -- Reemplaza CRLF por <br> en el contenido (ahora con CLOB)
    l_tabla := replace(i_tabla, utl_tcp.crlf, '<br>');
  
    l_html := replace(l_html, '&TITULO_TABLA', i_titulo);
    l_html := f_clob_replace(l_html, '&TABLA', l_tabla);
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

  function f_enviar_correo_id(i_id_plantilla      varchar2,
                              i_datos_extra       clob default null,
                              i_id_usuario        number default null,
                              i_destinatario      varchar2 default null,
                              i_destino_respuesta varchar2 default null,
                              i_destinatario_cc   varchar2 default null,
                              i_destinatario_bcc  varchar2 default null,
                              i_adjuntos          y_objetos default null)
    return t_correos.id_correo%type is
    l_plantilla_asunto    t_correo_plantillas.plantilla_asunto%type;
    l_plantilla_contenido t_correo_plantillas.plantilla_contenido%type;
    l_asunto              t_correos.asunto%type;
    l_contenido           t_correos.contenido%type;
    l_destinatario        t_correos.destinatario%type;
    l_destino_respuesta   t_correos.destino_respuesta%type;
    l_destinatario_cc     t_correos.destinatario_cc%type;
    l_destinatario_bcc    t_correos.destinatario_bcc%type;
    l_id_correo           t_correos.id_correo%type;
    l_id_correo_adjunto   t_correo_adjuntos.id_correo_adjunto%type;
    l_id_categoria        t_mensajes.id_categoria%type;
    i                     integer;
  begin
    l_destinatario      := i_destinatario;
    l_destino_respuesta := i_destino_respuesta;
    l_destinatario_cc   := i_destinatario_cc;
    l_destinatario_bcc  := i_destinatario_bcc;
  
    if i_id_usuario is not null and l_destinatario is null then
      l_destinatario := f_direccion_correo_usuario(i_id_usuario);
    end if;
  
    if l_destinatario is null then
      raise_application_error(-20000,
                              'Dirección de correo destino obligatorio');
    end if;
  
    if i_id_plantilla is null then
      raise_application_error(-20000, 'Plantilla del mensaje obligatorio');
    end if;
  
    if not (i_datos_extra is json) then
      raise_application_error(-20000,
                              'Formato no válida para los datos extra. Debe ser formato JSON');
    end if;
  
    begin
      select a.plantilla_asunto, a.plantilla_contenido, a.id_categoria
        into l_plantilla_asunto, l_plantilla_contenido, l_id_categoria
        from t_correo_plantillas a, t_mensajeria_categorias b
       where a.id_plantilla = i_id_plantilla
         and a.id_categoria = b.id_categoria;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Plantilla del mensaje inexistente');
    end;
  
    if not k_sistema.f_es_produccion then
      l_destinatario      := k_util.f_valor_parametro('DIRECCION_CORREO_PRUEBAS');
      l_destino_respuesta := null;
      l_destinatario_cc   := null;
      l_destinatario_bcc  := null;
    end if;
  
    l_asunto := substr(fl_reemplazar_expresion(l_plantilla_asunto,
                                               i_datos_extra),
                       1,
                       2000);
  
    l_contenido := fl_reemplazar_expresion(l_plantilla_contenido,
                                           i_datos_extra);
  
    insert into t_correos
      (id_usuario,
       destinatario,
       asunto,
       contenido,
       id_categoria,
       remitente,
       destino_respuesta,
       destinatario_cc,
       destinatario_bcc)
    values
      (i_id_usuario,
       l_destinatario,
       l_asunto,
       l_contenido,
       l_id_categoria,
       k_util.f_valor_parametro('DIRECCION_CORREO_REMITENTE'),
       l_destino_respuesta,
       l_destinatario_cc,
       l_destinatario_bcc)
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
  
    return l_id_correo;
  end f_enviar_correo_id;

  procedure p_enviar_correo(i_id_plantilla      in varchar2,
                            i_datos_extra       in clob default null,
                            i_id_usuario        in number default null,
                            i_destinatario      in varchar2 default null,
                            i_destino_respuesta in varchar2 default null,
                            i_destinatario_cc   in varchar2 default null,
                            i_destinatario_bcc  in varchar2 default null,
                            i_adjuntos          in y_objetos default null) is
    vl_id_correo t_correos.id_correo%type;
  begin
    vl_id_correo := f_enviar_correo_id(i_id_plantilla      => i_id_plantilla,
                                       i_datos_extra       => i_datos_extra,
                                       i_id_usuario        => i_id_usuario,
                                       i_destinatario      => i_destinatario,
                                       i_destino_respuesta => i_destino_respuesta,
                                       i_destinatario_cc   => i_destinatario_cc,
                                       i_destinatario_bcc  => i_destinatario_bcc,
                                       i_adjuntos          => i_adjuntos);
  end p_enviar_correo;

  function f_enviar_mensaje_id(i_id_plantilla    varchar2,
                               i_datos_extra     clob default null,
                               i_id_usuario      number default null,
                               i_numero_telefono varchar2 default null)
    return t_mensajes.id_mensaje%type is
    l_plantilla       t_mensaje_plantillas.plantilla%type;
    l_contenido       t_mensajes.contenido%type;
    l_numero_telefono t_mensajes.numero_telefono%type;
    l_id_categoria    t_mensajes.id_categoria%type;
    l_telefonia       t_mensajes.telefonia%type;
    l_id_mensaje      t_mensajes.id_mensaje%type;
  begin
    l_numero_telefono := i_numero_telefono;
  
    if i_id_usuario is not null and l_numero_telefono is null then
      l_numero_telefono := f_numero_telefono_usuario(i_id_usuario);
    end if;
  
    if l_numero_telefono is null then
      raise_application_error(-20000,
                              'Número de teléfono destino obligatorio');
    end if;
  
    if i_id_plantilla is null then
      raise_application_error(-20000, 'Plantilla del mensaje obligatorio');
    end if;
  
    if not (i_datos_extra is json) then
      raise_application_error(-20000,
                              'Formato no válida para los datos extra. Debe ser formato JSON');
    end if;
  
    begin
      select a.plantilla, a.id_categoria, b.telefonia
        into l_plantilla, l_id_categoria, l_telefonia
        from t_mensaje_plantillas a, t_mensajeria_categorias b
       where a.id_plantilla = i_id_plantilla
         and a.id_categoria = b.id_categoria;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Plantilla del mensaje inexistente');
    end;
  
    if not k_sistema.f_es_produccion then
      l_numero_telefono := k_util.f_valor_parametro('NUMERO_TELEFONO_PRUEBAS');
    end if;
  
    l_contenido := substr(fl_reemplazar_expresion(l_plantilla,
                                                  i_datos_extra),
                          1,
                          160);
    insert into t_mensajes
      (id_usuario, numero_telefono, contenido, id_categoria, telefonia)
    values
      (i_id_usuario,
       l_numero_telefono,
       l_contenido,
       l_id_categoria,
       l_telefonia)
    returning id_mensaje into l_id_mensaje;
  
    return l_id_mensaje;
  end f_enviar_mensaje_id;

  procedure p_enviar_mensaje(i_id_plantilla    in varchar2,
                             i_datos_extra     in clob default null,
                             i_id_usuario      in number default null,
                             i_numero_telefono in varchar2 default null) is
    vl_id_mensaje t_mensajes.id_mensaje%type;
  begin
    vl_id_mensaje := f_enviar_mensaje_id(i_id_plantilla    => i_id_plantilla,
                                         i_datos_extra     => i_datos_extra,
                                         i_id_usuario      => i_id_usuario,
                                         i_numero_telefono => i_numero_telefono);
  end p_enviar_mensaje;

  function f_enviar_notificacion_id(i_id_plantilla       varchar2,
                                    i_datos_extra        clob default null,
                                    i_id_usuario         number default null,
                                    i_suscripcion        varchar2 default null,
                                    i_token_notificacion varchar2 default null,
                                    i_dispositivo_seguro varchar2 default null,
                                    i_id_aplicacion      varchar2 default null)
    return t_notificaciones.id_notificacion%type is
    l_suscripcion        t_notificaciones.suscripcion%type;
    l_token_notificacion t_notificaciones.token_notificacion%type;
    l_dispositivo_seguro char(1);
    --
    l_plantilla_titulo      t_notificacion_plantillas.plantilla_titulo%type;
    l_plantilla_contenido   t_notificacion_plantillas.plantilla_contenido%type;
    l_plantilla_datos_extra t_notificacion_plantillas.plantilla_datos_extra%type;
    --
    l_titulo          t_notificaciones.titulo%type;
    l_contenido       t_notificaciones.contenido%type;
    l_datos_extra     t_notificaciones.datos_extra%type;
    l_id_categoria    t_notificaciones.id_categoria%type;
    l_plataforma      t_notificaciones.plataforma%type;
    l_id_notificacion t_notificaciones.id_notificacion%type;
  begin
    if i_id_plantilla is null then
      raise_application_error(-20000, 'Plantilla del mensaje obligatorio');
    end if;
  
    if not (i_datos_extra is json) then
      raise_application_error(-20000,
                              'Formato no válida para los datos extra. Debe ser formato JSON');
    end if;
  
    l_suscripcion        := i_suscripcion;
    l_token_notificacion := i_token_notificacion;
    l_dispositivo_seguro := nvl(substr(i_dispositivo_seguro, 1, 1), 'S');
  
    if l_token_notificacion is null and l_suscripcion is null then
      raise_application_error(-20000,
                              'Token o suscripción de notificación destino obligatorio');
    end if;
  
    begin
      select a.plantilla_titulo,
             a.plantilla_contenido,
             a.plantilla_datos_extra,
             a.id_categoria,
             'FCM' plataforma --TODO
        into l_plantilla_titulo,
             l_plantilla_contenido,
             l_plantilla_datos_extra,
             l_id_categoria,
             l_plataforma
        from t_notificacion_plantillas a, t_mensajeria_categorias b
       where a.id_plantilla = i_id_plantilla
         and a.id_categoria = b.id_categoria
            -- opcional (deberia ser obligatorio, ya que id_aplicacion es un PK)
         and (i_id_aplicacion is null or a.id_aplicacion = i_id_aplicacion);
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Plantilla de notificacion inexistente');
    end;
  
    if not k_sistema.f_es_produccion then
      if l_suscripcion is not null then
        l_suscripcion := k_util.f_valor_parametro('SUSCRIPCION_PRUEBAS');
      end if;
    
      if l_token_notificacion is not null then
        l_token_notificacion := k_util.f_valor_parametro('TOKEN_NOTIFICACION_PRUEBAS');
      end if;
    end if;
  
    l_titulo := substr(fl_reemplazar_expresion(l_plantilla_titulo,
                                               i_datos_extra),
                       1,
                       160);
  
    l_contenido := substr(fl_reemplazar_expresion(l_plantilla_contenido,
                                                  i_datos_extra),
                          1,
                          500);
  
    l_datos_extra := fl_reemplazar_expresion(l_plantilla_datos_extra,
                                             i_datos_extra);
  
    insert into t_notificaciones
      (id_usuario,
       token_notificacion,
       suscripcion,
       titulo,
       contenido,
       estado,
       id_categoria,
       datos_extra,
       plataforma)
    values
      (i_id_usuario,
       l_token_notificacion,
       l_suscripcion,
       l_titulo,
       l_contenido,
       'P',
       l_id_categoria,
       l_datos_extra,
       l_plataforma)
    returning id_notificacion into l_id_notificacion;
  
    return l_id_notificacion;
  end f_enviar_notificacion_id;

  procedure p_enviar_notificacion(i_id_plantilla       in varchar2,
                                  i_datos_extra        in clob default null,
                                  i_id_usuario         in number default null,
                                  i_suscripcion        in varchar2 default null,
                                  i_token_notificacion in varchar2 default null,
                                  i_dispositivo_seguro in varchar2 default null,
                                  i_id_aplicacion      in varchar2 default null) is
    vl_id_notificacion t_notificaciones.id_notificacion%type;
  begin
    vl_id_notificacion := f_enviar_notificacion_id(i_id_plantilla       => i_id_plantilla,
                                                   i_datos_extra        => i_datos_extra,
                                                   i_id_usuario         => i_id_usuario,
                                                   i_suscripcion        => i_suscripcion,
                                                   i_token_notificacion => i_token_notificacion,
                                                   i_dispositivo_seguro => i_dispositivo_seguro,
                                                   i_id_aplicacion      => i_id_aplicacion);
  end p_enviar_notificacion;

  function f_enviar_correo(i_id_plantilla      in varchar2,
                           i_datos_extra       in clob default null,
                           i_id_usuario        in number default null,
                           i_destinatario      in varchar2 default null,
                           i_destino_respuesta in varchar2 default null,
                           i_destinatario_cc   in varchar2 default null,
                           i_destinatario_bcc  in varchar2 default null,
                           i_adjuntos          in y_objetos default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_correo(i_id_plantilla,
                    i_datos_extra,
                    i_id_usuario,
                    i_destinatario,
                    i_destino_respuesta,
                    i_destinatario_cc,
                    i_destinatario_bcc,
                    i_adjuntos);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

  function f_enviar_mensaje(i_id_plantilla    in varchar2,
                            i_datos_extra     in clob default null,
                            i_id_usuario      in number default null,
                            i_numero_telefono in varchar2 default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_mensaje(i_id_plantilla,
                     i_datos_extra,
                     i_id_usuario,
                     i_numero_telefono);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

  function f_enviar_notificacion(i_id_plantilla       in varchar2,
                                 i_datos_extra        in clob default null,
                                 i_id_usuario         in number default null,
                                 i_suscripcion        in varchar2 default null,
                                 i_token_notificacion in varchar2 default null,
                                 i_dispositivo_seguro in varchar2 default null)
    return pls_integer is
    pragma autonomous_transaction;
    l_rsp pls_integer;
  begin
    -- Inicializa respuesta
    l_rsp := 0;
  
    p_enviar_notificacion(i_id_plantilla,
                          i_datos_extra,
                          i_id_usuario,
                          i_suscripcion,
                          i_token_notificacion,
                          i_dispositivo_seguro);
  
    commit;
    return l_rsp;
  exception
    when others then
      l_rsp := utl_call_stack.error_number(1);
      rollback;
      return l_rsp;
  end;

  function f_clob_replace(i_clob        in clob,
                          i_search      in varchar2,
                          i_replacement in clob) return clob is
    l_pos    integer;
    l_output clob;
  begin
    l_output := i_clob;
    l_pos    := dbms_lob.instr(l_output, i_search, 1, 1);
  
    if l_pos > 0 then
      dbms_lob.createtemporary(l_output, true);
      dbms_lob.append(l_output, dbms_lob.substr(i_clob, l_pos - 1, 1));
      dbms_lob.append(l_output, i_replacement);
      dbms_lob.append(l_output,
                      dbms_lob.substr(i_clob,
                                      dbms_lob.getlength(i_clob) -
                                      (l_pos + length(i_search) - 1),
                                      l_pos + length(i_search)));
    end if;
  
    return l_output;
  end;

end;
/

