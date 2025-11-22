create or replace package body test_y_respuesta is

  procedure parse_json_generico is
    l_respuesta y_respuesta;
    l_error     y_error;
    l_resultado y_objeto;
  begin
    -- Arrange
    l_respuesta       := new y_respuesta();
    l_error           := new y_error();
    l_error.clave     := '0001';
    l_error.mensaje   := 'Este es un mensaje';
    l_respuesta.datos := l_error;
    --
    k_sistema.p_inicializar_cola;
    k_sistema.p_encolar('Y_ERROR');
    -- Act
    l_resultado := y_respuesta.parse_json(l_respuesta.to_json);
    -- Assert
    ut.expect(l_resultado.to_json).to_equal(l_respuesta.to_json);
  end;

end;
/
