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

end;
/

