create or replace type y_lista_parametros force as object
(
/**
Lista de parámetros.

%author jtsoya539 30/3/2020 10:57:43
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

/** Parámetros */
  parametros y_parametros,

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_lista_parametros.
*/
  constructor function y_lista_parametros return self as result,

  constructor function y_lista_parametros(i_parametros in y_parametros)
    return self as result,

  constructor function y_lista_parametros(i_parametros in clob,
                                          -- OPERACION
                                          i_id_operacion in number default null,
                                          i_version      in varchar2 default null,
                                          -- PARAMETRO
                                          i_tabla       in varchar2 default null,
                                          i_tipo_filtro in varchar2 default null)
    return self as result,

  member function f_valor_parametro(i_nombre in varchar2) return anydata,

  member function f_valor_parametro_string(i_nombre in varchar2)
    return varchar2,

  member function f_valor_parametro_number(i_nombre in varchar2)
    return number,

  member function f_valor_parametro_boolean(i_nombre in varchar2)
    return boolean,

  member function f_valor_parametro_date(i_nombre in varchar2) return date,

  member function f_valor_parametro_object(i_nombre in varchar2)
    return y_objeto,

  member function f_valor_parametro_json_object(i_nombre in varchar2)
    return json_object_t,

  member function f_valor_parametro_json_array(i_nombre in varchar2)
    return json_array_t

)
/

