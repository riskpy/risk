create or replace package test_k_contexto is

  --%suite(Tests unitarios del paquete k_contexto)
  --%tags(package)

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

