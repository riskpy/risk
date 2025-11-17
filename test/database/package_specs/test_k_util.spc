CREATE OR REPLACE PACKAGE test_k_util IS

  --%suite(Tests unitarios del paquete k_util)
  --%tags(package)

  --%context(Tests unitarios de f_valor_parametro)
  --%name(f_valor_parametro)

  --%test()
  PROCEDURE f_valor_parametro_parametro_con_valor;
  --%test()
  PROCEDURE f_valor_parametro_parametro_sin_valor;
  --%test()
  PROCEDURE f_valor_parametro_parametro_inexistente;
  --%endcontext

  --%context(Tests unitarios de p_actualizar_valor_parametro)
  --%name(p_actualizar_valor_parametro)

  --%test()
  PROCEDURE p_actualizar_valor_parametro_uso_basico;
  --%endcontext

  --%context(Tests unitarios de f_base_datos)
  --%name(f_base_datos)

  --%test()
  PROCEDURE f_base_datos;
  --%endcontext

  --%context(Tests unitarios de f_terminal)
  --%name(f_terminal)

  --%test()
  PROCEDURE f_terminal;
  --%endcontext

  --%context(Tests unitarios de f_host)
  --%name(f_host)

  --%test()
  PROCEDURE f_host;
  --%endcontext

  --%context(Tests unitarios de f_direccion_ip)
  --%name(f_direccion_ip)

  --%test()
  PROCEDURE f_direccion_ip;
  --%endcontext

  --%context(Tests unitarios de f_esquema_actual)
  --%name(f_esquema_actual)

  --%test()
  PROCEDURE f_esquema_actual;
  --%endcontext

END;
/
