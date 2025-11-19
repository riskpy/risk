create or replace package k_json_util as
  /**
  Agrupa herramientas para facilitar el manejo de json y variables
  
  %author dmezac 04/05/2025
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

  c_json_object_vacio constant varchar2(10) := '{}';
  c_json_array_vacio  constant varchar2(10) := '[]';

  function f_contiene_valor(i_valor in varchar2,
                            i_json  in clob) return boolean;

  function f_obtener_valor(i_json  in clob,
                           i_clave in varchar2) return varchar2;

  function f_editar_valor(i_json  in clob,
                          i_clave in varchar2,
                          i_valor in varchar2) return clob;

  function f_contiene_valores(i_valores in varchar2,
                              i_json    in clob) return varchar2;

  function f_reemplazar_expresion(i_expresion                  in varchar2,
                                  i_valores                    in clob,
                                  i_encapsulador_inicial       in varchar2 := ':',
                                  i_encapsulador_final         in varchar2 := '',
                                  i_delimitador_texto_agregado in varchar2 := '')
    return clob;

  function f_reemplazar_expresion_clob(i_expresion                  in clob,
                                       i_valores                    in clob,
                                       i_encapsulador_inicial       in varchar2 := ':',
                                       i_encapsulador_final         in varchar2 := '',
                                       i_delimitador_texto_agregado in varchar2 := '')
    return clob;

  function f_replace_clob(i_source  in clob,
                          i_find    in varchar2,
                          i_replace in clob) return clob;

end k_json_util;
/
