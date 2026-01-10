create or replace package k_cadena is

  /**
  Agrupa operaciones relacionadas con cadenas
  
  %author jtsoya539 27/3/2020 17:05:34
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

  -- https://github.com/osalvador/tePLSQL
  --Define data type for Template Variable names
  subtype t_template_variable_name is varchar2(255);

  --Define data type for Template Variable values
  subtype t_template_variable_value is varchar2(32767);

  --Define Associative Array
  type t_assoc_array is table of t_template_variable_value index by t_template_variable_name;

  null_assoc_array t_assoc_array;

  /**
  Retorna una tabla de cadenas delimitadas por un separador
  
  %author dmezac 10/9/2020 18:05:15
  %param i_cadena Cadena
  %param i_separador Caracter separador. Por defecto '~'
  %return Tabla de cadenas
  */
  function f_separar_cadenas(i_cadena    in varchar2,
                             i_separador in varchar2 default '~')
    return y_cadenas
    pipelined;

  function f_unir_cadenas(i_cadena    in varchar2,
                          i_cadenas   in y_cadenas,
                          i_wrap_char in varchar2 default '@')
    return varchar2;

  function f_unir_cadenas(i_cadena    in varchar2,
                          i_cadena1   in varchar2 default null,
                          i_cadena2   in varchar2 default null,
                          i_cadena3   in varchar2 default null,
                          i_cadena4   in varchar2 default null,
                          i_cadena5   in varchar2 default null,
                          i_wrap_char in varchar2 default '@')
    return varchar2;

  /**
  Retorna una tabla de cadenas contenidas en delimitadores dentro de un texto dado
  
  %author dmezac 22/6/2025 18:05:15
  %param i_texto Texto a partir del cuál se hará la búsqueda de cadenas
  %param i_encapsulador_inicial Caracter delimitador inicial. Por defecto ':'
  %param i_encapsulador_final Caracter delimitador final. Por defecto ' '
  %return Tabla de cadenas
  */
  function f_extraer_cadenas(i_texto                in varchar2,
                             i_encapsulador_inicial in varchar2 := ':',
                             i_encapsulador_final   in varchar2 := ' ',
                             i_limpio               in varchar2 := 'N')
    return y_cadenas
    pipelined;

  /**
  Retorna el valor que se encuenta en la posicion indicada dentro de una cadena
  Si la posicion se encuentra fuera de rango retorna el valor mas cercano (primer valor o ultimo valor)
  
  %author jtsoya539 27/3/2020 17:07:15
  %param i_cadena Cadena
  %param i_posicion Posicion dentro de la cadena
  %param i_separador Caracter separador. Por defecto '~'
  %return Valor que se encuenta en la posicion indicada
  */
  function f_valor_posicion(i_cadena    in varchar2,
                            i_posicion  in number,
                            i_separador in varchar2 default '~')
    return varchar2;

  function f_reemplazar_acentos(i_cadena in varchar2) return varchar2;

  function f_formatear_titulo(i_titulo in varchar2) return varchar2
    deterministic;

  function f_procesar_plantilla(i_plantilla in clob,
                                i_variables in t_assoc_array default null_assoc_array,
                                i_wrap_char in varchar2 default '@')
    return clob;

  function f_buscar_cadena(pin_buscar    varchar2,
                           pin_cadena    varchar2,
                           pin_separador varchar2 default ',')
    return varchar2;

  function f_formatear_cadena(p_lista_campos     in varchar2, -- lista separada por comas
                              p_patron           in varchar2, -- texto plantilla, usar "#" como placeholder
                              p_separador_salida in varchar2 default chr(10) -- salto de línea o coma
                              ) return clob;

  function f_reemplazar_etiquetas(i_cadena       in clob,
                                  i_etiquetas    in y_cadenas,
                                  i_valores      in y_cadenas,
                                  i_encapsulador in varchar2 default '#')
    return clob;

end;
/
