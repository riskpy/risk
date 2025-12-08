create or replace trigger gb_roles
  before delete or update on t_roles
  for each row
declare
  l_en_uso number;
begin
  select count(*)
    into l_en_uso
    from t_flujo_instancia_pasos s,
         json_table(s.roles_responsables,
                    '$[*]' columns(val varchar2(100) path '$')) j
   where ((j.val = :old.id_rol and :old.id_rol is not null and
         :new.id_rol is null) /*eliminado*/
         or (j.val = :old.id_rol and :old.id_rol is not null and
         nvl(:old.id_rol, 'X') <> nvl(:new.id_rol, 'X') /*modificado*/
         ))
     and s.estado = k_flujo.c_estado_en_progreso;

  if l_en_uso > 0 then
    raise_application_error(-20002,
                            'No se puede eliminar o modificar el rol [' ||
                            :old.id_rol ||
                            '] porque está en uso en instancias activas del motor de flujos.');
  end if;
end;
/
