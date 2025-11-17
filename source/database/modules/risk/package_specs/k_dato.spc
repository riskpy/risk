CREATE OR REPLACE PACKAGE k_dato IS

  /**
  Agrupa operaciones relacionadas con datos adicionales
  
  %author jtsoya539 27/3/2020 16:22:16
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

  FUNCTION f_recuperar_dato(i_tabla      IN VARCHAR2,
                            i_campo      IN VARCHAR2,
                            i_referencia IN VARCHAR2) RETURN anydata;

  FUNCTION f_recuperar_dato_string(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_recuperar_dato_number(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_recuperar_dato_boolean(i_tabla      IN VARCHAR2,
                                    i_campo      IN VARCHAR2,
                                    i_referencia IN VARCHAR2) RETURN BOOLEAN;

  FUNCTION f_recuperar_dato_date(i_tabla      IN VARCHAR2,
                                 i_campo      IN VARCHAR2,
                                 i_referencia IN VARCHAR2) RETURN DATE;

  FUNCTION f_recuperar_dato_object(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN y_objeto;

  PROCEDURE p_guardar_dato(i_tabla      IN VARCHAR2,
                           i_campo      IN VARCHAR2,
                           i_referencia IN VARCHAR2,
                           i_dato       IN anydata);

  PROCEDURE p_guardar_dato_string(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN VARCHAR2);

  PROCEDURE p_guardar_dato_number(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN NUMBER);

  PROCEDURE p_guardar_dato_boolean(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2,
                                   i_dato       IN BOOLEAN);

  PROCEDURE p_guardar_dato_date(i_tabla      IN VARCHAR2,
                                i_campo      IN VARCHAR2,
                                i_referencia IN VARCHAR2,
                                i_dato       IN DATE);

  -- Para evitar el error ORA-22370, el tipo (heredado de y_objeto) del dato no
  -- debe contener atributos LOBs (CLOB, BLOB) ya que actualmente no cuenta con
  -- soporte para persistencia
  PROCEDURE p_guardar_dato_object(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN y_objeto);
  PRAGMA deprecate(p_guardar_dato_object,
                   'No usar! Siempre da error ORA-22370 por el campo json de y_objeto');

END;
/
