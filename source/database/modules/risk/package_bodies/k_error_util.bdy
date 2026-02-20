create or replace package body k_error_util is

  function f_inserts_error(i_clave               in varchar2,
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
    l_inserts := l_inserts || k_cadena.f_comentar('T_ERRORES') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('select clave, mensaje, id_dominio, id_idioma, id_pais from t_errores where clave = ''%s'' order by clave, id_idioma, id_pais',
                                               i_clave),
                                't_errores');
    l_inserts := l_inserts || l_insert;
    --
  
    return l_inserts;
  end;

  function f_deletes_error(i_clave in varchar2) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes || k_cadena.f_comentar('ERROR = ' || i_clave) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes || console.format('delete t_errores where clave = ''%s'';',
                                             i_clave) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_MODULO = ' || i_id_modulo) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes || console.format('delete t_errores where k_dominio.f_id_modulo(nvl(id_dominio, ''%s'')) = ''%s'';',
                                             k_dominio.c_id_dominio_defecto,
                                             i_id_modulo) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_scripts_errores(i_id_modulo           in varchar2 default null,
                             i_motivo_modificacion in varchar2 default null)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
    c_dirname constant varchar2(100) := 'errors';
    c_charset constant varchar2(100) := k_util.f_valor_parametro('CHARSET_EXPORTACION_SCRIPTS');
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    cursor c_errores(i_id_modulo in varchar2) is
      select a.clave,
             lower(k_dominio.f_id_modulo(nvl(a.id_dominio,
                                             k_dominio.c_id_dominio_defecto))) id_modulo,
             lower(k_cadena.f_reemplazar_acentos(nvl(a.id_dominio, '_') || '/' ||
                                                 a.clave)) || '.sql' nombre_archivo
        from t_errores a
       where k_dominio.f_id_modulo(nvl(a.id_dominio,
                                       k_dominio.c_id_dominio_defecto)) =
             i_id_modulo
       order by 3;
  begin
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando errores...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando errores...' ||
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
    
      for err in c_errores(m.id_modulo) loop
        l_inserts := f_inserts_error(err.clave, i_motivo_modificacion);
        --l_deletes := f_deletes_error(err.clave);
        --
        l_install := l_install || '@@scripts/' || c_dirname || '/' ||
                     err.nombre_archivo || utl_tcp.crlf;
        --l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
        --
        as_zip.add1file(l_zip,
                        err.id_modulo || '/scripts/' || c_dirname || '/' ||
                        err.nombre_archivo,
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

