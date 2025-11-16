CREATE OR REPLACE PACKAGE k_json_util AS
  /**
  Agrupa herramientas para facilitar el manejo de json y variables
  
  %author dmezac 04/05/2025
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 jtsoya539
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  c_json_object_vacio CONSTANT VARCHAR2(10) := '{}';
  c_json_array_vacio  CONSTANT VARCHAR2(10) := '[]';

  FUNCTION f_contiene_valor(i_valor IN VARCHAR2,
                            i_json  IN CLOB) RETURN BOOLEAN;

  FUNCTION f_obtener_valor(i_json  IN CLOB,
                           i_clave IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_editar_valor(i_json  IN CLOB,
                          i_clave IN VARCHAR2,
                          i_valor IN VARCHAR2) RETURN CLOB;

  FUNCTION f_contiene_valores(i_valores IN VARCHAR2,
                              i_json    IN CLOB) RETURN VARCHAR2;

  FUNCTION f_reemplazar_expresion(i_expresion                  IN VARCHAR2,
                                  i_valores                    IN CLOB,
                                  i_encapsulador_inicial       IN VARCHAR2 := ':',
                                  i_encapsulador_final         IN VARCHAR2 := '',
                                  i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB;

  FUNCTION f_reemplazar_expresion_clob(i_expresion                  IN CLOB,
                                       i_valores                    IN CLOB,
                                       i_encapsulador_inicial       IN VARCHAR2 := ':',
                                       i_encapsulador_final         IN VARCHAR2 := '',
                                       i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB;

  FUNCTION f_replace_clob(i_source  IN CLOB,
                          i_find    IN VARCHAR2,
                          i_replace IN CLOB) RETURN CLOB;

END k_json_util;
/
CREATE OR REPLACE PACKAGE BODY k_json_util AS

  FUNCTION f_contiene_valor(i_valor IN VARCHAR2,
                            i_json  IN CLOB) RETURN BOOLEAN IS
    l_sentencia VARCHAR2(4000);
    l_resultado PLS_INTEGER;
  BEGIN
    l_sentencia := 'SELECT COUNT(*) cantidad
        FROM dual
        WHERE json_exists(''' || i_json ||
                   ''', ''$[*]?(@ == "' || i_valor || '")'')';
  
    EXECUTE IMMEDIATE l_sentencia
      INTO l_resultado;
  
    IF l_resultado > 0 THEN
      RETURN TRUE;
    END IF;
  
    RETURN FALSE;
  END;

  FUNCTION f_obtener_valor(i_json  IN CLOB,
                           i_clave IN VARCHAR2) RETURN VARCHAR2 IS
    l_resultado VARCHAR2(4000);
    l_clave     VARCHAR2(1000) := '''$.' || i_clave || '''';
    --
    l_sentencia CLOB := 'SELECT json_value(:1, ' || l_clave ||
                        ') FROM dual';
  BEGIN
    IF json_query(i_json, '$') IS NOT NULL THEN
      EXECUTE IMMEDIATE l_sentencia
        INTO l_resultado
        USING i_json;
    ELSE
      l_resultado := NULL;
    END IF;
    RETURN l_resultado;
  END;

  FUNCTION f_editar_valor(i_json  IN CLOB,
                          i_clave IN VARCHAR2,
                          i_valor IN VARCHAR2) RETURN CLOB IS
    l_nuevo CLOB;
  BEGIN
    SELECT json_mergepatch(i_json,
                           json_object(i_clave VALUE i_valor RETURNING CLOB))
      INTO l_nuevo
      FROM dual;
    RETURN l_nuevo;
  END;

  FUNCTION f_contiene_valores(i_valores IN VARCHAR2,
                              i_json    IN CLOB) RETURN VARCHAR2 IS
    l_json_obj  json_object_t := json_object_t.parse(nvl(i_json, '{}'));
    l_token     VARCHAR2(100);
    l_pos       PLS_INTEGER := 1;
    l_faltantes VARCHAR2(4000);
  BEGIN
    LOOP
      l_token := regexp_substr(i_valores || ',', '[^,]+', 1, l_pos);
      EXIT WHEN l_token IS NULL;
      l_token := TRIM(l_token);
    
      IF NOT l_json_obj.has(l_token) THEN
        l_faltantes := l_faltantes || CASE
                         WHEN l_faltantes IS NULL THEN
                          ''
                         ELSE
                          ', '
                       END || l_token;
      END IF;
    
      l_pos := l_pos + 1;
    END LOOP;
  
    RETURN nvl(l_faltantes, 'OK');
  END;

  FUNCTION f_reemplazar_expresion(i_expresion                  IN VARCHAR2,
                                  i_valores                    IN CLOB,
                                  i_encapsulador_inicial       IN VARCHAR2 := ':',
                                  i_encapsulador_final         IN VARCHAR2 := '',
                                  i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB IS
  
    l_delimitador_texto VARCHAR2(1) := substr(i_delimitador_texto_agregado,
                                              1,
                                              1);
    l_expresion         CLOB := i_expresion;
  
    l_objeto_json json_object_t;
    l_clave       VARCHAR2(100);
    l_valor       json_element_t;
    l_valor_texto CLOB;
  BEGIN
    l_objeto_json := json_object_t.parse(i_valores);
  
    FOR i IN 1 .. l_objeto_json.get_size LOOP
      l_clave := l_objeto_json.get_keys() (i);
      l_valor := l_objeto_json.get(l_clave);
    
      IF l_valor.is_string THEN
        l_valor_texto := '' || l_delimitador_texto || '' ||
                         regexp_replace(l_valor.to_clob, '^"(.*)"$', '\1') || '' ||
                         l_delimitador_texto || '';
      ELSIF l_valor.is_number THEN
        l_valor_texto := l_valor.to_string;
      ELSE
        l_valor_texto := 'NULL'; -- podrías manejar booleanos, nulls, etc.
      END IF;
    
      l_expresion := REPLACE(l_expresion,
                             i_encapsulador_inicial || l_clave ||
                             i_encapsulador_final,
                             l_valor_texto);
    END LOOP;
  
    --dbms_output.put_line('Expresión generada: ' || l_expresion);
  
    RETURN l_expresion;
  
  END;

  FUNCTION f_reemplazar_expresion_clob(i_expresion                  IN CLOB,
                                       i_valores                    IN CLOB,
                                       i_encapsulador_inicial       IN VARCHAR2 := ':',
                                       i_encapsulador_final         IN VARCHAR2 := '',
                                       i_delimitador_texto_agregado IN VARCHAR2 := '')
    RETURN CLOB IS
    l_expresion         CLOB := i_expresion;
    l_objeto_json       json_object_t;
    l_clave             VARCHAR2(100);
    l_valor             json_element_t;
    l_valor_texto       CLOB;
    l_delimitador_texto VARCHAR2(1) := substr(i_delimitador_texto_agregado,
                                              1,
                                              1);
    vl_lugar            VARCHAR2(4000);
    l_len               INTEGER;
    l_clob_sin_comillas CLOB;
  BEGIN
    IF i_expresion IS NULL THEN
      RETURN NULL;
    END IF;
  
    l_objeto_json := json_object_t.parse(i_valores);
  
    FOR i IN 1 .. l_objeto_json.get_size LOOP
      l_clave  := l_objeto_json.get_keys() (i);
      l_valor  := l_objeto_json.get(l_clave);
      vl_lugar := substr(l_clave, 1, 4000);
    
      -- creamos siempre un temporal para el valor final
      dbms_lob.createtemporary(l_valor_texto, TRUE);
    
      IF l_valor.is_string THEN
        -- manejamos comillas inicial/final (si existen)
        l_len := dbms_lob.getlength(l_valor.to_clob);
        IF l_len >= 2 THEN
          IF dbms_lob.substr(l_valor.to_clob, 1, 1) = '"' AND
             dbms_lob.substr(l_valor.to_clob, 1, l_len) = '"' THEN
            -- creamos temporal para el substring sin comillas
            dbms_lob.createtemporary(l_clob_sin_comillas, TRUE);
            dbms_lob.copy(l_clob_sin_comillas,
                          l_valor.to_clob,
                          l_len - 2,
                          2,
                          1);
            -- armamos l_valor_texto: delimitador + contenido + delimitador
            IF l_delimitador_texto IS NOT NULL AND
               length(l_delimitador_texto) > 0 THEN
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            END IF;
            -- copiamos l_clob_sin_comillas por chunks (dbms_lob.append con locator puede fallar si origen inválido, así copiamos por substr)
            DECLARE
              p_pos INTEGER := 1;
              p_rem INTEGER := dbms_lob.getlength(l_clob_sin_comillas);
              p_buf VARCHAR2(32767);
            BEGIN
              WHILE p_rem > 0 LOOP
                p_buf := dbms_lob.substr(l_clob_sin_comillas,
                                         least(32767, p_rem),
                                         p_pos);
                dbms_lob.writeappend(l_valor_texto, length(p_buf), p_buf);
                p_pos := p_pos + length(p_buf);
                p_rem := p_rem - length(p_buf);
              END LOOP;
            END;
            IF l_delimitador_texto IS NOT NULL AND
               length(l_delimitador_texto) > 0 THEN
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            END IF;
            dbms_lob.freetemporary(l_clob_sin_comillas);
          ELSE
            -- no tiene comillas en ambos extremos: copiamos todo
            IF l_delimitador_texto IS NOT NULL AND
               length(l_delimitador_texto) > 0 THEN
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            END IF;
            -- copiamos l_valor.to_clob por chunks
            DECLARE
              p_pos INTEGER := 1;
              p_rem INTEGER := l_len;
              p_buf VARCHAR2(32767);
            BEGIN
              WHILE p_rem > 0 LOOP
                p_buf := dbms_lob.substr(l_valor.to_clob,
                                         least(32767, p_rem),
                                         p_pos);
                dbms_lob.writeappend(l_valor_texto, length(p_buf), p_buf);
                p_pos := p_pos + length(p_buf);
                p_rem := p_rem - length(p_buf);
              END LOOP;
            END;
            IF l_delimitador_texto IS NOT NULL AND
               length(l_delimitador_texto) > 0 THEN
              dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
            END IF;
          END IF;
        ELSE
          -- valor vacío o muy corto
          IF l_delimitador_texto IS NOT NULL AND
             length(l_delimitador_texto) > 0 THEN
            dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
          END IF;
          dbms_lob.append(l_valor_texto, l_valor.to_clob);
          IF l_delimitador_texto IS NOT NULL AND
             length(l_delimitador_texto) > 0 THEN
            dbms_lob.append(l_valor_texto, to_clob(l_delimitador_texto));
          END IF;
        END IF;
      
      ELSIF l_valor.is_number THEN
        dbms_lob.append(l_valor_texto, to_clob(l_valor.to_string));
      ELSE
        dbms_lob.append(l_valor_texto, to_clob('NULL'));
      END IF;
    
      -- Reemplazo seguro (f_replace_clob copia por chunks y retorna un nuevo CLOB)
      l_expresion := f_replace_clob(l_expresion,
                                    i_encapsulador_inicial || l_clave ||
                                    i_encapsulador_final,
                                    l_valor_texto);
    
      -- liberamos el temporal que creamos
      IF dbms_lob.istemporary(l_valor_texto) = 1 THEN
        dbms_lob.freetemporary(l_valor_texto);
      END IF;
    END LOOP;
  
    RETURN l_expresion;
  
  EXCEPTION
    WHEN OTHERS THEN
      -- asegurar liberar si algo quedó temporal
      BEGIN
        IF l_valor_texto IS NOT NULL AND
           dbms_lob.istemporary(l_valor_texto) = 1 THEN
          dbms_lob.freetemporary(l_valor_texto);
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      dbms_output.put_line('Error en clave: ' || vl_lugar || ' -> ' ||
                           SQLERRM);
      RETURN i_expresion;
  END f_reemplazar_expresion_clob;

  FUNCTION f_replace_clob(i_source  IN CLOB,
                          i_find    IN VARCHAR2,
                          i_replace IN CLOB) RETURN CLOB IS
    l_out      CLOB;
    l_src_len  INTEGER;
    l_find_len INTEGER := nvl(length(i_find), 0);
    l_pos      INTEGER;
    l_chunk CONSTANT INTEGER := 32767; -- chunk máximo
    l_buf      VARCHAR2(32767);
    l_rem      INTEGER;
    l_copy_pos INTEGER;
    l_rep_len  INTEGER;
    l_rep_pos  INTEGER;
  BEGIN
    -- si no hay texto fuente, devolvemos lo que venga (null seguro)
    IF i_source IS NULL THEN
      RETURN NULL;
    END IF;
  
    l_src_len := dbms_lob.getlength(i_source);
  
    dbms_lob.createtemporary(l_out, TRUE);
  
    -- buscar primera ocurrencia
    l_pos := dbms_lob.instr(i_source, i_find, 1, 1);
  
    -- si no hay ocurrencias, copiamos todo y retornamos
    IF l_pos = 0 THEN
      l_copy_pos := 1;
      l_rem      := l_src_len;
      WHILE l_rem > 0 LOOP
        l_buf := dbms_lob.substr(i_source,
                                 least(l_chunk, l_rem),
                                 l_copy_pos);
        dbms_lob.writeappend(l_out, length(l_buf), l_buf);
        l_copy_pos := l_copy_pos + length(l_buf);
        l_rem      := l_rem - length(l_buf);
      END LOOP;
      RETURN l_out;
    END IF;
  
    -- iteramos sobre todas las ocurrencias
    l_copy_pos := 1;
    WHILE l_pos > 0 LOOP
      -- copiamos la parte antes del patrón encontrado
      IF l_pos > l_copy_pos THEN
        l_rem := l_pos - l_copy_pos;
        WHILE l_rem > 0 LOOP
          l_buf := dbms_lob.substr(i_source,
                                   least(l_chunk, l_rem),
                                   l_copy_pos);
          dbms_lob.writeappend(l_out, length(l_buf), l_buf);
          l_copy_pos := l_copy_pos + length(l_buf);
          l_rem      := l_rem - length(l_buf);
        END LOOP;
      END IF;
    
      -- ahora agregamos el reemplazo (i_replace) por chunks (si no es null)
      IF i_replace IS NOT NULL THEN
        l_rep_len := dbms_lob.getlength(i_replace);
        l_rep_pos := 1;
        WHILE l_rep_pos <= l_rep_len LOOP
          l_buf := dbms_lob.substr(i_replace,
                                   least(l_chunk, l_rep_len - l_rep_pos + 1),
                                   l_rep_pos);
          dbms_lob.writeappend(l_out, length(l_buf), l_buf);
          l_rep_pos := l_rep_pos + length(l_buf);
        END LOOP;
      END IF;
    
      -- movemos puntero después del patrón
      l_copy_pos := l_pos + l_find_len;
      -- buscamos siguiente ocurrencia empezando desde l_copy_pos
      l_pos := dbms_lob.instr(i_source, i_find, l_copy_pos, 1);
    END LOOP;
  
    -- copiamos el resto final luego de la última ocurrencia
    IF l_copy_pos <= l_src_len THEN
      l_rem := l_src_len - l_copy_pos + 1;
      WHILE l_rem > 0 LOOP
        l_buf := dbms_lob.substr(i_source,
                                 least(l_chunk, l_rem),
                                 l_copy_pos);
        dbms_lob.writeappend(l_out, length(l_buf), l_buf);
        l_copy_pos := l_copy_pos + length(l_buf);
        l_rem      := l_rem - length(l_buf);
      END LOOP;
    END IF;
  
    RETURN l_out;
  
  EXCEPTION
    WHEN OTHERS THEN
      IF dbms_lob.istemporary(l_out) = 1 THEN
        BEGIN
          dbms_lob.freetemporary(l_out);
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END IF;
      RAISE;
  END f_replace_clob;

END k_json_util;
/
