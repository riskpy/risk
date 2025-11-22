create or replace package k_sistema is

  /**
  Agrupa operaciones relacionadas con parámetros de la sesión
  
  %author jtsoya539 27/3/2020 16:58:36
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors
  
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
  c_sistema constant varchar2(50) := 'SISTEMA';
  c_version constant varchar2(50) := 'VERSION';
  c_fecha   constant varchar2(50) := 'FECHA';
  c_usuario constant varchar2(50) := 'USUARIO';
  --
  c_direccion_ip      constant varchar2(50) := 'DIRECCION_IP';
  c_id_operacion      constant varchar2(50) := 'ID_OPERACION';
  c_nombre_operacion  constant varchar2(50) := 'NOMBRE_OPERACION';
  c_dominio_operacion constant varchar2(50) := 'DOMINIO_OPERACION';
  c_id_aplicacion     constant varchar2(50) := 'ID_APLICACION';
  c_id_sesion         constant varchar2(50) := 'ID_SESION';
  c_id_usuario        constant varchar2(50) := 'ID_USUARIO';
  c_id_pais           constant varchar2(50) := 'ID_PAIS';
  c_zona_horaria      constant varchar2(50) := 'ZONA_HORARIA';
  c_id_idioma         constant varchar2(50) := 'ID_IDIOMA';
  c_id_dispositivo    constant varchar2(50) := 'ID_DISPOSITIVO';

  /**
  Indica si el ambiente de Base de Datos es de producción
  
  %author jtsoya539 4/2/2021 08:56:25
  %return Indicador de si el ambiente de Base de Datos es de producción
  */
  function f_es_produccion return boolean;

  /**
  Retorna el valor del parámetro FECHA en la sesión
  
  %author jtsoya539 4/2/2021 08:54:38
  %return Valor del parámetro FECHA
  */
  function f_fecha return date;

  /**
  Retorna el valor del parámetro ID_USUARIO en la sesión
  
  %author jtsoya539 29/1/2022 10:22:38
  %return Valor del parámetro ID_USUARIO
  */
  function f_id_usuario return number;

  /**
  Retorna el valor del parámetro USUARIO en la sesión
  
  %author jtsoya539 4/2/2021 08:54:38
  %return Valor del parámetro USUARIO
  */
  function f_usuario return varchar2;

  /**
  Retorna el valor del parámetro ID_PAIS en la sesión
  
  %author dmezac 27/1/2022 23:54:40
  %return Valor del parámetro ID_PAIS
  */
  function f_pais return number;

  /**
  Retorna el valor del parámetro ZONA_HORARIA en la sesión
  
  %author dmezac 27/1/2022 23:50:38
  %return Valor del parámetro ZONA_HORARIA
  */
  function f_zona_horaria return varchar2;

  /**
  Retorna el valor del parámetro ID_IDIOMA en la sesión
  
  %author dmezac 27/1/2022 23:52:18
  %return Valor del parámetro ID_IDIOMA
  */
  function f_idioma return number;

  /**
  Retorna el valor de un parámetro en la sesión
  
  %author jtsoya539 27/3/2020 16:59:44
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro, si no existe retorna null
  */
  function f_valor_parametro(i_parametro in varchar2) return anydata;

  /**
  Retorna el valor de un parámetro de tipo string en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo string, si no existe retorna null
  */
  function f_valor_parametro_string(i_parametro in varchar2) return varchar2;

  /**
  Retorna el valor de un parámetro de tipo number en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo number, si no existe retorna null
  */
  function f_valor_parametro_number(i_parametro in varchar2) return number;

  /**
  Retorna el valor de un parámetro de tipo boolean en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo boolean, si no existe retorna null
  */
  function f_valor_parametro_boolean(i_parametro in varchar2) return boolean;

  /**
  Retorna el valor de un parámetro de tipo date en la sesión
  
  %author jtsoya539 4/2/2021 08:36:10
  %param i_parametro Nombre del parámetro
  %return Valor del parámetro de tipo date, si no existe retorna null
  */
  function f_valor_parametro_date(i_parametro in varchar2) return date;

  /**
  Define el valor de un parámetro en la sesión
  
  %author jtsoya539 27/3/2020 17:00:28
  %param i_parametro Nombre del parámetro
  %param i_valor Valor del parámetro
  */
  procedure p_definir_parametro(i_parametro in varchar2,
                                i_valor     in anydata);

  /**
  Define el valor de un parámetro de tipo string en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo string
  %param i_valor Valor del parámetro de tipo string
  */
  procedure p_definir_parametro_string(i_parametro in varchar2,
                                       i_valor     in varchar2);

  /**
  Define el valor de un parámetro de tipo number en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo number
  %param i_valor Valor del parámetro de tipo number
  */
  procedure p_definir_parametro_number(i_parametro in varchar2,
                                       i_valor     in number);

  /**
  Define el valor de un parámetro de tipo boolean en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo boolean
  %param i_valor Valor del parámetro de tipo boolean
  */
  procedure p_definir_parametro_boolean(i_parametro in varchar2,
                                        i_valor     in boolean);

  /**
  Define el valor de un parámetro de tipo date en la sesión
  
  %author jtsoya539 4/2/2021 08:42:00
  %param i_parametro Nombre del parámetro de tipo date
  %param i_valor Valor del parámetro de tipo date
  */
  procedure p_definir_parametro_date(i_parametro in varchar2,
                                     i_valor     in date);

  /**
  Define el valor de los parámetros por defecto de la sesión
  
  %author jtsoya539 4/2/2021 08:48:40
  */
  procedure p_inicializar_parametros;

  /**
  Define el valor de todos los parámetros de la sesión a null
  
  %author jtsoya539 27/3/2020 17:01:24
  */
  procedure p_limpiar_parametros;

  /**
  Elimina todos los parámetros definidos en la sesión
  
  %author jtsoya539 27/3/2020 17:02:14
  */
  procedure p_eliminar_parametros;

  /**
  Imprime todos los parámetros definidos en la sesión
  
  %author jtsoya539 27/3/2020 17:02:58
  */
  procedure p_imprimir_parametros;

  --
  procedure p_inicializar_cola;

  procedure p_encolar(i_valor in varchar2);

  function f_desencolar return varchar2;

  procedure p_imprimir_cola;
  --

end;
/
