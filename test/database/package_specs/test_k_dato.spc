CREATE OR REPLACE PACKAGE test_k_dato IS

  --%suite(Tests unitarios del paquete k_dato)
  --%tags(package)

  --%test(Guarda un dato adicional de tipo string)
  PROCEDURE p_guardar_dato_string_uso_basico;

  --%test(Guarda un dato adicional de tipo number)
  PROCEDURE p_guardar_dato_number_uso_basico;

  --%test(Guarda un dato adicional de tipo boolean)
  PROCEDURE p_guardar_dato_boolean_uso_basico;

  --%test(Guarda un dato adicional de tipo date)
  PROCEDURE p_guardar_dato_date_uso_basico;

  --%test(Guarda un dato adicional de tipo object)
  --%disabled
  PROCEDURE p_guardar_dato_object_uso_basico;

END;
/
