create or replace package test_k_operacion is

  --%suite(Tests unitarios del paquete k_operacion)
  --%tags(package)

  --%context(Tests unitarios de p_inicializar_log)
  --%name(p_inicializar_log)

  --%test()
  procedure p_inicializar_log_activo;
  --%test()
  procedure p_inicializar_log_inactivo;
  --%endcontext

  --%context(Tests unitarios de f_id_operacion)
  --%name(f_id_operacion)

  --%test()
  procedure f_id_operacion_existente;
  --%test()
  procedure f_id_operacion_inexistente;
  --%endcontext

  --%context(Tests unitarios de f_filtros_sql)
  --%name(f_filtros_sql)

  --%test()
  procedure f_filtros_sql_sin_parametros;
  --%test()
  procedure f_filtros_sql_parametros_ignorados;
  --%test()
  procedure f_filtros_sql_parametro_varchar2;
  --%test()
  procedure f_filtros_sql_parametro_date;
  --%test()
  procedure f_filtros_sql_parametro_number;
  --%test()
  --%throws(-20000)
  procedure f_filtros_sql_tipo_no_soportado;
  --%endcontext

  --%context(Tests unitarios de f_valor_parametro)
  --%name(f_valor_parametro)

  --%test()
  procedure f_valor_parametro_lista_null;
  --%test()
  procedure f_valor_parametro_lista_vacia;
  --%test() 
  procedure f_valor_parametro_nombre_con_diferente_case;
  --%test() 
  procedure f_valor_parametro_nombre_inexistente;
  --%test()
  procedure f_valor_parametro_string;
  --%test()
  procedure f_valor_parametro_number;
  --%test()
  procedure f_valor_parametro_boolean;
  --%test()
  procedure f_valor_parametro_date;
  --%test()
  procedure f_valor_parametro_object;
  --%endcontext

end;
/
