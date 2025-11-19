CREATE OR REPLACE PACKAGE k_cadena IS

  /**
  Agrupa operaciones relacionadas con cadenas
  
  %author jtsoya539 27/3/2020 17:05:34
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

  -- https://github.com/osalvador/tePLSQL
  --Define data type for Template Variable names
  SUBTYPE t_template_variable_name IS VARCHAR2(255);

  --Define data type for Template Variable values
  SUBTYPE t_template_variable_value IS VARCHAR2(32767);

  --Define Associative Array
  TYPE t_assoc_array IS TABLE OF t_template_variable_value INDEX BY t_template_variable_name;

  null_assoc_array t_assoc_array;

  /**
  Retorna una tabla de cadenas delimitadas por un separador
  
  %author dmezac 10/9/2020 18:05:15
  %param i_cadena Cadena
  %param i_separador Caracter separador. Por defecto '~'
  %return Tabla de cadenas
  */
  FUNCTION f_separar_cadenas(i_cadena    IN VARCHAR2,
                             i_separador IN VARCHAR2 DEFAULT '~')
    RETURN y_cadenas
    PIPELINED;

  FUNCTION f_unir_cadenas(i_cadena    IN VARCHAR2,
                          i_cadenas   IN y_cadenas,
                          i_wrap_char IN VARCHAR2 DEFAULT '@')
    RETURN VARCHAR2;

  FUNCTION f_unir_cadenas(i_cadena    IN VARCHAR2,
                          i_cadena1   IN VARCHAR2 DEFAULT NULL,
                          i_cadena2   IN VARCHAR2 DEFAULT NULL,
                          i_cadena3   IN VARCHAR2 DEFAULT NULL,
                          i_cadena4   IN VARCHAR2 DEFAULT NULL,
                          i_cadena5   IN VARCHAR2 DEFAULT NULL,
                          i_wrap_char IN VARCHAR2 DEFAULT '@')
    RETURN VARCHAR2;

  /**
  Retorna una tabla de cadenas contenidas en delimitadores dentro de un texto dado
  
  %author dmezac 22/6/2025 18:05:15
  %param i_texto Texto a partir del cuál se hará la búsqueda de cadenas
  %param i_encapsulador_inicial Caracter delimitador inicial. Por defecto ':'
  %param i_encapsulador_final Caracter delimitador final. Por defecto ' '
  %return Tabla de cadenas
  */
  FUNCTION f_extraer_cadenas(i_texto                IN VARCHAR2,
                             i_encapsulador_inicial IN VARCHAR2 := ':',
                             i_encapsulador_final   IN VARCHAR2 := ' ',
                             i_limpio               IN VARCHAR2 := 'N')
    RETURN y_cadenas
    PIPELINED;

  /**
  Retorna el valor que se encuenta en la posicion indicada dentro de una cadena
  Si la posicion se encuentra fuera de rango retorna el valor mas cercano (primer valor o ultimo valor)
  
  %author jtsoya539 27/3/2020 17:07:15
  %param i_cadena Cadena
  %param i_posicion Posicion dentro de la cadena
  %param i_separador Caracter separador. Por defecto '~'
  %return Valor que se encuenta en la posicion indicada
  */
  FUNCTION f_valor_posicion(i_cadena    IN VARCHAR2,
                            i_posicion  IN NUMBER,
                            i_separador IN VARCHAR2 DEFAULT '~')
    RETURN VARCHAR2;

  FUNCTION f_reemplazar_acentos(i_cadena IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_formatear_titulo(i_titulo IN VARCHAR2) RETURN VARCHAR2
    DETERMINISTIC;

  FUNCTION f_procesar_plantilla(i_plantilla IN CLOB,
                                i_variables IN t_assoc_array DEFAULT null_assoc_array,
                                i_wrap_char IN VARCHAR2 DEFAULT '@')
    RETURN CLOB;

  FUNCTION f_buscar_cadena(pin_buscar    VARCHAR2,
                           pin_cadena    VARCHAR2,
                           pin_separador VARCHAR2 DEFAULT ',')
    RETURN VARCHAR2;

  FUNCTION f_formatear_cadena(p_lista_campos     IN VARCHAR2, -- lista separada por comas
                              p_patron           IN VARCHAR2, -- texto plantilla, usar "#" como placeholder
                              p_separador_salida IN VARCHAR2 DEFAULT chr(10) -- salto de línea o coma
                              ) RETURN CLOB;

  FUNCTION f_reemplazar_etiquetas(i_cadena       IN CLOB,
                                  i_etiquetas    IN y_cadenas,
                                  i_valores      IN y_cadenas,
                                  i_encapsulador IN VARCHAR2 DEFAULT '#')
    RETURN CLOB;

END;
/
