create or replace package body k_importacion is

  function f_procesar_importacion_local(i_id_importacion         in number,
                                        i_archivo                in blob,
                                        i_parametros_adicionales in varchar2 default null,
                                        i_version                in varchar2 default null)
    return y_respuesta is
    l_rsp y_respuesta;
    --
    l_nombre_importacion     t_operaciones.nombre%type;
    l_version_importacion    t_operaciones.version_actual%type;
    l_parametros_automaticos t_operaciones.parametros_automaticos%type;
    l_separador_campos       t_importaciones.separador_campos%type;
    l_linea_inicial          t_importaciones.linea_inicial%type;
    l_nombre_tabla           t_importaciones.nombre_tabla%type;
    l_truncar_tabla          t_importaciones.truncar_tabla%type;
    --
    l_registros_ok    number;
    l_registros_error number;
    l_detalle_errores json_array_t := json_array_t();
    --
    l_contador pls_integer := 0;
    --
    l_funcion               varchar2(30);
    l_parametros_funcion    varchar2(4000);
    l_variables             varchar2(4000);
    l_variable1             varchar2(100);
    l_columnas              clob;
    l_columnas_lobs         clob;
    l_sentencia             clob;
    l_declaracion_tipos     clob;
    l_declaracion_variables clob;
    l_campos_simples        clob;
    l_variables_simples     clob;
    l_variables_indexadas   clob;
    l_campos_extras         varchar2(4000);
    l_variables_extras      varchar2(4000);
    --
    cursor c_parametros(i_id_importacion in number,
                        i_version        in varchar2) is
      select a.id_operacion,
             a.nombre,
             a.version,
             a.orden,
             a.activo,
             a.tipo_dato,
             a.formato,
             a.obligatorio,
             a.valor_defecto,
             a.detalle,
             a.valores_posibles,
             a.encriptado,
             b.posicion_inicial,
             b.longitud,
             b.posicion_decimal,
             b.mapeador
        from t_operacion_parametros a, t_importacion_parametros b
       where a.id_operacion = b.id_importacion(+)
         and a.nombre = b.nombre(+)
         and a.version = b.version(+)
         and a.id_operacion = i_id_importacion
         and a.version = i_version
       order by a.orden;
  begin
    savepoint inicio_importacion_sin_commit;
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Buscando datos de la importación';
    begin
      select o.nombre,
             o.version_actual,
             lower(o.parametros_automaticos),
             i.separador_campos,
             nvl(i.linea_inicial, 1),
             i.nombre_tabla,
             i.truncar_tabla
        into l_nombre_importacion,
             l_version_importacion,
             l_parametros_automaticos,
             l_separador_campos,
             l_linea_inicial,
             l_nombre_tabla,
             l_truncar_tabla
        from t_importaciones i, t_operaciones o
       where o.id_operacion = i.id_importacion
         and o.activo = 'S'
         and o.id_operacion = i_id_importacion
         and o.version_actual = nvl(i_version, o.version_actual);
    exception
      when no_data_found then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      'Importación inexistente o inactiva',
                                      'i_id_importacion=[' ||
                                      i_id_importacion || '], i_version=[' ||
                                      i_version || ']');
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Validando parámetros adicionales de la importación de archivo';
    declare
      l_valores_faltantes varchar2(1000);
    begin
      l_valores_faltantes := substr(k_json_util.f_contiene_valores(l_parametros_automaticos,
                                                                   i_parametros_adicionales),
                                    1,
                                    1000);
      if nvl(l_valores_faltantes, 'OK') <> 'OK' then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      'Faltan parámetros adicionales: ' ||
                                      l_valores_faltantes);
        raise k_operacion.ex_error_parametro;
      end if;
    end;
  
    l_rsp.lugar := 'Armando parámetros adicionales de la importación de archivo';
    declare
      -- tu JSON adicional
      l_json_obj json_object_t := json_object_t.parse(nvl(i_parametros_adicionales,
                                                          '{}'));
      l_claves   json_key_list := l_json_obj.get_keys;
      l_valor    varchar2(4000);
    begin
      for i in 1 .. l_claves.count loop
        l_campos_extras    := l_campos_extras || ', ';
        l_variables_extras := l_variables_extras || ', ';
      
        l_campos_extras := l_campos_extras || l_claves(i);
        l_valor         := l_json_obj.get_string(l_claves(i));
      
        if l_json_obj.has(l_claves(i)) then
          l_valor := l_json_obj.get_string(l_claves(i));
        else
          l_valor := null;
        end if;
      
        if l_valor is null then
          -- Valor NULL
          l_variables_extras := l_variables_extras || 'null';
        elsif k_util.f_es_valor_numerico(l_valor) then
          -- Valor numérico
          l_variables_extras := l_variables_extras || l_valor;
        elsif regexp_like(l_valor, '^\d{4}-\d{2}-\d{2}$') then
          -- Formato ISO (YYYY-MM-DD)
          l_variables_extras := l_variables_extras || 'to_date(''' ||
                                l_valor || ''',''YYYY-MM-DD'')';
        
        elsif regexp_like(l_valor, '^\d{2}/\d{2}/\d{4}$') then
          -- Formato latino (DD/MM/YYYY)
          l_variables_extras := l_variables_extras || 'to_date(''' ||
                                l_valor || ''',''DD/MM/YYYY'')';
        else
          -- Texto genérico
          l_variables_extras := l_variables_extras || '''' ||
                                replace(l_valor, '''', '''''') || '''';
        end if;
      end loop;
    end;
  
    l_rsp.lugar := 'Preparando variables de importación de archivo';
    for c in c_parametros(i_id_importacion, l_version_importacion) loop
      l_contador := l_contador + 1;
    
      if c.activo = 'S' then
      
        if l_variable1 is null then
          l_variable1 := lower(c.nombre);
        end if;
      
        l_variables := l_variables || case
                         when l_variables is not null then
                          ','
                       end || lower(c.nombre);
      
        l_columnas := l_columnas || case
                        when l_columnas is not null then
                         ',' || chr(10)
                      end || '             ' ||
                      replace(nvl(lower(c.mapeador), ':variable'),
                              ':variable',
                              't.column' || l_contador) || ' ' || lower(c.nombre);
      end if;
    
      l_columnas_lobs := l_columnas_lobs || case
                           when l_columnas_lobs is not null then
                            ',' || chr(10) ||
                            '                                                     '
                         end || 'lob_column(' || c.posicion_inicial || ', ' ||
                         c.longitud || ')';
    end loop;
  
    l_rsp.lugar := 'Preparando bloques de sentencia de importación de archivo';
    begin
      l_declaracion_tipos := k_cadena.f_formatear_cadena(l_variables,
                                                         '      TYPE t_#_tab IS TABLE OF ' ||
                                                         lower(l_nombre_tabla) ||
                                                         '.#%TYPE;',
                                                         chr(10));
    
      l_declaracion_variables := k_cadena.f_formatear_cadena(l_variables,
                                                             '      l_# t_#_tab;',
                                                             chr(10));
    
      l_campos_simples := k_cadena.f_formatear_cadena(l_variables,
                                                      '#',
                                                      ', ');
    
      l_variables_indexadas := k_cadena.f_formatear_cadena(l_variables,
                                                           'l_#(i)',
                                                           ', ');
    
      l_variables_simples := k_cadena.f_formatear_cadena(l_variables,
                                                         'l_#',
                                                         ', ');
    end;
  
    if l_separador_campos is null then
      l_rsp.lugar          := 'Definiendo función de importación de archivo con campos fijos';
      l_funcion            := 'fixedcolumns';
      l_parametros_funcion := q'[                          lob_columns( :columnas_lobs: )]';
    else
      l_rsp.lugar          := 'Definiendo función de importación de archivo con campos separados por caracter';
      l_funcion            := 'separatedcolumns';
      l_parametros_funcion := q'[                          ',',     /* separador de campos */
                          null,    /* juego de caracteres (optional) */
                          '"'      /* delimitador (optional) */]';
    end if;
  
    l_rsp.lugar := 'Inicializando sentencia de importación de archivo (etiquetada)';
    l_sentencia := q'[
    DECLARE
:declaracion_tipos:

:declaracion_variables:

      v_ok     NUMBER := 0;
      v_err    NUMBER := 0;
      v_errmsg JSON_ARRAY_T := JSON_ARRAY_T();

    BEGIN
      -- Cargar datos del origen
      SELECT --t.row_no,
             -- Campos del archivo
:columnas:
             --
      BULK COLLECT INTO :variables_simples:
      FROM TABLE(lob2table.:funcion:(:in_archivo,
                          chr(10), /* separador de registros */
:parametros_funcion: )) t;

      BEGIN
          FORALL i IN :linea_inicial: .. l_:variable1:.LAST SAVE EXCEPTIONS
            INSERT INTO :nombre_tabla: (:campos_simples::campos_extras:)
            VALUES (:variables_indexadas::variables_extras:);

          v_ok := SQL%ROWCOUNT;

      EXCEPTION
        WHEN OTHERS THEN
          v_err := SQL%BULK_EXCEPTIONS.COUNT;
          v_ok  := l_:variable1:.COUNT - v_err - (:linea_inicial: - 1);

          DECLARE
            v_json_array JSON_ARRAY_T := JSON_ARRAY_T();
            v_json_obj   JSON_OBJECT_T;
          BEGIN
            FOR j IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
              v_json_obj := JSON_OBJECT_T();
              v_json_obj.put('id', SQL%BULK_EXCEPTIONS(j).ERROR_INDEX + (:linea_inicial: - 1));
              v_json_obj.put('codigo', SQL%BULK_EXCEPTIONS(j).ERROR_CODE);
              v_json_obj.put('mensaje', SQLERRM(-SQL%BULK_EXCEPTIONS(j).ERROR_CODE));
              v_json_array.append(v_json_obj);
            END LOOP;
            v_errmsg := v_json_array;
          END;
      END;

      -- Pasar resultados al exterior
      :out_rows_ok     := v_ok;
      :out_rows_err    := v_err;
      :out_detail_errs := v_errmsg;
    END;
  ]';
  
    l_rsp.lugar := 'Reemplazando etiquetas de sentencia de importación de archivo';
    begin
      l_sentencia := k_cadena.f_reemplazar_etiquetas(i_cadena       => l_sentencia,
                                                     i_etiquetas    => y_cadenas('funcion',
                                                                                 'parametros_funcion',
                                                                                 'declaracion_tipos',
                                                                                 'declaracion_variables',
                                                                                 'campos_simples',
                                                                                 'variables_simples',
                                                                                 'variables_indexadas',
                                                                                 'campos_extras',
                                                                                 'variables_extras',
                                                                                 'variable1',
                                                                                 'linea_inicial',
                                                                                 'nombre_tabla',
                                                                                 'columnas',
                                                                                 'columnas_lobs'),
                                                     i_valores      => y_cadenas(l_funcion,
                                                                                 l_parametros_funcion,
                                                                                 l_declaracion_tipos,
                                                                                 l_declaracion_variables,
                                                                                 l_campos_simples,
                                                                                 l_variables_simples,
                                                                                 l_variables_indexadas,
                                                                                 l_campos_extras,
                                                                                 l_variables_extras,
                                                                                 l_variable1,
                                                                                 l_linea_inicial,
                                                                                 l_nombre_tabla,
                                                                                 l_columnas,
                                                                                 l_columnas_lobs),
                                                     i_encapsulador => ':');
    end;
  
    l_rsp.lugar := 'Ejecutando sentencia de importación de archivo';
    dbms_output.put_line(l_sentencia);
    execute immediate l_sentencia
      using in i_archivo, out l_registros_ok, out l_registros_error, out l_detalle_errores;
  
    l_rsp.lugar := 'Imprimiendo resultados de importación de archivo';
    dbms_output.put_line('Filas insertadas   : ' || l_registros_ok);
    dbms_output.put_line('Filas con error    : ' || l_registros_error);
    dbms_output.put_line('Detalle de errores :' || chr(10) ||
                         l_detalle_errores.to_clob);
  
    if l_registros_error > 0 then
      rollback to savepoint inicio_importacion_sin_commit;
      l_rsp.lugar := null;
    
      declare
        l_errores_clob    clob := l_detalle_errores.to_clob;
        l_resumen_errores varchar2(4000);
        --
        l_elementos y_datos := new y_datos();
        l_elemento  y_dato := new y_dato();
      begin
        select listagg(id, ', ') within group(order by id)
          into l_resumen_errores
          from json_table(l_errores_clob,
                          '$[*]' columns(id number path '$.id'));
      
        l_elemento      := new y_dato();
        l_elemento.json := l_errores_clob;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      k_error.f_mensaje_error(k_importacion.c_error_general_importacion,
                                                              l_resumen_errores),
                                      dbms_utility.format_error_stack,
                                      l_elemento);
        raise k_operacion.ex_error_general;
      end;
    
    end if;
  
    l_rsp.lugar      := null;
    l_rsp.mensaje_bd := 'Filas insertadas : ' || l_registros_ok;
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

  function f_procesar_importacion_autonoma(i_id_importacion         in number,
                                           i_archivo                in blob,
                                           i_parametros_adicionales in varchar2 default null,
                                           i_version                in varchar2 default null)
    return y_respuesta is
    pragma autonomous_transaction;
    l_rsp y_respuesta;
  begin
    -- Procesa importación
    l_rsp := f_procesar_importacion_local(i_id_importacion,
                                          i_archivo,
                                          i_parametros_adicionales,
                                          i_version);
    --
    if l_rsp.codigo = k_operacion.c_ok then
      commit;
    else
      rollback;
    end if;
    --
    return l_rsp;
  end;

  function f_procesar_importacion(i_id_importacion         in number,
                                  i_archivo                in blob,
                                  i_parametros_adicionales in varchar2 default null,
                                  i_transaccion_autonoma   in boolean,
                                  i_version                in varchar2 default null)
    return clob is
    l_rsp y_respuesta;
  begin
    -- Procesa importación
    if nvl(i_transaccion_autonoma, false) then
      l_rsp := f_procesar_importacion_autonoma(i_id_importacion,
                                               i_archivo,
                                               i_parametros_adicionales,
                                               i_version);
    else
      l_rsp := f_procesar_importacion_local(i_id_importacion,
                                            i_archivo,
                                            i_parametros_adicionales,
                                            i_version);
    end if;
    --
    return l_rsp.to_json;
  end;

  function f_procesar_importacion(i_nombre                 in varchar2,
                                  i_dominio                in varchar2,
                                  i_archivo                in blob,
                                  i_parametros_adicionales in varchar2 default null,
                                  i_transaccion_autonoma   in boolean default false,
                                  i_version                in varchar2 default null)
    return clob is
    l_rsp            y_respuesta;
    l_id_importacion t_importaciones.id_importacion%type;
  begin
    -- Busca importación
    l_id_importacion := k_operacion.f_id_operacion(k_operacion.c_tipo_importacion,
                                                   i_nombre,
                                                   i_dominio);
    -- Procesa importación
    if nvl(i_transaccion_autonoma, false) then
      l_rsp := f_procesar_importacion_autonoma(l_id_importacion,
                                               i_archivo,
                                               i_parametros_adicionales,
                                               i_version);
    else
      l_rsp := f_procesar_importacion_local(l_id_importacion,
                                            i_archivo,
                                            i_parametros_adicionales,
                                            i_version);
    end if;
    --
    return l_rsp.to_json;
  end;

end;
/
