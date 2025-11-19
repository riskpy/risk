create or replace package body k_monitoreo is

  c_table_template constant varchar2(4000) := '<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:template match="/">
<table style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;" width="100%">
 <tr>
  <xsl:for-each select="/ROWSET/ROW[1]/*">
   <th style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left"><xsl:if test="name() != ''PRIORIDAD''"><xsl:value-of select="name()"/></xsl:if></th>
  </xsl:for-each>
 </tr>
 <xsl:for-each select="/ROWSET/*">
 <xsl:variable name="var_size" select="2" />
  <tr>
   <xsl:variable name="var_pos" select="position()" />
   <xsl:variable name="var_mod" select="$var_pos mod($var_size)" />
   <xsl:if test="$var_mod = 1"><xsl:attribute name="bgcolor">#dddddd</xsl:attribute><xsl:attribute name="style">background-color: #dddddd;</xsl:attribute></xsl:if>
   <xsl:for-each select="./PRIORIDAD">
    <xsl:if test="text() = 1"><td><xsl:attribute name="bgcolor">#ee0000</xsl:attribute><xsl:attribute name="style">background-color: #ee0000; padding: 0px; width: 1px;</xsl:attribute><xsl:attribute name="width">1</xsl:attribute></td></xsl:if>
    <xsl:if test="text() = 2"><td><xsl:attribute name="bgcolor">#ff9900</xsl:attribute><xsl:attribute name="style">background-color: #ff9900; padding: 0px; width: 1px;</xsl:attribute><xsl:attribute name="width">1</xsl:attribute></td></xsl:if>
    <xsl:if test="text() = 3"><td><xsl:attribute name="bgcolor">#ffeb03</xsl:attribute><xsl:attribute name="style">background-color: #ffeb03; padding: 0px; width: 1px;</xsl:attribute><xsl:attribute name="width">1</xsl:attribute></td></xsl:if>
    <xsl:if test="text() = 4"><td><xsl:attribute name="bgcolor">#7bd849</xsl:attribute><xsl:attribute name="style">background-color: #7bd849; padding: 0px; width: 1px;</xsl:attribute><xsl:attribute name="width">1</xsl:attribute></td></xsl:if>
    <xsl:if test="text() = 5"><td><xsl:attribute name="bgcolor">#009900</xsl:attribute><xsl:attribute name="style">background-color: #009900; padding: 0px; width: 1px;</xsl:attribute><xsl:attribute name="width">1</xsl:attribute></td></xsl:if>
   </xsl:for-each>
   <xsl:for-each select="./*">
    <xsl:if test="name() != ''PRIORIDAD''"><td style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left"><xsl:value-of select="text()"/></td></xsl:if>
   </xsl:for-each>
  </tr>
 </xsl:for-each>
</table>
  </xsl:template>
</xsl:stylesheet>';

  procedure lp_reservar_id_ejecucion is
  begin
    k_sistema.p_definir_parametro_number(c_id_ejecucion,
                                         s_id_monitoreo_ejecucion.nextval);
  exception
    when others then
      null;
  end;

  procedure lp_registrar_ejecucion(i_id_monitoreo in number,
                                   i_datos        in clob,
                                   i_conflicto    in boolean) is
    pragma autonomous_transaction;
    l_timestamp t_monitoreo_ejecuciones.fecha_ejecucion%type := current_timestamp;
  begin
    insert into t_monitoreo_ejecuciones
      (id_monitoreo_ejecucion, id_monitoreo, fecha_ejecucion, datos)
    values
      (k_sistema.f_valor_parametro_number(c_id_ejecucion),
       i_id_monitoreo,
       l_timestamp,
       i_datos);
  
    if i_conflicto then
      update t_monitoreos
         set cantidad_ejecuciones             = nvl(cantidad_ejecuciones, 0) + 1,
             fecha_ultima_ejecucion           = l_timestamp,
             cantidad_ejecuciones_conflicto   = nvl(cantidad_ejecuciones_conflicto,
                                                    0) + 1,
             fecha_ultima_ejecucion_conflicto = l_timestamp
       where id_monitoreo = i_id_monitoreo;
    else
      update t_monitoreos
         set cantidad_ejecuciones   = nvl(cantidad_ejecuciones, 0) + 1,
             fecha_ultima_ejecucion = l_timestamp
       where id_monitoreo = i_id_monitoreo;
    end if;
  
    commit;
  exception
    when others then
      dbms_output.put_line('Error: ' || sqlerrm);
      rollback;
  end;

  function lf_procesar_monitoreo(i_id_monitoreo    in number,
                                 i_version         in varchar2 default null,
                                 o_tiene_conflicto out boolean)
    return y_respuesta is
    pragma autonomous_transaction;
    l_rsp               y_respuesta;
    l_nombre_monitoreo  t_operaciones.nombre%type;
    l_dominio_monitoreo t_operaciones.dominio%type;
    l_version_actual    t_operaciones.version_actual%type;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Buscando datos del monitoreo';
    begin
      select upper(o.nombre), upper(o.dominio), o.version_actual
        into l_nombre_monitoreo, l_dominio_monitoreo, l_version_actual
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.id_monitoreo = i_id_monitoreo;
    exception
      when no_data_found then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_servicio_no_implementado,
                                      'Monitoreo inexistente o inactivo');
        raise k_operacion.ex_error_parametro;
    end;
  
    -- CONSULTA
    l_rsp := f_monitoreo_sql(i_id_monitoreo, i_version, o_tiene_conflicto);
  
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
    update t_monitoreos
       set cantidad_ejecuciones             = null,
           fecha_ultima_ejecucion           = null,
           cantidad_ejecuciones_conflicto   = null,
           fecha_ultima_ejecucion_conflicto = null;
  end;

  procedure p_aviso_resumido(i_id_ejecucion in number) is
    l_envia varchar2(1) := 'N';
    l_body  clob;
    l_tabla clob;
  
    l_query varchar2(2000) := 'WITH v_datos AS
 (SELECT d.id_monitoreo_ejecucion, d.id_monitoreo, d.mitigado
    FROM v_monitoreo_datos d, t_monitoreos m
   WHERE d.id_monitoreo = m.id_monitoreo
     AND m.nivel_aviso = 1
     AND d.id_monitoreo_ejecucion = &id_ejecucion
     AND d.cantidad_elementos > 0)
SELECT n.prioridad,
       m.id_monitoreo "Id",
       p.detalle "Descripcion",
       nvl(COUNT(m.mitigado), 0) "C.T.",
       SUM(CASE m.mitigado
             WHEN ''true'' THEN
              1
             ELSE
              0
           END) "C.M.",
       nvl(COUNT(m.mitigado), 0) - SUM(CASE m.mitigado
                                         WHEN ''true'' THEN
                                          1
                                         ELSE
                                          0
                                       END) "C.P."
  FROM v_datos m, t_monitoreos n, t_operaciones p
 WHERE m.id_monitoreo = n.id_monitoreo
   AND n.id_monitoreo = p.id_operacion
 GROUP BY n.prioridad, m.id_monitoreo, p.detalle, m.id_monitoreo_ejecucion';
  
  begin
    --Verifica si hay datos a enviar
    begin
      select decode(nvl(count(1), 0), 0, 'N', 'S') envia
        into l_envia
        from v_monitoreo_datos d, t_monitoreos m
       where d.id_monitoreo = m.id_monitoreo
         and m.nivel_aviso = 1
         and d.id_monitoreo_ejecucion = i_id_ejecucion
         and d.cantidad_elementos > 0;
    exception
      when others then
        null;
    end;
  
    $if k_modulo.c_instalado_msj $then
    -- Arma el cuerpo de la tabla
    if l_envia = 'S' then
      l_tabla := k_html.f_query2table(i_query    => replace(l_query,
                                                            '&id_ejecucion',
                                                            i_id_ejecucion),
                                      i_template => c_table_template);
      -- Envía correo de monitoreo
      l_body := k_mensajeria.f_correo_tabla_html(i_tabla      => l_tabla,
                                                 i_titulo     => 'Monitoreo de Conflictos',
                                                 i_encabezado => 'Monitoreo de Conflictos',
                                                 i_pie        => '<b>C.T.</b> conflictos totales, <b>C.M.</b> conflictos mitigados, <b>C.P.</b> conflictos pendientes');
    
      if k_mensajeria.f_enviar_correo('Monitoreo de Conflictos ' || '#' ||
                                      i_id_ejecucion,
                                      l_body,
                                      null,
                                      k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS'),
                                      null,
                                      null,
                                      null,
                                      null,
                                      k_mensajeria.c_prioridad_importante) <>
         k_mensajeria.c_ok then
        dbms_output.put_line('Error en envio de monitoreo de conflictos resumido');
      end if;
    end if;
    $end
  
  end;

  procedure p_aviso_detallado(i_id_ejecucion in number,
                              i_id_monitoreo in number) is
    l_envia        varchar2(1) := 'N';
    l_body         clob;
    l_tabla        clob;
    l_tabla_causa  clob;
    l_tabla_accion clob;
  
    l_detalle t_operaciones.detalle%type;
    l_query   varchar2(2000) := 'SELECT j.*
  FROM t_monitoreo_ejecuciones d,
       json_table(d.datos,
                  ''$'' columns(NESTED path ''$.datos.elementos[*]''
                          columns(&columnas))) j
 WHERE d.id_monitoreo_ejecucion = &id_ejecucion
   AND d.id_monitoreo = &id_monitoreo';
  
    l_query_causa  varchar2(2000) := 'SELECT nvl(REPLACE(a.causa, chr(10), ''*=*''), ''No definido'') "Causa"
  FROM t_monitoreos a
 WHERE a.id_monitoreo = &id_monitoreo';
    l_query_accion varchar2(2000) := 'SELECT nvl(REPLACE(a.plan_accion, chr(10), ''*=*''), ''No definido'') "Plan de Acción"
  FROM t_monitoreos a
 WHERE a.id_monitoreo = &id_monitoreo';
  
  begin
    --Verifica si hay datos a enviar
    begin
      select decode(nvl(count(1), 0), 0, 'N', 'S') envia
        into l_envia
        from v_monitoreo_datos d, t_monitoreos m
       where d.id_monitoreo = m.id_monitoreo
         and m.nivel_aviso = 2
         and d.id_monitoreo_ejecucion = i_id_ejecucion
         and d.id_monitoreo = i_id_monitoreo
         and d.cantidad_elementos > 0;
    exception
      when others then
        null;
    end;
  
    $if k_modulo.c_instalado_msj $then
    if l_envia = 'S' then
      -- Obtiene datos del monitoreo
      begin
        select o.detalle
          into l_detalle
          from t_monitoreos m, t_operaciones o
         where o.id_operacion = m.id_monitoreo
           and o.activo = 'S'
           and m.id_monitoreo = i_id_monitoreo;
      end;
    
      l_query := replace(l_query,
                         '&columnas',
                         f_monitoreo_columnas_sql(i_id_monitoreo));
      l_query := replace(l_query, '&id_ejecucion', i_id_ejecucion);
      l_query := replace(l_query, '&id_monitoreo', i_id_monitoreo);
    
      l_tabla := k_html.f_query2table(i_query    => l_query,
                                      i_template => c_table_template);
    
      l_tabla_causa := k_html.f_query2table(i_query    => replace(l_query_causa,
                                                                  '&id_monitoreo',
                                                                  i_id_monitoreo),
                                            i_template => c_table_template);
    
      l_tabla_accion := k_html.f_query2table(i_query    => replace(l_query_accion,
                                                                   '&id_monitoreo',
                                                                   i_id_monitoreo),
                                             i_template => c_table_template);
    
      -- Envía correo de monitoreo
      l_body := k_mensajeria.f_correo_tabla_aux_html(i_tabla       => l_tabla,
                                                     i_tabla_aux_1 => l_tabla_causa,
                                                     i_tabla_aux_2 => l_tabla_accion,
                                                     i_titulo      => l_detalle,
                                                     i_encabezado  => l_detalle);
      l_body := replace(l_body, '_x0020_', ' ');
      l_body := replace(l_body, '*=*', chr(10) || '<br>');
      --dbms_output.put_line(l_body);
    
      if k_mensajeria.f_enviar_correo('Monitoreo de Conflictos ' || '#' ||
                                      i_id_ejecucion,
                                      l_body,
                                      null,
                                      k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS'),
                                      null,
                                      null,
                                      null,
                                      null,
                                      k_mensajeria.c_prioridad_importante) <>
         k_mensajeria.c_ok then
        dbms_output.put_line('Error en envio de monitoreo de conflictos resumido');
      end if;
    end if;
    $end
  
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

  function f_monitoreo_sql(i_id_monitoreo    in number,
                           i_version         in varchar2 default null,
                           o_tiene_conflicto out boolean) return y_respuesta is
    l_rsp       y_respuesta;
    l_rsp_det   y_respuesta;
    l_prms      y_parametros;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_dato;
  
    l_nombre_monitoreo  t_operaciones.nombre%type;
    l_dominio_monitoreo t_operaciones.dominio%type;
    l_version_actual    t_operaciones.version_actual%type;
    l_consulta_sql      t_monitoreos.consulta_sql%type;
  
    l_sentencia varchar2(4000);
  begin
    -- Inicializa respuesta
    l_rsp             := new y_respuesta();
    l_elementos       := new y_objetos();
    o_tiene_conflicto := false;
  
    l_rsp.lugar := 'Buscando datos del servicio';
    begin
      select upper(o.nombre),
             upper(o.dominio),
             o.version_actual,
             m.consulta_sql
        into l_nombre_monitoreo,
             l_dominio_monitoreo,
             l_version_actual,
             l_consulta_sql
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.id_monitoreo = i_id_monitoreo;
    exception
      when no_data_found then
        k_operacion.p_respuesta_error(l_rsp,
                                      k_operacion.c_error_parametro,
                                      'Monitoreo inexistente o inactivo');
        raise k_operacion.ex_error_parametro;
    end;
  
    l_rsp.lugar := 'Validando parametros';
    if l_consulta_sql is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    k_operacion.c_error_general,
                                    'Consulta SQL no definida');
      raise k_operacion.ex_error_parametro;
    end if;
  
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
        --dbms_output.put_line(l_elemento.json);
      
        begin
          -- Inicializa respuesta del conflicto
          l_rsp_det := new y_respuesta();
        
          l_rsp_det.lugar := 'Procesando parámetros del conflicto';
          begin
            l_prms := k_operacion.f_procesar_parametros(i_id_monitoreo,
                                                        l_elemento.json,
                                                        nvl(i_version,
                                                            l_version_actual));
          exception
            when others then
              k_operacion.p_respuesta_error(l_rsp_det,
                                            k_operacion.c_error_parametro,
                                            case
                                            k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                            k_error.c_user_defined_error then
                                            utl_call_stack.error_msg(1) when
                                            k_error.c_oracle_predefined_error then
                                            k_error.f_mensaje_error(k_operacion.c_error_parametro) end,
                                            dbms_utility.format_error_stack);
          end;
        
          l_rsp_det.lugar := 'Construyendo sentencia';
          if nvl(i_version, l_version_actual) = l_version_actual then
            l_sentencia := 'BEGIN :1 := K_MONITOREO_' ||
                           l_dominio_monitoreo || '.' || l_nombre_monitoreo ||
                           '(:2); END;';
          else
            l_sentencia := 'BEGIN :1 := K_MONITOREO_' ||
                           l_dominio_monitoreo || '.' || l_nombre_monitoreo || '_' ||
                           replace(i_version, '.', '_') || '(:2); END;';
          end if;
        
          l_rsp_det.lugar := 'Mitigando conflicto';
          begin
            execute immediate l_sentencia
              using out l_rsp_det, in l_prms;
          exception
            when k_operacion.ex_servicio_no_implementado then
              k_operacion.p_respuesta_error(l_rsp_det,
                                            k_operacion.c_servicio_no_implementado,
                                            'Mitigación de conflicto no implementada',
                                            dbms_utility.format_error_stack);
            when others then
              k_operacion.p_respuesta_error(l_rsp_det,
                                            k_operacion.c_error_general,
                                            case
                                            k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                            k_error.c_user_defined_error then
                                            utl_call_stack.error_msg(1) when
                                            k_error.c_oracle_predefined_error then
                                            'Error al mitigar conflicto' end,
                                            dbms_utility.format_error_stack);
          end;
        
          -- Inicializa datos para log
          k_operacion.p_inicializar_log(i_id_monitoreo);
        
          -- Registra log con datos de entrada y salida
          k_operacion.p_registrar_log(i_id_monitoreo,
                                      l_elemento.json,
                                      l_rsp_det.codigo,
                                      l_rsp_det.to_json,
                                      null,
                                      i_version);
        
          l_json_object.put('mitigado',
                            l_rsp_det.codigo = k_operacion.c_ok);
          l_elemento.json := l_json_object.to_clob;
          --dbms_output.put_line(l_elemento.json);
        end;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        o_tiene_conflicto := true;
      end loop;
    
      dbms_sql.close_cursor(l_cursor);
    end;
    -- ========================================================
  
    l_pagina := f_paginar_elementos(l_elementos, f_pagina_parametros(null));
  
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

  function f_monitoreo_columnas_sql(i_id_monitoreo in number) return clob is
    l_rsp varchar2(4000) := '';
  
    l_nombre_monitoreo  t_operaciones.nombre%type;
    l_dominio_monitoreo t_operaciones.dominio%type;
    l_version_actual    t_operaciones.version_actual%type;
    l_consulta_sql      t_monitoreos.consulta_sql%type;
  begin
    begin
      select upper(o.nombre),
             upper(o.dominio),
             o.version_actual,
             m.consulta_sql
        into l_nombre_monitoreo,
             l_dominio_monitoreo,
             l_version_actual,
             l_consulta_sql
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.id_monitoreo = i_id_monitoreo;
    exception
      when no_data_found then
        return null;
    end;
  
    if l_consulta_sql is null then
      return null;
    end if;
  
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
      
        l_rsp := l_rsp || case
                   when l_rsp is not null then
                    ', ' || chr(10)
                 end || lower(l_desc_tab(i).col_name) || ' path ''$.' ||
                 lower(l_desc_tab(i).col_name) || '''';
      end loop;
    
      dbms_sql.close_cursor(l_cursor);
    end;
    -- ========================================================
  
    l_rsp := l_rsp || case
               when l_rsp is not null then
                ', ' || chr(10)
             end || 'mitigado' || ' path ''$.' || 'mitigado' || '''';
  
    return l_rsp;
  exception
    when others then
      return l_rsp;
  end;

  function f_procesar_monitoreo(i_id_monitoreo in number,
                                i_version      in varchar2 default null)
    return clob is
    l_rsp       y_respuesta;
    l_conflicto boolean;
  begin
    -- Procesa monitoreo
    l_rsp := lf_procesar_monitoreo(i_id_monitoreo, i_version, l_conflicto);
    -- Registra ejecución
    k_monitoreo.lp_registrar_ejecucion(i_id_monitoreo,
                                       l_rsp.to_json,
                                       l_conflicto);
    return l_rsp.to_json;
  end;

  function f_procesar_monitoreo(i_nombre  in varchar2,
                                i_dominio in varchar2,
                                i_version in varchar2 default null)
    return clob is
    l_rsp          y_respuesta;
    l_id_monitoreo t_monitoreos.id_monitoreo%type;
    l_conflicto    boolean;
  begin
    -- Busca monitoreo
    l_id_monitoreo := k_operacion.f_id_operacion(k_operacion.c_tipo_monitoreo,
                                                 i_nombre,
                                                 i_dominio);
    -- Procesa monitoreo
    l_rsp := lf_procesar_monitoreo(l_id_monitoreo, i_version, l_conflicto);
    -- Registra ejecución
    k_monitoreo.lp_registrar_ejecucion(l_id_monitoreo,
                                       l_rsp.to_json,
                                       l_conflicto);
    return l_rsp.to_json;
  end;

  procedure p_procesar_monitoreos(i_frecuencia in varchar2 default null) is
    cursor c_monitoreos(i_frecuencias in varchar2 default null) is
      select o.id_operacion,
             upper(o.nombre) nombre,
             upper(o.dominio) dominio,
             o.version_actual
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and (m.frecuencia in
             (select *
                 from (k_cadena.f_separar_cadenas(i_frecuencias, ','))) or
             i_frecuencias is null);
    --
    l_frecuencias t_significados.referencia%type;
  begin
    -- Reserva identificador para ejecución
    k_monitoreo.lp_reservar_id_ejecucion;
    dbms_output.put_line('#' ||
                         k_sistema.f_valor_parametro_number(c_id_ejecucion));
    -- Obtiene las frecuencias según parámetro
    if i_frecuencia is not null then
      begin
        select si.referencia
          into l_frecuencias
          from t_significados si
         where si.dominio = 'FRECUENCIA_MONITOREO'
           and si.activo = 'S'
           and si.codigo = i_frecuencia;
      exception
        when no_data_found then
          raise ex_frecuencia_no_existe;
      end;
    end if;
    -- Procesa todos los monitoreos activos
    for c in c_monitoreos(l_frecuencias) loop
      declare
        l_res clob;
      begin
        l_res := k_monitoreo.f_procesar_monitoreo(c.id_operacion,
                                                  c.version_actual);
      end;
    end loop;
    -- Realiza el aviso resumido
    k_monitoreo.p_aviso_resumido(k_sistema.f_valor_parametro_number(c_id_ejecucion));
    -- Realiza el aviso detallado
    for c in c_monitoreos(l_frecuencias) loop
      k_monitoreo.p_aviso_detallado(k_sistema.f_valor_parametro_number(c_id_ejecucion),
                                    c.id_operacion);
    end loop;
  end;

end;
/
