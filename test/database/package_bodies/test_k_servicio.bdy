create or replace package body test_k_servicio is

  procedure f_procesar_servicio_inexistente is
    l_resultado clob;
    l_respuesta y_respuesta;
  begin
    -- Arrange
    -- Act
    l_resultado := k_servicio.f_procesar_servicio(i_nombre     => 'SERVICIO_QUE_NO_EXISTE',
                                                  i_dominio    => 'GEN',
                                                  i_parametros => '{}',
                                                  i_contexto   => '{}');
    -- Assert    
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_servicio_no_implementado);
  end;

  procedure f_procesar_servicio_error_json_parametros is
    l_resultado clob;
    l_respuesta y_respuesta;
  begin
    -- Arrange
    -- Act
    l_resultado := k_servicio.f_procesar_servicio(i_nombre     => 'VERSION_SISTEMA',
                                                  i_dominio    => 'GEN',
                                                  i_parametros => '{"dato":',
                                                  i_contexto   => '{}');
    -- Assert
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_error_parametro);
  end;

  procedure f_procesar_servicio_error_json_contexto is
    l_resultado clob;
    l_respuesta y_respuesta;
  begin
    -- Arrange
    -- Act
    l_resultado := k_servicio.f_procesar_servicio(i_nombre     => 'VERSION_SISTEMA',
                                                  i_dominio    => 'GEN',
                                                  i_parametros => '{}',
                                                  i_contexto   => '{"dato":');
    -- Assert
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_error_parametro);
  end;

  procedure f_procesar_servicio_error_tipo_contexto is
    l_resultado clob;
    l_respuesta y_respuesta;
  begin
    -- Arrange
    -- Act
    l_resultado := k_servicio.f_procesar_servicio(i_nombre     => 'VERSION_SISTEMA',
                                                  i_dominio    => 'GEN',
                                                  i_parametros => '{}',
                                                  i_contexto   => '{"usuario":1234}');
    -- Assert
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_error_parametro);
  end;

  procedure f_procesar_servicio_version_sistema is
    l_resultado clob;
    l_respuesta y_respuesta;
  begin
    -- Arrange
    -- Act
    l_resultado := k_servicio.f_procesar_servicio(i_nombre     => 'VERSION_SISTEMA',
                                                  i_dominio    => 'GEN',
                                                  i_parametros => '{}',
                                                  i_contexto   => '{}');
    -- Assert
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_DATO');
    l_respuesta := treat(y_respuesta.parse_json(l_resultado) as y_respuesta);
    ut.expect(l_respuesta.codigo).to_equal(k_operacion.c_ok);
  end;

end;
/
