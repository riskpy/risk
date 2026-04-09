create or replace package k_mensajeria is

  /**
  Agrupa operaciones relacionadas con el envío de mensajes a los usuarios
  
  El envío de mensajes se puede realizar a través de:
  <ul>
  <li>Correo electrónico (E-mail)</li>
  <li>Mensaje de texto (SMS)</li>
  <li>Notificación push</li>
  </ul>
  
  %author jtsoya539 27/3/2020 16:38:22
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  c_ok                           constant pls_integer := 0;
  c_cantidad_intentos_permitidos constant pls_integer := 3;

  -- Prioridades de envío
  c_prioridad_urgente    constant pls_integer := 1;
  c_prioridad_importante constant pls_integer := 2;
  c_prioridad_media      constant pls_integer := 3;
  c_prioridad_baja       constant pls_integer := 4;

  -- Encapsuladores
  c_encapsulador_inicial constant varchar2(2) := '$(';
  c_encapsulador_final   constant varchar2(2) := ')';

  -- Variable automáticas de plantillas
  c_variable_entidad                constant varchar2(30) := 'entidad'; --Nombre de fantasía de la entidad
  c_variable_nombre_entidad         constant varchar2(30) := 'nombre_entidad'; --Nombre legal de la entidad
  c_variable_url_logo               constant varchar2(30) := 'logo'; --URL del logo de la entidad
  c_variable_telefono_entidad       constant varchar2(30) := 'telefono_entidad'; --Número de teléfono de la entidad
  c_variable_telefono_corto_entidad constant varchar2(30) := 'telefono_corto_entidad'; --Número de teléfono corto de la entidad
  c_variable_whatsapp_entidad       constant varchar2(30) := 'whatsapp_entidad'; --Número de whatsapp de la entidad
  c_variable_base_datos             constant varchar2(30) := 'base_datos'; --Nombre de la base de datos
  c_variable_fecha                  constant varchar2(30) := 'fecha'; --Fecha real (sin hora)
  c_variable_fecha_hora             constant varchar2(30) := 'fecha_hora'; --Fecha real (con hora)
  c_variable_fecha_sistema          constant varchar2(30) := 'fecha_sistema'; --Fecha del sistema

  -- Tipos de alerta
  c_tipo_alerta_push   constant varchar2(10) := 'PUSH';
  c_tipo_alerta_sms    constant varchar2(10) := 'SMS';
  c_tipo_alerta_popup  constant varchar2(10) := 'POPUP';
  c_tipo_alerta_banner constant varchar2(10) := 'BANNER';

  function f_validar_direccion_correo(i_direccion_correo varchar2)
    return boolean;

  function f_validar_numero_telefono(i_numero_telefono varchar2)
    return boolean;

  function f_direccion_correo_usuario(i_id_usuario in number) return varchar2;

  function f_numero_telefono_usuario(i_id_usuario in number) return varchar2;

  function f_correo_html(i_contenido      in varchar2,
                         i_titulo         in varchar2 default null,
                         i_encabezado     in varchar2 default null,
                         i_pie            in varchar2 default null,
                         i_boton_etiqueta in varchar2 default null,
                         i_boton_accion   in varchar2 default null)
    return clob;

  function f_correo_tabla_html(i_tabla      in varchar2,
                               i_titulo     in varchar2 default null,
                               i_encabezado in varchar2 default null,
                               i_pie        in varchar2 default null)
    return clob;

  function f_correo_tabla_aux_html(i_tabla       in varchar2,
                                   i_tabla_aux_1 in varchar2 default null,
                                   i_tabla_aux_2 in varchar2 default null,
                                   i_tabla_aux_3 in varchar2 default null,
                                   i_titulo      in varchar2 default null,
                                   i_encabezado  in varchar2 default null,
                                   i_pie         in varchar2 default null)
    return clob;

  function f_enviar_correo_id(i_id_plantilla      in varchar2,
                              i_datos_extra       in clob default null,
                              i_id_usuario        in number default null,
                              i_destinatario      in varchar2 default null,
                              i_destino_respuesta in varchar2 default null,
                              i_destinatario_cc   in varchar2 default null,
                              i_destinatario_bcc  in varchar2 default null,
                              i_adjuntos          in y_objetos default null)
    return t_correos.id_correo%type;

  procedure p_enviar_correo(i_id_plantilla      in varchar2,
                            i_datos_extra       in clob default null,
                            i_id_usuario        in number default null,
                            i_destinatario      in varchar2 default null,
                            i_destino_respuesta in varchar2 default null,
                            i_destinatario_cc   in varchar2 default null,
                            i_destinatario_bcc  in varchar2 default null,
                            i_adjuntos          in y_objetos default null);

  function f_enviar_mensaje_id(i_id_plantilla    in varchar2,
                               i_datos_extra     in clob default null,
                               i_id_usuario      in number default null,
                               i_numero_telefono in varchar2 default null)
    return t_mensajes.id_mensaje%type;

  procedure p_enviar_mensaje(i_id_plantilla    in varchar2,
                             i_datos_extra     in clob default null,
                             i_id_usuario      in number default null,
                             i_numero_telefono in varchar2 default null);

  function f_enviar_notificacion_id(i_id_plantilla       varchar2,
                                    i_datos_extra        clob default null,
                                    i_id_usuario         number default null,
                                    i_suscripcion        varchar2 default null,
                                    i_token_notificacion varchar2 default null,
                                    i_dispositivo_seguro varchar2 default null,
                                    i_id_aplicacion      varchar2 default null)
    return t_notificaciones.id_notificacion%type;

  procedure p_enviar_notificacion(i_id_plantilla       in varchar2,
                                  i_datos_extra        in clob default null,
                                  i_id_usuario         in number default null,
                                  i_suscripcion        in varchar2 default null,
                                  i_token_notificacion in varchar2 default null,
                                  i_dispositivo_seguro in varchar2 default null,
                                  i_id_aplicacion      in varchar2 default null);

  function f_enviar_correo(i_id_plantilla      in varchar2,
                           i_datos_extra       in clob default null,
                           i_id_usuario        in number default null,
                           i_destinatario      in varchar2 default null,
                           i_destino_respuesta in varchar2 default null,
                           i_destinatario_cc   in varchar2 default null,
                           i_destinatario_bcc  in varchar2 default null,
                           i_adjuntos          in y_objetos default null)
    return pls_integer;

  function f_enviar_mensaje(i_id_plantilla    in varchar2,
                            i_datos_extra     in clob default null,
                            i_id_usuario      in number default null,
                            i_numero_telefono in varchar2 default null)
    return pls_integer;

  function f_enviar_notificacion(i_id_plantilla       in varchar2,
                                 i_datos_extra        in clob default null,
                                 i_id_usuario         in number default null,
                                 i_suscripcion        in varchar2 default null,
                                 i_token_notificacion in varchar2 default null,
                                 i_dispositivo_seguro in varchar2 default null)
    return pls_integer;

  function f_correo_tabla_html_clob(i_tabla      in clob,
                                    i_titulo     in varchar2 default null,
                                    i_encabezado in varchar2 default null,
                                    i_pie        in varchar2 default null)
    return clob;

  function f_clob_replace(i_clob        in clob,
                          i_search      in varchar2,
                          i_replacement in clob) return clob;
end;
/

