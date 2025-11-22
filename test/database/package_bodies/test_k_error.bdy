create or replace package body test_k_error is

  procedure f_tipo_excepcion_ude_negativo is
  begin
    ut.expect(k_error.f_tipo_excepcion(-20000)).to_equal(k_error.c_user_defined_error);
  end;

  procedure f_tipo_excepcion_ude_positivo is
  begin
    ut.expect(k_error.f_tipo_excepcion(20000)).to_equal(k_error.c_user_defined_error);
  end;

  procedure f_tipo_excepcion_ope is
  begin
    ut.expect(k_error.f_tipo_excepcion(-1)).to_equal(k_error.c_oracle_predefined_error);
  end;

  procedure f_mensaje_excepcion_ude is
    l_mensaje_excepcion varchar2(4000);
  begin
    begin
      raise_application_error(-20000, 'Este es un mensaje de error');
    exception
      when others then
        l_mensaje_excepcion := k_error.f_mensaje_excepcion(sqlerrm);
    end;
    ut.expect(l_mensaje_excepcion).to_equal('Este es un mensaje de error');
  end;

  procedure f_mensaje_excepcion_ope is
    l_mensaje_excepcion varchar2(4000);
    l_error_msg         varchar2(4000);
  begin
    begin
      raise no_data_found;
    exception
      when others then
        l_error_msg         := utl_call_stack.error_msg(1);
        l_mensaje_excepcion := k_error.f_mensaje_excepcion(sqlerrm);
    end;
    ut.expect(l_mensaje_excepcion).to_equal(l_error_msg);
  end;

  procedure f_mensaje_excepcion_ope_sin_plsql is
    l_mensaje_excepcion varchar2(4000);
    l_error_msg         varchar2(4000);
  begin
    begin
      raise program_error;
    exception
      when others then
        l_error_msg         := utl_call_stack.error_msg(1);
        l_mensaje_excepcion := k_error.f_mensaje_excepcion(sqlerrm);
    end;
    ut.expect(l_mensaje_excepcion).to_equal(replace(l_error_msg,
                                                    'PL/SQL: '));
  end;

  procedure f_mensaje_error_default_wrap_char is
    l_mensaje_error varchar2(4000);
  begin
    insert into t_errores
      (clave, mensaje)
    values
      ('mierror', '@1@-@2@-@3@-@4@-@5@');
  
    l_mensaje_error := k_error.f_mensaje_error('mierror',
                                               'uno',
                                               'dos',
                                               'tres',
                                               'cuatro',
                                               'cinco');
    ut.expect(l_mensaje_error).to_equal('uno-dos-tres-cuatro-cinco');
  end;

  procedure f_mensaje_error_custom_wrap_char is
    l_mensaje_error varchar2(4000);
  begin
    insert into t_errores
      (clave, mensaje)
    values
      ('mierror', '#1#-#2#-#3#-#4#-#5#');
  
    l_mensaje_error := k_error.f_mensaje_error('mierror',
                                               'uno',
                                               'dos',
                                               'tres',
                                               'cuatro',
                                               'cinco',
                                               '#');
    ut.expect(l_mensaje_error).to_equal('uno-dos-tres-cuatro-cinco');
  end;

  procedure f_mensaje_error_no_registrado is
  begin
    ut.expect(k_error.f_mensaje_error('errorquenoexiste')).to_equal('Error no registrado [errorquenoexiste]');
  end;

end;
/
