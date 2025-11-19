create or replace package body k_servicio is

  procedure lp_registrar_ejecucion(i_id_servicio in number) is
    pragma autonomous_transaction;
  begin
    update t_servicios
       set cantidad_ejecuciones   = nvl(cantidad_ejecuciones, 0) + 1,
           fecha_ultima_ejecucion = sysdate
     where id_servicio = i_id_servicio;
    commit;
  exception
    when others then
      rollback;
  end;

  procedure lp_registrar_sql_ejecucion(i_id_servicio in number,
                                       i_sql         in clob) is
    pragma autonomous_transaction;
  begin
    update t_servicios
       set sql_ultima_ejecucion = i_sql
     where id_servicio = i_id_servicio;
    commit;
  exception
    when others then
      rollback;
  end;

  function lf_procesar_servicio(i_id_servicio in number,
                                i_parametros  in clob,
                                i_contexto    in clob default null,
                                i_version     in varchar2 default null)
    return y_respuesta is
    pragma autonomous_transaction;
    l_rsp                 y_respuesta;
    l_prms                y_parametros;
    l_ctx                 y_parametros;
    l_nombre_servicio     t_operaciones.nombre%type;
    l_tipo_implementacion t_operaciones.tipo_implementacion%type;
    l_tipo_servicio       t_servicios.tipo%type;
    l_consulta_sql        t_servicios.consulta_sql%type;
    l_sentencia           clob;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Buscando datos del servicio';
    begin
      select upper(o.nombre), o.tipo_implementacion, s.tipo, s.consulta_sql
        into l_nombre_servicio,
             l_tipo_implementacion,
             l_tipo_servicio,
             l_consulta_sql
        from t_servicios s, t_operaciones o
       where o.id_operacion = s.id_servicio
         and o.activo = 'S'
         and s.id_servicio = i_id_servicio;
    exception
      when no_data_found then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_servicio_no_implementado,
                                      'Servicio inexistente o inactivo');
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Procesando parámetros del servicio';
    begin
      l_prms := k_operacion.f_procesar_parametros(i_id_servicio,
                                                  i_parametros,
                                                  i_version);
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_parametro,
                                      case
                                      k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                      k_error.c_user_defined_error then
                                      utl_call_stack.error_msg(1) when
                                      k_error.c_oracle_predefined_error then
                                      k_error.f_mensaje_error(k_operacion.c_error_parametro) end,
                                      dbms_utility.format_error_stack);
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Procesando contexto';
    begin
      l_ctx := k_operacion.f_procesar_parametros(k_operacion.c_id_operacion_contexto,
                                                 i_contexto);
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_parametro,
                                      case
                                      k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                      k_error.c_user_defined_error then
                                      utl_call_stack.error_msg(1) when
                                      k_error.c_oracle_predefined_error then
                                      k_error.f_mensaje_error(k_operacion.c_error_parametro) end,
                                      dbms_utility.format_error_stack);
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Definiendo parámetros en la sesión';
    k_operacion.p_definir_parametros(i_id_servicio, l_ctx);
  
    l_rsp.lugar := 'Validando permiso por aplicación';
    if k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion) is not null then
      if not k_operacion.f_validar_permiso_aplicacion(k_sistema.f_valor_parametro_string(k_sistema.c_id_aplicacion),
                                                      i_id_servicio) then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_permiso,
                                      k_error.f_mensaje_error(k_operacion.c_error_permiso));
        raise k_operacion.ex_error_general;
      end if;
    end if;
  
    l_rsp.lugar := 'Validando permiso por usuario';
    if k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario) is not null then
      if not
          k_autorizacion.f_validar_permiso(k_sistema.f_valor_parametro_number(k_sistema.c_id_usuario),
                                           k_operacion.f_id_permiso(i_id_servicio)) then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_permiso,
                                      k_error.f_mensaje_error(k_operacion.c_error_permiso));
        raise k_operacion.ex_error_general;
      end if;
    end if;
  
    if l_tipo_servicio = 'C' then
      -- CONSULTA
      l_rsp := f_servicio_sql(i_id_servicio, l_prms);
    
    else
      l_rsp.lugar := 'Construyendo sentencia';
      if l_tipo_implementacion in
         (k_operacion.c_tipo_implementacion_paquete,
          k_operacion.c_tipo_implementacion_funcion) then
        l_sentencia := 'BEGIN :1 := ' ||
                       k_operacion.f_nombre_programa(i_id_servicio,
                                                     i_version) ||
                       '(:2); END;';
      elsif l_tipo_implementacion =
            k_operacion.c_tipo_implementacion_bloque then
        l_sentencia := 'DECLARE ' || l_consulta_sql || ' BEGIN :1 := ' ||
                       k_operacion.f_nombre_programa(i_id_servicio,
                                                     i_version) ||
                       '(:2); END;';
      end if;
    
      -- Registra SQL
      lp_registrar_sql_ejecucion(i_id_servicio, l_sentencia);
    
      l_rsp.lugar := 'Procesando servicio';
      begin
        execute immediate l_sentencia
          using out l_rsp, in l_prms;
      exception
        when k_operacion.ex_servicio_no_implementado then
          k_operacion.p_respuesta_error(l_rsp,
                                        k_operacion.c_servicio_no_implementado,
                                        'Servicio no implementado',
                                        dbms_utility.format_error_stack);
          raise k_operacion.ex_error_general;
        when others then
          k_operacion.p_respuesta_error(l_rsp,
                                        k_operacion.c_error_general,
                                        case
                                        k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                        k_error.c_user_defined_error then
                                        utl_call_stack.error_msg(1) when
                                        k_error.c_oracle_predefined_error then
                                        'Error al procesar servicio' end,
                                        dbms_utility.format_error_stack);
          raise k_operacion.ex_error_general;
      end;
    
    end if;
  
    if l_rsp.codigo = k_operacion.c_ok then
      commit;
    else
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_rsp.datos);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      rollback;
      return l_rsp;
    when others then
      rollback;
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  procedure p_limpiar_historial is
  begin
    update t_servicios
       set cantidad_ejecuciones   = null,
           fecha_ultima_ejecucion = null,
           sql_ultima_ejecucion   = null;
  end;

  function f_pagina_parametros(i_parametros in y_parametros)
    return y_pagina_parametros is
  begin
    return nvl(treat(k_operacion.f_valor_parametro_object(i_parametros,
                                                          'pagina_parametros') as
                     y_pagina_parametros),
               new y_pagina_parametros());
  exception
    when others then
      return new y_pagina_parametros();
  end;

  function f_paginar_elementos(i_elementos           in y_objetos,
                               i_numero_pagina       in integer default null,
                               i_cantidad_por_pagina in integer default null,
                               i_no_paginar          in varchar2 default null)
    return y_pagina is
    l_pagina              y_pagina;
    l_objetos             y_objetos;
    l_numero_pagina       integer;
    l_cantidad_por_pagina integer;
    l_rango_i             integer;
    l_rango_j             integer;
    l_no_paginar          boolean;
  begin
    -- Inicializa respuesta
    l_pagina                    := new y_pagina();
    l_pagina.numero_actual      := 0;
    l_pagina.numero_siguiente   := 0;
    l_pagina.numero_ultima      := 0;
    l_pagina.numero_primera     := 0;
    l_pagina.numero_anterior    := 0;
    l_pagina.cantidad_elementos := 0;
  
    l_no_paginar := nvl(i_no_paginar, 'N') = 'S';
  
    -- Carga la cantidad total de elementos
    l_pagina.cantidad_elementos := i_elementos.count;
    --
  
    -- Valida parámetro de cantidad por página
    if l_no_paginar then
      l_cantidad_por_pagina := l_pagina.cantidad_elementos;
    else
      l_cantidad_por_pagina := nvl(i_cantidad_por_pagina,
                                   to_number(k_util.f_valor_parametro('PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA')));
    end if;
  
    if l_cantidad_por_pagina <= 0 then
      l_cantidad_por_pagina := to_number(k_util.f_valor_parametro('PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA'));
    end if;
  
    if not l_no_paginar and
       l_cantidad_por_pagina >
       to_number(k_util.f_valor_parametro('PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA')) then
      l_cantidad_por_pagina := to_number(k_util.f_valor_parametro('PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA'));
    end if;
    --
  
    -- Calcula primera página y última página
    l_pagina.numero_ultima := ceil(l_pagina.cantidad_elementos /
                                   l_cantidad_por_pagina);
  
    if l_pagina.numero_ultima > 0 then
      l_pagina.numero_primera := 1;
    end if;
    --
  
    -- Valida parámetro de número de página
    l_numero_pagina := nvl(i_numero_pagina, 1);
  
    if l_numero_pagina < l_pagina.numero_primera then
      l_numero_pagina := l_pagina.numero_primera;
    end if;
  
    if l_numero_pagina > l_pagina.numero_ultima then
      l_numero_pagina := l_pagina.numero_ultima;
    end if;
    --
  
    -- Carga página actual
    l_pagina.numero_actual := l_numero_pagina;
    --
  
    -- Calcula página anterior y página siguiente
    l_pagina.numero_anterior  := l_pagina.numero_actual - 1;
    l_pagina.numero_siguiente := l_pagina.numero_actual + 1;
  
    if l_pagina.numero_anterior < l_pagina.numero_primera then
      l_pagina.numero_anterior := l_pagina.numero_primera;
    end if;
  
    if l_pagina.numero_siguiente > l_pagina.numero_ultima then
      l_pagina.numero_siguiente := l_pagina.numero_ultima;
    end if;
    --
  
    -- Calcula el rango de elementos
    l_rango_i := ((l_pagina.numero_actual - 1) * l_cantidad_por_pagina) + 1;
    l_rango_j := l_pagina.numero_actual * l_cantidad_por_pagina;
  
    if l_rango_i < 0 then
      l_rango_i := 0;
    end if;
  
    if l_rango_j > l_pagina.cantidad_elementos then
      l_rango_j := l_pagina.cantidad_elementos;
    end if;
    --
  
    -- Carga elementos dentro del rango
    l_objetos := new y_objetos();
    if l_pagina.cantidad_elementos > 0 then
      for i in l_rango_i .. l_rango_j loop
        l_objetos.extend;
        l_objetos(l_objetos.count) := i_elementos(i);
      end loop;
    end if;
    l_pagina.elementos := l_objetos;
    --
  
    return l_pagina;
  end;

  function f_paginar_elementos(i_elementos         in y_objetos,
                               i_pagina_parametros in y_pagina_parametros)
    return y_pagina is
  begin
    return f_paginar_elementos(i_elementos,
                               i_pagina_parametros.pagina,
                               i_pagina_parametros.por_pagina,
                               i_pagina_parametros.no_paginar);
  end;

  function f_servicio_sql(i_id_servicio in number,
                          i_parametros  in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_dato;
  
    l_nombre_servicio  t_operaciones.nombre%type;
    l_dominio_servicio t_operaciones.dominio%type;
    l_consulta_sql     t_servicios.consulta_sql%type;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    l_rsp.lugar := 'Buscando datos del servicio';
    begin
      select upper(o.nombre), upper(o.dominio), s.consulta_sql
        into l_nombre_servicio, l_dominio_servicio, l_consulta_sql
        from t_servicios s, t_operaciones o
       where o.id_operacion = s.id_servicio
         and o.activo = 'S'
         and s.id_servicio = i_id_servicio;
    exception
      when no_data_found then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_parametro,
                                      'Servicio inexistente o inactivo');
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Validando parametros';
    if l_consulta_sql is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    k_operacion.c_error_general,
                                    'Consulta SQL no definida');
      raise k_operacion.ex_error_parametro;
    end if;
  
    l_consulta_sql := 'SELECT * FROM (' || l_consulta_sql || ')' ||
                      k_operacion.f_filtros_sql(i_parametros);
    -- Registra SQL
    lp_registrar_sql_ejecucion(i_id_servicio, l_consulta_sql);
  
    -- ========================================================
    declare
      l_cursor   pls_integer;
      l_row_cnt  pls_integer;
      l_col_cnt  pls_integer;
      l_desc_tab dbms_sql.desc_tab2;
      --
      l_buffer_varchar2  varchar2(32767);
      l_buffer_number    number;
      l_buffer_date      date;
      l_buffer_timestamp timestamp;
      --
      l_json_object json_object_t;
    begin
      l_cursor := dbms_sql.open_cursor;
      dbms_sql.parse(l_cursor, l_consulta_sql, dbms_sql.native);
      dbms_sql.describe_columns2(l_cursor, l_col_cnt, l_desc_tab);
    
      for i in 1 .. l_col_cnt loop
        if l_desc_tab(i).col_type in (dbms_types.typecode_varchar,
                         dbms_types.typecode_varchar2,
                         dbms_types.typecode_char,
                         dbms_types.typecode_clob,
                         dbms_types.typecode_nvarchar2,
                         dbms_types.typecode_nchar,
                         dbms_types.typecode_nclob) then
          dbms_sql.define_column(l_cursor, i, l_buffer_varchar2, 32767);
        elsif l_desc_tab(i).col_type in (dbms_types.typecode_number) then
          dbms_sql.define_column(l_cursor, i, l_buffer_number);
        elsif l_desc_tab(i).col_type in (dbms_types.typecode_date) then
          dbms_sql.define_column(l_cursor, i, l_buffer_date);
        elsif l_desc_tab(i).col_type in (dbms_types.typecode_timestamp) then
          dbms_sql.define_column(l_cursor, i, l_buffer_timestamp);
        end if;
      end loop;
    
      l_row_cnt := dbms_sql.execute(l_cursor);
    
      loop
        exit when dbms_sql.fetch_rows(l_cursor) = 0;
      
        l_json_object := new json_object_t();
      
        for i in 1 .. l_col_cnt loop
          if l_desc_tab(i)
           .col_type in (dbms_types.typecode_varchar,
                           dbms_types.typecode_varchar2,
                           dbms_types.typecode_char,
                           dbms_types.typecode_clob,
                           dbms_types.typecode_nvarchar2,
                           dbms_types.typecode_nchar,
                           dbms_types.typecode_nclob) then
            dbms_sql.column_value(l_cursor, i, l_buffer_varchar2);
            l_json_object.put(lower(l_desc_tab(i).col_name),
                              l_buffer_varchar2);
          elsif l_desc_tab(i).col_type in (dbms_types.typecode_number) then
            dbms_sql.column_value(l_cursor, i, l_buffer_number);
            l_json_object.put(lower(l_desc_tab(i).col_name),
                              l_buffer_number);
          elsif l_desc_tab(i).col_type in (dbms_types.typecode_date) then
            dbms_sql.column_value(l_cursor, i, l_buffer_date);
            l_json_object.put(lower(l_desc_tab(i).col_name), l_buffer_date);
          elsif l_desc_tab(i).col_type in (dbms_types.typecode_timestamp) then
            dbms_sql.column_value(l_cursor, i, l_buffer_timestamp);
            l_json_object.put(lower(l_desc_tab(i).col_name),
                              l_buffer_timestamp);
          end if;
        end loop;
      
        l_elemento      := new y_dato();
        l_elemento.json := l_json_object.to_clob;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      end loop;
    
      dbms_sql.close_cursor(l_cursor);
    end;
    -- ========================================================
  
    l_pagina := f_paginar_elementos(l_elementos,
                                    f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
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

  function f_procesar_servicio(i_id_servicio in number,
                               i_parametros  in clob,
                               i_contexto    in clob default null,
                               i_version     in varchar2 default null)
    return clob is
    l_rsp y_respuesta;
  begin
    -- Inicializa parámetros de la sesión
    k_sistema.p_inicializar_parametros;
    -- Registra ejecución
    lp_registrar_ejecucion(i_id_servicio);
    -- Inicializa datos para log
    k_operacion.p_inicializar_log(i_id_servicio);
    -- Procesa servicio
    l_rsp := lf_procesar_servicio(i_id_servicio,
                                  i_parametros,
                                  i_contexto,
                                  i_version);
    -- Registra log con datos de entrada y salida
    k_operacion.p_registrar_log(i_id_servicio,
                                i_parametros,
                                l_rsp.codigo,
                                l_rsp.to_json,
                                i_contexto,
                                i_version);
    return l_rsp.to_json;
  end;

  function f_procesar_servicio(i_nombre     in varchar2,
                               i_dominio    in varchar2,
                               i_parametros in clob,
                               i_contexto   in clob default null,
                               i_version    in varchar2 default null)
    return clob is
    l_rsp         y_respuesta;
    l_id_servicio t_servicios.id_servicio%type;
  begin
    -- Inicializa parámetros de la sesión
    k_sistema.p_inicializar_parametros;
    -- Busca servicio
    l_id_servicio := k_operacion.f_id_operacion(k_operacion.c_tipo_servicio,
                                                i_nombre,
                                                i_dominio);
    -- Registra ejecución
    lp_registrar_ejecucion(l_id_servicio);
    -- Inicializa datos para log
    k_operacion.p_inicializar_log(l_id_servicio);
    -- Procesa servicio
    l_rsp := lf_procesar_servicio(l_id_servicio,
                                  i_parametros,
                                  i_contexto,
                                  i_version);
    -- Registra log con datos de entrada y salida
    k_operacion.p_registrar_log(l_id_servicio,
                                i_parametros,
                                l_rsp.codigo,
                                l_rsp.to_json,
                                i_contexto,
                                i_version);
    return l_rsp.to_json;
  end;

end;
/
