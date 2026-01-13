create or replace package k_parametro authid current_user is

  /**
  Agrupa operaciones relacionadas con los parámetros
  
  %author jmeza 18/8/2025 16:16:59
  */

  -- Tablas de parámetros soportadas
  c_tabla_parametros               constant varchar2(50) := 'T_PARAMETROS';
  c_tabla_aplicaciones             constant varchar2(50) := 'T_APLICACION_PARAMETROS';
  c_tabla_suscripcion_aceptaciones constant varchar2(50) := 'T_SUSCRIPCION_ACEPTACION_PARAMETROS';

  -- Tipos
  type ry_datos_valor_parametro is record(
    valor         varchar2(4000),
    tipo_dato     varchar2(1),
    formato       varchar2(100),
    valor_defecto varchar2(1000),
    encriptado    varchar2(1));

  function f_procesar_parametros(i_tabla       in varchar2,
                                 i_parametros  in clob,
                                 i_tipo_filtro in varchar2 default null)
    return y_parametros;

  function f_datos_valor_parametro(i_tabla        in varchar2,
                                   i_id_parametro in varchar2,
                                   i_referencia   in varchar2 default null)
    return ry_datos_valor_parametro;

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

  function f_valor_parametro(i_tabla        in varchar2,
                             i_id_parametro in varchar2,
                             i_referencia   in varchar2 default null)
    return varchar2;

  procedure p_definir_parametro(i_tabla        in varchar2,
                                i_id_parametro in varchar2,
                                i_valor        in varchar2,
                                i_referencia   in varchar2 default null);

end;
/

