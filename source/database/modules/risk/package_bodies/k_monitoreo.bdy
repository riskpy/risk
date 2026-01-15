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
    <xsl:if test="name() != ''PRIORIDAD'' and name() != ''MIT''"><td style="font-family: sans-serif; font-size: 14px; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left"><xsl:value-of select="text()"/></td></xsl:if>
   </xsl:for-each>
   <xsl:for-each select="./MIT">
    <xsl:if test="text() = ''true''"><td style="font-family: sans-serif; font-size: 14px; color: #009900; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left"><img src="http://171.10.10.251/intranet/requerimientos_v2/images/accept.png" width="16" height="16" align="absmiddle"></img></td></xsl:if>
    <xsl:if test="text() = ''false''"><td style="font-family: sans-serif; font-size: 14px; color: #ee0000; vertical-align: top; text-align: left; padding: 8px;" valign="top" align="left"><img src="http://171.10.10.251/intranet/requerimientos_v2/images/delete.png" width="16" height="16" align="absmiddle"></img></td></xsl:if>
   </xsl:for-each>
  </tr>
 </xsl:for-each>
</table>
  </xsl:template>
</xsl:stylesheet>';

  c_sms_template constant varchar2(4000) := '<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
      <xsl:for-each select="/ROWSET/*">
          <xsl:for-each select="./*">
            <xsl:value-of select="text()"/>
            <xsl:text> </xsl:text>
          </xsl:for-each>
      </xsl:for-each>
  </xsl:template>
  </xsl:stylesheet>';

  procedure lp_limpiar_id_ejecucion is
  begin
    k_sistema.p_definir_parametro_number(c_id_ejecucion, null);
  exception
    when others then
      null;
  end;

  procedure lp_reservar_id_ejecucion is
    l_id_ejecucion t_monitoreo_ejecuciones.id_monitoreo_ejecucion%type;
  begin
    select nvl(max(a.id_monitoreo_ejecucion), 0) + 1
      into l_id_ejecucion
      from t_monitoreo_ejecuciones a;
    k_sistema.p_definir_parametro_number(c_id_ejecucion, l_id_ejecucion);
  exception
    when others then
      null;
  end;

  procedure lp_registrar_ejecucion(i_id_monitoreo in number,
                                   i_datos        in clob,
                                   i_conflicto    in boolean) is
    pragma autonomous_transaction;
    l_timestamp t_monitoreo_ejecuciones.fecha_fin_ejecucion%type := current_timestamp;
  begin
    insert into t_monitoreo_ejecuciones
      (id_monitoreo_ejecucion,
       id_monitoreo,
       fecha_fin_ejecucion,
       fecha_inicio_ejecucion,
       duracion,
       datos)
    values
      (k_sistema.f_valor_parametro_number(c_id_ejecucion),
       i_id_monitoreo,
       l_timestamp,
       nvl(g_ini_timestamp, l_timestamp),
       l_timestamp - nvl(g_ini_timestamp, l_timestamp),
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
      /*k_log.p_registrar_log(pin_tipo              => k_log.cg_tipo_log_error,
      pin_detalle           => sqlerrm,
      pin_modulo            => k_modulo.c_id_risk,
      pin_referencia1       => i_id_monitoreo,
      pin_referencia2       => k_sistema.f_valor_parametro_number(c_id_ejecucion),
      pin_registrar_siempre => true);*/
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
         and m.activo = 'S'
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

  procedure lp_mitigar_conflicto(i_id_monitoreo        in number,
                                 i_tipo_implementacion in varchar2,
                                 i_bloque_plsql        in varchar2,
                                 i_sentencia           in varchar2,
                                 i_prms                in y_parametros,
                                 io_rsp                in out y_respuesta) is
    pragma autonomous_transaction;
  begin
    k_sistema.p_configurar_modificacion(k_operacion.c_aplicacion_monitoreo,
                                        'MON-' || i_id_monitoreo);
    begin
      if i_tipo_implementacion = 'B' then
        if i_bloque_plsql is not null then
          execute immediate i_bloque_plsql
            using in i_prms, out io_rsp;
        end if;
      else
        execute immediate i_sentencia
          using out io_rsp, in i_prms;
      end if;
    exception
      when k_operacion.ex_servicio_no_implementado then
        k_operacion.p_respuesta_error(io_rsp,
                                      k_operacion.c_servicio_no_implementado,
                                      'Mitigación de conflicto no implementada',
                                      dbms_utility.format_error_stack);
      when others then
        k_operacion.p_respuesta_error(io_rsp,
                                      k_operacion.c_error_general,
                                      case
                                      k_error.f_tipo_excepcion(utl_call_stack.error_number(1)) when
                                      k_error.c_user_defined_error then
                                      utl_call_stack.error_msg(1) when
                                      k_error.c_oracle_predefined_error then
                                      'Error al mitigar conflicto' end,
                                      dbms_utility.format_error_stack);
    end;
  
    if io_rsp.codigo = k_operacion.c_ok then
      commit;
    else
      rollback;
    end if;
    k_sistema.p_configurar_modificacion(k_operacion.c_aplicacion_monitoreo,
                                        '');
  end;

  procedure lp_inicializar_variables is
  begin
    k_sistema.p_configurar_modificacion(k_operacion.c_aplicacion_monitoreo);
  
    g_ini_timestamp := current_timestamp;
  
    g_est_modulo := ''; --TODO: pae_cnf.fu_obt_est_modulo(c_cod_modulo);
  
    /*g_mod_cerrado := case
      when g_est_modulo = '2' then
       'N'
      else
       'S'
    end;*/
    g_mod_cerrado := 'N'; --TODO
  
    g_fecha_real   := trunc(sysdate);
    g_fecha_actual := trunc(sysdate); --TODO: pag_cal.fu_obt_fec_actual(c_cod_modulo);
  
    /*
    --TODO: calculo de fechas y dias hábiles
    if g_est_modulo in (1, 6) then
      -- En cierre.
      return;
    elsif g_est_modulo = 2 then
      -- El modulo esta abierto
      g_fecha_proceso := g_fecha_actual;
    else
      g_fecha_proceso := pag_cal.fu_obt_fec_habil(g_fecha_actual + 1,
                                                  1,
                                                  fun_obt_ofi_matriz);
    end if;
    
    if g_fecha_real =
       pag_cal.fu_obt_fec_habil(g_fecha_real, 1, fun_obt_ofi_matriz) then
      g_dia_habil := 'S';
    else
      g_dia_habil := 'N';
    end if;*/
  end;

  procedure lp_imprimir_variables is
  begin
    dbms_output.put_line('fecha_real = [' ||
                         to_char(g_fecha_real, 'dd/mm/yyyy') || ']');
    dbms_output.put_line('fecha_actual = [' ||
                         to_char(g_fecha_actual, 'dd/mm/yyyy') || ']');
    dbms_output.put_line('fecha_proceso = [' ||
                         to_char(g_fecha_proceso, 'dd/mm/yyyy') || ']');
    dbms_output.put_line('est_modulo = [' || g_est_modulo || ']');
    dbms_output.put_line('mod_cerrado = [' || g_mod_cerrado || ']');
    dbms_output.put_line('dia_habil = [' || g_dia_habil || ']');
  end;

  function lf_destinatario_principal_responsable return varchar2 is
    l_destinatario t_roles.direccion_correo%type;
  begin
    select a.direccion_correo
      into l_destinatario
      from t_roles a
     where a.nombre = k_util.f_valor_parametro('ROL_PRINCIPAL_MONITOREOS')
     fetch first 1 row only;
    return nvl(l_destinatario,
               k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS'));
  exception
    when others then
      return k_util.f_valor_parametro('DIRECCION_CORREO_MONITOREOS');
  end;

  function lf_destinatarios_responsables(i_id_monitoreo in number)
    return varchar2 is
    l_destinatarios varchar2(2000);
  
    cursor c_destinatarios(i_id_monitoreo in number) is
      select distinct g.nombre, g.direccion_correo
        from t_roles g, v_monitoreo_roles_responsables m
       where g.nombre = m.rol
         and g.activo = 'S'
         and g.direccion_correo is not null
         and m.id_monitoreo = i_id_monitoreo
      union
      select distinct us.alias, us.direccion_correo
        from t_roles                        g,
             v_monitoreo_roles_responsables m,
             t_rol_usuarios                 ru,
             t_usuarios                     us
       where g.nombre = m.rol
         and g.activo = 'S'
         and g.id_rol = ru.id_rol
         and ru.id_usuario = us.id_usuario
         and us.estado = 'A'
         and us.direccion_correo is not null
         and m.id_monitoreo = i_id_monitoreo
      union
      select distinct us.alias, us.direccion_correo
        from t_usuarios us, v_monitoreo_usu_responsables m
       where us.alias = m.usuario
         and us.estado = 'A'
         and us.direccion_correo is not null
         and m.id_monitoreo = i_id_monitoreo;
  
  begin
    for d in c_destinatarios(i_id_monitoreo) loop
      l_destinatarios := l_destinatarios || case
                           when l_destinatarios is not null then
                            ', '
                         end || d.direccion_correo;
    end loop;
    --
    return l_destinatarios;
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
    --
    l_datos_extra json_object_t := new json_object_t();
  
    l_query varchar2(2000) := 'WITH v_datos AS
 (SELECT d.id_monitoreo_ejecucion, d.id_monitoreo, d.mitigado
    FROM v_monitoreo_datos d, t_monitoreos m
   WHERE d.id_monitoreo = m.id_monitoreo
     AND m.nivel_aviso_correo = 1
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
         and m.nivel_aviso_correo = 1
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
                                                 i_pie        => '<div height="30"><b>C.T.</b> conflictos totales, <b>C.M.</b> conflictos mitigados, <b>C.P.</b> conflictos pendientes</div>' ||
                                                                 '<br>' ||
                                                                 '<div height="30">Generado por ' || user ||
                                                                 ' el ' ||
                                                                 to_char(sysdate,
                                                                         'DD/MM/YYYY') ||
                                                                 ' a las ' ||
                                                                 to_char(sysdate,
                                                                         'HH24:MI') ||
                                                                 '</div>');
    
      l_datos_extra.put('id_ejecucion', i_id_ejecucion);
      l_datos_extra.put('contenido', l_body);
    
      if k_mensajeria.f_enviar_correo(c_plantilla_monitoreo,
                                      l_datos_extra.to_clob,
                                      null,
                                      lf_destinatario_principal_responsable,
                                      null,
                                      null) <> k_mensajeria.c_ok then
        dbms_output.put_line('#' || i_id_ejecucion ||
                             ' - Error en envio de MON- resumido a: ' ||
                             lf_destinatario_principal_responsable);
      end if;
    end if;
    $end
  
  end;

  procedure p_aviso_detallado(i_id_ejecucion in number,
                              i_id_monitoreo in number) is
    l_envia         varchar2(1) := 'N';
    l_destinatarios varchar2(2000);
    l_body          clob;
    l_tabla         clob;
    l_tabla_causa   clob;
    l_tabla_accion  clob;
    --
    l_datos_extra json_object_t := new json_object_t();
  
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
         and m.nivel_aviso_correo = 2
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
           and m.activo = 'S'
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
                                                     i_encabezado  => l_detalle,
                                                     i_pie         => '<div height="30">Generado por ' || user ||
                                                                      ' el ' ||
                                                                      to_char(sysdate,
                                                                              'DD/MM/YYYY') ||
                                                                      ' a las ' ||
                                                                      to_char(sysdate,
                                                                              'HH24:MI') ||
                                                                      '</div>');
      l_body := replace(l_body, '_x0020_', ' ');
      l_body := replace(l_body, '*=*', chr(10) || '<br>');
      --dbms_output.put_line(l_body);
    
      l_datos_extra.put('id_ejecucion', i_id_ejecucion);
      l_datos_extra.put('contenido', l_body);
    
      l_destinatarios := lf_destinatarios_responsables(i_id_monitoreo);
      if l_destinatarios is null then
        if k_mensajeria.f_enviar_correo(c_plantilla_monitoreo,
                                        l_datos_extra.to_clob,
                                        null,
                                        lf_destinatario_principal_responsable,
                                        null,
                                        null) <> k_mensajeria.c_ok then
          dbms_output.put_line('#' || i_id_ejecucion ||
                               ' - Error en envio de MON- ' ||
                               i_id_monitoreo || ' detallado a: ' ||
                               lf_destinatario_principal_responsable);
        end if;
      
      else
        if k_mensajeria.f_enviar_correo(c_plantilla_monitoreo,
                                        l_datos_extra.to_clob,
                                        null,
                                        l_destinatarios,
                                        null,
                                        lf_destinatario_principal_responsable) <>
           k_mensajeria.c_ok then
          dbms_output.put_line('#' || i_id_ejecucion ||
                               ' - Error en envio de MON- ' ||
                               i_id_monitoreo || ' detallado a: ' ||
                               l_destinatarios || ' cc: ' ||
                               lf_destinatario_principal_responsable);
        end if;
      end if;
    end if;
    $end
  
  exception
    when others then
      /*k_log.p_registrar_log(pin_tipo              => k_log.cg_tipo_log_error,
      pin_detalle           => sqlerrm,
      pin_modulo            => k_modulo.c_id_risk,
      pin_referencia1       => i_id_monitoreo,
      pin_referencia2       => i_id_ejecucion,
      pin_registrar_siempre => true);*/
      null;
  end;

  procedure p_aviso_mensaje(i_id_ejecucion in number,
                            i_id_monitoreo in number) is
    pragma autonomous_transaction;
    l_envia varchar2(1) := 'N';
    l_tabla clob;
    --
    l_datos_extra json_object_t := new json_object_t();
  
    l_query varchar2(2000) := 'WITH v_datos AS
 (SELECT d.id_monitoreo_ejecucion, d.id_monitoreo, d.mitigado
    FROM v_monitoreo_datos d, t_monitoreos m
   WHERE d.id_monitoreo = m.id_monitoreo
     AND m.aviso_mensaje = ''S''
     AND d.id_monitoreo_ejecucion = &id_ejecucion
     AND d.id_monitoreo = &id_monitoreo
     AND d.cantidad_elementos > 0)
SELECT ''#'' || m.id_monitoreo_ejecucion "Id_Ejecucion",
       ''MON-'' || m.id_monitoreo "Id",
       ''- '' || p.detalle "Descripcion",
       ''Mitigados: '' || to_char(SUM(CASE m.mitigado
             WHEN ''true'' THEN
              1
             ELSE
              0
           END)) "C.M.",
       ''/ '' || to_char(nvl(COUNT(m.mitigado), 0)) "C.T."
  FROM v_datos m, t_monitoreos n, t_operaciones p
 WHERE m.id_monitoreo = n.id_monitoreo
   AND n.id_monitoreo = p.id_operacion
 GROUP BY n.prioridad, m.id_monitoreo, p.detalle, m.id_monitoreo_ejecucion';
  
    cursor c_usuarios(i_id_monitoreo in number) is
      select distinct null id_usuario, null alias, g.numero_telefono
        from t_roles g, v_monitoreo_roles_responsables m
       where g.nombre = m.rol
         and g.activo = 'S'
         and g.numero_telefono is not null
         and m.id_monitoreo = i_id_monitoreo
      union
      select distinct null id_usuario, null alias, g.numero_telefono
        from t_roles g
       where g.nombre =
             k_util.f_valor_parametro('ROL_PRINCIPAL_MONITOREOS')
         and g.activo = 'S'
         and g.numero_telefono is not null
      union
      select distinct us.id_usuario, us.alias, us.numero_telefono
        from t_roles g, t_rol_usuarios ru, t_usuarios us
       where g.nombre =
             k_util.f_valor_parametro('ROL_PRINCIPAL_MONITOREOS')
         and g.activo = 'S'
         and g.id_rol = ru.id_rol
         and ru.id_usuario = us.id_usuario
         and us.estado = 'A'
         and us.numero_telefono is not null
      union
      select distinct us.id_usuario, us.alias, us.numero_telefono
        from t_roles                        g,
             v_monitoreo_roles_responsables m,
             t_rol_usuarios                 ru,
             t_usuarios                     us
       where g.nombre = m.rol
         and g.activo = 'S'
         and g.id_rol = ru.id_rol
         and ru.id_usuario = us.id_usuario
         and us.estado = 'A'
         and us.numero_telefono is not null
         and m.id_monitoreo = i_id_monitoreo
      union
      select distinct us.id_usuario, us.alias, us.numero_telefono
        from t_usuarios us, v_monitoreo_usu_responsables m
       where us.alias = m.usuario
         and us.estado = 'A'
         and us.numero_telefono is not null
         and m.id_monitoreo = i_id_monitoreo;
  
  begin
    --Verifica si hay datos a enviar
    begin
      select decode(nvl(count(1), 0), 0, 'N', 'S') envia
        into l_envia
        from v_monitoreo_datos d, t_monitoreos m
       where d.id_monitoreo = m.id_monitoreo
         and m.aviso_mensaje = 'S'
         and d.id_monitoreo_ejecucion = i_id_ejecucion
         and d.id_monitoreo = i_id_monitoreo
         and d.cantidad_elementos > 0;
    exception
      when others then
        null;
    end;
  
    $if k_modulo.c_instalado_msj $then
    if l_envia = 'S' then
      -- Arma el cuerpo de la tabla
      l_query := replace(l_query, '&id_ejecucion', i_id_ejecucion);
      l_query := replace(l_query, '&id_monitoreo', i_id_monitoreo);
      l_tabla := k_html.f_query2table(i_query    => l_query,
                                      i_template => c_sms_template);
    
      l_datos_extra.put('id_ejecucion', i_id_ejecucion);
      l_datos_extra.put('contenido', l_tabla);
    
      -- Envía SMS de monitoreo
      for c in c_usuarios(i_id_monitoreo) loop
        /*if k_mensajeria.f_enviar_mensaje(i_id_plantilla    => c_plantilla_monitoreo,
                                         i_datos_extra     => l_datos_extra.to_clob,
                                         i_id_usuario      => c.id_usuario,
                                         i_numero_telefono => c.numero_telefono) <>
           k_mensajeria.c_ok then
          dbms_output.put_line('#' || i_id_ejecucion ||
                               ' - Error en envio de MON- ' ||
                               i_id_monitoreo || ' por sms al usuario: ' ||
                               c.alias || ' con nro. de telefono: ' ||
                               c.numero_telefono);
        end if;*/
        null;
      end loop;
    end if;
    $end
  
    commit;
  exception
    when others then
      /*k_log.p_registrar_log(pin_tipo              => k_log.cg_tipo_log_error,
      pin_detalle           => sqlerrm,
      pin_modulo            => k_modulo.c_id_risk,
      pin_referencia1       => i_id_monitoreo,
      pin_referencia2       => i_id_ejecucion,
      pin_registrar_siempre => true);*/
      rollback;
  end;

  procedure p_aviso_notificacion(i_id_ejecucion in number,
                                 i_id_monitoreo in number) is
    pragma autonomous_transaction;
    l_envia varchar2(1) := 'N';
    l_tabla clob;
    --
    l_datos_extra json_object_t := new json_object_t();
  
    l_query varchar2(2000) := 'WITH v_datos AS
 (SELECT d.id_monitoreo_ejecucion, d.id_monitoreo, d.mitigado
    FROM v_monitoreo_datos d, t_monitoreos m
   WHERE d.id_monitoreo = m.id_monitoreo
     AND m.aviso_notificacion = ''S''
     AND d.id_monitoreo_ejecucion = &id_ejecucion
     AND d.id_monitoreo = &id_monitoreo
     AND d.cantidad_elementos > 0)
SELECT ''MON-'' || m.id_monitoreo "Id",
       ''- '' || p.detalle "Descripcion",
       ''Mitigados: '' || to_char(SUM(CASE m.mitigado
             WHEN ''true'' THEN
              1
             ELSE
              0
           END)) "C.M.",
       ''/ '' || to_char(nvl(COUNT(m.mitigado), 0)) "C.T."
  FROM v_datos m, t_monitoreos n, t_operaciones p
 WHERE m.id_monitoreo = n.id_monitoreo
   AND n.id_monitoreo = p.id_operacion
 GROUP BY n.prioridad, m.id_monitoreo, p.detalle, m.id_monitoreo_ejecucion';
  
    cursor c_usuarios(i_id_monitoreo in number) is
      select distinct us.id_usuario, us.alias
        from t_roles g, t_rol_usuarios ru, t_usuarios us
       where g.nombre =
             k_util.f_valor_parametro('ROL_PRINCIPAL_MONITOREOS')
         and g.activo = 'S'
         and g.id_rol = ru.id_rol
         and ru.id_usuario = us.id_usuario
         and us.estado = 'A'
      union
      select distinct us.id_usuario, us.alias
        from t_roles                        g,
             v_monitoreo_roles_responsables m,
             t_rol_usuarios                 ru,
             t_usuarios                     us
       where g.nombre = m.rol
         and g.activo = 'S'
         and g.id_rol = ru.id_rol
         and ru.id_usuario = us.id_usuario
         and us.estado = 'A'
         and m.id_monitoreo = i_id_monitoreo
      union
      select distinct us.id_usuario, us.alias
        from t_usuarios us, v_monitoreo_usu_responsables m
       where us.alias = m.usuario
         and us.estado = 'A'
         and m.id_monitoreo = i_id_monitoreo;
  
  begin
    --Verifica si hay datos a enviar
    begin
      select decode(nvl(count(1), 0), 0, 'N', 'S') envia
        into l_envia
        from v_monitoreo_datos d, t_monitoreos m
       where d.id_monitoreo = m.id_monitoreo
         and m.aviso_notificacion = 'S'
         and d.id_monitoreo_ejecucion = i_id_ejecucion
         and d.id_monitoreo = i_id_monitoreo
         and d.cantidad_elementos > 0;
    exception
      when others then
        null;
    end;
  
    $if k_modulo.c_instalado_msj $then
    if l_envia = 'S' then
      -- Arma el cuerpo de la tabla
      l_query := replace(l_query, '&id_ejecucion', i_id_ejecucion);
      l_query := replace(l_query, '&id_monitoreo', i_id_monitoreo);
      l_tabla := k_html.f_query2table(i_query    => l_query,
                                      i_template => c_sms_template);
    
      l_datos_extra.put('id_ejecucion', i_id_ejecucion);
      l_datos_extra.put('contenido', l_tabla);
    
      -- Envía PUSH de monitoreo
      for c in c_usuarios(i_id_monitoreo) loop
        /*if k_mensajeria.f_enviar_notificacion(i_id_plantilla       => c_plantilla_monitoreo,
                                              i_datos_extra        => l_datos_extra.to_clob,
                                              i_id_usuario         => c.id_usuario,
                                              i_dispositivo_seguro => 'N') <>
           k_mensajeria.c_ok then
          dbms_output.put_line('#' || i_id_ejecucion ||
                               ' - Error en envio de MON- ' ||
                               i_id_monitoreo || ' por push al usuario: ' ||
                               c.alias);
        end if;*/
        null;
      end loop;
    end if;
    $end
  
    commit;
  exception
    when others then
      /*k_log.p_registrar_log(pin_tipo              => k_log.cg_tipo_log_error,
      pin_detalle           => sqlerrm,
      pin_modulo            => k_modulo.c_id_risk,
      pin_referencia1       => i_id_monitoreo,
      pin_referencia2       => i_id_ejecucion,
      pin_registrar_siempre => true);*/
      rollback;
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
  
    l_id_log              t_operacion_logs.id_operacion_log%type;
    l_nombre_monitoreo    t_operaciones.nombre%type;
    l_dominio_monitoreo   t_operaciones.dominio%type;
    l_version_actual      t_operaciones.version_actual%type;
    l_tipo_implementacion t_operaciones.tipo_implementacion%type;
    l_consulta_sql        t_monitoreos.consulta_sql%type;
    l_bloque_plsql        t_monitoreos.bloque_plsql%type;
    l_bloque_final        t_monitoreos.bloque_plsql%type := '';
  
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
             nvl(o.tipo_implementacion, 'K'),
             m.consulta_sql,
             m.bloque_plsql
        into l_nombre_monitoreo,
             l_dominio_monitoreo,
             l_version_actual,
             l_tipo_implementacion,
             l_consulta_sql,
             l_bloque_plsql
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.activo = 'S'
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
        
          if l_rsp_det.codigo = k_operacion.c_ok then
            l_rsp_det.codigo := null;
            l_rsp_det.lugar  := 'Construyendo sentencia';
            if l_tipo_implementacion = 'B' then
              declare
                i            pls_integer;
                l_variables  clob := '';
                l_asignacion clob := '';
              begin
                i := l_prms.first;
                while i is not null loop
                  --DBMS_OUTPUT.PUT_LINE( l_prms(i).nombre||' '||replace(l_prms(i).valor.gettypename,'SYS.','') );
                  if replace(l_prms(i).valor.gettypename, 'SYS.', '') in
                     ('VARCHAR2') then
                    l_variables  := l_variables || '  l_' || l_prms(i).nombre ||
                                    ' VARCHAR2(1000);' || chr(10);
                    l_asignacion := l_asignacion || '    l_' || l_prms(i).nombre ||
                                    ' := k_operacion.f_valor_parametro_string(l_parametros, ''' || l_prms(i).nombre ||
                                    ''');' || chr(10);
                  elsif replace(l_prms(i).valor.gettypename, 'SYS.', '') in
                        ('NUMBER') then
                    l_variables  := l_variables || '  l_' || l_prms(i).nombre ||
                                    ' NUMBER(38);' || chr(10);
                    l_asignacion := l_asignacion || '    l_' || l_prms(i).nombre ||
                                    ' := k_operacion.f_valor_parametro_number(l_parametros, ''' || l_prms(i).nombre ||
                                    ''');' || chr(10);
                  elsif replace(l_prms(i).valor.gettypename, 'SYS.', '') in
                        ('DATE') then
                    l_variables  := l_variables || '  l_' || l_prms(i).nombre ||
                                    ' DATE;' || chr(10);
                    l_asignacion := l_asignacion || '    l_' || l_prms(i).nombre ||
                                    ' := k_operacion.f_valor_parametro_date(l_parametros, ''' || l_prms(i).nombre ||
                                    ''');' || chr(10);
                  end if;
                  i := l_prms.next(i);
                end loop;
                --DBMS_OUTPUT.PUT_LINE( l_variables );
                --DBMS_OUTPUT.PUT_LINE( l_asignacion );
              
                if l_bloque_plsql is not null then
                  l_bloque_final := 'DECLARE' || chr(10) ||
                                    '  l_rsp        y_respuesta := NEW y_respuesta();' ||
                                    chr(10) || l_variables || chr(10) ||
                                    '  l_parametros y_parametros := :1;' ||
                                    chr(10) || 'BEGIN' || chr(10) ||
                                    '  IF l_parametros.count > 0 THEN' ||
                                    chr(10) || l_asignacion || chr(10) ||
                                    '    DECLARE' || chr(10) || '    BEGIN' ||
                                    chr(10) ||
                                    '      l_rsp.lugar := ''Procesando la operacion'';' ||
                                    chr(10) || '      --' || chr(10) ||
                                    '    ' || l_bloque_plsql || ' ' ||
                                    chr(10) || '      --' || chr(10) ||
                                    '      k_operacion.p_respuesta_ok(l_rsp);' ||
                                    chr(10) || '    EXCEPTION' || chr(10) ||
                                    '      WHEN k_operacion.ex_error_parametro THEN' ||
                                    chr(10) || '        NULL;' || chr(10) ||
                                    '      WHEN k_operacion.ex_error_general THEN' ||
                                    chr(10) || '        NULL;' || chr(10) ||
                                    '      WHEN OTHERS THEN' || chr(10) ||
                                    '        k_operacion.p_respuesta_excepcion(l_rsp,' ||
                                    chr(10) ||
                                    '                                      utl_call_stack.error_number(1),' ||
                                    chr(10) ||
                                    '                                      utl_call_stack.error_msg(1),' ||
                                    chr(10) ||
                                    '                                      dbms_utility.format_error_stack);' ||
                                    chr(10) || '    END;' || chr(10) ||
                                    '  ELSE' || chr(10) ||
                                    '    l_rsp.lugar := ''SIN PARÁMETROS'';' ||
                                    chr(10) || '  END IF;' || chr(10) ||
                                    '  :2 := l_rsp;' || chr(10) || 'END;';
                end if;
              end;
            else
              if nvl(i_version, l_version_actual) = l_version_actual then
                l_sentencia := 'BEGIN :1 := pag_monitoreo_' ||
                               l_dominio_monitoreo || '.' ||
                               l_nombre_monitoreo || '(:2); END;';
              else
                l_sentencia := 'BEGIN :1 := pag_monitoreo_' ||
                               l_dominio_monitoreo || '.' ||
                               l_nombre_monitoreo || '_' ||
                               replace(i_version, '.', '_') || '(:2); END;';
              end if;
            end if;
          
            l_rsp_det.lugar := 'Mitigando conflicto';
            lp_mitigar_conflicto(i_id_monitoreo,
                                 l_tipo_implementacion,
                                 l_bloque_final,
                                 l_sentencia,
                                 l_prms,
                                 l_rsp_det);
            l_bloque_final := '';
          
          end if;
        
          -- Reserva identificador para log
          --k_operacion.p_reservar_id_log(i_id_monitoreo);
        
          -- Registra log con datos de entrada y salida
          k_operacion.p_registrar_log(l_id_log,
                                      i_id_monitoreo,
                                      l_elemento.json,
                                      l_rsp_det.codigo,
                                      l_rsp_det.to_json,
                                      null,
                                      i_version);
        
          --DBMS_OUTPUT.PUT_LINE( '----'||l_rsp_det.to_json);
          l_json_object.put('mitigado',
                            l_rsp_det.codigo is not null and
                            l_rsp_det.codigo = k_operacion.c_ok);
          if not (l_rsp_det.codigo = k_operacion.c_ok) then
            l_json_object.put('error', l_rsp_det.mensaje_bd);
          end if;
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
    l_mitiga            varchar2(1) := 'N';
  begin
    begin
      select upper(o.nombre),
             upper(o.dominio),
             o.version_actual,
             m.consulta_sql,
             case
               when (nvl(o.tipo_implementacion, 'K') = 'B' and
                    m.bloque_plsql is not null) or
                    nvl(o.tipo_implementacion, 'K') <> 'B' then
                'S'
               else
                'N'
             end
        into l_nombre_monitoreo,
             l_dominio_monitoreo,
             l_version_actual,
             l_consulta_sql,
             l_mitiga
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.activo = 'S'
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
  
    if l_mitiga = 'S' then
      l_rsp := l_rsp || case
                 when l_rsp is not null then
                  ', ' || chr(10)
               end || 'mit' || ' path ''$.' || 'mitigado' || '''';
    end if;
  
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
    -- Inicializa variables globales
    lp_inicializar_variables;
    -- Procesa monitoreo
    l_rsp := lf_procesar_monitoreo(i_id_monitoreo, i_version, l_conflicto);
    -- Registra ejecución
    lp_registrar_ejecucion(i_id_monitoreo, l_rsp.to_json, l_conflicto);
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
    -- Inicializa variables globales
    lp_inicializar_variables;
    -- Busca monitoreo
    l_id_monitoreo := k_operacion.f_id_operacion(k_operacion.c_tipo_monitoreo,
                                                 i_nombre,
                                                 i_dominio);
    -- Procesa monitoreo
    l_rsp := lf_procesar_monitoreo(l_id_monitoreo, i_version, l_conflicto);
    -- Registra ejecución
    lp_registrar_ejecucion(l_id_monitoreo, l_rsp.to_json, l_conflicto);
    return l_rsp.to_json;
  end;

  procedure p_procesar_monitoreos(i_frecuencia in varchar2 default null) is
    cursor c_monitoreos(i_frecuencias in varchar2 default null,
                        i_mod_cerrado in varchar2 default null,
                        i_dia_habil   in varchar2 default null) is
      select o.id_operacion,
             upper(o.nombre) nombre,
             upper(o.dominio) dominio,
             o.version_actual
        from t_monitoreos m, t_operaciones o
       where o.id_operacion = m.id_monitoreo
         and o.activo = 'S'
         and m.activo = 'S'
         and (m.frecuencia in
             (select *
                 from (k_cadena.f_separar_cadenas(i_frecuencias, ','))) or
             i_frecuencias is null)
         and (nvl(i_mod_cerrado, 'N') = 'N' or
             m.opera_sistema_cerrado = 'S')
         and (nvl(i_dia_habil, 'S') = 'S' or m.opera_dia_no_habil = 'S')
         and to_number(to_char(sysdate, 'HH24')) between
             to_number(nvl(m.hora_minima, '00')) and
             to_number(nvl(m.hora_maxima, '24')) - 1
       order by case m.frecuencia
                  when '15MI' then
                   1
                  when '30MI' then
                   2
                  when 'H' then
                   3
                  when '2H' then
                   4
                  when '6H' then
                   5
                  when '12H' then
                   6
                  when 'D' then
                   7
                  when 'S' then
                   8
                  when 'M' then
                   9
                  else
                   999
                end;
    --
    l_frecuencias t_significados.referencia%type;
  begin
    -- Inicializa variables globales
    lp_inicializar_variables;
    -- Obtiene las frecuencias según parámetro
    if i_frecuencia is not null then
      l_frecuencias := k_significado.f_referencia_codigo(i_dominio => 'FRECUENCIA_MONITOREO',
                                                         i_codigo  => i_frecuencia);
      if l_frecuencias is null then
        raise ex_frecuencia_no_existe;
      end if;
    end if;
    -- Limpia el identificador para ejecución
    lp_limpiar_id_ejecucion;
    for c in c_monitoreos(l_frecuencias, g_mod_cerrado, g_dia_habil) loop
      -- Reserva identificador para ejecución
      lp_reservar_id_ejecucion;
      dbms_output.put_line('#' ||
                           k_sistema.f_valor_parametro_number(c_id_ejecucion));
      exit;
    end loop;
    if k_sistema.f_valor_parametro_number(c_id_ejecucion) is not null then
      lp_imprimir_variables;
      -- Procesa todos los monitoreos activos
      for c in c_monitoreos(l_frecuencias, g_mod_cerrado, g_dia_habil) loop
        declare
          l_res clob;
        begin
          l_res := f_procesar_monitoreo(c.id_operacion, c.version_actual);
        end;
      end loop;
      -- Realiza el aviso resumido
      p_aviso_resumido(k_sistema.f_valor_parametro_number(c_id_ejecucion));
      -- Realiza el aviso detallado
      for c in c_monitoreos(l_frecuencias) loop
        p_aviso_detallado(k_sistema.f_valor_parametro_number(c_id_ejecucion),
                          c.id_operacion);
        --
        p_aviso_mensaje(k_sistema.f_valor_parametro_number(c_id_ejecucion),
                        c.id_operacion);
        --
        p_aviso_notificacion(k_sistema.f_valor_parametro_number(c_id_ejecucion),
                             c.id_operacion);
      end loop;
    end if;
  end;

end;
/

