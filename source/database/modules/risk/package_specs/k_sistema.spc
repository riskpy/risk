CREATE OR REPLACE PACKAGE k_sistema IS

  /**
  Agrupa operaciones relacionadas con parámetros de la sesión
  
  %author jtsoya539 27/3/2020 16:58:36
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

  -- Parámetros
  c_sistema CONSTANT VARCHAR2(50) := 'SISTEMA';
  c_version CONSTANT VARCHAR2(50) := 'VERSION';
  c_fecha   CONSTANT VARCHAR2(50) := 'FECHA';
  c_usuario CONSTANT VARCHAR2(50) := 'USUARIO';
  --
  c_direccion_ip      CONSTANT VARCHAR2(50) := 'DIRECCION_IP';
  c_id_operacion      CONSTANT VARCHAR2(50) := 'ID_OPERACION';
  c_nombre_operacion  CONSTANT VARCHAR2(50) := 'NOMBRE_OPERACION';
  c_dominio_operacion CONSTANT VARCHAR2(50) := 'DOMINIO_OPERACION';
  c_id_aplicacion     CONSTANT VARCHAR2(50) := 'ID_APLICACION';
  c_id_sesion         CONSTANT VARCHAR2(50) := 'ID_SESION';
  c_id_usuario        CONSTANT VARCHAR2(50) := 'ID_USUARIO';
  c_id_pais           CONSTANT VARCHAR2(50) := 'ID_PAIS';
  c_zona_horaria      CONSTANT VARCHAR2(50) := 'ZONA_HORARIA';
  c_id_idioma         CONSTANT VARCHAR2(50) := 'ID_IDIOMA';
  c_id_dispositivo    CONSTANT VARCHAR2(50) := 'ID_DISPOSITIVO';

  /**
  Indica si el ambiente de Base de Datos es de producción
  
  %author jtsoya539 4/2/2021 08:56:25
  %return Indicador de si el ambiente de Base de Datos es de producción
  */
  FUNCTION f_es_produccion RETURN BOOLEAN;

  /**
  Retorna el valor del parámetro FECHA en la sesión
  
  %author jtsoya539 4/2/2021 08:54:38
  %return Valor del parámetro FECHA
  */
  FUNCTION f_fecha RETURN DATE;

  /**
  Retorna el valor del parámetro ID_USUARIO en la sesión
  
  %author jtsoya539 29/1/2022 10:22:38
  %return Valor del parámetro ID_USUARIO
  */
  FUNCTION f_id_usuario RETURN NUMBER;

  /**
  Retorna el valor del parámetro USUARIO en la sesión
  
  %author jtsoya539 4/2/2021 08:54:38
  %return Valor del parámetro USUARIO
  */
  FUNCTION f_usuario RETURN VARCHAR2;

  /**
  Retorna el valor del parámetro ID_PAIS en la sesión
  
  %author dmezac 27/1/2022 23:54:40
  %return Valor del parámetro ID_PAIS
  */
  FUNCTION f_pais RETURN NUMBER;

  /**
  Retorna el valor del parámetro ZONA_HORARIA en la sesión
  
  %author dmezac 27/1/2022 23:50:38
  %return Valor del parámetro ZONA_HORARIA
  */
  FUNCTION f_zona_horaria RETURN VARCHAR2;

  /**
  Retorna el valor del parámetro ID_IDIOMA en la sesión
  
  %author dmezac 27/1/2022 23:52:18
  %return Valor del parámetro ID_IDIOMA
  */
  FUNCTION f_idioma RETURN NUMBER;

  /**
  Retorna el valor de un parámetro en la sesión
  
  %author jtsoya539 27/3/2020 16:59:44
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro, si no existe retorna null
  */
  FUNCTION f_valor_parametro(i_parametro IN VARCHAR2) RETURN anydata;

  /**
  Retorna el valor de un parámetro de tipo string en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo string, si no existe retorna null
  */
  FUNCTION f_valor_parametro_string(i_parametro IN VARCHAR2) RETURN VARCHAR2;

  /**
  Retorna el valor de un parámetro de tipo number en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo number, si no existe retorna null
  */
  FUNCTION f_valor_parametro_number(i_parametro IN VARCHAR2) RETURN NUMBER;

  /**
  Retorna el valor de un parámetro de tipo boolean en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo boolean, si no existe retorna null
  */
  FUNCTION f_valor_parametro_boolean(i_parametro IN VARCHAR2) RETURN BOOLEAN;

  /**
  Retorna el valor de un parámetro de tipo date en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo date, si no existe retorna null
  */
  FUNCTION f_valor_parametro_date(i_parametro IN VARCHAR2) RETURN DATE;

  /**
  Define el valor de un parámetro en la sesión
  
  %author jtsoya539 27/3/2020 17:00:28
  %param i_parametro Nombre del parámetro
  %param i_valor Valor del parámetro
  */
  PROCEDURE p_definir_parametro(i_parametro IN VARCHAR2,
                                i_valor     IN anydata);

  /**
  Define el valor de un parámetro de tipo string en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo string
  %param i_valor Valor del parámetro de tipo string
  */
  PROCEDURE p_definir_parametro_string(i_parametro IN VARCHAR2,
                                       i_valor     IN VARCHAR2);

  /**
  Define el valor de un parámetro de tipo number en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo number
  %param i_valor Valor del parámetro de tipo number
  */
  PROCEDURE p_definir_parametro_number(i_parametro IN VARCHAR2,
                                       i_valor     IN NUMBER);

  /**
  Define el valor de un parámetro de tipo boolean en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo boolean
  %param i_valor Valor del parámetro de tipo boolean
  */
  PROCEDURE p_definir_parametro_boolean(i_parametro IN VARCHAR2,
                                        i_valor     IN BOOLEAN);

  /**
  Define el valor de un parámetro de tipo date en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo date
  %param i_valor Valor del parámetro de tipo date
  */
  PROCEDURE p_definir_parametro_date(i_parametro IN VARCHAR2,
                                     i_valor     IN DATE);

  /**
  Define el valor de los parámetros por defecto de la sesión
  
  %author jtsoya539 4/2/2021 08:48:40
  */
  PROCEDURE p_inicializar_parametros;

  /**
  Define el valor de todos los parámetros de la sesión a null
  
  %author jtsoya539 27/3/2020 17:01:24
  */
  PROCEDURE p_limpiar_parametros;

  /**
  Elimina todos los parámetros definidos en la sesión
  
  %author jtsoya539 27/3/2020 17:02:14
  */
  PROCEDURE p_eliminar_parametros;

  /**
  Imprime todos los parámetros definidos en la sesión
  
  %author jtsoya539 27/3/2020 17:02:58
  */
  PROCEDURE p_imprimir_parametros;

  --
  PROCEDURE p_inicializar_cola;

  PROCEDURE p_encolar(i_valor IN VARCHAR2);

  FUNCTION f_desencolar RETURN VARCHAR2;

  PROCEDURE p_imprimir_cola;
  --

END;
/
