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
    k_sistema.p_definir_parametro_string(k_operacion.c_sql_ejecucion,
                                         i_sql);
  
    update t_servicios
       set sql_ultima_ejecucion = i_sql
     where id_servicio = i_id_servicio;
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_crear_servicio(i_nombre                         in t_operaciones.nombre%type,
                             i_dominio                        in t_operaciones.dominio%type,
                             i_tipo                           in t_servicios.tipo%type default c_tipo_servicio_web,
                             i_version_actual                 in t_operaciones.version_actual%type default '0.1.0',
                             i_tipo_implementacion            in t_operaciones.tipo_implementacion%type default k_operacion.c_tipo_implementacion_paquete,
                             i_nombre_programa_implementacion in t_operaciones.nombre_programa_implementacion%type default null,
                             i_detalle                        in t_operaciones.detalle%type default null,
                             i_parametros_automaticos         in t_operaciones.parametros_automaticos%type default null,
                             i_aplicaciones_permitidas        in t_operaciones.aplicaciones_permitidas%type default null,
                             i_consulta_sql                   in t_servicios.consulta_sql%type default null) is
    l_id_operacion t_operaciones.id_operacion%type;
  begin
    insert into t_operaciones
      (tipo,
       nombre,
       dominio,
       activo,
       detalle,
       version_actual,
       nivel_log,
       parametros_automaticos,
       tipo_implementacion,
       aplicaciones_permitidas,
       nombre_programa_implementacion)
    values
      (k_operacion.c_tipo_servicio,
       i_nombre,
       i_dominio,
       'S',
       i_detalle,
       nvl(i_version_actual, '0.1.0'),
       1,
       i_parametros_automaticos,
       nvl(i_tipo_implementacion, k_operacion.c_tipo_implementacion_paquete),
       i_aplicaciones_permitidas,
       i_nombre_programa_implementacion)
    returning id_operacion into l_id_operacion;
  
    insert into t_servicios
      (id_servicio, tipo, consulta_sql)
    values
      (l_id_operacion, nvl(i_tipo, c_tipo_servicio_web), i_consulta_sql);
  end;

  procedure p_limpiar_historial is
  begin
    update t_servicios
       set cantidad_ejecuciones   = null,
           fecha_ultima_ejecucion = null,
           sql_ultima_ejecucion   = null;
  end;

  function f_tipo_servicio(i_id_servicio in number) return varchar2 is
    l_tipo t_servicios.tipo%type;
  begin
    select s.tipo
      into l_tipo
      from t_servicios s, t_operaciones o
     where o.id_operacion = s.id_servicio
       and o.activo = 'S'
       and s.id_servicio = i_id_servicio;
  
    return l_tipo;
  exception
    when others then
      return null;
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

  function f_servicio_sql(i_id_servicio    in number,
                          i_parametros     in y_parametros,
                          i_registro_unico in boolean default false)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_dato := new y_dato();
  
    l_nombre_servicio   t_operaciones.nombre%type;
    l_dominio_servicio  t_operaciones.dominio%type;
    l_consulta_sql      t_servicios.consulta_sql%type;
    l_consulta_final    clob;
    l_filtros_resultado clob;
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
  
    -- Verificar si la consulta tiene parámetros dinámicos
    l_rsp.lugar := 'Procesando parámetros y consulta';
  
    -- Verificar si existen parámetros dinámicos en la consulta
    declare
      l_tiene_parametros_dinamicos boolean := false;
    begin
      if i_parametros is not null then
        declare
          i integer;
        begin
          i := i_parametros.first;
          while i is not null loop
            if i_parametros(i).nombre is not null and
                instr(upper(l_consulta_sql),
                      ':' || upper(i_parametros(i).nombre)) > 0 then
              l_tiene_parametros_dinamicos := true;
              exit; -- Salir del loop si encontramos al menos uno
            end if;
            i := i_parametros.next(i);
          end loop;
        end;
      end if;
    
      if l_tiene_parametros_dinamicos then
        -- CASO 1: Hay parámetros dinámicos - reemplazar directamente
        l_consulta_final := k_operacion.f_filtros_sql_dinamico(i_parametros,
                                                               l_consulta_sql);
        -- Envolver en SELECT * FROM () para mantener consistencia
        l_consulta_final := 'SELECT * FROM (' || l_consulta_final || ')';
      else
        -- CASO 2: No hay parámetros dinámicos - usar método tradicional
        l_consulta_final := 'SELECT * FROM (' || l_consulta_sql || ')' ||
                            k_operacion.f_filtros_sql(i_parametros);
      end if;
    end;
  
    -- Registra SQL
    lp_registrar_sql_ejecucion(i_id_servicio, l_consulta_final);
  
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
      dbms_sql.parse(l_cursor, l_consulta_final, dbms_sql.native);
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
        exit when i_registro_unico;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      end loop;
    
      dbms_sql.close_cursor(l_cursor);
    end;
    -- ========================================================
  
    if i_registro_unico then
      k_operacion.p_respuesta_ok(l_rsp, l_elemento);
    else
      l_pagina := f_paginar_elementos(l_elementos,
                                      f_pagina_parametros(i_parametros));
    
      k_operacion.p_respuesta_ok(l_rsp, l_pagina);
    end if;
  
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

  function lf_procesar_servicio_principal(i_id_servicio in number,
                                          i_parametros  in clob,
                                          i_contexto    in clob default null,
                                          i_version     in varchar2 default null)
    return y_respuesta is
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
    k_sistema.p_definir_parametro_string(k_sistema.cg_contexto, i_contexto);
  
    l_rsp.lugar := 'Validando permiso por aplicación';
    if k_sistema.f_id_aplicacion is not null and
       k_util.f_valor_parametro('VALIDACION_PERMISO_APLICACION') = 'S' then
      if not k_operacion.f_validar_permiso_aplicacion(k_sistema.f_id_aplicacion,
                                                      i_id_servicio) then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_permiso,
                                      k_error.f_mensaje_error(k_operacion.c_error_permiso),
                                      console.format('id_aplicacion=[%s], id_operacion=[%s]',
                                                     k_sistema.f_id_aplicacion,
                                                     i_id_servicio));
        raise k_operacion.ex_error_general;
      end if;
    end if;
  
    l_rsp.lugar := 'Validando permiso por usuario';
    if k_sistema.f_id_usuario is not null and
       k_util.f_valor_parametro('VALIDACION_PERMISO_USUARIO') = 'S' then
      if not
          k_autorizacion.f_validar_permiso(k_sistema.f_id_usuario,
                                           k_operacion.f_id_permiso(i_id_servicio),
                                           null,
                                           k_sistema.f_id_entidad,
                                           k_entidad.f_grupo_usuario(k_sistema.f_id_entidad,
                                                                     k_sistema.f_id_usuario)) then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_permiso,
                                      k_error.f_mensaje_error(k_operacion.c_error_permiso),
                                      console.format('id_permiso=[%s], id_usuario=[%s], id_entidad=[%s], grupo=[%s]',
                                                     k_operacion.f_id_permiso(i_id_servicio),
                                                     k_sistema.f_id_usuario,
                                                     k_sistema.f_id_entidad,
                                                     k_entidad.f_grupo_usuario(k_sistema.f_id_entidad,
                                                                               k_sistema.f_id_usuario)));
        raise k_operacion.ex_error_general;
      end if;
    end if;
  
    if l_tipo_servicio = c_tipo_consulta then
      -- CONSULTA
      l_rsp := f_servicio_sql(i_id_servicio, l_prms);
    
    elsif l_tipo_servicio = c_tipo_consulta_unica then
      -- CONSULTA ÚNICA
      l_rsp := f_servicio_sql(i_id_servicio, l_prms, true);
    
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
        if k_operacion.f_tipo_argumento_parametros(i_id_servicio, i_version) =
           'Y_LISTA_PARAMETROS' then
          execute immediate l_sentencia
            using out l_rsp, in new y_lista_parametros(i_parametros => l_prms);
        else
          execute immediate l_sentencia
            using out l_rsp, in l_prms;
        end if;
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
  
    if l_rsp.codigo <> k_operacion.c_ok then
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_rsp.datos);
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

  function f_procesar_servicio_principal(i_id_servicio       in number,
                                         i_parametros        in clob,
                                         i_contexto          in clob default null,
                                         i_version           in varchar2 default null,
                                         i_eliminar_contexto in boolean default false)
    return y_respuesta is
    l_rsp    y_respuesta;
    l_id_log t_operacion_logs.id_operacion_log%type;
  begin
    -- Inicializa parámetros de la sesión
    k_sistema.p_inicializar_parametros;
    -- Configura modificación (control de auditoría)
    k_sistema.p_configurar_modificacion(pin_aplicacion => k_operacion.c_aplicacion_servicio);
    -- Registra ejecución
    lp_registrar_ejecucion(i_id_servicio);
    -- Registra log con datos de entrada
    k_operacion.p_registrar_log(l_id_log,
                                i_id_servicio,
                                i_parametros,
                                null,
                                null,
                                i_contexto,
                                i_version);
    -- Procesa servicio
    l_rsp := lf_procesar_servicio_principal(i_id_servicio,
                                            i_parametros,
                                            i_contexto,
                                            i_version);
    --
    l_rsp.mensaje := replace(l_rsp.mensaje,
                             k_operacion.c_id_log,
                             to_char(l_id_log));
    -- Registra log con datos de entrada y salida
    k_operacion.p_registrar_log(l_id_log,
                                i_id_servicio,
                                i_parametros,
                                l_rsp.codigo,
                                l_rsp.to_json,
                                i_contexto,
                                i_version);
    -- Elimina parámetros de la sesión
    if i_eliminar_contexto then
      k_sistema.p_eliminar_parametros;
    end if;
    --
    return l_rsp;
  end;

  function f_procesar_servicio(i_id_servicio in number,
                               i_parametros  in clob,
                               i_contexto    in clob default null,
                               i_version     in varchar2 default null)
    return clob is
    pragma autonomous_transaction;
    l_rsp y_respuesta;
  begin
    -- Procesa servicio
    l_rsp := f_procesar_servicio_principal(i_id_servicio,
                                           i_parametros,
                                           i_contexto,
                                           i_version,
                                           true);
    --
    if l_rsp.codigo = k_operacion.c_ok then
      commit;
    else
      rollback;
    end if;
    --
    return l_rsp.to_json;
  end;

  function f_procesar_servicio(i_nombre     in varchar2,
                               i_dominio    in varchar2,
                               i_parametros in clob,
                               i_contexto   in clob default null,
                               i_version    in varchar2 default null)
    return clob is
    pragma autonomous_transaction;
    l_rsp         y_respuesta;
    l_id_servicio t_servicios.id_servicio%type;
  begin
    -- Busca servicio
    l_id_servicio := k_operacion.f_id_operacion(k_operacion.c_tipo_servicio,
                                                i_nombre,
                                                i_dominio);
    -- Procesa servicio
    l_rsp := f_procesar_servicio_principal(l_id_servicio,
                                           i_parametros,
                                           i_contexto,
                                           i_version,
                                           true);
    --
    if l_rsp.codigo = k_operacion.c_ok then
      commit;
    else
      rollback;
    end if;
    --
    return l_rsp.to_json;
  end;

end;
/
