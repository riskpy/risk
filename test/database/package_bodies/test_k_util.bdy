create or replace package body test_k_util is

  procedure f_valor_parametro_parametro_con_valor is
    l_valor t_parametros.valor%type;
  begin
    -- Arrange
    insert into t_parametro_definiciones
      (tabla,
       id_parametro,
       descripcion,
       orden,
       nombre_referencia,
       tipo_dato,
       observacion,
       id_dominio,
       tipo_filtro)
    values
      ('T_PARAMETROS',
       'PARAMETRO_CON_VALOR',
       null,
       null,
       'ID_PARAMETRO',
       'S',
       null,
       null,
       null);
    insert into t_parametros
      (id_parametro, valor)
    values
      ('PARAMETRO_CON_VALOR', 'VALOR');
    -- Act
    l_valor := k_util.f_valor_parametro('PARAMETRO_CON_VALOR');
    -- Assert
    ut.expect(l_valor).to_equal('VALOR');
  end;

  procedure f_valor_parametro_parametro_sin_valor is
    l_valor t_parametros.valor%type;
  begin
    -- Arrange
    insert into t_parametro_definiciones
      (tabla,
       id_parametro,
       descripcion,
       orden,
       nombre_referencia,
       tipo_dato,
       observacion,
       id_dominio,
       tipo_filtro)
    values
      ('T_PARAMETROS',
       'PARAMETRO_SIN_VALOR',
       null,
       null,
       'ID_PARAMETRO',
       'S',
       null,
       null,
       null);
    insert into t_parametros
      (id_parametro, valor)
    values
      ('PARAMETRO_SIN_VALOR', null);
    -- Act
    l_valor := k_util.f_valor_parametro('PARAMETRO_SIN_VALOR');
    -- Assert
    ut.expect(l_valor).to_(be_null());
  end;

  procedure f_valor_parametro_parametro_inexistente is
    l_valor t_parametros.valor%type;
  begin
    -- Arrange
    -- Act
    l_valor := k_util.f_valor_parametro('PARAMETRO_QUE_NO_EXISTE');
    -- Assert
    ut.expect(l_valor).to_(be_null());
  end;

  procedure p_actualizar_valor_parametro_uso_basico is
    l_valor t_parametros.valor%type;
  begin
    -- Arrange
    insert into t_parametro_definiciones
      (tabla,
       id_parametro,
       descripcion,
       orden,
       nombre_referencia,
       tipo_dato,
       observacion,
       id_dominio,
       tipo_filtro)
    values
      ('T_PARAMETROS',
       'PARAMETRO_CON_VALOR',
       null,
       null,
       'ID_PARAMETRO',
       'S',
       null,
       null,
       null);
    insert into t_parametros
      (id_parametro, valor)
    values
      ('PARAMETRO_CON_VALOR', 'VALOR1');
    -- Act
    k_util.p_actualizar_valor_parametro('PARAMETRO_CON_VALOR', 'VALOR2');
    -- Assert
    select a.valor
      into l_valor
      from t_parametros a
     where a.id_parametro = 'PARAMETRO_CON_VALOR';
    ut.expect(l_valor).to_equal('VALOR2');
  end;

end;
/

