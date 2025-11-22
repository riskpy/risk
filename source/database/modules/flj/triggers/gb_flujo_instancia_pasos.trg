create or replace trigger gb_flujo_instancia_pasos
  before insert or update on t_flujo_instancia_pasos
  for each row
declare
  l_nombre_paso t_flujo_pasos.nombre%type;
begin
  -- Obtener el nombre del paso de la instancia
  begin
    select nombre
      into l_nombre_paso
      from t_flujo_pasos a
     where a.id_paso = :new.id_paso;
  end;

  -- Validar roles responsables
  declare
    l_rol_json_arr json_array_t;
    l_nombre_rol   t_roles.nombre%type;
    l_cantidad     pls_integer;
  begin
    if :new.roles_responsables is null then
      return;
    end if;
  
    -- Validar que es un array válido
    l_rol_json_arr := json_array_t.parse(:new.roles_responsables);
  
    for i in 0 .. l_rol_json_arr.get_size - 1 loop
      l_nombre_rol := l_rol_json_arr.get_string(i);
    
      -- Verificar si existe el rol
      select count(*)
        into l_cantidad
        from t_roles a
       where a.nombre = l_nombre_rol;
    
      if l_cantidad = 0 then
        raise_application_error(-20001,
                                'Rol [' || l_nombre_rol ||
                                '] inválido como responsables para el siguiente paso [' ||
                                l_nombre_paso || ']');
      end if;
    end loop;
  end;

  -- Validar usuarios responsables
  declare
    l_usu_json_arr  json_array_t;
    l_alias_usuario t_usuarios.alias%type;
    l_cantidad      pls_integer;
  begin
    if :new.usuarios_responsables is null then
      return;
    end if;
  
    -- Validar que es un array válido
    l_usu_json_arr := json_array_t.parse(:new.usuarios_responsables);
  
    for i in 0 .. l_usu_json_arr.get_size - 1 loop
      l_alias_usuario := l_usu_json_arr.get_string(i);
    
      -- Verificar si existe el usuario
      select count(*)
        into l_cantidad
        from t_usuarios a
       where a.alias = l_alias_usuario
         and a.estado = 'A'; --Activo
    
      if l_cantidad = 0 then
        raise_application_error(-20001,
                                'Usuario [' || l_alias_usuario ||
                                '] inválido como responsables para el siguiente paso [' ||
                                l_nombre_paso || ']');
      end if;
    end loop;
  end;

end;
/
