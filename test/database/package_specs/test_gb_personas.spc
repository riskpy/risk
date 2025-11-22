create or replace package test_gb_personas is

  --%suite(Tests unitarios del trigger gb_personas)
  --%tags(trigger)

  --%test(Guarda el nombre en mayúsculas al insertar)
  procedure nombre_mayusculas_al_insertar;

  --%test(Guarda el apellido en mayúsculas al insertar)
  procedure apellido_mayusculas_al_insertar;

  --%test(Guarda el nombre completo en mayúsculas al insertar)
  procedure nombre_completo_mayusculas_al_insertar;

  --%test(Guarda el nombre en mayúsculas al actualizar)
  procedure nombre_mayusculas_al_actualizar;

  --%test(Guarda el apellido en mayúsculas al actualizar)
  procedure apellido_mayusculas_al_actualizar;

  --%test(Guarda el nombre completo en mayúsculas al actualizar)
  procedure nombre_completo_mayusculas_al_actualizar;

end;
/
