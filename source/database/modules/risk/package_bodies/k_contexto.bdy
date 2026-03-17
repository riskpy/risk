create or replace package body k_contexto is

  -- Cache en memoria por sesión
  g_namespace varchar2(50);

  function f_namespace return varchar2 is
    l_namespace varchar2(50);
    l_app_name  t_modulos.usuario_insercion%type;
  begin
    if g_namespace is not null then
      return g_namespace;
    end if;
  
    begin
      select substr(usuario_insercion,
                    1,
                    instr(usuario_insercion, '_' || id_modulo) - 1)
        into l_app_name
        from t_modulos
       where id_modulo = k_modulo.c_id_risk;
    exception
      when others then
        l_app_name := k_modulo.c_id_risk;
    end;
    l_namespace := l_app_name || '_CTX';
  
    g_namespace := l_namespace;
    return l_namespace;
  end;

  procedure p_definir_parametro(i_parametro in varchar2,
                                i_valor     in varchar2) is
  begin
    dbms_session.set_context(f_namespace, i_parametro, i_valor);
  end;

  function f_valor_parametro(i_parametro in varchar2) return varchar2 is
  begin
    return sys_context(f_namespace, i_parametro, 4000);
  end;

  function f_base_datos return varchar2 is
  begin
    return sys_context('USERENV', 'DB_NAME');
  end;

  function f_terminal return varchar2 is
  begin
    return sys_context('USERENV', 'TERMINAL');
  end;

  function f_host return varchar2 is
  begin
    return sys_context('USERENV', 'HOST');
  end;

  function f_direccion_ip return varchar2 is
  begin
    return sys_context('USERENV', 'IP_ADDRESS');
  end;

  function f_esquema_actual return varchar2 is
  begin
    return sys_context('USERENV', 'CURRENT_SCHEMA');
  end;

end;
/

