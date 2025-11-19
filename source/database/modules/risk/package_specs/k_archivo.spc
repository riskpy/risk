CREATE OR REPLACE PACKAGE k_archivo IS

  /**
  Agrupa operaciones relacionadas con archivos
  
  %author jtsoya539 27/3/2020 16:22:16
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
  
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

  -- Carpetas de archivos
  c_carpeta_fuentes  CONSTANT VARCHAR2(30) := 'FUENTES';
  c_carpeta_imagenes CONSTANT VARCHAR2(30) := 'IMAGENES';
  c_carpeta_textos   CONSTANT VARCHAR2(30) := 'TEXTOS';

  FUNCTION f_tipo_mime(i_dominio   IN VARCHAR2,
                       i_extension IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_recuperar_archivo(i_tabla      IN VARCHAR2,
                               i_campo      IN VARCHAR2,
                               i_referencia IN VARCHAR2,
                               i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN y_archivo;

  PROCEDURE p_guardar_archivo(i_tabla      IN VARCHAR2,
                              i_campo      IN VARCHAR2,
                              i_referencia IN VARCHAR2,
                              i_archivo    IN y_archivo);

  PROCEDURE p_calcular_propiedades(i_contenido IN BLOB,
                                   o_checksum  OUT VARCHAR2,
                                   o_tamano    OUT NUMBER);

  FUNCTION f_version_archivo(i_tabla      IN VARCHAR2,
                             i_campo      IN VARCHAR2,
                             i_referencia IN VARCHAR2) RETURN NUMBER;

  FUNCTION f_data_url(i_contenido IN BLOB,
                      i_tipo_mime IN VARCHAR2) RETURN CLOB;

  FUNCTION f_data_url(i_tabla      IN VARCHAR2,
                      i_campo      IN VARCHAR2,
                      i_referencia IN VARCHAR2,
                      i_version    IN VARCHAR2 DEFAULT NULL) RETURN CLOB;

END;
/
