create or replace package body k_operacion_util is

  function f_inserts_operacion(i_operacion           in t_operaciones%rowtype,
                               i_motivo_modificacion in varchar2 default null)
    return clob is
    l_inserts clob;
    l_insert  clob;
  begin
    if i_motivo_modificacion is not null then
      l_inserts := l_inserts ||
                   'begin p_configurar_modificacion(pin_aplicacion => ''PLSQL_DEV'', pin_motivo => ''' ||
                   i_motivo_modificacion || '''); end;' || utl_tcp.crlf || '/' ||
                   utl_tcp.crlf;
    end if;
    l_inserts := l_inserts || k_cadena.f_comentar('T_OPERACIONES') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_operacion, tipo, nombre, dominio, activo, detalle, version_actual, nivel_log, parametros_automaticos, tipo_implementacion, aplicaciones_permitidas, nombre_programa_implementacion FROM t_operaciones WHERE id_operacion = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_operaciones');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_OPERACION_PARAMETROS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_operacion, nombre, version, orden, activo, tipo_dato, formato, longitud_maxima, obligatorio, valor_defecto, etiqueta, detalle, valores_posibles, encriptado FROM t_operacion_parametros WHERE id_operacion = %s ORDER BY version, orden',
                                               to_char(i_operacion.id_operacion)),
                                't_operacion_parametros');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_SERVICIOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_servicio, tipo, consulta_sql FROM t_servicios WHERE id_servicio = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_servicios');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_REPORTES') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_reporte, tipo, consulta_sql FROM t_reportes WHERE id_reporte = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_reportes');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_TRABAJOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_trabajo, tipo, accion, fecha_inicio, tiempo_inicio, intervalo_repeticion, fecha_fin, comentarios FROM t_trabajos WHERE id_trabajo = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_trabajos');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_MONITOREOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_monitoreo, causa, plan_accion, activo, consulta_sql, bloque_plsql, prioridad, roles_responsables, usuarios_responsables, nivel_aviso_correo, aviso_notificacion, aviso_mensaje, frecuencia, opera_sistema_cerrado, opera_dia_no_habil, hora_minima, hora_maxima, comentarios FROM t_monitoreos WHERE id_monitoreo = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_monitoreos');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_IMPORTACIONES') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_importacion, separador_campos, delimitador_campo, linea_inicial, nombre_tabla, truncar_tabla, proceso_previo, proceso_posterior FROM t_importaciones WHERE id_importacion = %s',
                                               to_char(i_operacion.id_operacion)),
                                't_importaciones');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts ||
                 k_cadena.f_comentar('T_IMPORTACION_PARAMETROS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT a.id_importacion, a.nombre, a.version, a.posicion_inicial, a.longitud, a.posicion_decimal, a.mapeador FROM t_importacion_parametros a, t_operacion_parametros b WHERE a.id_importacion = %s AND b.id_operacion = a.id_importacion AND b.nombre=a.nombre AND b.version = a.version ORDER BY b.version, b.orden',
                                               to_char(i_operacion.id_operacion)),
                                't_importacion_parametros');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_ROL_PERMISOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT id_rol, id_permiso, consultar, insertar, actualizar, eliminar, verificar, autorizar FROM t_rol_permisos WHERE id_permiso = k_operacion.f_id_permiso(%s) ORDER BY id_rol',
                                               to_char(i_operacion.id_operacion)),
                                't_rol_permisos');
    l_inserts := l_inserts || l_insert;
    --
    if i_operacion.tipo_implementacion =
       k_operacion.c_tipo_implementacion_funcion and
       i_operacion.nombre_programa_implementacion is null then
      l_inserts := l_inserts || k_cadena.f_comentar('FUNCTION') ||
                   utl_tcp.crlf;
      l_insert  := dbms_metadata.get_ddl('FUNCTION',
                                         upper(k_operacion.f_nombre_programa(i_operacion.id_operacion)));
      l_insert  := trim(utl_tcp.crlf from l_insert);
      l_insert  := trim(' ' from l_insert);
      l_insert  := l_insert || utl_tcp.crlf || '/';
      l_inserts := l_inserts || l_insert;
    end if;
  
    return l_inserts;
  end;

  function f_inserts_operacion(i_id_operacion        in number,
                               i_motivo_modificacion in varchar2 default null)
    return clob is
  begin
    return f_inserts_operacion(k_operacion.f_operacion(i_id_operacion),
                               i_motivo_modificacion);
  end;

  function f_inserts_operacion(i_tipo                in varchar2,
                               i_nombre              in varchar2,
                               i_dominio             in varchar2,
                               i_motivo_modificacion in varchar2 default null)
    return clob is
  begin
    return f_inserts_operacion(k_operacion.f_id_operacion(i_tipo,
                                                          i_nombre,
                                                          i_dominio),
                               i_motivo_modificacion);
  end;

  function f_deletes_operacion(i_operacion in t_operaciones%rowtype)
    return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_OPERACION = ' ||
                                     to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes ||
                 console.format('DELETE t_rol_permisos WHERE id_permiso = k_operacion.f_id_permiso(%s);',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_importacion_parametros WHERE id_importacion = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_importaciones WHERE id_importacion = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_monitoreos WHERE id_monitoreo = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_trabajos WHERE id_trabajo = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_reportes WHERE id_reporte = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_servicios WHERE id_servicio = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_operacion_parametros WHERE id_operacion = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_operaciones WHERE id_operacion = %s;',
                                to_char(i_operacion.id_operacion)) ||
                 utl_tcp.crlf;
    --
    if i_operacion.tipo_implementacion =
       k_operacion.c_tipo_implementacion_funcion and
       i_operacion.nombre_programa_implementacion is null then
      l_deletes := l_deletes || 'DROP FUNCTION ' ||
                   lower(k_operacion.f_nombre_programa(i_operacion.id_operacion)) || ';' ||
                   utl_tcp.crlf;
    end if;
  
    return l_deletes;
  end;

  function f_deletes_operacion(i_id_operacion in number) return clob is
  begin
    return f_deletes_operacion(k_operacion.f_operacion(i_id_operacion));
  end;

  function f_deletes_operacion(i_tipo    in varchar2,
                               i_nombre  in varchar2,
                               i_dominio in varchar2) return clob is
  begin
    return f_deletes_operacion(k_operacion.f_id_operacion(i_tipo,
                                                          i_nombre,
                                                          i_dominio));
  end;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_MODULO = ' || i_id_modulo) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes || console.format('DELETE t_rol_permisos WHERE id_permiso IN (SELECT k_operacion.f_id_permiso(o.id_operacion) FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_importacion_parametros WHERE id_importacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_importaciones WHERE id_importacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_monitoreos WHERE id_monitoreo IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_trabajos WHERE id_trabajo IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_reportes WHERE id_reporte IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_servicios WHERE id_servicio IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_operacion_parametros WHERE id_operacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_operaciones WHERE id_operacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = ''%s'');',
                                             i_id_modulo) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_scripts_operaciones(i_id_modulo           in varchar2 default null,
                                 i_motivo_modificacion in varchar2 default null)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
    c_dirname constant varchar2(100) := 'operations';
    c_charset constant varchar2(100) := k_util.f_valor_parametro('CHARSET_EXPORTACION_SCRIPTS');
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    cursor c_operaciones(i_id_modulo in varchar2) is
      select a.id_operacion,
             lower(k_operacion.f_id_modulo(a.id_operacion)) id_modulo,
             lower(k_cadena.f_reemplazar_acentos(k_significado.f_significado_codigo('TIPO_OPERACION',
                                                                                    a.tipo) || '/' ||
                                                 nvl(a.dominio, '_') || '/' ||
                                                 a.nombre)) || '.sql' nombre_archivo
        from t_operaciones a
       where k_operacion.f_id_modulo(a.id_operacion) = i_id_modulo
       order by 3;
  begin
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando operaciones...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando operaciones...' ||
                     utl_tcp.crlf;
      l_uninstall := l_uninstall ||
                     'prompt -----------------------------------' ||
                     utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      if i_motivo_modificacion is not null then
        l_uninstall := l_uninstall ||
                       'begin p_configurar_modificacion(pin_aplicacion => ''PLSQL_DEV'', pin_motivo => ''' ||
                       i_motivo_modificacion || '''); end;' || utl_tcp.crlf || '/' ||
                       utl_tcp.crlf;
      end if;
    
      for ope in c_operaciones(m.id_modulo) loop
        l_inserts := f_inserts_operacion(ope.id_operacion,
                                         i_motivo_modificacion);
        --l_deletes := f_deletes_operacion(ope.id_operacion);
        --
        l_install := l_install || '@@scripts/' || c_dirname || '/' ||
                     ope.nombre_archivo || utl_tcp.crlf;
        --l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
        --
        as_zip.add1file(l_zip,
                        ope.id_modulo || '/scripts/' || c_dirname || '/' ||
                        ope.nombre_archivo,
                        k_util.clob_to_blob(l_inserts, c_charset));
      end loop;
    
      l_deletes   := f_deletes_modulo(m.id_modulo);
      l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
    
      as_zip.add1file(l_zip,
                      lower(m.id_modulo) || '/scripts/' || c_dirname || '/' ||
                      'install.sql',
                      k_util.clob_to_blob(l_install, c_charset));
      as_zip.add1file(l_zip,
                      lower(m.id_modulo) || '/scripts/' || c_dirname || '/' ||
                      'uninstall.sql',
                      k_util.clob_to_blob(l_uninstall, c_charset));
    end loop;
  
    if l_zip is not null and dbms_lob.getlength(l_zip) > 0 then
      as_zip.finish_zip(l_zip);
    end if;
  
    return l_zip;
  end;

end;
/

