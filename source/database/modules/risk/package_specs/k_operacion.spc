CREATE OR REPLACE PACKAGE k_operacion IS

  /**
  Agrupa operaciones relacionadas con las Operaciones (Servicios Web, Reportes, Trabajos, Monitoreos, Importaciones)
  
  %author jtsoya539 27/3/2020 16:42:26
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

  -- Tipos de Operaciones
  c_tipo_servicio    CONSTANT CHAR(1) := 'S';
  c_tipo_reporte     CONSTANT CHAR(1) := 'R';
  c_tipo_trabajo     CONSTANT CHAR(1) := 'T';
  c_tipo_monitoreo   CONSTANT CHAR(1) := 'M';
  c_tipo_importacion CONSTANT CHAR(1) := 'I';
  c_tipo_parametros  CONSTANT CHAR(1) := 'P';

  -- Tipos de Implementaciones
  c_tipo_implementacion_paquete CONSTANT CHAR(1) := 'K';
  c_tipo_implementacion_funcion CONSTANT CHAR(1) := 'F';
  c_tipo_implementacion_bloque  CONSTANT CHAR(1) := 'B';

  -- Códigos de respuesta
  c_ok                       CONSTANT VARCHAR2(10) := '0';
  c_servicio_no_implementado CONSTANT VARCHAR2(10) := 'ser0001';
  c_error_parametro          CONSTANT VARCHAR2(10) := 'ser0002';
  c_error_permiso            CONSTANT VARCHAR2(10) := 'ser0003';
  c_error_general            CONSTANT VARCHAR2(10) := 'ser0099';
  c_error_inesperado         CONSTANT VARCHAR2(10) := 'ser9999';

  -- Otras constantes
  c_id_log                 CONSTANT VARCHAR2(50) := 'ID_LOG';
  c_fecha_hora_inicio_log  CONSTANT VARCHAR2(50) := 'FECHA_HORA_INICIO_LOG';
  c_id_ope_par_automaticos CONSTANT PLS_INTEGER := 1000;
  c_id_operacion_contexto  CONSTANT PLS_INTEGER := 1001;

  -- Excepciones
  ex_servicio_no_implementado EXCEPTION;
  ex_error_parametro          EXCEPTION;
  ex_error_general            EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_servicio_no_implementado, -6550);

  PROCEDURE p_inicializar_log(i_id_operacion IN NUMBER);

  PROCEDURE p_registrar_log(i_id_operacion     IN NUMBER,
                            i_parametros       IN CLOB,
                            i_codigo_respuesta IN VARCHAR2,
                            i_respuesta        IN CLOB,
                            i_contexto         IN CLOB DEFAULT NULL,
                            i_version          IN VARCHAR2 DEFAULT NULL);

  PROCEDURE p_respuesta_ok(io_respuesta IN OUT NOCOPY y_respuesta,
                           i_datos      IN y_objeto DEFAULT NULL);

  PROCEDURE p_respuesta_error(io_respuesta IN OUT NOCOPY y_respuesta,
                              i_codigo     IN VARCHAR2,
                              i_mensaje    IN VARCHAR2 DEFAULT NULL,
                              i_mensaje_bd IN VARCHAR2 DEFAULT NULL,
                              i_datos      IN y_objeto DEFAULT NULL);

  PROCEDURE p_respuesta_excepcion(io_respuesta   IN OUT NOCOPY y_respuesta,
                                  i_error_number IN NUMBER,
                                  i_error_msg    IN VARCHAR2,
                                  i_error_stack  IN VARCHAR2);

  PROCEDURE p_validar_parametro(io_respuesta IN OUT NOCOPY y_respuesta,
                                i_expresion  IN BOOLEAN,
                                i_mensaje    IN VARCHAR2);

  PROCEDURE p_definir_parametros(i_id_operacion IN NUMBER,
                                 i_contexto     IN y_parametros);

  FUNCTION f_operacion(i_id_operacion IN NUMBER) RETURN t_operaciones%ROWTYPE;

  FUNCTION f_id_operacion(i_tipo    IN VARCHAR2,
                          i_nombre  IN VARCHAR2,
                          i_dominio IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_id_permiso(i_id_operacion IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_id_modulo(i_id_operacion IN NUMBER) RETURN VARCHAR2;

  FUNCTION f_validar_permiso_aplicacion(i_id_aplicacion IN VARCHAR2,
                                        i_id_operacion  IN NUMBER)
    RETURN BOOLEAN;

  FUNCTION f_procesar_parametros(i_id_operacion IN NUMBER,
                                 i_parametros   IN CLOB,
                                 i_version      IN VARCHAR2 DEFAULT NULL)
    RETURN y_parametros;

  FUNCTION f_nombre_programa(i_id_operacion IN NUMBER,
                             i_version      IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;

  FUNCTION f_filtros_sql(i_parametros      IN y_parametros,
                         i_nombres_excluir IN y_cadenas DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_valor_parametro(i_parametros IN y_parametros,
                             i_nombre     IN VARCHAR2) RETURN anydata;

  FUNCTION f_valor_parametro_string(i_parametros IN y_parametros,
                                    i_nombre     IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_valor_parametro_number(i_parametros IN y_parametros,
                                    i_nombre     IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_valor_parametro_boolean(i_parametros IN y_parametros,
                                     i_nombre     IN VARCHAR2) RETURN BOOLEAN;

  FUNCTION f_valor_parametro_date(i_parametros IN y_parametros,
                                  i_nombre     IN VARCHAR2) RETURN DATE;

  FUNCTION f_valor_parametro_object(i_parametros IN y_parametros,
                                    i_nombre     IN VARCHAR2) RETURN y_objeto;

  FUNCTION f_inserts_operacion(i_operacion IN t_operaciones%ROWTYPE)
    RETURN CLOB;

  FUNCTION f_inserts_operacion(i_id_operacion IN NUMBER) RETURN CLOB;

  FUNCTION f_inserts_operacion(i_tipo    IN VARCHAR2,
                               i_nombre  IN VARCHAR2,
                               i_dominio IN VARCHAR2) RETURN CLOB;

  FUNCTION f_deletes_operacion(i_operacion IN t_operaciones%ROWTYPE)
    RETURN CLOB;

  FUNCTION f_deletes_operacion(i_id_operacion IN NUMBER) RETURN CLOB;

  FUNCTION f_deletes_operacion(i_tipo    IN VARCHAR2,
                               i_nombre  IN VARCHAR2,
                               i_dominio IN VARCHAR2) RETURN CLOB;

  FUNCTION f_scripts_operaciones(i_id_modulo IN VARCHAR2 DEFAULT NULL)
    RETURN BLOB;

END;
/
