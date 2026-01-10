create or replace package k_util is

  /**
  Agrupa herramientas para facilitar el desarrollo
  
  %author jtsoya539 27/3/2020 17:05:34
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

  /**
  Genera trigger de secuencia para un campo de una tabla
  
  %author jtsoya539 27/3/2020 17:06:21
  %param i_tabla Tabla
  %param i_campo Campo
  %param i_trigger Trigger
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  procedure p_generar_trigger_secuencia(i_tabla    in varchar2,
                                        i_campo    in varchar2,
                                        i_trigger  in varchar2 default null,
                                        i_ejecutar in boolean default true);

  function f_valor_secuencia_id(i_tabla in varchar2) return number;

  function f_valor_parametro(i_id_parametro in varchar2) return varchar2;

  procedure p_actualizar_valor_parametro(i_id_parametro in varchar2,
                                         i_valor        in varchar2);

  function f_hash(i_data      in varchar2,
                  i_hash_type in pls_integer) return varchar2 deterministic;

  function get_dotnet_ticks(intimestamp in timestamp) return number;

  function guid return varchar2;

  function randomuuid return varchar2;

  /**
  Genera par de claves RSA separadas por punto (.)
  Formato: public_key.private_key
  
  %author dmezac 01/04/2025
  %return Par de claves RSA separadas por punto (.) en formato public_key.private_key
  */
  function rsakeypairgenerator return varchar2;

  function bool_to_string(i_bool in boolean) return varchar2;

  function string_to_bool(i_string in varchar2) return boolean;

  function blob_to_clob(p_data in blob) return clob;

  function clob_to_blob(p_data    in clob,
                        p_charset in varchar2 default null) return blob;

  function base64encode(i_blob in blob) return clob;

  function base64decode(i_clob in clob) return blob;

  function encrypt(i_src in varchar2) return varchar2;

  function decrypt(i_src in varchar2) return varchar2;

  function read_http_body(resp in out utl_http.resp) return clob;

  function f_base_datos return varchar2;

  function f_terminal return varchar2;

  function f_host return varchar2;

  function f_direccion_ip return varchar2;

  function f_esquema_actual return varchar2;

  function f_charset return varchar2;

  /**
  Retorna si el valor recibido es de tipo numérico
  
  %author dmezac 26/1/2022 19:48:15
  %param i_valor valor a determinar si es numérico o no
  %return Si el valor recibido es de tipo numérico
  */
  function f_es_valor_numerico(i_valor in varchar2) return boolean;

  /**
  Retorna si el valor recibido es de tipo numérico
  
  %author dmezac 26/1/2022 19:48:15
  %param i_valor valor a determinar si es numérico o no
  %return Si el valor recibido es de tipo numérico
  */
  function f_es_valor_numerico_sn(i_valor in varchar2) return varchar2;

  /**
  Retorna una zona horaria en formato '(+|-)HH:MM'
  
  %author dmezac 26/1/2022 19:43:15
  %param i_zona_horaria Zona horaria en formato decimal
  %return Zona horaria en formato '(+|-)HH:MM'
  */
  function f_zona_horaria(i_zona_horaria in varchar2) return varchar2;

end;
/

