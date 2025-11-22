create or replace package body k_json_util as

  function f_contiene_valor(i_valor in varchar2,
                            i_json  in clob) return boolean is
    l_sentencia varchar2(4000);
    l_resultado pls_integer;
  begin
    l_sentencia := 'SELECT COUNT(*) cantidad
        FROM dual
        WHERE json_exists(''' || i_json ||
                   ''', ''$[*]?(@ == "' || i_valor || '")'')';
  
    execute immediate l_sentencia
      into l_resultado;
  
    if l_resultado > 0 then
      return true;
    end if;
  
    return false;
  end;

  function f_obtener_valor(i_json  in clob,
                           i_clave in varchar2) return varchar2 is
    l_resultado varchar2(4000);
    l_clave     varchar2(1000) := '''$.' || i_clave || '''';
    --
    l_sentencia clob := 'SELECT json_value(:1, ' || l_clave ||
                        ') FROM dual';
  begin
    if json_query(i_json, '$') is not null then
      execute immediate l_sentencia
        into l_resultado
        using i_json;
    else
      l_resultado := null;
    end if;
    return l_resultado;
  end;

  function f_editar_valor(i_json  in clob,
                          i_clave in varchar2,
                          i_valor in varchar2) return clob is
    l_nuevo clob;
  begin
    select json_mergepatch(i_json,
                           json_object(i_clave value i_valor returning clob))
      into l_nuevo
      from dual;
    return l_nuevo;
  end;

  function f_contiene_valores(i_valores in varchar2,
                              i_json    in clob) return varchar2 is
    l_json_obj  json_object_t := json_object_t.parse(nvl(i_json, '{}'));
    l_token     varchar2(100);
    l_pos       pls_integer := 1;
    l_faltantes varchar2(4000);
  begin
    loop
      l_token := regexp_substr(i_valores || ',', '[^,]+', 1, l_pos);
      exit when l_token is null;
      l_token := trim(l_token);
    
      if not l_json_obj.has(l_token) then
        l_faltantes := l_faltantes || case
                         when l_faltantes is null then
                          ''
                         else
                          ', '
                       end || l_token;
      end if;
    
      l_pos := l_pos + 1;
    end loop;
  
    return nvl(l_faltantes, 'OK');
  end;

  function f_reemplazar_expresion(i_expresion                  in varchar2,
                                  i_valores                    in clob,
                                  i_encapsulador_inicial       in varchar2 := ':',
                                  i_encapsulador_final         in varchar2 := '',
                                  i_delimitador_texto_agregado in varchar2 := '')
    return clob is
  
    l_delimitador_texto varchar2(1) := substr(i_delimitador_texto_agregado,
                                              1,
                                              1);
    l_expresion         clob := i_expresion;
  
    l_objeto_json json_object_t;
    l_clave       varchar2(100);
    l_valor       json_element_t;
    l_valor_texto clob;
  begin
    l_objeto_json := json_object_t.parse(i_valores);
  
    for i in 1 .. l_objeto_json.get_size loop
      l_clave := l_objeto_json.get_keys() (i);
      l_valor := l_objeto_json.get(l_clave);
    
      if l_valor.is_string then
        l_valor_texto := '' || l_delimitador_texto || '' ||
                         regexp_replace(l_valor.to_clob, '^"(.*)"$', '\1') || '' ||
                         l_delimitador_texto || '';
      elsif l_valor.is_number then
        l_valor_texto := l_valor.to_string;
      else
        l_valor_texto := 'NULL'; -- podrías manejar booleanos, nulls, etc.
      end if;
    
      l_expresion := replace(l_expresion,
                             i_encapsulador_inicial || l_clave ||
                             i_encapsulador_final,
                             l_valor_texto);
    end loop;
  
    --dbms_output.put_line('Expresión generada: ' || l_expresion);
  
    return l_expresion;
  
  end;

  function f_reemplazar_expresion_clob(i_expresion                  in clob,
                                       i_valores                    in clob,
                                       i_encapsulador_inicial       in varchar2 := ':',
                                       i_encapsulador_final         in varchar2 := '',
                                       i_delimitador_texto_agregado in varchar2 := '')
    return clob is
    l_expresion         clob := i_expresion;
    l_objeto_json       json_object_t;
    l_clave             varchar2(100);
    l_valor             json_element_t;
    l_valor_texto       clob;
    l_delimitador_texto varchar2(1) := substr(i_delimitador_texto_agregado,
                                              1,
                                              1);
    vl_lugar            varchar2(4000);
    l_len               integer;
    l_clob_sin_comillas clob;
  begin
    if i_expresion is null then
      return null;
    end if;
  
    l_objeto_json := json_object_t.parse(i_valores);
  
    for i in 1 .. l_objeto_json.get_size loop
      l_clave  := l_objeto_json.get_keys() (i);
      l_valor  := l_objeto_json.get(l_clave);
      vl_lugar := substr(l_clave, 1, 4000);
    
      -- creamos siempre un temporal para el valor final
      dbms_lob.createtemporary(l_valor_texto, true);
    
      if l_valor.is_string then
        -- manejamos comillas inicial/final (si existen)
        l_len := dbms_lob.getlength(l_valor.to_clob);
        if l_len >= 2 then
          if dbms_lob.substr(l_valor.to_clob, 1, 1) = '"' and
             dbms_lob.substr(l_valor.to_clob, 1, l_len) = '"' then
            -- creamos temporal para el substring sin comillas
            dbms_lob.createtemporary(l_clob_sin_comillas, true);
            dbms_lob.copy(l_clob_sin_comillas,
                          l_valor.to_clob,
                          l_len - 2,
                          2,
                          1);
            -- armamos l_valor_texto: delimitador + contenido + delimitador
            if l_delimitador_texto is not null and
               length(l_delimitador_texto) > 0 then
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            end if;
            -- copiamos l_clob_sin_comillas por chunks (dbms_lob.append con locator puede fallar si origen inválido, así copiamos por substr)
            declare
              p_pos integer := 1;
              p_rem integer := dbms_lob.getlength(l_clob_sin_comillas);
              p_buf varchar2(32767);
            begin
              while p_rem > 0 loop
                p_buf := dbms_lob.substr(l_clob_sin_comillas,
                                         least(32767, p_rem),
                                         p_pos);
                dbms_lob.writeappend(l_valor_texto, length(p_buf), p_buf);
                p_pos := p_pos + length(p_buf);
                p_rem := p_rem - length(p_buf);
              end loop;
            end;
            if l_delimitador_texto is not null and
               length(l_delimitador_texto) > 0 then
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            end if;
            dbms_lob.freetemporary(l_clob_sin_comillas);
          else
            -- no tiene comillas en ambos extremos: copiamos todo
            if l_delimitador_texto is not null and
               length(l_delimitador_texto) > 0 then
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            end if;
            -- copiamos l_valor.to_clob por chunks
            declare
              p_pos integer := 1;
              p_rem integer := l_len;
              p_buf varchar2(32767);
            begin
              while p_rem > 0 loop
                p_buf := dbms_lob.substr(l_valor.to_clob,
                                         least(32767, p_rem),
                                         p_pos);
                dbms_lob.writeappend(l_valor_texto, length(p_buf), p_buf);
                p_pos := p_pos + length(p_buf);
                p_rem := p_rem - length(p_buf);
              end loop;
            end;
            if l_delimitador_texto is not null and
               length(l_delimitador_texto) > 0 then
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            end if;
          end if;
        else
          -- valor vacío o muy corto
          if l_delimitador_texto is not null and
             length(l_delimitador_texto) > 0 then
            dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
          end if;
          dbms_lob.append(l_valor_texto, l_valor.to_clob);
          if l_delimitador_texto is not null and
             length(l_delimitador_texto) > 0 then
            dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
          end if;
        end if;
      
      elsif l_valor.is_number then
        dbms_lob.append(l_valor_texto, to_clob(l_valor.to_string));
      else
        dbms_lob.append(l_valor_texto, to_clob('NULL'));
      end if;
    
      -- Reemplazo seguro (f_replace_clob copia por chunks y retorna un nuevo CLOB)
      l_expresion := f_replace_clob(l_expresion,
                                    i_encapsulador_inicial || l_clave ||
                                    i_encapsulador_final,
                                    l_valor_texto);
    
      -- liberamos el temporal que creamos
      if dbms_lob.istemporary(l_valor_texto) = 1 then
        dbms_lob.freetemporary(l_valor_texto);
      end if;
    end loop;
  
    return l_expresion;
  
  exception
    when others then
      -- asegurar liberar si algo quedó temporal
      begin
        if l_valor_texto is not null and
           dbms_lob.istemporary(l_valor_texto) = 1 then
          dbms_lob.freetemporary(l_valor_texto);
        end if;
      exception
        when others then
          null;
      end;
      dbms_output.put_line('Error en clave: ' || vl_lugar || ' -> ' ||
                           sqlerrm);
      return i_expresion;
  end f_reemplazar_expresion_clob;

  function f_replace_clob(i_source  in clob,
                          i_find    in varchar2,
                          i_replace in clob) return clob is
    l_out      clob;
    l_src_len  integer;
    l_find_len integer := nvl(length(i_find), 0);
    l_pos      integer;
    l_chunk constant integer := 32767; -- chunk máximo
    l_buf      varchar2(32767);
    l_rem      integer;
    l_copy_pos integer;
    l_rep_len  integer;
    l_rep_pos  integer;
  begin
    -- si no hay texto fuente, devolvemos lo que venga (null seguro)
    if i_source is null then
      return null;
    end if;
  
    l_src_len := dbms_lob.getlength(i_source);
  
    dbms_lob.createtemporary(l_out, true);
  
    -- buscar primera ocurrencia
    l_pos := dbms_lob.instr(i_source, i_find, 1, 1);
  
    -- si no hay ocurrencias, copiamos todo y retornamos
    if l_pos = 0 then
      l_copy_pos := 1;
      l_rem      := l_src_len;
      while l_rem > 0 loop
        l_buf := dbms_lob.substr(i_source,
                                 least(l_chunk, l_rem),
                                 l_copy_pos);
        dbms_lob.writeappend(l_out, length(l_buf), l_buf);
        l_copy_pos := l_copy_pos + length(l_buf);
        l_rem      := l_rem - length(l_buf);
      end loop;
      return l_out;
    end if;
  
    -- iteramos sobre todas las ocurrencias
    l_copy_pos := 1;
    while l_pos > 0 loop
      -- copiamos la parte antes del patrón encontrado
      if l_pos > l_copy_pos then
        l_rem := l_pos - l_copy_pos;
        while l_rem > 0 loop
          l_buf := dbms_lob.substr(i_source,
                                   least(l_chunk, l_rem),
                                   l_copy_pos);
          dbms_lob.writeappend(l_out, length(l_buf), l_buf);
          l_copy_pos := l_copy_pos + length(l_buf);
          l_rem      := l_rem - length(l_buf);
        end loop;
      end if;
    
      -- ahora agregamos el reemplazo (i_replace) por chunks (si no es null)
      if i_replace is not null then
        l_rep_len := dbms_lob.getlength(i_replace);
        l_rep_pos := 1;
        while l_rep_pos <= l_rep_len loop
          l_buf := dbms_lob.substr(i_replace,
                                   least(l_chunk, l_rep_len - l_rep_pos + 1),
                                   l_rep_pos);
          dbms_lob.writeappend(l_out, length(l_buf), l_buf);
          l_rep_pos := l_rep_pos + length(l_buf);
        end loop;
      end if;
    
      -- movemos puntero después del patrón
      l_copy_pos := l_pos + l_find_len;
      -- buscamos siguiente ocurrencia empezando desde l_copy_pos
      l_pos := dbms_lob.instr(i_source, i_find, l_copy_pos, 1);
    end loop;
  
    -- copiamos el resto final luego de la última ocurrencia
    if l_copy_pos <= l_src_len then
      l_rem := l_src_len - l_copy_pos + 1;
      while l_rem > 0 loop
        l_buf := dbms_lob.substr(i_source,
                                 least(l_chunk, l_rem),
                                 l_copy_pos);
        dbms_lob.writeappend(l_out, length(l_buf), l_buf);
        l_copy_pos := l_copy_pos + length(l_buf);
        l_rem      := l_rem - length(l_buf);
      end loop;
    end if;
  
    return l_out;
  
  exception
    when others then
      if dbms_lob.istemporary(l_out) = 1 then
        begin
          dbms_lob.freetemporary(l_out);
        exception
          when others then
            null;
        end;
      end if;
      raise;
  end f_replace_clob;

end k_json_util;
/
