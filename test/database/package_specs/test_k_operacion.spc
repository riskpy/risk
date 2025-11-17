CREATE OR REPLACE PACKAGE test_k_operacion IS

  --%suite(Tests unitarios del paquete k_operacion)
  --%tags(package)

  --%context(Tests unitarios de p_inicializar_log)
  --%name(p_inicializar_log)

  --%test()
  PROCEDURE p_inicializar_log_activo;
  --%test()
  PROCEDURE p_inicializar_log_inactivo;
  --%endcontext

  --%context(Tests unitarios de f_id_operacion)
  --%name(f_id_operacion)

  --%test()
  PROCEDURE f_id_operacion_existente;
  --%test()
  PROCEDURE f_id_operacion_inexistente;
  --%endcontext

  --%context(Tests unitarios de f_filtros_sql)
  --%name(f_filtros_sql)

  --%test()
  PROCEDURE f_filtros_sql_sin_parametros;
  --%test()
  PROCEDURE f_filtros_sql_parametros_ignorados;
  --%test()
  PROCEDURE f_filtros_sql_parametro_varchar2;
  --%test()
  PROCEDURE f_filtros_sql_parametro_date;
  --%test()
  PROCEDURE f_filtros_sql_parametro_number;
  --%test()
  --%throws(-20000)
  PROCEDURE f_filtros_sql_tipo_no_soportado;
  --%endcontext

  --%context(Tests unitarios de f_valor_parametro)
  --%name(f_valor_parametro)

  --%test()
  PROCEDURE f_valor_parametro_lista_null;
  --%test()
  PROCEDURE f_valor_parametro_lista_vacia;
  --%test() 
  PROCEDURE f_valor_parametro_nombre_con_diferente_case;
  --%test() 
  PROCEDURE f_valor_parametro_nombre_inexistente;
  --%test()
  PROCEDURE f_valor_parametro_string;
  --%test()
  PROCEDURE f_valor_parametro_number;
  --%test()
  PROCEDURE f_valor_parametro_boolean;
  --%test()
  PROCEDURE f_valor_parametro_date;
  --%test()
  PROCEDURE f_valor_parametro_object;
  --%endcontext

END;
/
