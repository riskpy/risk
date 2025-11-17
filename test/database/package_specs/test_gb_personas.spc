CREATE OR REPLACE PACKAGE test_gb_personas IS

  --%suite(Tests unitarios del trigger gb_personas)
  --%tags(trigger)

  --%test(Guarda el nombre en mayúsculas al insertar)
  PROCEDURE nombre_mayusculas_al_insertar;

  --%test(Guarda el apellido en mayúsculas al insertar)
  PROCEDURE apellido_mayusculas_al_insertar;

  --%test(Guarda el nombre completo en mayúsculas al insertar)
  PROCEDURE nombre_completo_mayusculas_al_insertar;

  --%test(Guarda el nombre en mayúsculas al actualizar)
  PROCEDURE nombre_mayusculas_al_actualizar;

  --%test(Guarda el apellido en mayúsculas al actualizar)
  PROCEDURE apellido_mayusculas_al_actualizar;

  --%test(Guarda el nombre completo en mayúsculas al actualizar)
  PROCEDURE nombre_completo_mayusculas_al_actualizar;

END;
/
