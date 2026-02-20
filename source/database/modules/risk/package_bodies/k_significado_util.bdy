create or replace package body k_significado_util is

  function f_inserts_dominio(i_significado_dominio in t_significado_dominios%rowtype,
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
    l_inserts := l_inserts || k_cadena.f_comentar('T_SIGNIFICADO_DOMINIOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT dominio, descripcion, detalle, activo, id_dominio FROM t_significado_dominios WHERE dominio = ''%s''',
                                               i_significado_dominio.dominio),
                                't_significado_dominios');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_SIGNIFICADOS') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('SELECT dominio, codigo, significado, referencia, activo, referencia_2 FROM t_significados WHERE dominio = ''%s'' ORDER BY codigo',
                                               i_significado_dominio.dominio),
                                't_significados');
    l_inserts := l_inserts || l_insert;
    --
  
    return l_inserts;
  end;

  function f_inserts_dominio(i_dominio             in varchar2,
                             i_motivo_modificacion in varchar2 default null)
    return clob is
  begin
    return f_inserts_dominio(k_significado.f_dominio(i_dominio),
                             i_motivo_modificacion);
  end;

  function f_deletes_dominio(i_significado_dominio in t_significado_dominios%rowtype)
    return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('DOMINIO = ' ||
                                     i_significado_dominio.dominio) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes ||
                 console.format('DELETE t_significados WHERE dominio = ''%s'';',
                                i_significado_dominio.dominio) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('DELETE t_significado_dominios WHERE dominio = ''%s'';',
                                i_significado_dominio.dominio) ||
                 utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_deletes_dominio(i_dominio in varchar2) return clob is
  begin
    return f_deletes_dominio(k_significado.f_dominio(i_dominio));
  end;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_MODULO = ' || i_id_modulo) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes || console.format('DELETE t_significados WHERE k_significado.f_id_modulo_dominio(dominio) = ''%s'';',
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('DELETE t_significado_dominios WHERE k_significado.f_id_modulo_dominio(dominio) = ''%s'';',
                                             i_id_modulo) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_scripts_dominios(i_id_modulo           in varchar2 default null,
                              i_motivo_modificacion in varchar2 default null)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
    c_dirname constant varchar2(100) := 'meanings';
    c_charset constant varchar2(100) := k_util.f_valor_parametro('CHARSET_EXPORTACION_SCRIPTS');
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    cursor c_significado_dominios(i_id_modulo in varchar2) is
      select a.dominio,
             lower(k_significado.f_id_modulo_dominio(a.dominio)) id_modulo,
             lower(k_cadena.f_reemplazar_acentos(nvl(a.id_dominio, '_') || '/' ||
                                                 a.dominio)) || '.sql' nombre_archivo
        from t_significado_dominios a
       where k_significado.f_id_modulo_dominio(a.dominio) = i_id_modulo
       order by 3;
  begin
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando significados...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando significados...' ||
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
    
      for dom in c_significado_dominios(m.id_modulo) loop
        l_inserts := f_inserts_dominio(dom.dominio, i_motivo_modificacion);
        --l_deletes := f_deletes_dominio(dom.dominio);
        --
        l_install := l_install || '@@scripts/' || c_dirname || '/' ||
                     dom.nombre_archivo || utl_tcp.crlf;
        --l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
        --
        as_zip.add1file(l_zip,
                        dom.id_modulo || '/scripts/' || c_dirname || '/' ||
                        dom.nombre_archivo,
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

