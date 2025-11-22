create or replace package body test_gb_personas is

  procedure nombre_mayusculas_al_insertar is
    l_id_persona t_personas.id_persona%type;
    l_nombre     t_personas.nombre%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    -- Act
    insert into t_personas
      (id_persona, nombre)
    values
      (l_id_persona, 'John')
    returning nombre into l_nombre;
    -- Assert
    ut.expect(l_nombre).to_equal('JOHN');
  end;

  procedure apellido_mayusculas_al_insertar is
    l_id_persona t_personas.id_persona%type;
    l_apellido   t_personas.apellido%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    -- Act
    insert into t_personas
      (id_persona, apellido)
    values
      (l_id_persona, 'Doe')
    returning apellido into l_apellido;
    -- Assert
    ut.expect(l_apellido).to_equal('DOE');
  end;

  procedure nombre_completo_mayusculas_al_insertar is
    l_id_persona      t_personas.id_persona%type;
    l_nombre_completo t_personas.nombre_completo%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    -- Act
    insert into t_personas
      (id_persona, nombre_completo)
    values
      (l_id_persona, 'John Doe')
    returning nombre_completo into l_nombre_completo;
    -- Assert
    ut.expect(l_nombre_completo).to_equal('JOHN DOE');
  end;

  procedure nombre_mayusculas_al_actualizar is
    l_id_persona t_personas.id_persona%type;
    l_nombre     t_personas.nombre%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    insert into t_personas
      (id_persona, nombre)
    values
      (l_id_persona, 'Nombre')
    returning id_persona into l_id_persona;
    -- Act
    update t_personas
       set nombre = 'John'
     where id_persona = l_id_persona
    returning nombre into l_nombre;
    -- Assert
    ut.expect(l_nombre).to_equal('JOHN');
  end;

  procedure apellido_mayusculas_al_actualizar is
    l_id_persona t_personas.id_persona%type;
    l_apellido   t_personas.apellido%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    insert into t_personas
      (id_persona, apellido)
    values
      (l_id_persona, 'Apellido')
    returning id_persona into l_id_persona;
    -- Act
    update t_personas
       set apellido = 'Doe'
     where id_persona = l_id_persona
    returning apellido into l_apellido;
    -- Assert
    ut.expect(l_apellido).to_equal('DOE');
  end;

  procedure nombre_completo_mayusculas_al_actualizar is
    l_id_persona      t_personas.id_persona%type;
    l_nombre_completo t_personas.nombre_completo%type;
  begin
    -- Arrange
    select max(id_persona) + 1 into l_id_persona from t_personas;
    insert into t_personas
      (id_persona, nombre_completo)
    values
      (l_id_persona, 'Nombre Apellido')
    returning id_persona into l_id_persona;
    -- Act
    update t_personas
       set nombre_completo = 'John Doe'
     where id_persona = l_id_persona
    returning nombre_completo into l_nombre_completo;
    -- Assert
    ut.expect(l_nombre_completo).to_equal('JOHN DOE');
  end;

end;
/
