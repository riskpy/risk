create or replace package body test_k_dato is

  c_tabla             constant varchar2(30) := 'T_MODULOS';
  c_nombre_referencia constant varchar2(30) := 'ID_MODULO';

  procedure lp_insertar_modulo is
  begin
    insert into t_modulos
      (id_modulo, nombre, activo)
    values
      ('TEST', 'MÓDULO DE PRUEBA', 'S');
  end;

  procedure p_guardar_dato_string_uso_basico is
    l_cantidad integer;
  begin
    -- Arrange
    insert into t_dato_definiciones
      (tabla, campo, descripcion, orden, nombre_referencia, tipo_dato)
    values
      (c_tabla,
       'MI_STRING',
       'Dato adicional de tipo string',
       1,
       c_nombre_referencia,
       'S');
    lp_insertar_modulo;
    -- Act
    k_dato.p_guardar_dato_string(c_tabla, 'MI_STRING', 'TEST', 'qwerty');
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_STRING'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

  procedure p_guardar_dato_number_uso_basico is
    l_cantidad integer;
  begin
    -- Arrange
    insert into t_dato_definiciones
      (tabla, campo, descripcion, orden, nombre_referencia, tipo_dato)
    values
      (c_tabla,
       'MI_NUMBER',
       'Dato adicional de tipo number',
       2,
       c_nombre_referencia,
       'N');
    lp_insertar_modulo;
    -- Act
    k_dato.p_guardar_dato_number(c_tabla, 'MI_NUMBER', 'TEST', 123);
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_NUMBER'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

  procedure p_guardar_dato_boolean_uso_basico is
    l_cantidad integer;
  begin
    -- Arrange
    insert into t_dato_definiciones
      (tabla, campo, descripcion, orden, nombre_referencia, tipo_dato)
    values
      (c_tabla,
       'MI_BOOLEAN',
       'Dato adicional de tipo boolean',
       3,
       c_nombre_referencia,
       'B');
    lp_insertar_modulo;
    -- Act
    k_dato.p_guardar_dato_boolean(c_tabla, 'MI_BOOLEAN', 'TEST', true);
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_BOOLEAN'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

  procedure p_guardar_dato_date_uso_basico is
    l_cantidad integer;
  begin
    -- Arrange
    insert into t_dato_definiciones
      (tabla, campo, descripcion, orden, nombre_referencia, tipo_dato)
    values
      (c_tabla,
       'MI_DATE',
       'Dato adicional de tipo date',
       4,
       c_nombre_referencia,
       'D');
    lp_insertar_modulo;
    -- Act
    k_dato.p_guardar_dato_date(c_tabla, 'MI_DATE', 'TEST', trunc(sysdate));
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_DATE'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

  procedure p_guardar_dato_object_uso_basico is
    l_cantidad integer;
    l_dato     y_rol;
  begin
    -- Arrange
    insert into t_dato_definiciones
      (tabla, campo, descripcion, orden, nombre_referencia, tipo_dato)
    values
      (c_tabla,
       'MI_OBJECT',
       'Dato adicional de tipo object',
       5,
       c_nombre_referencia,
       'O');
    lp_insertar_modulo;
    -- Act
    l_dato        := new y_rol();
    l_dato.id_rol := 123;
    l_dato.nombre := 'qwerty';
    k_dato.p_guardar_dato_object(c_tabla, 'MI_OBJECT', 'TEST', l_dato);
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_OBJECT'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

end;
/
