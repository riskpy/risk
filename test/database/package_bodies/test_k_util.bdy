create or replace package body test_k_util is

  procedure f_valor_parametro_parametro_con_valor is
    l_valor t_parametros.valor%type;
  begin
    -- Arrange
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

  procedure f_base_datos is
  begin
    ut.expect(k_util.f_base_datos).to_equal(sys_context('USERENV',
                                                        'DB_NAME'));
  end;

  procedure f_terminal is
  begin
    ut.expect(k_util.f_terminal).to_equal(sys_context('USERENV',
                                                      'TERMINAL'));
  end;

  procedure f_host is
  begin
    ut.expect(k_util.f_host).to_equal(sys_context('USERENV', 'HOST'));
  end;

  procedure f_direccion_ip is
  begin
    ut.expect(k_util.f_direccion_ip).to_equal(sys_context('USERENV',
                                                          'IP_ADDRESS'));
  end;

  procedure f_esquema_actual is
  begin
    ut.expect(k_util.f_esquema_actual).to_equal(sys_context('USERENV',
                                                            'CURRENT_SCHEMA'));
  end;

end;
/
