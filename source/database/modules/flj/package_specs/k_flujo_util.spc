create or replace package k_flujo_util as
  /**
  Agrupa herramientas para facilitar el manejo del motor de flujos
  
  %author dmezac 04/05/2025
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

  function f_obtener_variable(i_variables in clob,
                              i_clave     in varchar2) return varchar2;

  function f_editar_variable(i_variables in clob,
                             i_clave     in varchar2,
                             i_valor     in varchar2) return clob;

  function f_reemplazar_variables(i_expresion         in varchar2,
                                  i_variables         in clob,
                                  i_delimitador_texto in varchar2 := '''')
    return varchar2;

  function f_evaluar_condicion(i_condicion in varchar2,
                               i_variables in clob) return boolean;

  function f_contiene_valor(i_valor     in varchar2,
                            i_variables in clob) return boolean;

end k_flujo_util;
/
