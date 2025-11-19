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
  Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
  
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

  procedure p_enviar_correo(i_subject         in varchar2,
                            i_body            in clob,
                            i_id_usuario      in number default null,
                            i_to              in varchar2 default null,
                            i_reply_to        in varchar2 default null,
                            i_cc              in varchar2 default null,
                            i_bcc             in varchar2 default null,
                            i_adjuntos        in y_archivos default null,
                            i_prioridad_envio in number default null);

  procedure p_enviar_mensaje(i_contenido       in varchar2,
                             i_id_usuario      in number default null,
                             i_numero_telefono in varchar2 default null,
                             i_prioridad_envio in number default null);

  procedure p_enviar_notificacion(i_titulo          in varchar2,
                                  i_contenido       in varchar2,
                                  i_id_usuario      in number default null,
                                  i_suscripcion     in varchar2 default null,
                                  i_prioridad_envio in number default null,
                                  i_datos_extra     in varchar2 default null);

  function f_enviar_correo(i_subject         in varchar2,
                           i_body            in clob,
                           i_id_usuario      in number default null,
                           i_to              in varchar2 default null,
                           i_reply_to        in varchar2 default null,
                           i_cc              in varchar2 default null,
                           i_bcc             in varchar2 default null,
                           i_adjuntos        in y_archivos default null,
                           i_prioridad_envio in number default null)
    return pls_integer;

  function f_enviar_mensaje(i_contenido       in varchar2,
                            i_id_usuario      in number default null,
                            i_numero_telefono in varchar2 default null,
                            i_prioridad_envio in number default null)
    return pls_integer;

  function f_enviar_notificacion(i_titulo          in varchar2,
                                 i_contenido       in varchar2,
                                 i_id_usuario      in number default null,
                                 i_suscripcion     in varchar2 default null,
                                 i_prioridad_envio in number default null,
                                 i_datos_extra     in varchar2 default null)
    return pls_integer;

end;
/
