create or replace trigger gb_errores_actualizar_clave
  before insert or update on t_errores
  for each row
begin
  :new.clave := lower(:new.clave);
end;
/
