create or replace package body k_archivo is

  function f_tipo_mime(i_dominio   in varchar2,
                       i_extension in varchar2) return varchar2 is
    l_referencia t_significados.referencia%type;
  begin
    begin
      select a.referencia
        into l_referencia
        from t_significados a
       where a.activo = 'S'
         and a.dominio = i_dominio
         and upper(a.codigo) = upper(i_extension);
    exception
      when others then
        l_referencia := null;
    end;
    return l_referencia;
  end;

  function f_recuperar_archivo(i_tabla      in varchar2,
                               i_campo      in varchar2,
                               i_referencia in varchar2,
                               i_version    in varchar2 default null)
    return y_archivo is
    l_archivo y_archivo;
  begin
    l_archivo := new y_archivo();
  
    begin
      select a.contenido,
             a.url,
             a.checksum,
             a.tamano,
             a.nombre,
             a.extension,
             f_tipo_mime(d.extensiones_permitidas, a.extension)
        into l_archivo.contenido,
             l_archivo.url,
             l_archivo.checksum,
             l_archivo.tamano,
             l_archivo.nombre,
             l_archivo.extension,
             l_archivo.tipo_mime
        from t_archivos a, t_archivo_definiciones d
       where d.tabla = a.tabla
         and d.campo = a.campo
         and upper(a.tabla) = upper(i_tabla)
         and upper(a.campo) = upper(i_campo)
         and a.referencia = i_referencia
         and nvl(a.version_actual, 0) =
             nvl(i_version, nvl(a.version_actual, 0));
    exception
      when no_data_found then
        -- Busca versión en tabla histórica
        begin
          select h.contenido,
                 h.url,
                 h.checksum,
                 h.tamano,
                 h.nombre,
                 h.extension,
                 f_tipo_mime(d.extensiones_permitidas, h.extension)
            into l_archivo.contenido,
                 l_archivo.url,
                 l_archivo.checksum,
                 l_archivo.tamano,
                 l_archivo.nombre,
                 l_archivo.extension,
                 l_archivo.tipo_mime
            from t_archivos_hist h, t_archivo_definiciones d
           where d.tabla = h.tabla
             and d.campo = h.campo
             and upper(h.tabla) = upper(i_tabla)
             and upper(h.campo) = upper(i_campo)
             and h.referencia = i_referencia
             and h.version = nvl(i_version, -1);
        exception
          when no_data_found then
            raise_application_error(-20000, 'Archivo inexistente');
          when others then
            raise_application_error(-20000, 'Error al recuperar archivo');
        end;
      when others then
        raise_application_error(-20000, 'Error al recuperar archivo');
    end;
  
    return l_archivo;
  end;

  procedure p_guardar_archivo(i_tabla      in varchar2,
                              i_campo      in varchar2,
                              i_referencia in varchar2,
                              i_archivo    in y_archivo) is
    l_version_actual t_archivos.version_actual%type;
  begin
    update t_archivos a
       set a.contenido      = i_archivo.contenido,
           a.url            = i_archivo.url,
           a.nombre         = i_archivo.nombre,
           a.extension      = i_archivo.extension,
           a.version_actual = nvl(a.version_actual, 0) + 1
     where upper(a.tabla) = upper(i_tabla)
       and upper(a.campo) = upper(i_campo)
       and a.referencia = i_referencia;
  
    if sql%notfound then
      select nvl(max(h.version), 0) + 1
        into l_version_actual
        from t_archivos_hist h
       where upper(h.tabla) = upper(i_tabla)
         and upper(h.campo) = upper(i_campo)
         and h.referencia = i_referencia;
    
      insert into t_archivos
        (tabla,
         campo,
         referencia,
         contenido,
         url,
         nombre,
         extension,
         version_actual)
      values
        (upper(i_tabla),
         upper(i_campo),
         i_referencia,
         i_archivo.contenido,
         i_archivo.url,
         i_archivo.nombre,
         i_archivo.extension,
         l_version_actual);
    end if;
  end;

  procedure p_calcular_propiedades(i_contenido in blob,
                                   o_checksum  out varchar2,
                                   o_tamano    out number) is
  begin
    if i_contenido is not null then
      begin
        o_checksum := rawtohex(as_crypto.hash(i_contenido,
                                              as_crypto.hash_sh1));
      exception
        when others then
          o_checksum := null;
      end;
    
      begin
        o_tamano := dbms_lob.getlength(i_contenido);
      exception
        when others then
          o_tamano := null;
      end;
    end if;
  end;

  function f_version_archivo(i_tabla      in varchar2,
                             i_campo      in varchar2,
                             i_referencia in varchar2) return number is
    l_version t_archivos.version_actual%type;
  begin
  
    select nvl(a.version_actual, 0)
      into l_version
      from t_archivos a, t_archivo_definiciones d
     where d.tabla = a.tabla
       and d.campo = a.campo
       and upper(a.tabla) = upper(i_tabla)
       and upper(a.campo) = upper(i_campo)
       and a.referencia = i_referencia;
  
    return l_version;
  exception
    when others then
      return null;
  end;

  -- https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs
  function f_data_url(i_contenido in blob,
                      i_tipo_mime in varchar2) return clob is
    l_data_url clob;
    l_base64   clob;
  begin
    -- Codifica en formato Base64
    l_base64 := k_util.base64encode(i_contenido);
    -- Elimina caracteres de nueva línea
    l_base64 := replace(l_base64, utl_tcp.crlf);
  
    l_data_url := 'data:' || i_tipo_mime || ';charset=' || k_util.f_charset ||
                  ';base64,' || l_base64;
  
    return l_data_url;
  end;

  function f_data_url(i_tabla      in varchar2,
                      i_campo      in varchar2,
                      i_referencia in varchar2,
                      i_version    in varchar2 default null) return clob is
    l_archivo y_archivo;
  begin
    -- Recupera el archivo
    l_archivo := f_recuperar_archivo(i_tabla,
                                     i_campo,
                                     i_referencia,
                                     i_version);
  
    return f_data_url(l_archivo.contenido, l_archivo.tipo_mime);
  end;

end;
/
