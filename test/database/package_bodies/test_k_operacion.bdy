create or replace package body test_k_operacion is

  procedure p_inicializar_log_activo is
    l_id_operacion t_operaciones.id_operacion%type;
  begin
    -- Arrange
    insert into t_operaciones
      (tipo, nombre, dominio, activo, version_actual, nivel_log)
    values
      ('S', 'OPERACION_DE_PRUEBA', 'GEN', 'S', '0.1.0', 2)
    returning id_operacion into l_id_operacion;
    k_sistema.p_inicializar_parametros;
    -- Act
    k_operacion.p_inicializar_log(l_id_operacion);
    -- Assert
    ut.expect(k_sistema.f_valor_parametro_number(k_operacion.c_id_log)).to_be_not_null();
  end;

  procedure p_inicializar_log_inactivo is
    l_id_operacion t_operaciones.id_operacion%type;
  begin
    -- Arrange
    insert into t_operaciones
      (tipo, nombre, dominio, activo, version_actual, nivel_log)
    values
      ('S', 'OPERACION_DE_PRUEBA', 'GEN', 'S', '0.1.0', 0)
    returning id_operacion into l_id_operacion;
    k_sistema.p_inicializar_parametros;
    -- Act
    k_operacion.p_inicializar_log(l_id_operacion);
    -- Assert
    ut.expect(k_sistema.f_valor_parametro_number(k_operacion.c_id_log)).to_be_null();
  end;

  procedure f_id_operacion_existente is
    l_id_operacion t_operaciones.id_operacion%type;
    l_resultado    t_operaciones.id_operacion%type;
  begin
    -- Arrange
    insert into t_operaciones
      (tipo, nombre, dominio, activo, version_actual, nivel_log)
    values
      ('S', 'OPERACION_DE_PRUEBA', 'GEN', 'S', '0.1.0', 2)
    returning id_operacion into l_id_operacion;
    -- Act
    l_resultado := k_operacion.f_id_operacion(i_tipo    => 'S',
                                              i_nombre  => 'OPERACION_DE_PRUEBA',
                                              i_dominio => 'GEN');
    -- Assert
    ut.expect(l_resultado).to_equal(l_id_operacion);
  end;

  procedure f_id_operacion_inexistente is
    l_resultado t_operaciones.id_operacion%type;
  begin
    -- Arrange
    -- Act
    l_resultado := k_operacion.f_id_operacion(i_tipo    => 'S',
                                              i_nombre  => 'OPERACION_QUE_NO_EXISTE',
                                              i_dominio => 'GEN');
    -- Assert
    ut.expect(l_resultado).to_be_null();
  end;

  procedure f_filtros_sql_sin_parametros is
    l_parametros y_parametros;
  begin
    l_parametros := new y_parametros();
    ut.expect(k_operacion.f_filtros_sql(l_parametros)).to_(be_null());
  end;

  procedure f_filtros_sql_parametros_ignorados is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros := new y_parametros();
  
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'formato';
    l_parametro.valor  := anydata.convertvarchar2('PDF');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
  
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'PAGINA_PARAMETROS';
    l_parametro.valor  := anydata.convertobject(new y_pagina_parametros());
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
  
    ut.expect(k_operacion.f_filtros_sql(l_parametros)).to_(be_null());
  end;

  procedure f_filtros_sql_parametro_varchar2 is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'campo';
    l_parametro.valor  := anydata.convertvarchar2('hola');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    ut.expect(k_operacion.f_filtros_sql(l_parametros)).to_be_like('%campo = ''hola''%');
  end;

  procedure f_filtros_sql_parametro_date is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'campo';
    l_parametro.valor  := anydata.convertdate(sysdate);
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    ut.expect(k_operacion.f_filtros_sql(l_parametros)).to_be_like('%to_char(campo, ''YYYY-MM-DD'') = ''%-%-%''%');
  end;

  procedure f_filtros_sql_parametro_number is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'campo';
    l_parametro.valor  := anydata.convertnumber(1234);
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    ut.expect(k_operacion.f_filtros_sql(l_parametros)).to_be_like('%to_char(campo, ''TM'', ''NLS_NUMERIC_CHARACTERS = ''''.,'''''') = ''1234''%');
  end;

  procedure f_filtros_sql_tipo_no_soportado is
    l_parametros y_parametros;
    l_parametro  y_parametro;
    l_resultado  clob;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'campo';
    l_parametro.valor  := anydata.convertclob('hola');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    l_resultado := k_operacion.f_filtros_sql(l_parametros);
  end;

  procedure f_valor_parametro_lista_null is
    l_parametros y_parametros;
  begin
    -- Act
    -- Assert
    ut.expect(anydata.accessvarchar2(k_operacion.f_valor_parametro(i_parametros => l_parametros,
                                                                   i_nombre     => 'parametro'))).to_be_null();
  end;

  procedure f_valor_parametro_lista_vacia is
    l_parametros y_parametros;
  begin
    l_parametros := new y_parametros();
    -- Act
    -- Assert
    ut.expect(anydata.accessvarchar2(k_operacion.f_valor_parametro(i_parametros => l_parametros,
                                                                   i_nombre     => 'parametro'))).to_be_null();
  end;

  procedure f_valor_parametro_nombre_con_diferente_case is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertvarchar2('hola');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(anydata.accessvarchar2(k_operacion.f_valor_parametro(i_parametros => l_parametros,
                                                                   i_nombre     => 'PARAMETRO'))).to_equal('hola');
  end;

  procedure f_valor_parametro_nombre_inexistente is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertvarchar2('hola');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(anydata.accessvarchar2(k_operacion.f_valor_parametro(i_parametros => l_parametros,
                                                                   i_nombre     => 'no_existe'))).to_be_null();
  end;

  procedure f_valor_parametro_string is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertvarchar2('hola');
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(k_operacion.f_valor_parametro_string(i_parametros => l_parametros,
                                                   i_nombre     => 'parametro')).to_equal('hola');
  end;

  procedure f_valor_parametro_number is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertnumber(1234);
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(k_operacion.f_valor_parametro_number(i_parametros => l_parametros,
                                                   i_nombre     => 'parametro')).to_equal(1234);
  end;

  procedure f_valor_parametro_boolean is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertnumber(sys.diutil.bool_to_int(true));
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(k_operacion.f_valor_parametro_boolean(i_parametros => l_parametros,
                                                    i_nombre     => 'parametro')).to_equal(true);
  end;

  procedure f_valor_parametro_date is
    l_parametros y_parametros;
    l_parametro  y_parametro;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertdate(trunc(sysdate));
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    -- Assert
    ut.expect(k_operacion.f_valor_parametro_date(i_parametros => l_parametros,
                                                 i_nombre     => 'parametro')).to_equal(trunc(sysdate));
  end;

  procedure f_valor_parametro_object is
    l_parametros y_parametros;
    l_parametro  y_parametro;
    l_dato       y_dato;
    l_resultado  y_dato;
  begin
    l_parametros       := new y_parametros();
    l_parametro        := new y_parametro();
    l_dato             := new y_dato();
    l_dato.contenido   := 'hola';
    l_parametro.nombre := 'parametro';
    l_parametro.valor  := anydata.convertobject(l_dato);
    l_parametros.extend;
    l_parametros(l_parametros.count) := l_parametro;
    -- Act
    l_resultado := treat(k_operacion.f_valor_parametro_object(i_parametros => l_parametros,
                                                              i_nombre     => 'parametro') as
                         y_dato);
    -- Assert
    ut.expect(l_resultado.contenido).to_equal(l_dato.contenido);
  end;

end;
/
