CREATE OR REPLACE PACKAGE BODY test_y_dato IS

  PROCEDURE y_dato_uso_basico IS
  BEGIN
    ut.expect('hola').to_equal('hola');
  END;

END;
/
