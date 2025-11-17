CREATE OR REPLACE PACKAGE test_k_sistema IS

  --%suite(Tests unitarios del paquete k_sistema)
  --%tags(package)

  --%context(Tests unitarios de f_fecha)
  --%name(f_fecha)

  --%test()
  PROCEDURE f_fecha_por_defecto;
  --%endcontext

  --%context(Tests unitarios de f_usuario)
  --%name(f_usuario)

  --%test()
  PROCEDURE f_usuario_por_defecto;
  --%endcontext

END;
/
