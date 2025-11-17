CREATE OR REPLACE PACKAGE k_sesion IS

  /**
  Agrupa operaciones relacionadas con las sesiones
  
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

  -- Tipos de token
  c_access_token  CONSTANT CHAR(1) := 'A';
  c_refresh_token CONSTANT CHAR(1) := 'R';

  -- Excepciones
  ex_sesion_inexistente EXCEPTION;

  FUNCTION f_id_sesion(i_access_token IN VARCHAR2,
                       i_estado       IN VARCHAR2 DEFAULT NULL) RETURN NUMBER;

  FUNCTION f_validar_sesion(i_access_token IN VARCHAR2) RETURN BOOLEAN;

  FUNCTION f_datos_sesion(i_id_sesion IN NUMBER) RETURN y_sesion;

  FUNCTION f_dispositivo_sesion(i_id_sesion IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_tiempo_expiracion_token(i_id_aplicacion IN VARCHAR2,
                                     i_tipo_token    IN VARCHAR2)
    RETURN NUMBER;

  FUNCTION f_fecha_expiracion_access_token(i_access_token IN VARCHAR2)
    RETURN DATE;

  FUNCTION f_fecha_expiracion_refresh_token(i_id_aplicacion IN VARCHAR2)
    RETURN DATE;

  PROCEDURE p_validar_sesion(i_access_token IN VARCHAR2);

  PROCEDURE p_cambiar_estado(i_access_token IN VARCHAR2,
                             i_estado       IN VARCHAR2);

  PROCEDURE p_expirar_sesiones(i_id_usuario IN NUMBER);

END;
/
