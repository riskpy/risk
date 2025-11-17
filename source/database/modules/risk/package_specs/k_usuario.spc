CREATE OR REPLACE PACKAGE k_usuario IS

  /**
  Agrupa operaciones relacionadas con los usuarios
  
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

  -- Excepciones
  ex_usuario_inexistente EXCEPTION;
  ex_usuario_existente   EXCEPTION;

  FUNCTION f_buscar_id(i_usuario IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_id_usuario(i_alias IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_id_persona(i_id_usuario IN NUMBER) RETURN NUMBER;

  FUNCTION f_alias(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_estado(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_origen(i_id_usuario IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_validar_alias(i_alias VARCHAR2) RETURN BOOLEAN;

  FUNCTION f_version_avatar(i_alias IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_datos_usuario(i_id_usuario IN NUMBER) RETURN y_usuario;

  FUNCTION f_existe_usuario_externo(i_origen     IN VARCHAR2,
                                    i_id_externo IN VARCHAR2) RETURN BOOLEAN;

  PROCEDURE p_cambiar_estado(i_id_usuario IN NUMBER,
                             i_estado     IN VARCHAR2);

  $if k_modulo.c_instalado_msj $then
  /**
  Suscribe usuario a una notificación
  
  %author dmezac 15/7/2021 23:05:15
  %param i_id_usuario Identificador del usuario
  %param i_suscripcion_alta Suscripción a dar de alta
  */
  PROCEDURE p_suscribir_notificacion(i_id_usuario       IN NUMBER,
                                     i_suscripcion_alta IN VARCHAR2);

  /**
  Desuscribe usuario de una notificación
  
  %author dmezac 15/7/2021 23:05:15
  %param i_id_usuario Identificador del usuario
  %param i_suscripcion_baja Suscripción a dar de baja
  */
  PROCEDURE p_desuscribir_notificacion(i_id_usuario       IN NUMBER,
                                       i_suscripcion_baja IN VARCHAR2);
  $end

  /**
  Guarda dato de un usuario
  
  %author dmezac 22/8/2021 15:05:15
  %param i_alias Alias del usuario
  %param i_campo Campo a guardar
  %param i_dato Dato a guardar
  */
  PROCEDURE p_guardar_dato_string(i_alias IN VARCHAR2,
                                  i_campo IN VARCHAR2,
                                  i_dato  IN VARCHAR2);

END;
/
