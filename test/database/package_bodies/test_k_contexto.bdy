create or replace package body test_k_contexto is

  procedure f_base_datos is
  begin
    ut.expect(k_contexto.f_base_datos).to_equal(sys_context('USERENV',
                                                            'DB_NAME'));
  end;

  procedure f_terminal is
  begin
    ut.expect(k_contexto.f_terminal).to_equal(sys_context('USERENV',
                                                          'TERMINAL'));
  end;

  procedure f_host is
  begin
    ut.expect(k_contexto.f_host).to_equal(sys_context('USERENV', 'HOST'));
  end;

  procedure f_direccion_ip is
  begin
    ut.expect(k_contexto.f_direccion_ip).to_equal(sys_context('USERENV',
                                                              'IP_ADDRESS'));
  end;

  procedure f_esquema_actual is
  begin
    ut.expect(k_contexto.f_esquema_actual).to_equal(sys_context('USERENV',
                                                                'CURRENT_SCHEMA'));
  end;

end;
/

