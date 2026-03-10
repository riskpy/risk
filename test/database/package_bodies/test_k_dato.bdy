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

  procedure p_guardar_dato_uso_basico is
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
    k_dato.p_guardar_dato(c_tabla, 'MI_STRING', 'TEST', 'qwerty');
    -- Assert
    select count(*)
      into l_cantidad
      from t_datos
     where tabla = c_tabla
       and campo = 'MI_STRING'
       and referencia = 'TEST';
    ut.expect(l_cantidad).to_be_greater_than(0);
  end;

end;
/
