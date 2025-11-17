CREATE OR REPLACE PACKAGE k_json_util AS
  /**
  Agrupa herramientas para facilitar el manejo de json y variables
  
  %author dmezac 04/05/2025
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

  c_json_object_vacio CONSTANT VARCHAR2(10) := '{}';
  c_json_array_vacio  CONSTANT VARCHAR2(10) := '[]';

  FUNCTION f_contiene_valor(i_valor IN VARCHAR2,
                            i_json  IN CLOB) RETURN BOOLEAN;

  FUNCTION f_obtener_valor(i_json  IN CLOB,
                           i_clave IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_editar_valor(i_json  IN CLOB,
                          i_clave IN VARCHAR2,
                          i_valor IN VARCHAR2) RETURN CLOB;

  FUNCTION f_contiene_valores(i_valores IN VARCHAR2,
                              i_json    IN CLOB) RETURN VARCHAR2;

  FUNCTION f_reemplazar_expresion(i_expresion                  IN VARCHAR2,
                                  i_valores                    IN CLOB,
                                  i_encapsulador_inicial       IN VARCHAR2 := ':',
                                  i_encapsulador_final         IN VARCHAR2 := '',
                                  i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB;

  FUNCTION f_reemplazar_expresion_clob(i_expresion                  IN CLOB,
                                       i_valores                    IN CLOB,
                                       i_encapsulador_inicial       IN VARCHAR2 := ':',
                                       i_encapsulador_final         IN VARCHAR2 := '',
                                       i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB;

  FUNCTION f_replace_clob(i_source  IN CLOB,
                          i_find    IN VARCHAR2,
                          i_replace IN CLOB) RETURN CLOB;

END k_json_util;
/
