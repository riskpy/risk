create or replace package body k_parametro_util is

  function f_inserts_parametro(i_parametro_definicion in t_parametro_definiciones%rowtype,
                               i_motivo_modificacion  in varchar2 default null)
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
    l_inserts := l_inserts ||
                 k_cadena.f_comentar('T_PARAMETRO_DEFINICIONES') ||
                 utl_tcp.crlf;
    l_insert  := fn_gen_inserts(console.format('select tabla, id_parametro, descripcion, orden, nombre_referencia, tipo_dato, observacion, id_dominio, tipo_filtro, formato, longitud_maxima, obligatorio, valor_defecto, etiqueta, valores_posibles, encriptado from t_parametro_definiciones where tabla = ''%s'' and id_parametro = ''%s''',
                                               i_parametro_definicion.tabla,
                                               i_parametro_definicion.id_parametro),
                                't_parametro_definiciones');
    l_inserts := l_inserts || l_insert;
    --
    l_inserts := l_inserts || k_cadena.f_comentar('T_PARAMETROS') ||
                 utl_tcp.crlf;
    if i_parametro_definicion.tabla = k_parametro.c_tabla_parametros then
      l_insert := fn_gen_inserts(console.format('select id_parametro, valor from t_parametros where id_parametro = ''%s''',
                                                i_parametro_definicion.id_parametro),
                                 't_parametros');
    else
      l_insert := fn_gen_inserts(console.format('select id_parametro, valor from t_parametros where 1 = 2'),
                                 't_parametros');
    end if;
    l_inserts := l_inserts || l_insert;
  
    return l_inserts;
  end;

  function f_inserts_parametro(i_tabla               in varchar2,
                               i_id_parametro        in varchar2,
                               i_motivo_modificacion in varchar2 default null)
    return clob is
  begin
    return f_inserts_parametro(k_parametro.f_parametro_definicion(i_tabla,
                                                                  i_id_parametro),
                               i_motivo_modificacion);
  end;

  function f_deletes_parametro(i_parametro_definicion in t_parametro_definiciones%rowtype)
    return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_PARAMETRO = ' ||
                                     i_parametro_definicion.id_parametro) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes ||
                 console.format('delete t_parametros where id_parametro = ''%s'';',
                                i_parametro_definicion.id_parametro) ||
                 utl_tcp.crlf;
    l_deletes := l_deletes ||
                 console.format('delete t_parametro_definiciones where tabla = ''%s'' and id_parametro = ''%s'';',
                                i_parametro_definicion.tabla,
                                i_parametro_definicion.id_parametro) ||
                 utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_deletes_parametro(i_tabla        in varchar2,
                               i_id_parametro in varchar2) return clob is
  begin
    return f_deletes_parametro(k_parametro.f_parametro_definicion(i_tabla,
                                                                  i_id_parametro));
  end;

  function f_deletes_modulo(i_id_modulo in varchar2) return clob is
    l_deletes clob;
  begin
    l_deletes := l_deletes ||
                 k_cadena.f_comentar('ID_MODULO = ' || i_id_modulo) ||
                 utl_tcp.crlf;
    --
    l_deletes := l_deletes || console.format('delete t_parametros p where (select k_dominio.f_id_modulo(nvl(pd.id_dominio, ''%s'')) from t_parametro_definiciones pd where pd.tabla = ''T_PARAMETROS'' and pd.id_parametro = p.id_parametro) = ''%s'';',
                                             k_dominio.c_id_dominio_defecto,
                                             i_id_modulo) || utl_tcp.crlf;
    l_deletes := l_deletes || console.format('delete t_parametro_definiciones where k_dominio.f_id_modulo(nvl(id_dominio, ''%s'')) = ''%s'';',
                                             k_dominio.c_id_dominio_defecto,
                                             i_id_modulo) || utl_tcp.crlf;
    --
  
    return l_deletes;
  end;

  function f_scripts_parametros(i_id_modulo           in varchar2 default null,
                                i_motivo_modificacion in varchar2 default null)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
    c_dirname constant varchar2(100) := 'parameters';
    c_charset constant varchar2(100) := k_util.f_valor_parametro('CHARSET_EXPORTACION_SCRIPTS');
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    cursor c_parametro_definiciones(i_id_modulo in varchar2) is
      select a.tabla,
             a.id_parametro,
             lower(k_dominio.f_id_modulo(nvl(a.id_dominio,
                                             k_dominio.c_id_dominio_defecto))) id_modulo,
             lower(k_cadena.f_reemplazar_acentos(a.tabla || '/' ||
                                                 nvl(a.id_dominio, '_') || '/' ||
                                                 a.id_parametro)) || '.sql' nombre_archivo
        from t_parametro_definiciones a
       where k_dominio.f_id_modulo(nvl(a.id_dominio,
                                       k_dominio.c_id_dominio_defecto)) =
             i_id_modulo
       order by 4;
  begin
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando parametros...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando parametros...' ||
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
    
      for def in c_parametro_definiciones(m.id_modulo) loop
        l_inserts := f_inserts_parametro(def.tabla,
                                         def.id_parametro,
                                         i_motivo_modificacion);
        --l_deletes := f_deletes_parametro(def.id_parametro);
        --
        l_install := l_install || '@@scripts/' || c_dirname || '/' ||
                     def.nombre_archivo || utl_tcp.crlf;
        --l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
        --
        as_zip.add1file(l_zip,
                        def.id_modulo || '/scripts/' || c_dirname || '/' ||
                        def.nombre_archivo,
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

