CREATE OR REPLACE PACKAGE k_util IS

  /**
  Agrupa herramientas para facilitar el desarrollo
  
  %author jtsoya539 27/3/2020 17:05:34
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
  ex_tipo_inexistente EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_tipo_inexistente, -6550);

  /**
  Genera trigger de secuencia para un campo de una tabla
  
  %author jtsoya539 27/3/2020 17:06:21
  %param i_tabla Tabla
  %param i_campo Campo
  %param i_trigger Trigger
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  PROCEDURE p_generar_trigger_secuencia(i_tabla    IN VARCHAR2,
                                        i_campo    IN VARCHAR2,
                                        i_trigger  IN VARCHAR2 DEFAULT NULL,
                                        i_ejecutar IN BOOLEAN DEFAULT TRUE);

  PROCEDURE p_generar_type_objeto(i_tabla    IN VARCHAR2,
                                  i_type     IN VARCHAR2 DEFAULT NULL,
                                  i_ejecutar IN BOOLEAN DEFAULT TRUE);

  FUNCTION f_valor_parametro(i_id_parametro IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE p_actualizar_valor_parametro(i_id_parametro IN VARCHAR2,
                                         i_valor        IN VARCHAR2);

  FUNCTION f_hash(i_data      IN VARCHAR2,
                  i_hash_type IN PLS_INTEGER) RETURN VARCHAR2 DETERMINISTIC;

  FUNCTION bool_to_string(i_bool IN BOOLEAN) RETURN VARCHAR2;

  FUNCTION string_to_bool(i_string IN VARCHAR2) RETURN BOOLEAN;

  FUNCTION blob_to_clob(p_data IN BLOB) RETURN CLOB;

  FUNCTION clob_to_blob(p_data IN CLOB) RETURN BLOB;

  FUNCTION base64encode(i_blob IN BLOB) RETURN CLOB;

  FUNCTION base64decode(i_clob IN CLOB) RETURN BLOB;

  FUNCTION encrypt(i_src IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION decrypt(i_src IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION json_to_objeto(i_json        IN CLOB,
                          i_nombre_tipo IN VARCHAR2) RETURN anydata;

  FUNCTION objeto_to_json(i_objeto IN anydata) RETURN CLOB;

  FUNCTION read_http_body(resp IN OUT utl_http.resp) RETURN CLOB;

  FUNCTION f_base_datos RETURN VARCHAR2;

  FUNCTION f_terminal RETURN VARCHAR2;

  FUNCTION f_host RETURN VARCHAR2;

  FUNCTION f_direccion_ip RETURN VARCHAR2;

  FUNCTION f_esquema_actual RETURN VARCHAR2;

  FUNCTION f_charset RETURN VARCHAR2;

  /**
  Retorna si el valor recibido es de tipo numérico
  
  %author dmezac 26/1/2022 19:48:15
  %param i_valor Zona horaria en formato decimal
  %return Si el valor recibido es de tipo numérico
  */
  FUNCTION f_es_valor_numerico(i_valor IN VARCHAR2) RETURN BOOLEAN;

  /**
  Retorna una zona horaria en formato '(+|-)HH:MM'
  
  %author dmezac 26/1/2022 19:43:15
  %param i_zona_horaria Zona horaria en formato decimal
  %return Zona horaria en formato '(+|-)HH:MM'
  */
  FUNCTION f_zona_horaria(i_zona_horaria IN VARCHAR2) RETURN VARCHAR2;

END;
/
