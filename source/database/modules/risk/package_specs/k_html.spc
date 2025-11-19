create or replace package k_html is

  /**
  Agrupa operaciones relacionadas con la generacion de HTML
  
  %author jtsoya539 27/3/2020 16:36:54
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

  function f_query2table(i_query    in clob,
                         i_template in clob := null) return clob;

  function f_escapar_texto(i_texto in clob) return clob;

  function f_html return clob;

  procedure p_inicializar(i_doctype in boolean default true);

  procedure p_print(i_clob in clob);

  procedure p_font_face(i_fuentes in varchar2);

end;
/
