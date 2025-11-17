CREATE OR REPLACE PACKAGE test_k_servicio IS

  --%suite(Tests unitarios del paquete k_servicio)
  --%tags(package)

  --%context(Tests unitarios de f_procesar_servicio)
  --%name(f_procesar_servicio)

  --%test()
  PROCEDURE f_procesar_servicio_inexistente;
  --%test()
  PROCEDURE f_procesar_servicio_error_json_parametros;
  --%test()
  PROCEDURE f_procesar_servicio_error_json_contexto;
  --%test()
  PROCEDURE f_procesar_servicio_error_tipo_contexto;
  --%test()
  PROCEDURE f_procesar_servicio_version_sistema;
  --%endcontext

END;
/
