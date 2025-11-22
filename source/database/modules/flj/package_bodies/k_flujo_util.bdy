create or replace package body k_flujo_util as

  function f_obtener_variable(i_variables in clob,
                              i_clave     in varchar2) return varchar2 is
    l_resultado varchar2(4000);
    l_clave     varchar2(1000) := '''$.' || i_clave || '''';
    --
    l_sentencia clob := 'SELECT json_value(:1, ' || l_clave ||
                        ') FROM dual';
  begin
    --dbms_output.put_line(l_sentencia);
    if json_query(i_variables, '$') is not null then
      execute immediate l_sentencia
        into l_resultado
        using i_variables;
    else
      l_resultado := null;
    end if;
    return l_resultado;
  end;

  function f_editar_variable(i_variables in clob,
                             i_clave     in varchar2,
                             i_valor     in varchar2) return clob is
    l_nuevo clob;
  begin
    select json_mergepatch(i_variables,
                           json_object(i_clave value i_valor returning clob))
      into l_nuevo
      from dual;
    return l_nuevo;
  end;

  function f_reemplazar_variables(i_expresion         in varchar2,
                                  i_variables         in clob,
                                  i_delimitador_texto in varchar2 := '''')
    return varchar2 is
  
    l_delimitador_texto varchar2(1) := substr(i_delimitador_texto, 1, 1);
    l_expresion         varchar2(4000) := i_expresion;
  
    l_objeto_json json_object_t;
    l_clave       varchar2(100);
    l_valor       json_element_t;
    l_valor_texto varchar2(4000);
  begin
    l_objeto_json := json_object_t.parse(i_variables);
  
    for i in 1 .. l_objeto_json.get_size loop
      l_clave := l_objeto_json.get_keys() (i);
      l_valor := l_objeto_json.get(l_clave);
    
      if l_valor.is_string then
        l_valor_texto := '' || l_delimitador_texto || '' ||
                         regexp_replace(l_valor.to_string, '^"(.*)"$', '\1') || '' ||
                         l_delimitador_texto || '';
      elsif l_valor.is_number then
        l_valor_texto := l_valor.to_string;
      else
        l_valor_texto := 'NULL'; -- podrías manejar booleanos, nulls, etc.
      end if;
    
      l_expresion := replace(l_expresion, ':' || l_clave, l_valor_texto);
    end loop;
  
    --dbms_output.put_line('Expresión generada: ' || l_expresion);
  
    return l_expresion;
  
  end;

  function f_evaluar_condicion(i_condicion in varchar2,
                               i_variables in clob) return boolean is
    l_expresion varchar2(4000) := i_condicion;
  begin
    l_expresion := f_reemplazar_variables(l_expresion, i_variables);
  
    -- Evaluación opcional de la expresión (como se mostró antes)
    declare
      l_resultado pls_integer;
    begin
      execute immediate 'BEGIN IF ' || l_expresion ||
                        ' THEN :r := 1; ELSE :r := 0; END IF; END;'
        using out l_resultado;
    
      if l_resultado = 1 then
        --dbms_output.put_line('Condición evaluada como TRUE');
        return true;
      end if;
    end;
  
    return false;
  end;

  function f_contiene_valor(i_valor     in varchar2,
                            i_variables in clob) return boolean is
    l_sentencia varchar2(4000);
    l_resultado pls_integer;
  begin
    l_sentencia := 'SELECT COUNT(*) cantidad
        FROM dual
        WHERE json_exists(''' || i_variables ||
                   ''', ''$[*]?(@ == "' || i_valor || '")'')';
  
    execute immediate l_sentencia
      into l_resultado;
  
    if l_resultado > 0 then
      --dbms_output.put_line('Condición evaluada como TRUE');
      return true;
    end if;
  
    return false;
  end;

end k_flujo_util;
/
