create or replace package body k_reporte_gen is

  function version_sistema(i_parametros in y_parametros) return y_archivo is
    l_rsp            y_respuesta;
    l_contenido      blob;
    l_formato        varchar2(10);
    l_version_actual t_modulos.version_actual%type;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parámetros';
    l_formato   := k_reporte.f_formato(i_parametros);
  
    l_rsp.lugar := 'Obteniendo versión del sistema';
    begin
      select version_actual
        into l_version_actual
        from t_modulos
       where id_modulo = k_modulo.c_id_risk;
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      'gen0001',
                                      'Error al obtener versión del sistema');
        raise k_operacion.ex_error_general;
    end;
  
    case l_formato
      when k_reporte.c_formato_pdf then
        -- PDF
        as_pdf.init;
        as_pdf.set_info(k_sistema.f_valor_parametro_string(k_sistema.c_nombre_operacion),
                        k_sistema.f_usuario);
        as_pdf.set_page_format('A4');
        as_pdf.set_page_orientation('PORTRAIT');
        as_pdf.set_margins(2.5, 3, 2.5, 3, 'cm');
        as_pdf.write(l_version_actual);
        l_contenido := as_pdf.get_pdf;
      
      when k_reporte.c_formato_docx then
        -- DOCX
        declare
          l_document  pls_integer;
          l_paragraph pls_integer;
        begin
          l_document  := zt_word.f_new_document;
          l_paragraph := zt_word.f_new_paragraph(p_doc_id => l_document,
                                                 p_text   => l_version_actual);
          l_contenido := zt_word.f_make_document(l_document);
        end;
      
      when k_reporte.c_formato_xlsx then
        -- XLSX
        as_xlsx.clear_workbook;
        as_xlsx.new_sheet;
        as_xlsx.cell(1, 1, l_version_actual);
        l_contenido := as_xlsx.finish;
      
      when k_reporte.c_formato_csv then
        -- CSV
        declare
          l_txt clob;
        begin
          l_txt       := l_version_actual;
          l_contenido := k_util.clob_to_blob(l_txt);
        end;
      
      when k_reporte.c_formato_html then
        -- HTML
        k_html.p_inicializar;
        htp.htmlopen;
        htp.headopen;
        htp.p('<meta charset="utf-8">');
        htp.meta(null, k_reporte.c_meta_format, k_reporte.c_formato_pdf);
        htp.meta(null, k_reporte.c_meta_page_size, 'A4');
        htp.meta(null,
                 k_reporte.c_meta_page_orientation,
                 k_reporte.c_orientacion_vertical);
        htp.meta(null, 'author', k_sistema.f_usuario);
        htp.meta(null, 'description', '');
        htp.title(k_sistema.f_valor_parametro_string(k_sistema.c_nombre_operacion));
        htp.headclose;
        htp.bodyopen;
        htp.p('<p>' || k_html.f_escapar_texto(l_version_actual) || '</p>');
        htp.bodyclose;
        htp.htmlclose;
        l_contenido := k_util.clob_to_blob(k_html.f_html);
      
      else
        k_operacion.p_respuesta_error(l_rsp,
                                      'gen0002',
                                      'Formato de salida no implementado');
        raise k_operacion.ex_error_general;
    end case;
  
    return k_reporte.f_archivo_ok(l_contenido, l_formato);
  exception
    when k_operacion.ex_error_parametro then
      return k_reporte.f_archivo_error(l_rsp, l_formato);
    when k_operacion.ex_error_general then
      return k_reporte.f_archivo_error(l_rsp, l_formato);
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return k_reporte.f_archivo_error(l_rsp, l_formato);
  end;

end;
/

