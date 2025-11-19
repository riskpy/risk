create or replace package k_dato is

  /**
  Agrupa operaciones relacionadas con datos adicionales
  
  %author jtsoya539 27/3/2020 16:22:16
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

  function f_recuperar_dato(i_tabla      in varchar2,
                            i_campo      in varchar2,
                            i_referencia in varchar2) return anydata;

  function f_recuperar_dato_string(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return varchar2;

  function f_recuperar_dato_number(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return number;

  function f_recuperar_dato_boolean(i_tabla      in varchar2,
                                    i_campo      in varchar2,
                                    i_referencia in varchar2) return boolean;

  function f_recuperar_dato_date(i_tabla      in varchar2,
                                 i_campo      in varchar2,
                                 i_referencia in varchar2) return date;

  function f_recuperar_dato_object(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return y_objeto;

  procedure p_guardar_dato(i_tabla      in varchar2,
                           i_campo      in varchar2,
                           i_referencia in varchar2,
                           i_dato       in anydata);

  procedure p_guardar_dato_string(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in varchar2);

  procedure p_guardar_dato_number(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in number);

  procedure p_guardar_dato_boolean(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2,
                                   i_dato       in boolean);

  procedure p_guardar_dato_date(i_tabla      in varchar2,
                                i_campo      in varchar2,
                                i_referencia in varchar2,
                                i_dato       in date);

  -- Para evitar el error ORA-22370, el tipo (heredado de y_objeto) del dato no
  -- debe contener atributos LOBs (CLOB, BLOB) ya que actualmente no cuenta con
  -- soporte para persistencia
  procedure p_guardar_dato_object(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in y_objeto);
  pragma deprecate(p_guardar_dato_object,
                   'No usar! Siempre da error ORA-22370 por el campo json de y_objeto');

end;
/
