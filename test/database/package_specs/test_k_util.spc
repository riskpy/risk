create or replace package test_k_util is

  --%suite(Tests unitarios del paquete k_util)
  --%tags(package)

  --%context(Tests unitarios de f_valor_parametro)
  --%name(f_valor_parametro)

  --%test()
  procedure f_valor_parametro_parametro_con_valor;
  --%test()
  procedure f_valor_parametro_parametro_sin_valor;
  --%test()
  procedure f_valor_parametro_parametro_inexistente;
  --%endcontext

  --%context(Tests unitarios de p_actualizar_valor_parametro)
  --%name(p_actualizar_valor_parametro)

  --%test()
  procedure p_actualizar_valor_parametro_uso_basico;
  --%endcontext

  --%context(Tests unitarios de f_base_datos)
  --%name(f_base_datos)

  --%test()
  procedure f_base_datos;
  --%endcontext

  --%context(Tests unitarios de f_terminal)
  --%name(f_terminal)

  --%test()
  procedure f_terminal;
  --%endcontext

  --%context(Tests unitarios de f_host)
  --%name(f_host)

  --%test()
  procedure f_host;
  --%endcontext

  --%context(Tests unitarios de f_direccion_ip)
  --%name(f_direccion_ip)

  --%test()
  procedure f_direccion_ip;
  --%endcontext

  --%context(Tests unitarios de f_esquema_actual)
  --%name(f_esquema_actual)

  --%test()
  procedure f_esquema_actual;
  --%endcontext

end;
/
