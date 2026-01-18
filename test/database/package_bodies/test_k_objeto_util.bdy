create or replace package body test_k_objeto_util is

  procedure parse_json_to_json_escenario_1 is
    vl_barrio  y_barrio := y_barrio();
    vl_barrio1 y_barrio := y_barrio();
  begin
    -- Arrange
    vl_barrio.id_barrio := '1';
    vl_barrio.nombre    := 'barrio obrero';
    -- Act
    vl_barrio1 := treat(y_barrio.parse_json(vl_barrio.to_json()) as
                        y_barrio);
    --vl_barrio1.nombre := 'sajonia';
    -- Assert
    ut.expect(vl_barrio1.to_json()).to_equal(vl_barrio.to_json());
  end;

  procedure parse_json_to_json_escenario_2 is
    vl_dispositivo  y_dispositivo := y_dispositivo();
    vl_dispositivo1 y_dispositivo := y_dispositivo();
    --
    vl_plantilla  y_dato := y_dato();
    vl_plantillas y_datos := y_datos();
  begin
    -- Arrange
    vl_dispositivo.id_dispositivo           := 1;
    vl_dispositivo.token_dispositivo        := 'prueba';
    vl_dispositivo.nombre_sistema_operativo := 'WIN';
  
    vl_plantilla.contenido := 'ANDROID';
    vl_plantillas.extend;
    vl_plantillas(1) := vl_plantilla;
    vl_dispositivo.plantillas := vl_plantillas;
    -- Act
    vl_dispositivo1 := treat(y_dispositivo.parse_json(vl_dispositivo.to_json()) as
                             y_dispositivo);
    --vl_dispositivo1.nombre_sistema_operativo := 'IOS';
    -- Assert
    ut.expect(vl_dispositivo1.to_json()).to_equal(vl_dispositivo.to_json());
  end;

  procedure parse_json_to_json_escenario_5 is
    vl_usuario  y_usuario := y_usuario();
    vl_usuario1 y_usuario := y_usuario();
    --
    vl_rol   y_rol := y_rol();
    vl_roles y_objetos := y_objetos();
  begin
    -- Arrange
    vl_usuario.id_usuario := 1;
    vl_usuario.alias      := 'dmezac';
  
    vl_rol.nombre := 'DESARROLLADOR';
    vl_roles.extend;
    vl_roles(1) := vl_rol;
    vl_usuario.roles := vl_roles;
    -- Act
    vl_usuario1 := treat(y_usuario.parse_json(vl_usuario.to_json()) as
                         y_usuario);
    --vl_usuario1.id_usuario := 2;
    --vl_usuario1.alias      := 'jmeza';
    -- Assert
    ut.expect(vl_usuario1.to_json()).to_equal(vl_usuario.to_json());
  end;

end;
/
