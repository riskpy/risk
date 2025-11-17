CREATE OR REPLACE PACKAGE BODY k_monitoreo_aut IS

  FUNCTION sesiones_expiradas(i_parametros IN y_parametros)
    RETURN y_respuesta IS
    l_rsp        y_respuesta;
    l_id_usuario t_usuarios.id_usuario%TYPE;
  BEGIN
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar  := 'Obteniendo parámetros';
    l_id_usuario := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'id_usuario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_usuario IS NOT NULL,
                                    'Debe ingresar id_usuario');
  
    l_rsp.lugar := 'Expirando sesiones de usuario';
    k_sesion.p_expirar_sesiones(i_id_usuario => l_id_usuario);
  
    k_operacion.p_respuesta_ok(l_rsp);
    RETURN l_rsp;
  EXCEPTION
    WHEN k_operacion.ex_error_parametro THEN
      RETURN l_rsp;
    WHEN k_operacion.ex_error_general THEN
      RETURN l_rsp;
    WHEN OTHERS THEN
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      RETURN l_rsp;
  END;

END;
/
