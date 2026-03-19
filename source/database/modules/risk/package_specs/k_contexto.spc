create or replace package k_contexto is

  /**
  Agrupa operaciones relacionadas con parámetros del contexto
  
  %author jtsoya539 15/3/2026 21:31:00
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

  function f_namespace return varchar2;

  function f_valor_parametro(i_parametro in varchar2) return varchar2;

  function f_valor_parametro_string(i_parametro in varchar2) return varchar2;

  function f_valor_parametro_number(i_parametro in varchar2) return number;

  function f_valor_parametro_boolean(i_parametro in varchar2) return boolean;

  function f_valor_parametro_date(i_parametro in varchar2) return date;

  procedure p_definir_parametro(i_parametro in varchar2,
                                i_valor     in varchar2);

  procedure p_definir_parametro_string(i_parametro in varchar2,
                                       i_valor     in varchar2);

  procedure p_definir_parametro_number(i_parametro in varchar2,
                                       i_valor     in number);

  procedure p_definir_parametro_boolean(i_parametro in varchar2,
                                        i_valor     in boolean);

  procedure p_definir_parametro_date(i_parametro in varchar2,
                                     i_valor     in date);

  /**
  Define el valor de los parámetros por defecto del contexto
  
  %author jtsoya539 15/3/2026 21:31:00
  */
  procedure p_inicializar_parametros;

  /**
  Define el valor de todos los parámetros del contexto a null
  
  %author jtsoya539 15/3/2026 21:31:00
  */
  procedure p_limpiar_parametros;

  /**
  Elimina todos los parámetros definidos en el contexto
  
  %author jtsoya539 15/3/2026 21:31:00
  */
  procedure p_eliminar_parametros;

  /**
  Imprime todos los parámetros definidos en el contexto
  
  %author jtsoya539 15/3/2026 21:31:00
  */
  procedure p_imprimir_parametros;

  --
  function f_base_datos return varchar2;

  function f_terminal return varchar2;

  function f_host return varchar2;

  function f_direccion_ip return varchar2;

  function f_esquema_actual return varchar2;
  --

end;
/

