create or replace package body k_objeto_util is

  g_cola y_tipo_objetos;

  /**
    Retorna la lista de atributos de un tipo de objeto
  
    %author dmezac 17/04/2025
    %param i_propietario Propietario del tipo del objeto.
    %param i_nombre_tipo Nombre del tipo del objeto.
    %return Lista de atributos de un tipo de objeto (cacheados en sesión).
  */
  function obtener_atributos_almacenados(i_propietario varchar2,
                                         i_nombre_tipo varchar2)
    return y_tipo_atributos is
    l_clave     varchar2(260) := i_propietario || '.' || i_nombre_tipo;
    l_resultado y_tipo_atributos := y_tipo_atributos();
  begin
    if g_cache_atributos.exists(l_clave) then
      return g_cache_atributos(l_clave);
    end if;
  
    for c_atributos in (select a.owner,
                               a.type_name,
                               lower(a.attr_name) attr_name,
                               a.attr_type_name,
                               a.attr_type_mod,
                               b.typecode,
                               c.elem_type_owner,
                               c.elem_type_name
                          from all_type_attrs a,
                               all_types      b,
                               all_coll_types c
                         where (a.attr_type_owner = b.owner or
                               a.attr_type_owner = 'PUBLIC' or
                               a.attr_type_owner is null)
                           and a.attr_type_name = b.type_name(+)
                              --
                           and b.typecode(+) in ('COLLECTION', 'OBJECT')
                           and b.owner = c.owner(+)
                           and b.type_name = c.type_name(+)
                              --
                           and a.owner = i_propietario
                           and a.type_name = i_nombre_tipo
                           and a.attr_name not in ('JSON')
                         order by a.attr_no) loop
      l_resultado.extend;
      /*dbms_output.put_line('***** ' || c_atributos.attr_name || ' ' ||
      c_atributos.attr_type_name || ' .' ||
      c_atributos.typecode || ' .' ||
      c_atributos.elem_type_name || '. *****');*/
      l_resultado(l_resultado.count) := y_tipo_atributo(c_atributos.attr_name,
                                                        c_atributos.attr_type_name,
                                                        c_atributos.attr_type_mod,
                                                        c_atributos.typecode,
                                                        c_atributos.elem_type_name);
    end loop;
  
    g_cache_atributos(l_clave) := l_resultado;
    return l_resultado;
  end obtener_atributos_almacenados;

  /**
    Retorna el objeto deserializado a partir de un JSON.
    Cada sub-tipo del tipo base y_objeto debe implementar esta función con los
    atributos correspondientes.
  
    %author dmezac 17/04/2025
    %param i_json JSON del objeto a deserializar.
    %param i_propietario Propietario del tipo del objeto a deserializar.
    %param i_nombre_tipo Nombre del tipo del objeto a deserializar.
    %param i_tipos Lista de tipos a deserializar.
    %return Objeto deserializado a partir de un JSON.
  */
  function parse_json(i_json        in clob,
                      i_tipos       in y_tipo_objetos default null,
                      i_propietario in varchar2 default null,
                      i_nombre_tipo in varchar2 default null) return y_objeto is
    vl_propietario varchar2(100);
    vl_nombre_tipo varchar2(100);
    --
    l_sql        clob;
    l_sql_campos clob;
    l_objeto     y_objeto;
    --
    l_indice pls_integer := 0;
    --
    l_atributo  y_tipo_atributo;
    l_atributos y_tipo_atributos;
  begin
    vl_propietario := nvl(i_propietario, utl_call_stack.owner(2));
    vl_nombre_tipo := nvl(i_nombre_tipo, utl_call_stack.subprogram(2) (1));
  
    l_atributos := obtener_atributos_almacenados(vl_propietario,
                                                 vl_nombre_tipo);
    for i in 1 .. l_atributos.count loop
      l_atributo := l_atributos(i);
      if l_atributo.modificador = 'REF' then
      
        null;
      
      elsif l_atributo.tipo in ('INTEGER',
                                'NUMBER',
                                'DECIMAL',
                                'VARCHAR2',
                                'CHAR',
                                'CLOB',
                                'DATE',
                                'TIMESTAMP') then
      
        l_sql := l_sql || 'o.' || l_atributo.nombre;
        if l_atributo.tipo in ('INTEGER', 'NUMBER', 'DECIMAL') then
          l_sql_campos := l_sql_campos || '  l_objeto.' ||
                          l_atributo.nombre ||
                          ' := l_json_object.get_number(''' ||
                          l_atributo.nombre || ''');' || chr(10);
        elsif l_atributo.tipo in ('DATE') then
          l_sql_campos := l_sql_campos || '  l_objeto.' ||
                          l_atributo.nombre ||
                          ' := l_json_object.get_date(''' ||
                          l_atributo.nombre || ''');' || chr(10);
        elsif l_atributo.tipo in ('TIMESTAMP') then
          l_sql_campos := l_sql_campos || '  l_objeto.' ||
                          l_atributo.nombre ||
                          ' := l_json_object.get_timestamp(''' ||
                          l_atributo.nombre || ''');' || chr(10);
        elsif l_atributo.tipo in ('CLOB') then
          l_sql_campos := l_sql_campos || '  l_objeto.' ||
                          l_atributo.nombre ||
                          ' := l_json_object.get_clob(''' ||
                          l_atributo.nombre || ''');' || chr(10);
        else
          l_sql_campos := l_sql_campos || '  l_objeto.' ||
                          l_atributo.nombre ||
                          ' := l_json_object.get_string(''' ||
                          l_atributo.nombre || ''');' || chr(10);
        end if;
      
      elsif l_atributo.codigo_tipo = 'OBJECT' then
      
        l_sql_campos := l_sql_campos || chr(10) ||
                        '  DECLARE
    l_json_element json_element_t;
  BEGIN
    l_json_element := l_json_object.get(''' ||
                        l_atributo.nombre || ''');

    IF l_json_element IS NULL OR l_json_element.is_null THEN
      l_objeto.' || l_atributo.nombre || ' := null;
    ELSE
      DECLARE
        l_anydata anydata;
        l_result  pls_integer;
        l_tipo    k_objeto_util.ry_tipo_objeto := new k_objeto_util.ry_tipo_objeto();
      BEGIN
        ' || case
                          when l_atributo.tipo = 'Y_OBJETO' then
                           'l_tipo := k_objeto_util.f_desencolar;'
                          else
                           'l_tipo.nombre := ''' || l_atributo.tipo || ''';'
                        end || '

        l_anydata := k_objeto_util.json_to_objeto(l_json_element.to_clob,
                                                  l_tipo);
        l_result  := l_anydata.getobject(l_objeto.' ||
                        l_atributo.nombre || ');
      EXCEPTION
        WHEN OTHERS THEN
          l_objeto.' || l_atributo.nombre || ' := null;
      END;
    END IF;
  END;' || chr(10);
      
      elsif l_atributo.codigo_tipo = 'COLLECTION' then
      
        declare
          l_nombre_elemento varchar2(128) := l_atributo.nombre_elemento;
        begin
          begin
            if l_nombre_elemento = 'Y_OBJETO' and i_tipos is not null and
               i_tipos.count() > l_indice then
              l_indice          := l_indice + 1;
              l_nombre_elemento := case
                                     when i_tipos(l_indice).propietario is not null then
                                      i_tipos(l_indice).propietario || '.'
                                   end || i_tipos(l_indice).nombre;
            end if;
          exception
            when others then
              console.error('k_objeto_util.parse_json' || ' ' || i_json || '-' ||
                            i_propietario || '-' || vl_nombre_tipo);
          end;
          l_sql_campos := l_sql_campos || chr(10) || '  DECLARE
    l_' || l_atributo.nombre || ' ' ||
                          l_atributo.tipo || ';
    l_dato      ' || l_nombre_elemento || ';
  BEGIN
    l_json_array := l_json_object.get_array(''' ||
                          l_atributo.nombre || ''');

    IF l_json_array IS NULL THEN
      l_objeto.' || l_atributo.nombre ||
                          ' := NEW ' || l_atributo.tipo || '();
    ELSE
      l_' || l_atributo.nombre || ' := NEW ' ||
                          l_atributo.tipo || '();
      FOR i IN 0 .. l_json_array.get_size - 1 LOOP
        l_dato := NEW ' || l_nombre_elemento || '();
        l_dato := treat(' || l_nombre_elemento ||
                          '.parse_json(l_json_array.get(i).to_clob) AS
                        ' || l_nombre_elemento || ');
        l_' || l_atributo.nombre || '.extend;
        l_' || l_atributo.nombre || '(l_' ||
                          l_atributo.nombre || '.count) := l_dato;
      END LOOP;
      l_objeto.' || l_atributo.nombre || ' := l_' ||
                          l_atributo.nombre || ';
    END IF;
  END;' || chr(10);
        end;
      
      else
      
        dbms_output.put_line(l_atributo.tipo || ' <tipo no soportado>');
      
      end if;
    end loop;
  
    l_sql := 'DECLARE
  l_objeto      ' || lower(vl_nombre_tipo) || ';
  l_json_object json_object_t;
  l_json_array  json_array_t;
BEGIN
  l_json_object := json_object_t.parse(:i_json);

  l_objeto := new ' || lower(vl_nombre_tipo) || '();
' || l_sql_campos || '
  :out := l_objeto;
END;';
    --dbms_output.put_line(l_sql);
    execute immediate l_sql
      using in i_json, out l_objeto;
    return l_objeto;
  end parse_json;

  /**
    Retorna el objeto serializado en formato JSON.
    Cada sub-tipo del tipo base y_objeto debe implementar esta función con los
    atributos correspondientes.
  
    %author dmezac 17/04/2025
    %param i_objeto Objeto a serializar.
    %param i_propietario Propietario del tipo del objeto a serializar.
    %param i_nombre_tipo Nombre del tipo del objeto a serializar.
    %return Objeto serializado en formato JSON.
  */
  function to_json(i_objeto      in y_objeto,
                   i_propietario in varchar2 default null,
                   i_nombre_tipo in varchar2 default null) return clob is
    vl_propietario varchar2(100);
    vl_nombre_tipo varchar2(100);
    --
    l_sql        clob;
    l_sql_campos clob;
    l_json       clob;
    --
    l_atributo  y_tipo_atributo;
    l_atributos y_tipo_atributos;
  begin
    vl_propietario := nvl(i_propietario, utl_call_stack.owner(2));
    vl_nombre_tipo := nvl(i_nombre_tipo, utl_call_stack.subprogram(2) (1));
  
    l_atributos := obtener_atributos_almacenados(vl_propietario,
                                                 vl_nombre_tipo);
    for i in 1 .. l_atributos.count loop
      l_atributo := l_atributos(i);
      if l_atributo.modificador = 'REF' then
      
        null;
      
      elsif l_atributo.tipo in ('INTEGER',
                                'NUMBER',
                                'DECIMAL',
                                'VARCHAR2',
                                'CHAR',
                                'CLOB',
                                'DATE',
                                'TIMESTAMP') then
      
        if l_atributo.tipo in ('CLOB') and
           upper(l_atributo.nombre) = 'INFO_ADICIONAL' then
          l_sql        := l_sql || 'o.' || l_atributo.nombre;
          l_sql_campos := l_sql_campos || '  l_json_object.put(''' ||
                          l_atributo.nombre ||
                          ''', k_util.clob_to_blob(l_objeto.' ||
                          l_atributo.nombre || ', ''AL32UTF8''));' ||
                          chr(10);
        else
          l_sql        := l_sql || 'o.' || l_atributo.nombre;
          l_sql_campos := l_sql_campos || '  l_json_object.put(''' ||
                          l_atributo.nombre || ''', l_objeto.' ||
                          l_atributo.nombre || ');' || chr(10);
        end if;
      
      elsif l_atributo.codigo_tipo = 'OBJECT' then
      
        l_sql_campos := l_sql_campos || chr(10) || '  IF l_objeto.' ||
                        l_atributo.nombre || ' IS NULL THEN
    l_json_object.put_null(''' || l_atributo.nombre ||
                        ''');
  ELSE
    l_json_object.put(''' || l_atributo.nombre || ''',
                      json_element_t.parse(nvl(l_objeto.' ||
                        l_atributo.nombre ||
                        '.json,
                                               l_objeto.' ||
                        l_atributo.nombre || '.to_json)));
  END IF;' || chr(10);
      
      elsif l_atributo.codigo_tipo = 'COLLECTION' then
      
        l_sql_campos := l_sql_campos || chr(10) || '  IF l_objeto.' ||
                        l_atributo.nombre || ' IS NULL THEN
    l_json_object.put_null(''' || l_atributo.nombre ||
                        ''');
  ELSE
    l_json_array := NEW json_array_t();
    i            := l_objeto.' || l_atributo.nombre ||
                        '.first;
    WHILE i IS NOT NULL LOOP
      l_json_array.append(json_object_t.parse(nvl(l_objeto.' ||
                        l_atributo.nombre ||
                        '(i).json,
                                                  l_objeto.' ||
                        l_atributo.nombre || '(i).to_json)));
      i := l_objeto.' || l_atributo.nombre ||
                        '.next(i);
    END LOOP;
    l_json_object.put(''' || l_atributo.nombre ||
                        ''', l_json_array);
  END IF;' || chr(10);
      
      else
      
        dbms_output.put_line(l_atributo.tipo || ' <tipo no soportado>');
      
      end if;
    end loop;
  
    l_sql := 'DECLARE
  l_json_object json_object_t;
  l_json_array  json_array_t;
  i             INTEGER;
  l_objeto      ' || lower(vl_nombre_tipo) || ';
BEGIN
  l_objeto := treat(:i_objeto as ' || lower(vl_nombre_tipo) || ');
  l_json_object := NEW json_object_t();
' || l_sql_campos || '
  :out := l_json_object.to_clob;
END;';
    --dbms_output.put_line(l_sql);
    execute immediate l_sql
      using in i_objeto, out l_json;
    return l_json;
  end to_json;

  function json_to_objeto(i_json        in clob,
                          i_nombre_tipo in varchar2) return anydata is
    l_retorno anydata;
    l_objeto  y_objeto;
  begin
    if i_json is not null and i_nombre_tipo is not null then
      begin
        execute immediate 'BEGIN :1 := ' || lower(i_nombre_tipo) ||
                          '.parse_json(i_json => :2); END;'
          using out l_objeto, in i_json;
      exception
        when ex_tipo_inexistente then
          raise_application_error(-20000,
                                  'Tipo ' || lower(i_nombre_tipo) ||
                                  ' no existe');
      end;
    end if;
  
    l_retorno := anydata.convertobject(l_objeto);
  
    return l_retorno;
  end;

  function json_to_objeto(i_json in clob,
                          i_tipo in ry_tipo_objeto) return anydata is
  begin
    return json_to_objeto(i_json,
                          case when i_tipo.propietario is not null then
                          i_tipo.propietario || '.' end || i_tipo.nombre);
  end;

  function objeto_to_json(i_objeto in anydata) return clob is
    l_json     clob;
    l_typeinfo anytype;
    l_typecode pls_integer;
  begin
    if i_objeto is not null then
      l_typecode := i_objeto.gettype(l_typeinfo);
      if l_typecode = dbms_types.typecode_object then
        execute immediate 'DECLARE
  l_retorno PLS_INTEGER;
  l_anydata anydata := :1;
  l_object  ' || i_objeto.gettypename || ';
  l_clob    CLOB;
BEGIN
  l_retorno := l_anydata.getobject(obj => l_object);
  :2        := l_object.to_json();
END;'
          using in i_objeto, out l_json;
      end if;
    end if;
    return l_json;
  end;

  --
  procedure p_inicializar_cola is
  begin
    g_cola := new y_tipo_objetos();
  end;

  procedure p_encolar(i_propietario in varchar2,
                      i_nombre      in varchar2) is
  begin
    if g_cola is null then
      p_inicializar_cola;
    end if;
    g_cola.extend;
    g_cola(g_cola.count).propietario := i_propietario;
    g_cola(g_cola.count).nombre := i_nombre;
  end;

  function f_desencolar return ry_tipo_objeto is
    l_valor ry_tipo_objeto;
  begin
    if g_cola is null then
      p_inicializar_cola;
    end if;
    if g_cola.exists(g_cola.first) then
      l_valor := g_cola(g_cola.first);
      g_cola.delete(g_cola.first);
    end if;
    return l_valor;
  end;

  procedure p_imprimir_cola is
    i integer;
  begin
    if g_cola is not null then
      i := g_cola.first;
      while i is not null loop
        dbms_output.put_line(to_char(i) || ': ' || g_cola(i).propietario || case when g_cola(i).propietario is not null then '.'
                             end || g_cola(i).nombre);
        i := g_cola.next(i);
      end loop;
    end if;
  end;
  --

  procedure p_generar_type_objeto(i_tabla    in varchar2,
                                  i_type     in varchar2 default null,
                                  i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
    l_type      varchar2(30);
    l_comments  varchar2(4000);
    l_campos1   varchar2(4000);
    l_campos2   varchar2(4000);
    l_campos3   varchar2(4000);
    l_data_type varchar2(100);
  
    cursor cr_campos is
      select m.comments,
             c.column_name,
             c.data_type,
             c.data_length,
             c.data_precision,
             c.data_scale
        from all_tab_columns c, all_col_comments m
       where m.table_name = c.table_name
         and m.column_name = c.column_name
         and lower(c.table_name) like 't\_%' escape
       '\'
         and lower(c.table_name) = lower(i_tabla)
         and c.column_name not in
             (k_auditoria.g_nombre_campo_created_by,
              k_auditoria.g_nombre_campo_created,
              k_auditoria.g_nombre_campo_updated_by,
              k_auditoria.g_nombre_campo_updated)
       order by c.column_id;
  begin
    l_type := lower(nvl(i_type,
                        'y_' || substr(i_tabla, 3, length(i_tabla) - 3)));
  
    -- Genera type spec
    select c.comments
      into l_comments
      from all_tab_comments c
     where lower(c.table_name) like 't\_%' escape
     '\'
       and lower(c.table_name) = lower(i_tabla);
  
    l_campos1 := '';
    for c in cr_campos loop
      l_campos1 := l_campos1 || '/** ' || c.comments || ' */' ||
                   utl_tcp.crlf;
      l_campos1 := l_campos1 || lower(c.column_name) || ' ';
    
      case c.data_type
        when 'NUMBER' then
          if c.data_precision is not null then
            if c.data_scale > 0 then
              l_data_type := c.data_type || '(' ||
                             to_char(c.data_precision) || ',' ||
                             to_char(c.data_scale) || ')';
            else
              l_data_type := c.data_type || '(' ||
                             to_char(c.data_precision) || ')';
            end if;
          else
            l_data_type := c.data_type;
          end if;
        when 'VARCHAR2' then
          l_data_type := c.data_type || '(' || to_char(c.data_length) || ')';
        else
          l_data_type := c.data_type;
      end case;
      l_campos1 := l_campos1 || l_data_type || ',' || utl_tcp.crlf;
    end loop;
  
    l_sentencia := 'CREATE OR REPLACE TYPE ' || l_type || ' FORCE UNDER y_objeto
(
/**
Agrupa datos de ' || l_comments || '.

%author ' || lower(user) || ' ' ||
                   to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') || '
*/

/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors

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

' || l_campos1 || '

  CONSTRUCTOR FUNCTION ' || l_type || ' RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    -- Genera type body
    l_campos1 := '';
    for c in cr_campos loop
      l_campos1 := l_campos1 || 'self.' || lower(c.column_name) ||
                   ' := NULL;' || utl_tcp.crlf;
    end loop;
  
    l_campos2 := '';
    for c in cr_campos loop
      case c.data_type
        when 'VARCHAR2' then
          l_data_type := 'string';
        else
          l_data_type := lower(c.data_type);
      end case;
    
      l_campos2 := l_campos2 || 'l_objeto.' || lower(c.column_name) ||
                   ' := l_json_object.get_' || l_data_type || '(''' ||
                   lower(c.column_name) || ''');' || utl_tcp.crlf;
    end loop;
  
    l_campos3 := '';
    for c in cr_campos loop
      l_campos3 := l_campos3 || 'l_json_object.put(''' ||
                   lower(c.column_name) || ''', self.' ||
                   lower(c.column_name) || ');' || utl_tcp.crlf;
    end loop;
  
    l_sentencia := 'CREATE OR REPLACE TYPE BODY ' || l_type || ' IS

  CONSTRUCTOR FUNCTION ' || l_type || ' RETURN SELF AS RESULT AS
  BEGIN
' || l_campos1 || '
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
  BEGIN
    RETURN k_objeto_util.parse_json(i_json);
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
  BEGIN
    RETURN k_objeto_util.to_json(self);
  END;

END;';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

  function f_objetos_clob(pin_objetos y_objetos) return clob is
    vl_objetos    y_objetos := pin_objetos;
    vl_objeto     y_objeto;
    vl_lista_json json_array_t := null;
    vl_json       json_object_t;
  begin
    for vl_indice in 1 .. vl_objetos.count loop
      -- Si aún no se inicializó, inicializamos el array.
      if vl_lista_json is null then
        vl_lista_json := json_array_t();
      end if;
    
      vl_objeto := treat(vl_objetos(vl_indice) as y_objeto);
    
      vl_json := json_object_t();
      vl_json := json_object_t.parse(vl_objeto.to_json);
    
      vl_lista_json.append(vl_json);
    end loop;
  
    return vl_lista_json.to_clob;
  end f_objetos_clob;

end k_objeto_util;
/

