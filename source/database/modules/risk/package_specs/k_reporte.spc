create or replace package k_reporte is

  /**
  Agrupa operaciones relacionadas con los Reportes del sistema
  
  %author jtsoya539 27/3/2020 16:42:26
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  -- Formatos de salida
  c_formato_pdf  constant varchar2(10) := 'PDF';
  c_formato_docx constant varchar2(10) := 'DOCX';
  c_formato_xlsx constant varchar2(10) := 'XLSX';
  c_formato_csv  constant varchar2(10) := 'CSV';
  c_formato_html constant varchar2(10) := 'HTML';

  -- Orientaciones
  c_orientacion_vertical   constant varchar2(10) := 'PORTRAIT';
  c_orientacion_horizontal constant varchar2(10) := 'LANDSCAPE';

  -- Nombres de metadatos para conversión de reportes HTML a PDF
  c_meta_format           constant varchar2(30) := 'risk:format';
  c_meta_page_size        constant varchar2(30) := 'risk:page_size';
  c_meta_page_orientation constant varchar2(30) := 'risk:page_orientation';

  procedure p_registrar_sql_ejecucion(i_id_reporte in number,
                                      i_sql        in clob);

  procedure p_limpiar_historial;

  function f_archivo_ok(i_contenido in blob,
                        i_formato   in varchar2 default null,
                        i_nombre    in varchar2 default null)
    return y_archivo;

  function f_archivo_error(i_respuesta in y_respuesta,
                           i_formato   in varchar2 default null,
                           i_nombre    in varchar2 default null)
    return y_archivo;

  function f_formato(i_parametros in y_parametros) return varchar2;

  /**
  Agrega encabezado y pie de página al reporte PDF con formato:
  
  enc1                   enc3
  enc2                   enc4
  ---------------------------
  
  
     Contenido del reporte
  
  
  ---------------------------
  pie1                   pie2
  
  %author jtsoya539 19/3/2024 13:13:50
  %param i_encabezado1 Texto 1 del encabezado
  %param i_encabezado2 Texto 2 del encabezado
  %param i_encabezado3 Texto 3 del encabezado
  %param i_encabezado4 Texto 4 del encabezado
  %param i_pie1 Texto 1 del pie
  %param i_pie2 Texto 2 del pie
  %param i_page_nr Número de página actual
  %param i_page_count Número total de páginas
  */
  procedure p_agregar_encabezado_pie_pdf(i_encabezado1 in varchar2 default null,
                                         i_encabezado2 in varchar2 default null,
                                         i_encabezado3 in varchar2 default null,
                                         i_encabezado4 in varchar2 default null,
                                         i_pie1        in varchar2 default null,
                                         i_pie2        in varchar2 default null,
                                         i_page_nr     in number default null,
                                         i_page_count  in number default null);

  function f_reporte_sql(i_consulta_sql in clob,
                         i_formato      in varchar2 default null)
    return y_archivo;

  function f_reporte_sql(i_id_reporte in number,
                         i_parametros in y_parametros) return y_archivo;

  function f_procesar_reporte(i_id_reporte in number,
                              i_parametros in clob,
                              i_contexto   in clob default null,
                              i_version    in varchar2 default null)
    return clob;

  function f_procesar_reporte(i_nombre     in varchar2,
                              i_dominio    in varchar2,
                              i_parametros in clob,
                              i_contexto   in clob default null,
                              i_version    in varchar2 default null)
    return clob;

end;
/
