create or replace package body test_k_sistema is

  procedure f_fecha_por_defecto is
    l_fecha_actual t_modulos.fecha_actual%type;
  begin
    select fecha_actual
      into l_fecha_actual
      from t_modulos
     where id_modulo = k_modulo.c_id_risk;
    k_sistema.p_inicializar_parametros;
    ut.expect(k_sistema.f_fecha).to_equal(l_fecha_actual);
  end;

  procedure f_usuario_por_defecto is
  begin
    k_sistema.p_inicializar_parametros;
    ut.expect(k_sistema.f_usuario).to_equal(user);
  end;

end;
/

