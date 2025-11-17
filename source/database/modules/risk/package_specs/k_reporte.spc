CREATE OR REPLACE PACKAGE k_reporte IS

  /**
  Agrupa operaciones relacionadas con los Reportes del sistema
  
  %author jtsoya539 27/3/2020 16:42:26
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 jtsoya539
  
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
  c_formato_pdf  CONSTANT VARCHAR2(10) := 'PDF';
  c_formato_docx CONSTANT VARCHAR2(10) := 'DOCX';
  c_formato_xlsx CONSTANT VARCHAR2(10) := 'XLSX';
  c_formato_csv  CONSTANT VARCHAR2(10) := 'CSV';
  c_formato_html CONSTANT VARCHAR2(10) := 'HTML';

  -- Orientaciones
  c_orientacion_vertical   CONSTANT VARCHAR2(10) := 'PORTRAIT';
  c_orientacion_horizontal CONSTANT VARCHAR2(10) := 'LANDSCAPE';

  -- Nombres de metadatos para conversión de reportes HTML a PDF
  c_meta_format           CONSTANT VARCHAR2(30) := 'risk:format';
  c_meta_page_size        CONSTANT VARCHAR2(30) := 'risk:page_size';
  c_meta_page_orientation CONSTANT VARCHAR2(30) := 'risk:page_orientation';

  PROCEDURE p_registrar_sql_ejecucion(i_id_reporte IN NUMBER,
                                      i_sql        IN CLOB);

  PROCEDURE p_limpiar_historial;

  FUNCTION f_archivo_ok(i_contenido IN BLOB,
                        i_formato   IN VARCHAR2 DEFAULT NULL,
                        i_nombre    IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo;

  FUNCTION f_archivo_error(i_respuesta IN y_respuesta,
                           i_formato   IN VARCHAR2 DEFAULT NULL,
                           i_nombre    IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo;

  FUNCTION f_formato(i_parametros IN y_parametros) RETURN VARCHAR2;

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
  PROCEDURE p_agregar_encabezado_pie_pdf(i_encabezado1 IN VARCHAR2 DEFAULT NULL,
                                         i_encabezado2 IN VARCHAR2 DEFAULT NULL,
                                         i_encabezado3 IN VARCHAR2 DEFAULT NULL,
                                         i_encabezado4 IN VARCHAR2 DEFAULT NULL,
                                         i_pie1        IN VARCHAR2 DEFAULT NULL,
                                         i_pie2        IN VARCHAR2 DEFAULT NULL,
                                         i_page_nr     IN NUMBER DEFAULT NULL,
                                         i_page_count  IN NUMBER DEFAULT NULL);

  FUNCTION f_reporte_sql(i_consulta_sql IN CLOB,
                         i_formato      IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo;

  FUNCTION f_reporte_sql(i_id_reporte IN NUMBER,
                         i_parametros IN y_parametros) RETURN y_archivo;

  FUNCTION f_procesar_reporte(i_id_reporte IN NUMBER,
                              i_parametros IN CLOB,
                              i_contexto   IN CLOB DEFAULT NULL,
                              i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_procesar_reporte(i_nombre     IN VARCHAR2,
                              i_dominio    IN VARCHAR2,
                              i_parametros IN CLOB,
                              i_contexto   IN CLOB DEFAULT NULL,
                              i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

END;
/
