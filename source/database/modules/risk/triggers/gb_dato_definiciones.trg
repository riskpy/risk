create or replace trigger gb_dato_definiciones
  before insert or update on t_dato_definiciones
  for each row
begin
  :new.tabla := upper(:new.tabla);
  :new.campo := upper(:new.campo);
end;
/

