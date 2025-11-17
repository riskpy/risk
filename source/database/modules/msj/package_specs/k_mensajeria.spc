CREATE OR REPLACE PACKAGE k_mensajeria IS

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
  Copyright (c) 2019 jtsoya539
  
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

  c_ok                           CONSTANT PLS_INTEGER := 0;
  c_cantidad_intentos_permitidos CONSTANT PLS_INTEGER := 3;

  -- Prioridades de envío
  c_prioridad_urgente    CONSTANT PLS_INTEGER := 1;
  c_prioridad_importante CONSTANT PLS_INTEGER := 2;
  c_prioridad_media      CONSTANT PLS_INTEGER := 3;
  c_prioridad_baja       CONSTANT PLS_INTEGER := 4;

  FUNCTION f_validar_direccion_correo(i_direccion_correo VARCHAR2)
    RETURN BOOLEAN;

  FUNCTION f_validar_numero_telefono(i_numero_telefono VARCHAR2)
    RETURN BOOLEAN;

  FUNCTION f_direccion_correo_usuario(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_numero_telefono_usuario(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_correo_html(i_contenido      IN VARCHAR2,
                         i_titulo         IN VARCHAR2 DEFAULT NULL,
                         i_encabezado     IN VARCHAR2 DEFAULT NULL,
                         i_pie            IN VARCHAR2 DEFAULT NULL,
                         i_boton_etiqueta IN VARCHAR2 DEFAULT NULL,
                         i_boton_accion   IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_correo_tabla_html(i_tabla      IN VARCHAR2,
                               i_titulo     IN VARCHAR2 DEFAULT NULL,
                               i_encabezado IN VARCHAR2 DEFAULT NULL,
                               i_pie        IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_correo_tabla_aux_html(i_tabla       IN VARCHAR2,
                                   i_tabla_aux_1 IN VARCHAR2 DEFAULT NULL,
                                   i_tabla_aux_2 IN VARCHAR2 DEFAULT NULL,
                                   i_tabla_aux_3 IN VARCHAR2 DEFAULT NULL,
                                   i_titulo      IN VARCHAR2 DEFAULT NULL,
                                   i_encabezado  IN VARCHAR2 DEFAULT NULL,
                                   i_pie         IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  PROCEDURE p_enviar_correo(i_subject         IN VARCHAR2,
                            i_body            IN CLOB,
                            i_id_usuario      IN NUMBER DEFAULT NULL,
                            i_to              IN VARCHAR2 DEFAULT NULL,
                            i_reply_to        IN VARCHAR2 DEFAULT NULL,
                            i_cc              IN VARCHAR2 DEFAULT NULL,
                            i_bcc             IN VARCHAR2 DEFAULT NULL,
                            i_adjuntos        IN y_archivos DEFAULT NULL,
                            i_prioridad_envio IN NUMBER DEFAULT NULL);

  PROCEDURE p_enviar_mensaje(i_contenido       IN VARCHAR2,
                             i_id_usuario      IN NUMBER DEFAULT NULL,
                             i_numero_telefono IN VARCHAR2 DEFAULT NULL,
                             i_prioridad_envio IN NUMBER DEFAULT NULL);

  PROCEDURE p_enviar_notificacion(i_titulo          IN VARCHAR2,
                                  i_contenido       IN VARCHAR2,
                                  i_id_usuario      IN NUMBER DEFAULT NULL,
                                  i_suscripcion     IN VARCHAR2 DEFAULT NULL,
                                  i_prioridad_envio IN NUMBER DEFAULT NULL,
                                  i_datos_extra     IN VARCHAR2 DEFAULT NULL);

  FUNCTION f_enviar_correo(i_subject         IN VARCHAR2,
                           i_body            IN CLOB,
                           i_id_usuario      IN NUMBER DEFAULT NULL,
                           i_to              IN VARCHAR2 DEFAULT NULL,
                           i_reply_to        IN VARCHAR2 DEFAULT NULL,
                           i_cc              IN VARCHAR2 DEFAULT NULL,
                           i_bcc             IN VARCHAR2 DEFAULT NULL,
                           i_adjuntos        IN y_archivos DEFAULT NULL,
                           i_prioridad_envio IN NUMBER DEFAULT NULL)
    RETURN PLS_INTEGER;

  FUNCTION f_enviar_mensaje(i_contenido       IN VARCHAR2,
                            i_id_usuario      IN NUMBER DEFAULT NULL,
                            i_numero_telefono IN VARCHAR2 DEFAULT NULL,
                            i_prioridad_envio IN NUMBER DEFAULT NULL)
    RETURN PLS_INTEGER;

  FUNCTION f_enviar_notificacion(i_titulo          IN VARCHAR2,
                                 i_contenido       IN VARCHAR2,
                                 i_id_usuario      IN NUMBER DEFAULT NULL,
                                 i_suscripcion     IN VARCHAR2 DEFAULT NULL,
                                 i_prioridad_envio IN NUMBER DEFAULT NULL,
                                 i_datos_extra     IN VARCHAR2 DEFAULT NULL)
    RETURN PLS_INTEGER;

END;
/
