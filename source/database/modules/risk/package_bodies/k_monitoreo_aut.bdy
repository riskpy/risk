create or replace package body k_monitoreo_aut is

  function sesiones_expiradas(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp        y_respuesta;
    l_id_usuario t_usuarios.id_usuario%type;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar  := 'Obteniendo parámetros';
    l_id_usuario := k_operacion.f_valor_parametro_number(i_parametros,
                                                         'id_usuario');
  
    l_rsp.lugar := 'Validando parámetros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_id_usuario is not null,
                                    'Debe ingresar id_usuario');
  
    l_rsp.lugar := 'Expirando sesiones de usuario';
    k_sesion.p_expirar_sesiones(i_id_usuario => l_id_usuario);
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

end;
/
