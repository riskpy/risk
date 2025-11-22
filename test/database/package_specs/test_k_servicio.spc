create or replace package test_k_servicio is

  --%suite(Tests unitarios del paquete k_servicio)
  --%tags(package)

  --%context(Tests unitarios de f_procesar_servicio)
  --%name(f_procesar_servicio)

  --%test()
  procedure f_procesar_servicio_inexistente;
  --%test()
  procedure f_procesar_servicio_error_json_parametros;
  --%test()
  procedure f_procesar_servicio_error_json_contexto;
  --%test()
  procedure f_procesar_servicio_error_tipo_contexto;
  --%test()
  procedure f_procesar_servicio_version_sistema;
  --%endcontext

end;
/
