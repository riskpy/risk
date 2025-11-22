create or replace package body test_y_dato is

  procedure y_dato_uso_basico is
  begin
    ut.expect('hola').to_equal('hola');
  end;

end;
/
