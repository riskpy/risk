create or replace package k_trabajo is

  /**
  Agrupa operaciones relacionadas con los Trabajos del sistema
  
  %author dmezac 4/9/2020 07:30:15
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

  -- Códigos de respuesta
  c_ok                      constant varchar2(10) := '0';
  c_trabajo_no_implementado constant varchar2(10) := 'tra0001';
  c_error_parametro         constant varchar2(10) := 'tra0002';
  c_error_general           constant varchar2(10) := 'tra0099';
  c_error_inesperado        constant varchar2(10) := 'tra9999';

  -- Excepciones
  ex_trabajo_no_implementado  exception;
  ex_trabajo_ya_existe        exception;
  ex_trabajo_no_existe        exception;
  ex_error_parametro          exception;
  ex_programa_con_dependencia exception;
  ex_error_general            exception;
  pragma exception_init(ex_trabajo_no_existe, -27475);
  pragma exception_init(ex_trabajo_no_existe, -27476);
  pragma exception_init(ex_trabajo_ya_existe, -27477);
  pragma exception_init(ex_programa_con_dependencia, -27479);

  -- Códigos de trabajos del sistema
  c_monitoreo_conflictos_mensual    constant number(15) := 2000;
  c_monitoreo_conflictos_semanal    constant number(15) := 2001;
  c_monitoreo_conflictos_diario     constant number(15) := 2002;
  c_monitoreo_conflictos_12_horas   constant number(15) := 2003;
  c_monitoreo_conflictos_6_horas    constant number(15) := 2004;
  c_monitoreo_conflictos_2_horas    constant number(15) := 2005;
  c_monitoreo_conflictos_hora       constant number(15) := 2006;
  c_monitoreo_conflictos_30_minutos constant number(15) := 2007;
  c_monitoreo_conflictos_15_minutos constant number(15) := 2008;

  -- Crea un trabajo en el sistema
  -- Para crear un trabajo el usuario debe tener permiso de CREATE JOB
  -- GRANT CREATE JOB TO &user;
  -- %param
  procedure p_crear_trabajo(i_id_trabajo           in number,
                            i_parametros           in clob default null,
                            i_fecha_inicio         in timestamp with time zone default null,
                            i_intervalo_repeticion in varchar2 default null,
                            i_fecha_fin            in timestamp with time zone default null);

  -- Edita un trabajo en el sistema
  -- Edición de la acción o programa del trabajo no implementada
  -- %param
  procedure p_editar_trabajo(i_id_trabajo           in number,
                             i_parametros           in clob default null,
                             i_fecha_inicio         in timestamp with time zone default null,
                             i_intervalo_repeticion in varchar2 default null,
                             i_fecha_fin            in timestamp with time zone default null,
                             i_editar_accion        in boolean default false);

  -- Crea o edita un trabajo en el sistema
  -- Edición de la acción o programa del trabajo no implementada
  -- %param
  procedure p_crear_o_editar_trabajo(i_id_trabajo           in number,
                                     i_parametros           in clob default null,
                                     i_fecha_inicio         in timestamp with time zone default null,
                                     i_intervalo_repeticion in varchar2 default null,
                                     i_fecha_fin            in timestamp with time zone default null);

  -- Elimina un trabajo en el sistema
  -- %param
  procedure p_eliminar_trabajo(i_id_trabajo in number,
                               i_parametros in clob default null);

  procedure p_mantener_trabajos(i_id_modulo in varchar2 default null);

end;
/

