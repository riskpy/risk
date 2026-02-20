create or replace package k_significado_util is

  /**
  Agrupa utilidades relacionadas con significados
  
  %author jtsoya539 22/12/2025
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

  function f_inserts_dominio(i_significado_dominio in t_significado_dominios%rowtype,
                             i_motivo_modificacion in varchar2 default null)
    return clob;

  function f_inserts_dominio(i_dominio             in varchar2,
                             i_motivo_modificacion in varchar2 default null)
    return clob;

  function f_deletes_dominio(i_significado_dominio in t_significado_dominios%rowtype)
    return clob;

  function f_deletes_dominio(i_dominio in varchar2) return clob;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob;

  function f_scripts_dominios(i_id_modulo           in varchar2 default null,
                              i_motivo_modificacion in varchar2 default null)
    return blob;

end;
/
