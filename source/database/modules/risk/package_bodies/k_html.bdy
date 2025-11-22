create or replace package body k_html is

  c_charset_bytes constant pls_integer := 4;

  function lf_clob_to_htbuf_arr(i_clob in clob) return htp.htbuf_arr is
    l_htbuf_arr     htp.htbuf_arr;
    l_buffer_length integer;
    l_length        integer;
    k               number;
  begin
    l_htbuf_arr     := new htp.htbuf_arr();
    l_buffer_length := floor(255 / c_charset_bytes);
  
    l_length := dbms_lob.getlength(i_clob);
    if l_length > 0 and l_buffer_length > 0 then
      k := ceil(l_length / l_buffer_length);
      for i in 1 .. k loop
        l_htbuf_arr(i) := dbms_lob.substr(i_clob,
                                          l_buffer_length,
                                          1 + l_buffer_length * (i - 1));
      end loop;
    end if;
  
    return l_htbuf_arr;
  end;

  -- https://dba.stackexchange.com/a/6780
  -- https://stackoverflow.com/a/7755800
  function f_query2table(i_query    in clob,
                         i_template in clob := null) return clob is
    l_table     clob;
    l_ctx       dbms_xmlgen.ctxhandle;
    l_xml_query xmltype;
    l_xml_table xmltype;
    --
    l_template clob := nvl(i_template,
                           '<?xml version="1.0" encoding="UTF-8"?>
  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  <xsl:template match="/">
    <table border="1" cellspacing="0">
      <tr bgcolor="lightgray">
        <xsl:for-each select="/ROWSET/ROW[1]/*">
          <th><xsl:value-of select="name()"/></th>
        </xsl:for-each>
      </tr>
      <xsl:for-each select="/ROWSET/*">
        <tr>
          <xsl:for-each select="./*">
            <td><xsl:value-of select="text()"/></td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  </xsl:stylesheet>');
  begin
    l_ctx := dbms_xmlgen.newcontext(i_query);
    dbms_xmlgen.setnullhandling(l_ctx, dbms_xmlgen.empty_tag);
    dbms_xmlgen.setprettyprinting(l_ctx, false);
    l_xml_query := dbms_xmlgen.getxmltype(l_ctx);
  
    if dbms_xmlgen.getnumrowsprocessed(l_ctx) > 0 and
       l_xml_query is not null then
      l_xml_table := l_xml_query.transform(xmltype(l_template));
      l_table     := l_xml_table.getclobval;
    end if;
  
    dbms_xmlgen.closecontext(l_ctx);
  
    return l_table;
  end;

  function f_escapar_texto(i_texto in clob) return clob is
    l_tmp clob;
  begin
    l_tmp := i_texto;
    --
    l_tmp := replace(l_tmp, '&', '&' || 'amp;');
    l_tmp := replace(l_tmp, '''', '&' || 'apos;');
    l_tmp := replace(l_tmp, '"', '&' || 'quot;');
    l_tmp := replace(l_tmp, '>', '&' || 'gt;');
    l_tmp := replace(l_tmp, '<', '&' || 'lt;');
    --
    l_tmp := replace(l_tmp, 'Á', '&' || 'Aacute;');
    l_tmp := replace(l_tmp, 'É', '&' || 'Eacute;');
    l_tmp := replace(l_tmp, 'Í', '&' || 'Iacute;');
    l_tmp := replace(l_tmp, 'Ó', '&' || 'Oacute;');
    l_tmp := replace(l_tmp, 'Ú', '&' || 'Uacute;');
    l_tmp := replace(l_tmp, 'Ñ', '&' || 'Ntilde;');
    l_tmp := replace(l_tmp, 'Ü', '&' || 'Uuml;');
    l_tmp := replace(l_tmp, 'Ç', '&' || 'Ccedil;');
    --
    l_tmp := replace(l_tmp, 'á', '&' || 'aacute;');
    l_tmp := replace(l_tmp, 'é', '&' || 'eacute;');
    l_tmp := replace(l_tmp, 'í', '&' || 'iacute;');
    l_tmp := replace(l_tmp, 'ó', '&' || 'oacute;');
    l_tmp := replace(l_tmp, 'ú', '&' || 'uacute;');
    l_tmp := replace(l_tmp, 'ñ', '&' || 'ntilde;');
    l_tmp := replace(l_tmp, 'ü', '&' || 'uuml;');
    l_tmp := replace(l_tmp, 'ç', '&' || 'ccedil;');
    return l_tmp;
  end;

  function f_html return clob is
    l_html clob;
    l_page htp.htbuf_arr;
    l_rows integer := 999999;
    i      binary_integer;
  begin
    htp.get_page(l_page, l_rows);
  
    i := l_page.first;
    while i is not null loop
      l_html := l_html || l_page(i);
      i      := l_page.next(i);
    end loop;
  
    return l_html;
  end;

  procedure p_inicializar(i_doctype in boolean default true) is
  begin
    owa.num_cgi_vars := 0;
    -- https://forums.allroundautomations.com/ubb/ubbthreads.php?ubb=showflat&Number=60068
    htp.htbuf_len := floor(255 / c_charset_bytes);
    htp.init;
    htp.adddefaulthtmlhdr(false);
  
    if i_doctype then
      htp.p('<!DOCTYPE html>');
    end if;
  end;

  procedure p_print(i_clob in clob) is
    l_htbuf_arr htp.htbuf_arr;
    i           integer;
  begin
    l_htbuf_arr := lf_clob_to_htbuf_arr(i_clob);
    i           := l_htbuf_arr.first;
    while i is not null loop
      htp.prn(l_htbuf_arr(i));
      i := l_htbuf_arr.next(i);
    end loop;
    -- Agrega un salto de línea
    htp.p;
  end;

  -- https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face
  procedure p_font_face(i_fuentes in varchar2) is
    cursor c_fuentes is
      select a.tabla,
             a.campo,
             a.referencia,
             a.nombre,
             decode(upper(a.extension),
                    'TTF',
                    'truetype',
                    'OTF',
                    'opentype',
                    'WOFF',
                    'woff',
                    'WOFF2',
                    'woff2') format
        from t_archivos a
       where a.tabla = k_archivo.c_carpeta_fuentes
         and a.campo = 'ARCHIVO'
         and a.contenido is not null
         and a.nombre is not null
         and a.extension is not null
         and a.referencia in
             (select * from k_cadena.f_separar_cadenas(i_fuentes, ','));
  begin
    for c in c_fuentes loop
      p_print('@font-face { font-family: "' || c.nombre || '"; src: url("' ||
              k_archivo.f_data_url(c.tabla, c.campo, c.referencia) ||
              '") format("' || c.format || '"); }');
    end loop;
  end;

end;
/
