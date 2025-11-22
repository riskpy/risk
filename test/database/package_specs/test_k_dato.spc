create or replace package test_k_dato is

  --%suite(Tests unitarios del paquete k_dato)
  --%tags(package)

  --%test(Guarda un dato adicional de tipo string)
  procedure p_guardar_dato_string_uso_basico;

  --%test(Guarda un dato adicional de tipo number)
  procedure p_guardar_dato_number_uso_basico;

  --%test(Guarda un dato adicional de tipo boolean)
  procedure p_guardar_dato_boolean_uso_basico;

  --%test(Guarda un dato adicional de tipo date)
  procedure p_guardar_dato_date_uso_basico;

  --%test(Guarda un dato adicional de tipo object)
  --%disabled
  procedure p_guardar_dato_object_uso_basico;

end;
/
