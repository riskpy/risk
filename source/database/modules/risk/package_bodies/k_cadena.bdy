create or replace package body k_cadena is

  function f_separar_cadenas(i_cadena    in varchar2,
                             i_separador in varchar2 default '~')
    return y_cadenas
    pipelined is
    l_idx    pls_integer;
    l_cadena varchar2(32767);
  begin
    l_cadena := i_cadena;
    loop
      l_idx := instr(l_cadena, i_separador);
      if l_idx > 0 then
        pipe row(substr(l_cadena, 1, l_idx - 1));
        l_cadena := substr(l_cadena, l_idx + length(i_separador));
      else
        pipe row(l_cadena);
        exit;
      end if;
    end loop;
    return;
  end;

  function f_unir_cadenas(i_cadena    in varchar2,
                          i_cadenas   in y_cadenas,
                          i_wrap_char in varchar2 default '@')
    return varchar2 is
    l_cadena varchar2(32767);
  begin
    l_cadena := i_cadena;
    if l_cadena is not null and i_cadenas.count > 0 then
      for i in i_cadenas.first .. i_cadenas.last loop
        -- Given the index "i" find the related placeholder in the message and
        -- replace the placeholder with the array's value at index "i".
        l_cadena := replace(l_cadena,
                            i_wrap_char || to_char(i) || i_wrap_char,
                            i_cadenas(i));
      end loop;
    end if;
  
    return l_cadena;
  end;

  function f_unir_cadenas(i_cadena    in varchar2,
                          i_cadena1   in varchar2 default null,
                          i_cadena2   in varchar2 default null,
                          i_cadena3   in varchar2 default null,
                          i_cadena4   in varchar2 default null,
                          i_cadena5   in varchar2 default null,
                          i_wrap_char in varchar2 default '@')
    return varchar2 is
    l_cadenas y_cadenas;
  begin
    l_cadenas := new y_cadenas();
    l_cadenas.extend(5);
  
    if i_cadena1 is not null then
      l_cadenas(1) := i_cadena1;
    end if;
    if i_cadena2 is not null then
      l_cadenas(2) := i_cadena2;
    end if;
    if i_cadena3 is not null then
      l_cadenas(3) := i_cadena3;
    end if;
    if i_cadena4 is not null then
      l_cadenas(4) := i_cadena4;
    end if;
    if i_cadena5 is not null then
      l_cadenas(5) := i_cadena5;
    end if;
  
    return f_unir_cadenas(i_cadena, l_cadenas, nvl(i_wrap_char, '@'));
  end;

  function f_valor_posicion(i_cadena    in varchar2,
                            i_posicion  in number,
                            i_separador in varchar2 default '~')
    return varchar2 is
    l_valor           varchar2(32767);
    l_posicion        number;
    l_separador       varchar2(10);
    l_longitud_valor  number;
    l_posicion_inicio number;
    l_posicion_fin    number;
  begin
    l_separador := i_separador;
  
    if i_posicion > 0 then
      l_posicion := i_posicion;
    else
      l_posicion := 1;
    end if;
  
    -- Posicion del inicio del valor dentro de la cadena
    if l_posicion > 1 then
      l_posicion_inicio := instr(i_cadena, l_separador, 1, l_posicion - 1);
      if l_posicion_inicio = 0 then
        l_posicion_inicio := instr(i_cadena, l_separador, -1, 1);
      end if;
      l_posicion_inicio := l_posicion_inicio + length(l_separador);
    else
      l_posicion_inicio := 1;
    end if;
  
    -- Posicion del fin del valor dentro de la cadena
    l_posicion_fin := instr(i_cadena, l_separador, 1, l_posicion);
  
    if l_posicion_fin = 0 then
      l_valor := substr(i_cadena, l_posicion_inicio);
    else
      l_longitud_valor := l_posicion_fin - l_posicion_inicio;
      l_valor          := substr(i_cadena,
                                 l_posicion_inicio,
                                 l_longitud_valor);
    end if;
    return l_valor;
  end;

  function f_extraer_cadenas(i_texto                in varchar2,
                             i_encapsulador_inicial in varchar2 := ':',
                             i_encapsulador_final   in varchar2 := ' ',
                             i_limpio               in varchar2 := 'N')
    return y_cadenas
    pipelined is
    l_limpio char(1) := nvl(substr(i_limpio, 1, 1), 'N');
    --
    l_pos         pls_integer := 1;
    l_start       pls_integer;
    l_end         pls_integer;
    l_placeholder varchar2(32767);
    l_len_ini     pls_integer := length(i_encapsulador_inicial);
    l_len_fin     pls_integer := length(i_encapsulador_final);
  begin
    loop
      l_start := instr(i_texto, i_encapsulador_inicial, l_pos);
      exit when l_start = 0;
    
      l_end := instr(i_texto, i_encapsulador_final, l_start + l_len_ini);
      exit when l_end = 0;
    
      if l_limpio = 'S' then
        -- Solo el contenido interno, sin delimitadores
        l_placeholder := trim(substr(i_texto,
                                     l_start + l_len_ini,
                                     l_end - l_start - l_len_ini));
      else
        -- Placeholder completo con delimitadores
        l_placeholder := trim(substr(i_texto,
                                     l_start,
                                     l_end - l_start + l_len_fin));
      end if;
    
      pipe row(l_placeholder);
      l_pos := l_end + l_len_fin;
    end loop;
  
    return;
  end;

  function f_reemplazar_acentos(i_cadena in varchar2) return varchar2 is
  begin
    return translate(i_cadena,
                     '·ÈÌÛ˙‡ËÏÚ˘‚ÍÓÙ˚‰ÎÔˆ¸Á„ı¡…Õ”⁄¿»Ã“Ÿ¬ Œ‘€ƒÀœ÷‹«√’',
                     'aeiouaeiouaeiouaeioucaoAEIOUAEIOUAEIOUAEIOUCAO');
  end;

  function f_formatear_titulo(i_titulo in varchar2) return varchar2 is
    v_resultado varchar2(4000);
    v_palabra   varchar2(100);
    v_longitud  pls_integer;
    v_temp      varchar2(4000);
  
    type t_lista is table of varchar2(20);
    v_excepciones t_lista := t_lista('de',
                                     'del',
                                     'la',
                                     'las',
                                     'el',
                                     'los',
                                     'y',
                                     'o',
                                     'a',
                                     'en',
                                     'con',
                                     'por',
                                     'para');
  
    -- FunciÛn auxiliar para saber si una palabra est· en la lista
    function es_excepcion(p_palabra varchar2) return boolean is
    begin
      for i in 1 .. v_excepciones.count loop
        if p_palabra = v_excepciones(i) then
          return true;
        end if;
      end loop;
      return false;
    end;
  begin
    v_temp      := lower(i_titulo);
    v_resultado := '';
    v_longitud  := regexp_count(v_temp, '\S+');
  
    for i in 1 .. v_longitud loop
      v_palabra := regexp_substr(v_temp, '\S+', 1, i);
    
      if i = 1 then
        v_palabra := initcap(v_palabra);
      else
        if es_excepcion(v_palabra) then
          v_palabra := lower(v_palabra);
        elsif v_palabra = upper(v_palabra) then
          v_palabra := v_palabra; -- sigla, se mantiene
        else
          v_palabra := initcap(v_palabra);
        end if;
      end if;
    
      v_resultado := v_resultado || v_palabra || ' ';
    end loop;
  
    return rtrim(v_resultado);
  end;

  -- https://github.com/osalvador/tePLSQL
  function f_procesar_plantilla(i_plantilla in clob,
                                i_variables in t_assoc_array default null_assoc_array,
                                i_wrap_char in varchar2 default '@')
    return clob is
    l_key     t_template_variable_name;
    l_value   t_template_variable_value;
    l_retorno clob;
  begin
    l_retorno := i_plantilla;
  
    l_key := i_variables.first;
    while l_key is not null loop
      l_value := i_variables(l_key);
    
      l_retorno := replace(l_retorno,
                           i_wrap_char || l_key || i_wrap_char,
                           l_value);
      l_retorno := replace(l_retorno,
                           i_wrap_char || lower(l_key) || i_wrap_char,
                           l_value);
      l_retorno := replace(l_retorno,
                           i_wrap_char || upper(l_key) || i_wrap_char,
                           l_value);
      l_retorno := replace(l_retorno,
                           i_wrap_char || initcap(l_key) || i_wrap_char,
                           l_value);
    
      l_key := i_variables.next(l_key);
    end loop;
  
    return l_retorno;
  end;

  function f_buscar_cadena(pin_buscar    varchar2,
                           pin_cadena    varchar2,
                           pin_separador varchar2 default ',')
    return varchar2 is
    vl_encontrado varchar2(1) := 'N';
  begin
    begin
      select 'S'
        into vl_encontrado
        from k_cadena.f_separar_cadenas(pin_cadena, pin_separador)
       where trim(column_value) = pin_buscar;
    exception
      when no_data_found then
        vl_encontrado := 'N';
      when too_many_rows then
        vl_encontrado := 'S';
    end;
  
    return vl_encontrado;
  end f_buscar_cadena;

  function f_formatear_cadena(p_lista_campos     in varchar2, -- lista separada por comas
                              p_patron           in varchar2, -- texto plantilla, usar "#" como placeholder
                              p_separador_salida in varchar2 default chr(10) -- salto de lÌnea o coma
                              ) return clob is
    v_resultado clob := empty_clob();
    v_token     varchar2(4000);
    v_pos       pls_integer := 1;
    v_lista     varchar2(32767) := p_lista_campos || ',';
  begin
    loop
      v_token := regexp_substr(v_lista, '[^,]+', 1, v_pos);
      exit when v_token is null;
    
      v_resultado := v_resultado || replace(p_patron, '#', trim(v_token));
    
      -- Agregar separador si no es el ˙ltimo elemento
      if regexp_substr(v_lista, '[^,]+', 1, v_pos + 1) is not null then
        v_resultado := v_resultado || p_separador_salida;
      end if;
    
      v_pos := v_pos + 1;
    end loop;
  
    return v_resultado;
  end f_formatear_cadena;

  function f_reemplazar_etiquetas(i_cadena       in clob,
                                  i_etiquetas    in y_cadenas,
                                  i_valores      in y_cadenas,
                                  i_encapsulador in varchar2 default '#')
    return clob is
    l_result clob := i_cadena;
  begin
    for i in 1 .. i_etiquetas.count loop
      l_result := replace(l_result,
                          i_encapsulador || i_etiquetas(i) || i_encapsulador,
                          nvl(i_valores(i), ''));
    end loop;
    return l_result;
  end f_reemplazar_etiquetas;

end;
/

