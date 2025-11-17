CREATE OR REPLACE PACKAGE BODY test_k_sistema IS

  PROCEDURE f_fecha_por_defecto IS
    l_fecha_actual t_modulos.fecha_actual%TYPE;
  BEGIN
    SELECT fecha_actual
      INTO l_fecha_actual
      FROM t_modulos
     WHERE id_modulo = 'RISK';
    k_sistema.p_inicializar_parametros;
    ut.expect(k_sistema.f_fecha).to_equal(l_fecha_actual);
  END;

  PROCEDURE f_usuario_por_defecto IS
  BEGIN
    k_sistema.p_inicializar_parametros;
    ut.expect(k_sistema.f_usuario).to_equal(USER);
  END;

END;
/
