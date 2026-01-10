create or replace package k_significado is

  /**
  Agrupa operaciones relacionadas con significados
  
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

  function f_dominio(i_dominio in varchar2)
    return t_significado_dominios%rowtype;

  /**
  Retorna el significado de un codigo dentro de un dominio de significados
  
  %author jtsoya539 27/3/2020 17:08:39
  %param i_dominio Dominio de significados
  %param i_codigo Codigo
  %return Significado
  */
  function f_significado_codigo(i_dominio in varchar2,
                                i_codigo  in varchar2,
                                i_activo  in varchar2 default null)
    return varchar2;

  function f_referencia_codigo(i_dominio in varchar2,
                               i_codigo  in varchar2,
                               i_activo  in varchar2 default null)
    return varchar2;

  function f_referencia_2_codigo(i_dominio in varchar2,
                                 i_codigo  in varchar2,
                                 i_activo  in varchar2 default null)
    return varchar2;

  function f_existe_codigo(i_dominio in varchar2,
                           i_codigo  in varchar2,
                           i_activo  in varchar2 default null) return boolean;

  function f_id_modulo_dominio(i_dominio in varchar2) return varchar2;

  function f_codigo_referencia(i_dominio    in varchar2,
                               i_referencia in varchar2) return varchar2;

end;
/
