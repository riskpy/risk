create or replace package k_monitoreo is

  /**
  Agrupa operaciones relacionadas con los Monitoreos de Conflictos del sistema
  
  %author dmezac 24/5/2022 10:42:26
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

  -- Constantes
  c_id_ejecucion        constant varchar2(50) := 'ID_EJECUCION';
  c_plantilla_monitoreo constant t_correo_plantillas.id_plantilla%type := 'PLANTILLA_MONITOREO';
  --
  c_id_modulo constant t_modulos.id_modulo%type := 'RISK';

  -- Excepciones
  ex_frecuencia_no_existe exception;

  -- Variables globales
  g_est_modulo    varchar2(1);
  g_mod_cerrado   varchar2(1);
  g_dia_habil     varchar2(1);
  g_fecha_real    date;
  g_fecha_actual  date;
  g_fecha_proceso date;
  g_ini_timestamp t_monitoreo_ejecuciones.fecha_inicio_ejecucion%type;

  procedure p_limpiar_historial;

  procedure p_aviso_resumido(i_id_ejecucion in number);

  procedure p_aviso_detallado(i_id_ejecucion in number,
                              i_id_monitoreo in number);

  procedure p_aviso_mensaje(i_id_ejecucion in number,
                            i_id_monitoreo in number);

  procedure p_aviso_notificacion(i_id_ejecucion in number,
                                 i_id_monitoreo in number);

  function f_pagina_parametros(i_parametros in y_parametros)
    return y_pagina_parametros;

  function f_paginar_elementos(i_elementos           in y_objetos,
                               i_numero_pagina       in integer default null,
                               i_cantidad_por_pagina in integer default null,
                               i_no_paginar          in varchar2 default null)
    return y_pagina;

  function f_paginar_elementos(i_elementos         in y_objetos,
                               i_pagina_parametros in y_pagina_parametros)
    return y_pagina;

  function f_monitoreo_sql(i_id_monitoreo    in number,
                           i_version         in varchar2 default null,
                           o_tiene_conflicto out boolean) return y_respuesta;

  function f_monitoreo_columnas_sql(i_id_monitoreo in number) return clob;

  function f_procesar_monitoreo(i_id_monitoreo in number,
                                i_version      in varchar2 default null)
    return clob;

  function f_procesar_monitoreo(i_nombre  in varchar2,
                                i_dominio in varchar2,
                                i_version in varchar2 default null)
    return clob;

  procedure p_procesar_monitoreos(i_frecuencia in varchar2 default null);

end;
/

