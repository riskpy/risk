create or replace package body k_modulo_util is

  function f_inserts_modulo(i_modulo              in t_modulos%rowtype,
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
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_MODULOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('select id_modulo, nombre, detalle, activo, fecha_actual, version_actual from t_modulos where id_modulo = ''%s''',
                                               i_modulo.id_modulo),
                                't_modulos');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_DOMINIOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('select id_dominio, nombre, detalle, activo, id_modulo from t_dominios where id_modulo = ''%s'' order by id_dominio',
                                               i_modulo.id_modulo),
                                't_dominios');
    l_inserts := l_inserts || l_insert;
    --
  
    return l_inserts;
  end;

  function f_inserts_modulo(i_id_modulo           in varchar2,
                            i_motivo_modificacion in varchar2 default null)
    return clob is
  begin
    return f_inserts_modulo(k_modulo.f_modulo(i_id_modulo),
                            i_motivo_modificacion);
  end;

  function f_deletes_modulo(i_modulo in t_modulos%rowtype) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('MODULO = ' || i_modulo.id_modulo) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes ||
                 console.format('delete t_dominios where id_modulo = ''%s'';',
                                i_modulo.id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('delete t_modulos where id_modulo = ''%s'';',
                                i_modulo.id_modulo) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob is
  begin
    return f_deletes_modulo(k_modulo.f_modulo(i_id_modulo));
  end;

  function f_scripts(i_id_modulo            in varchar2 default null,
                     i_motivo_modificacion  in varchar2 default null,
                     i_incluir_parametros   in boolean default true,
                     i_incluir_significados in boolean default true,
                     i_incluir_errores      in boolean default true,
                     i_incluir_aplicaciones in boolean default true,
                     i_incluir_operaciones  in boolean default true)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
    c_dirname constant varchar2(100) := 'module';
    c_charset constant varchar2(100) := k_util.f_valor_parametro('CHARSET_EXPORTACION_SCRIPTS');
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    procedure p_add_files(io_zip_1 in out nocopy blob,
                          i_zip_2  in blob) is
      l_file_names as_zip.file_names;
      i            integer;
    begin
      l_file_names := as_zip.get_file_names(i_zip_2);
      i            := l_file_names.first;
      while i is not null loop
        as_zip.add1file(io_zip_1,
                        l_file_names(i),
                        as_zip.get_file(i_zip_2, l_file_names(i), c_charset));
        i := l_file_names.next(i);
      end loop;
    end;
  begin
    -- Módulo y Dominios
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando modulo...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando modulo...' ||
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
    
      l_inserts := f_inserts_modulo(m.id_modulo, i_motivo_modificacion);
      l_install := l_install || l_inserts || utl_tcp.crlf;
    
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
  
    -- Parámetros
    if i_incluir_parametros then
      p_add_files(l_zip,
                  k_parametro_util.f_scripts_parametros(i_id_modulo,
                                                        i_motivo_modificacion));
    end if;
  
    -- Significados
    if i_incluir_significados then
      p_add_files(l_zip,
                  k_significado_util.f_scripts_dominios(i_id_modulo,
                                                        i_motivo_modificacion));
    end if;
  
    -- Errores
    if i_incluir_errores then
      p_add_files(l_zip,
                  k_error_util.f_scripts_errores(i_id_modulo,
                                                 i_motivo_modificacion));
    end if;
  
    -- Aplicaciones
    if i_incluir_aplicaciones then
      p_add_files(l_zip,
                  k_aplicacion_util.f_scripts_aplicaciones(i_id_modulo,
                                                           i_motivo_modificacion));
    end if;
  
    -- Operaciones
    if i_incluir_operaciones then
      p_add_files(l_zip,
                  k_operacion_util.f_scripts_operaciones(i_id_modulo,
                                                         i_motivo_modificacion));
    end if;
  
    if l_zip is not null and dbms_lob.getlength(l_zip) > 0 then
      as_zip.finish_zip(l_zip);
    end if;
  
    return l_zip;
  end;

end;
/

