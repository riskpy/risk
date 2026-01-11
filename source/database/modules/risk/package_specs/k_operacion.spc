create or replace package k_operacion is

  /**
  Agrupa operaciones relacionadas con las Operaciones (Servicios Web, Reportes, Trabajos, Monitoreos, Importaciones)
  
  %author jtsoya539 27/3/2020 16:42:26
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

  -- Tipos de Operaciones
  c_tipo_servicio   constant char(1) := 'S';
  c_tipo_reporte    constant char(1) := 'R';
  c_tipo_trabajo    constant char(1) := 'T';
  c_tipo_monitoreo  constant char(1) := 'M';
  c_tipo_importacion constant char(1) := 'I';
  c_tipo_parametros constant char(1) := 'P';

  -- Tipos de Implementaciones
  c_tipo_implementacion_paquete constant char(1) := 'K';
  c_tipo_implementacion_funcion constant char(1) := 'F';
  c_tipo_implementacion_bloque  constant char(1) := 'B';

  -- Códigos de respuesta
  c_ok                       constant varchar2(10) := '0';
  c_servicio_no_implementado constant varchar2(10) := 'ser0001';
  c_error_parametro          constant varchar2(10) := 'ser0002';
  c_error_permiso            constant varchar2(10) := 'ser0003';
  c_error_general            constant varchar2(10) := 'ser0099';
  c_error_registro_bloqueado constant varchar2(10) := 'ser9997';
  c_error_clave_duplicada    constant varchar2(10) := 'ser9998';
  c_error_inesperado         constant varchar2(10) := 'ser9999';

  -- Niveles de log
  cg_nivel_log_off   constant pls_integer := 0;
  cg_nivel_log_error constant pls_integer := 1;
  cg_nivel_log_info  constant pls_integer := 2;

  -- Otras constantes
  c_id_log                 constant varchar2(50) := '##ID_LOG##';
  c_sql_ejecucion          constant varchar2(50) := 'SQL_EJECUCION';
  c_id_ope_par_automaticos constant pls_integer := 1000;
  c_id_operacion_contexto  constant pls_integer := 1001;
  --
  c_aplicacion_servicio  constant t_aplicaciones.nombre%type := 'API';
  c_aplicacion_reporte   constant t_aplicaciones.nombre%type := 'API';
  c_aplicacion_trabajo   constant t_aplicaciones.nombre%type := 'TRABAJO';
  c_aplicacion_monitoreo constant t_aplicaciones.nombre%type := 'MONITOREO';

  -- Excepciones
  ex_servicio_no_implementado exception;
  ex_error_parametro          exception;
  ex_error_general            exception;
  pragma exception_init(ex_servicio_no_implementado, -6550);

  procedure p_crear_parametro(i_id_operacion     in t_operacion_parametros.id_operacion %type,
                              i_nombre           in t_operacion_parametros.nombre%type,
                              i_tipo_dato        in t_operacion_parametros.tipo_dato%type,
                              i_orden            in t_operacion_parametros.orden%type,
                              i_obligatorio      in t_operacion_parametros.obligatorio%type default 'N',
                              i_version          in t_operacion_parametros.version%type default '0.1.0',
                              i_formato          in t_operacion_parametros.formato%type default null,
                              i_longitud_maxima  in t_operacion_parametros.longitud_maxima%type default null,
                              i_valor_defecto    in t_operacion_parametros.valor_defecto%type default null,
                              i_valores_posibles in t_operacion_parametros.valores_posibles%type default null,
                              i_etiqueta         in t_operacion_parametros.etiqueta%type default null,
                              i_detalle          in t_operacion_parametros.detalle%type default null,
                              i_encriptado       in t_operacion_parametros.encriptado%type default 'N');

  procedure p_registrar_log(io_id_log          in out number,
                            i_id_operacion     in number,
                            i_parametros       in clob,
                            i_codigo_respuesta in varchar2 default null,
                            i_respuesta        in clob default null,
                            i_contexto         in clob default null,
                            i_version          in varchar2 default null);

  procedure p_respuesta_ok(io_respuesta in out nocopy y_respuesta,
                           i_datos      in y_objeto default null);

  procedure p_respuesta_error(io_respuesta in out nocopy y_respuesta,
                              i_codigo     in varchar2,
                              i_mensaje    in varchar2 default null,
                              i_mensaje_bd in varchar2 default null,
                              i_datos      in y_objeto default null,
                              i_tipo_error in varchar2 default null);

  procedure p_respuesta_excepcion(io_respuesta   in out nocopy y_respuesta,
                                  i_error_number in number,
                                  i_error_msg    in varchar2,
                                  i_error_stack  in varchar2);

  procedure p_validar_parametro(io_respuesta in out nocopy y_respuesta,
                                i_expresion  in boolean,
                                i_mensaje    in varchar2);

  procedure p_definir_parametros(i_id_operacion in number,
                                 i_contexto     in y_parametros);

  function f_operacion(i_id_operacion in number) return t_operaciones%rowtype;

  function f_id_operacion(i_tipo    in varchar2,
                          i_nombre  in varchar2,
                          i_dominio in varchar2) return number;

  function f_id_permiso(i_id_operacion in number) return varchar2;

  function f_id_modulo(i_id_operacion in number) return varchar2;

  function f_validar_permiso_aplicacion(i_id_aplicacion in varchar2,
                                        i_id_operacion  in number)
    return boolean;

  function f_procesar_parametros(i_id_operacion in number,
                                 i_parametros   in clob,
                                 i_version      in varchar2 default null)
    return y_parametros;

  function f_nombre_programa(i_id_operacion in number,
                             i_version      in varchar2 default null)
    return varchar2;

  function f_tipo_argumento_parametros(i_id_operacion in number,
                                       i_version      in varchar2 default null)
    return varchar2;

  function f_filtros_sql(i_parametros      in y_parametros,
                         i_nombres_excluir in y_cadenas default null)
    return clob;

  function f_filtros_sql_dinamico(i_parametros      in y_parametros,
                                  i_consulta_sql    in clob default null,
                                  i_nombres_excluir in y_cadenas default null)
    return clob;

  function f_valor_parametro(i_parametros in y_parametros,
                             i_nombre     in varchar2) return anydata;

  function f_valor_parametro_string(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return varchar2;

  function f_valor_parametro_number(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return number;

  function f_valor_parametro_boolean(i_parametros in y_parametros,
                                     i_nombre     in varchar2) return boolean;

  function f_valor_parametro_date(i_parametros in y_parametros,
                                  i_nombre     in varchar2) return date;

  function f_valor_parametro_object(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return y_objeto;

  function f_valor_parametro_json_object(i_parametros in y_parametros,
                                         i_nombre     in varchar2)
    return json_object_t;

  function f_valor_parametro_json_array(i_parametros in y_parametros,
                                        i_nombre     in varchar2)
    return json_array_t;

end;
/

