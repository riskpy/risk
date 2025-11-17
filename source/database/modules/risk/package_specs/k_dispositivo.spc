CREATE OR REPLACE PACKAGE k_dispositivo IS

  /**
  Agrupa operaciones relacionadas con los dispositivos
  
  %author jtsoya539 27/3/2020 16:16:59
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

  c_suscripcion_defecto CONSTANT VARCHAR2(120) := 'default';
  c_suscripcion_usuario CONSTANT VARCHAR2(120) := 'user';

  FUNCTION f_suscripcion_defecto RETURN VARCHAR2;

  FUNCTION f_suscripcion_usuario(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_id_dispositivo(i_token_dispositivo IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_registrar_dispositivo(i_id_aplicacion             IN VARCHAR2,
                                   i_token_dispositivo         IN VARCHAR2,
                                   i_token_notificacion        IN VARCHAR2 DEFAULT NULL,
                                   i_nombre_sistema_operativo  IN VARCHAR2 DEFAULT NULL,
                                   i_version_sistema_operativo IN VARCHAR2 DEFAULT NULL,
                                   i_tipo                      IN VARCHAR2 DEFAULT NULL,
                                   i_nombre_navegador          IN VARCHAR2 DEFAULT NULL,
                                   i_version_navegador         IN VARCHAR2 DEFAULT NULL,
                                   i_version_aplicacion        IN VARCHAR2 DEFAULT NULL,
                                   i_pais_iso_alpha_2          IN VARCHAR2 DEFAULT NULL,
                                   i_zona_horaria              IN VARCHAR2 DEFAULT NULL,
                                   i_idioma_iso369_1           IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  FUNCTION f_datos_dispositivo(i_id_dispositivo IN NUMBER)
    RETURN y_dispositivo;

  $if k_modulo.c_instalado_msj $then
  PROCEDURE p_suscribir_notificacion(i_id_dispositivo   IN NUMBER,
                                     i_suscripcion_alta IN VARCHAR2);

  /**
  Suscribe a una notificación a partir de otra suscripción
  
  %author dmezac 24/6/2021 10:05:15
  %param i_suscripcion Suscripción original
  %param i_suscripcion_alta Suscripción a dar de alta
  */
  PROCEDURE p_suscribir_notificacion_s(i_suscripcion      IN VARCHAR2,
                                       i_suscripcion_alta IN VARCHAR2);

  /**
  Suscribe el dispositivo a las notificaciones de un usuario
  
  %author dmezac 15/7/2021 23:30:15
  %param i_id_dispositivo Identificador del dispositivo
  %param i_id_usuario Identificador del usuario
  */
  PROCEDURE p_suscribir_notificacion_usuario(i_id_dispositivo IN NUMBER,
                                             i_id_usuario     IN NUMBER);

  PROCEDURE p_desuscribir_notificacion(i_id_dispositivo   IN NUMBER,
                                       i_suscripcion_baja IN VARCHAR2);

  /**
  Desuscribe de una notificación a partir de otra suscripción
  
  %author dmezac 24/6/2021 10:05:15
  %param i_suscripcion Suscripción original
  %param i_suscripcion_alta Suscripción a dar de baja
  */
  PROCEDURE p_desuscribir_notificacion_s(i_suscripcion      IN VARCHAR2,
                                         i_suscripcion_baja IN VARCHAR2);

  /**
  Desuscribe el dispositivo de las notificaciones de un usuario
  
  %author dmezac 15/7/2021 23:30:15
  %param i_id_dispositivo Identificador del dispositivo
  %param i_id_usuario Identificador del usuario
  */
  PROCEDURE p_desuscribir_notificacion_usuario(i_id_dispositivo IN NUMBER,
                                               i_id_usuario     IN NUMBER);
  $end

  PROCEDURE p_registrar_ubicacion(i_id_dispositivo IN NUMBER,
                                  i_latitud        IN NUMBER,
                                  i_longitud       IN NUMBER);

END;
/
