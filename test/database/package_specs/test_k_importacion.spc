create or replace package test_k_importacion is

  --%suite(Tests unitarios del paquete k_importacion)
  --%tags(package)

  --%context(Tests unitarios de f_procesar_importacion)
  --%name(f_procesar_importacion)

  --%test()
  procedure p_procesar_importacion_campos_fijos_ok;
  --%test()
  procedure p_procesar_importacion_campos_fijos_error;
  --%test()
  procedure p_procesar_importacion_campos_separados_por_coma_ok;
  --%test()
  procedure p_procesar_importacion_campos_separados_por_coma_error;
  --%endcontext

end;
/
