CREATE OR REPLACE PACKAGE test_k_importacion IS

  --%suite(Tests unitarios del paquete k_importacion)
  --%tags(package)

  --%context(Tests unitarios de f_procesar_importacion)
  --%name(f_procesar_importacion)

  --%test()
  PROCEDURE p_procesar_importacion_campos_fijos_ok;
  --%test()
  PROCEDURE p_procesar_importacion_campos_fijos_error;
  --%test()
  PROCEDURE p_procesar_importacion_campos_separados_por_coma_ok;
  --%test()
  PROCEDURE p_procesar_importacion_campos_separados_por_coma_error;
  --%endcontext

END;
/
