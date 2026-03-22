create or replace package k_parametro authid current_user is

  /**
  Agrupa operaciones relacionadas con los parámetros
  
  %author jtsoya539 18/8/2025 16:16:59
  */

  -- Tipos de datos soportados
  c_tipo_dato_string      constant char(1) := 'S';
  c_tipo_dato_number      constant char(1) := 'N';
  c_tipo_dato_boolean     constant char(1) := 'B';
  c_tipo_dato_date        constant char(1) := 'D';
  c_tipo_dato_object      constant char(1) := 'O';
  c_tipo_dato_json_object constant char(1) := 'J';
  c_tipo_dato_json_array  constant char(1) := 'A';
  c_tipo_dato_clob        constant char(1) := 'C';

  -- Tipos de definiciones soportados
  c_tipo_definicion_operacion constant varchar2(10) := 'OPERACION';
  c_tipo_definicion_parametro constant varchar2(10) := 'PARAMETRO';
  c_tipo_definicion_dato      constant varchar2(10) := 'DATO';

  -- Tablas de parámetros soportadas
  c_tabla_parametros               constant varchar2(50) := 'T_PARAMETROS';
  c_tabla_aplicaciones             constant varchar2(50) := 'T_APLICACION_PARAMETROS';
  c_tabla_suscripcion_aceptaciones constant varchar2(50) := 'T_SUSCRIPCION_ACEPTACION_PARAMETROS';

  c_id_ope_par_automaticos constant pls_integer := 1000;

  -- Tipos
  type ry_datos_valor_parametro is record(
    valor         varchar2(4000),
    tipo_dato     varchar2(1),
    formato       varchar2(100),
    valor_defecto varchar2(1000),
    encriptado    varchar2(1));

  type ry_datos_definicion_parametro is record(
    tipo_definicion  varchar2(100),
    nombre           varchar2(100),
    orden            number(3),
    activo           varchar2(1),
    tipo_dato        varchar2(1),
    formato          varchar2(100),
    longitud_maxima  number(15),
    obligatorio      varchar2(1),
    valor_defecto    varchar2(1000),
    etiqueta         varchar2(2000),
    detalle          varchar2(4000),
    valores_posibles varchar2(50),
    encriptado       varchar2(1));

  type y_datos_definiciones is table of ry_datos_definicion_parametro;

  function f_parametro_definicion(i_tabla        in varchar2,
                                  i_id_parametro in varchar2)
    return t_parametro_definiciones%rowtype;

  function f_parametro_definiciones( -- OPERACION
                                    i_id_operacion in number default null,
                                    i_version      in varchar2 default null,
                                    -- PARAMETRO
                                    i_tabla_parametro in varchar2 default null,
                                    i_tipo_filtro     in varchar2 default null,
                                    -- DATO
                                    i_tabla_dato in varchar2 default null,
                                    i_campo      in varchar2 default null)
    return y_datos_definiciones;

  function f_validar_parametro(i_parametro_definicion in ry_datos_definicion_parametro,
                               i_valor                in json_element_t)
    return anydata;

  function f_procesar_parametros(i_parametros in clob,
                                 -- OPERACION
                                 i_id_operacion in number default null,
                                 i_version      in varchar2 default null,
                                 -- PARAMETRO
                                 i_tabla_parametro in varchar2 default null,
                                 i_tipo_filtro     in varchar2 default null,
                                 -- DATO
                                 i_tabla_dato in varchar2 default null,
                                 i_campo      in varchar2 default null)
    return y_parametros;

  function f_procesar_parametros(i_parametros      in clob,
                                 i_tabla_parametro in varchar2,
                                 i_tipo_filtro     in varchar2 default null)
    return y_parametros;

  function f_datos_valor_parametro(i_tabla        in varchar2,
                                   i_id_parametro in varchar2,
                                   i_referencia   in varchar2 default null)
    return ry_datos_valor_parametro;

  function f_valor_parametro(i_tabla        in varchar2,
                             i_id_parametro in varchar2,
                             i_referencia   in varchar2 default null)
    return varchar2;

  function f_valor_parametro_string(i_tabla        in varchar2,
                                    i_id_parametro in varchar2,
                                    i_referencia   in varchar2 default null)
    return varchar2;

  function f_valor_parametro_number(i_tabla        in varchar2,
                                    i_id_parametro in varchar2,
                                    i_referencia   in varchar2 default null)
    return number;

  function f_valor_parametro_boolean(i_tabla        in varchar2,
                                     i_id_parametro in varchar2,
                                     i_referencia   in varchar2 default null)
    return boolean;

  function f_valor_parametro_date(i_tabla        in varchar2,
                                  i_id_parametro in varchar2,
                                  i_referencia   in varchar2 default null)
    return date;

  procedure p_definir_parametro(i_tabla        in varchar2,
                                i_id_parametro in varchar2,
                                i_valor        in varchar2,
                                i_referencia   in varchar2 default null);

  procedure p_definir_parametro_string(i_tabla        in varchar2,
                                       i_id_parametro in varchar2,
                                       i_valor        in varchar2,
                                       i_referencia   in varchar2 default null);

  procedure p_definir_parametro_number(i_tabla        in varchar2,
                                       i_id_parametro in varchar2,
                                       i_valor        in number,
                                       i_referencia   in varchar2 default null);

  procedure p_definir_parametro_boolean(i_tabla        in varchar2,
                                        i_id_parametro in varchar2,
                                        i_valor        in boolean,
                                        i_referencia   in varchar2 default null);

  procedure p_definir_parametro_date(i_tabla        in varchar2,
                                     i_id_parametro in varchar2,
                                     i_valor        in date,
                                     i_referencia   in varchar2 default null);

end;
/

