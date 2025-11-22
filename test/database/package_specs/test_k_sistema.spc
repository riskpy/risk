create or replace package test_k_sistema is

  --%suite(Tests unitarios del paquete k_sistema)
  --%tags(package)

  --%context(Tests unitarios de f_fecha)
  --%name(f_fecha)

  --%test()
  procedure f_fecha_por_defecto;
  --%endcontext

  --%context(Tests unitarios de f_usuario)
  --%name(f_usuario)

  --%test()
  procedure f_usuario_por_defecto;
  --%endcontext

end;
/
