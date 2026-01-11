create or replace package k_operacion_util is

  /**
  Agrupa utilidades relacionadas con las Operaciones (Servicios Web, Reportes, Trabajos, Monitoreos, Importaciones)
  
  %author jmeza 11/12/2025
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

  function f_inserts_operacion(i_operacion           in t_operaciones%rowtype,
                               i_motivo_modificacion in varchar2 default null)
    return clob;

  function f_inserts_operacion(i_id_operacion        in number,
                               i_motivo_modificacion in varchar2 default null)
    return clob;

  function f_inserts_operacion(i_tipo                in varchar2,
                               i_nombre              in varchar2,
                               i_dominio             in varchar2,
                               i_motivo_modificacion in varchar2 default null)
    return clob;

  function f_deletes_operacion(i_operacion in t_operaciones%rowtype)
    return clob;

  function f_deletes_operacion(i_id_operacion in number) return clob;

  function f_deletes_operacion(i_tipo    in varchar2,
                               i_nombre  in varchar2,
                               i_dominio in varchar2) return clob;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob;

  function f_scripts_operaciones(i_id_modulo           in varchar2 default null,
                                 i_motivo_modificacion in varchar2 default null)
    return blob;

end;
/

