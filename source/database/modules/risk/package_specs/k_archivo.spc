create or replace package k_archivo is

  /**
  Agrupa operaciones relacionadas con archivos
  
  %author jtsoya539 27/3/2020 16:22:16
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors
  
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
  c_carpeta_fuentes  constant varchar2(30) := 'FUENTES';
  c_carpeta_imagenes constant varchar2(30) := 'IMAGENES';
  c_carpeta_textos   constant varchar2(30) := 'TEXTOS';

  function f_tipo_mime(i_dominio   in varchar2,
                       i_extension in varchar2) return varchar2;

  function f_recuperar_archivo(i_tabla      in varchar2,
                               i_campo      in varchar2,
                               i_referencia in varchar2,
                               i_version    in varchar2 default null)
    return y_archivo;

  procedure p_guardar_archivo(i_tabla      in varchar2,
                              i_campo      in varchar2,
                              i_referencia in varchar2,
                              i_archivo    in y_archivo);

  procedure p_calcular_propiedades(i_contenido in blob,
                                   o_checksum  out varchar2,
                                   o_tamano    out number);

  function f_version_archivo(i_tabla      in varchar2,
                             i_campo      in varchar2,
                             i_referencia in varchar2) return number;

  function f_data_url(i_contenido in blob,
                      i_tipo_mime in varchar2) return clob;

  function f_data_url(i_tabla      in varchar2,
                      i_campo      in varchar2,
                      i_referencia in varchar2,
                      i_version    in varchar2 default null) return clob;

end;
/
