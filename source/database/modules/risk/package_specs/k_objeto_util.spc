create or replace package k_objeto_util is
  /**
  Agrupa herramientas para facilitar el manejo de objetos del tipo y_objeto
  
  %author dmezac 17/04/2025
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
  -- Excepciones
  ex_tipo_inexistente exception;
  pragma exception_init(ex_tipo_inexistente, -6550);

  -- Tipos
  type ry_tipo_objeto is record(
    propietario varchar2(128),
    nombre      varchar2(128));
  type y_tipo_objetos is table of ry_tipo_objeto;
  type y_cache_atributos is table of y_tipo_atributos index by varchar2(260);

  -- Cache en memoria por sesión
  g_cache_atributos y_cache_atributos;

  /**
    Retorna el objeto deserializado a partir de un JSON.
    Cada sub-tipo del tipo base y_objeto debe implementar esta función con los
    atributos correspondientes.
  
    %author dmezac 17/04/2025
    %param i_json JSON del objeto a deserializar.
    %param i_propietario Propietario del tipo del objeto a deserializar.
    %param i_nombre_tipo Nombre del tipo del objeto a deserializar.
    %param i_tipos Lista de tipos a deserializar.
    %return Objeto deserializado a partir de un JSON.
  */
  function parse_json(i_json        in clob,
                      i_tipos       in y_tipo_objetos default null,
                      i_propietario in varchar2 default null,
                      i_nombre_tipo in varchar2 default null) return y_objeto;

  /**
    Retorna el objeto serializado en formato JSON.
    Cada sub-tipo del tipo base y_objeto debe implementar esta función con los
    atributos correspondientes.
  
    %author dmezac 17/04/2025
    %param i_objeto Objeto a serializar.
    %param i_propietario Propietario del tipo del objeto a serializar.
    %param i_nombre_tipo Nombre del tipo del objeto a serializar.
    %return Objeto serializado en formato JSON.
  */
  function to_json(i_objeto      in y_objeto,
                   i_propietario in varchar2 default null,
                   i_nombre_tipo in varchar2 default null) return clob;

  function json_to_objeto(i_json        in clob,
                          i_nombre_tipo in varchar2) return anydata;

  function json_to_objeto(i_json in clob,
                          i_tipo in ry_tipo_objeto) return anydata;

  function objeto_to_json(i_objeto in anydata) return clob;

  --
  procedure p_inicializar_cola;

  procedure p_encolar(i_propietario in varchar2,
                      i_nombre      in varchar2);

  function f_desencolar return ry_tipo_objeto;

  procedure p_imprimir_cola;
  --

  procedure p_generar_type_objeto(i_tabla    in varchar2,
                                  i_type     in varchar2 default null,
                                  i_ejecutar in boolean default true);

  function f_objetos_clob(pin_objetos y_objetos) return clob;

end k_objeto_util;
/

