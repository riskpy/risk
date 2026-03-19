create or replace package body k_contexto is

  -- Cache en memoria por sesión
  g_namespace varchar2(30);

  g_indice binary_integer;

  function f_namespace return varchar2 is
    l_namespace varchar2(30);
    l_app_name  t_parametros.valor%type;
  begin
    if g_namespace is not null then
      return g_namespace;
    end if;
  
    l_app_name  := k_util.f_valor_parametro('NOMBRE_SISTEMA');
    l_namespace := nvl(l_app_name, k_modulo.c_id_risk) || '_CTX';
  
    g_namespace := l_namespace;
    return l_namespace;
  end;

  procedure p_definir_parametro(i_parametro in varchar2,
                                i_valor     in varchar2) is
  begin
    dbms_session.set_context(f_namespace,
                             i_parametro,
                             substr(i_valor, 1, 4000));
  end;

  procedure p_definir_parametro_string(i_parametro in varchar2,
                                       i_valor     in varchar2) is
  begin
    p_definir_parametro(i_parametro, i_valor);
  end;

  procedure p_definir_parametro_number(i_parametro in varchar2,
                                       i_valor     in number) is
  begin
    p_definir_parametro(i_parametro, to_char(i_valor));
  end;

  procedure p_definir_parametro_boolean(i_parametro in varchar2,
                                        i_valor     in boolean) is
  begin
    p_definir_parametro(i_parametro, k_util.bool_to_string(i_valor));
  end;

  procedure p_definir_parametro_date(i_parametro in varchar2,
                                     i_valor     in date) is
  begin
    p_definir_parametro(i_parametro, k_util.date_to_string(i_valor));
  end;

  function f_valor_parametro(i_parametro in varchar2) return varchar2 is
  begin
    return sys_context(f_namespace, i_parametro, 4000);
  end;

  function f_valor_parametro_string(i_parametro in varchar2) return varchar2 is
  begin
    return f_valor_parametro(i_parametro);
  end;

  function f_valor_parametro_number(i_parametro in varchar2) return number is
  begin
    return to_number(f_valor_parametro(i_parametro));
  end;

  function f_valor_parametro_boolean(i_parametro in varchar2) return boolean is
  begin
    return k_util.string_to_bool(f_valor_parametro(i_parametro));
  end;

  function f_valor_parametro_date(i_parametro in varchar2) return date is
  begin
    return k_util.string_to_date(f_valor_parametro(i_parametro));
  end;

  procedure p_inicializar_parametros is
  begin
    -- Elimina parámetros
    p_eliminar_parametros;
  
    -- Define parámetros por defecto
  end;

  procedure p_limpiar_parametros is
    l_list  dbms_session.appctxtabtyp;
    l_lsize number;
  begin
    dbms_session.list_context(l_list, l_lsize);
  
    g_indice := l_list.first;
    while g_indice is not null loop
      if l_list(g_indice).namespace = f_namespace then
        p_definir_parametro(l_list(g_indice).attribute, null);
      end if;
      g_indice := l_list.next(g_indice);
    end loop;
  end;

  procedure p_eliminar_parametros is
  begin
    dbms_session.clear_all_context(f_namespace);
  end;

  procedure p_imprimir_parametros is
    l_list  dbms_session.appctxtabtyp;
    l_lsize number;
  begin
    dbms_session.list_context(l_list, l_lsize);
  
    g_indice := l_list.first;
    while g_indice is not null loop
      if l_list(g_indice).namespace = f_namespace then
        dbms_output.put(l_list(g_indice).attribute || ': ');
        dbms_output.put(l_list(g_indice).value);
        dbms_output.new_line;
      end if;
      g_indice := l_list.next(g_indice);
    end loop;
  end;

  --
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
  --

end;
/

