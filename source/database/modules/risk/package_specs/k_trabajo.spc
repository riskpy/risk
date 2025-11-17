CREATE OR REPLACE PACKAGE k_trabajo IS

  /**
  Agrupa operaciones relacionadas con los Trabajos del sistema
  
  %author dmezac 4/9/2020 07:30:15
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

  -- Códigos de respuesta
  c_ok                      CONSTANT VARCHAR2(10) := '0';
  c_trabajo_no_implementado CONSTANT VARCHAR2(10) := 'tra0001';
  c_error_parametro         CONSTANT VARCHAR2(10) := 'tra0002';
  c_error_general           CONSTANT VARCHAR2(10) := 'tra0099';
  c_error_inesperado        CONSTANT VARCHAR2(10) := 'tra9999';

  -- Excepciones
  ex_trabajo_no_implementado  EXCEPTION;
  ex_trabajo_ya_existe        EXCEPTION;
  ex_trabajo_no_existe        EXCEPTION;
  ex_error_parametro          EXCEPTION;
  ex_programa_con_dependencia EXCEPTION;
  ex_error_general            EXCEPTION;
  PRAGMA EXCEPTION_INIT(ex_trabajo_no_existe, -27475);
  PRAGMA EXCEPTION_INIT(ex_trabajo_no_existe, -27476);
  PRAGMA EXCEPTION_INIT(ex_trabajo_ya_existe, -27477);
  PRAGMA EXCEPTION_INIT(ex_programa_con_dependencia, -27479);

  -- Códigos de trabajos del sistema
  c_monitoreo_conflictos_mensual  CONSTANT NUMBER(15) := 2000;
  c_monitoreo_conflictos_semanal  CONSTANT NUMBER(15) := 2001;
  c_monitoreo_conflictos_diario   CONSTANT NUMBER(15) := 2002;
  c_monitoreo_conflictos_12_horas CONSTANT NUMBER(15) := 2003;
  c_monitoreo_conflictos_6_horas  CONSTANT NUMBER(15) := 2004;
  c_monitoreo_conflictos_2_horas  CONSTANT NUMBER(15) := 2005;
  c_monitoreo_conflictos_hora     CONSTANT NUMBER(15) := 2006;

  -- Crea un trabajo en el sistema
  -- Para crear un trabajo el usuario debe tener permiso de CREATE JOB
  -- GRANT CREATE JOB TO &user;
  -- %param
  PROCEDURE p_crear_trabajo(i_id_trabajo           IN NUMBER,
                            i_parametros           IN CLOB DEFAULT NULL,
                            i_fecha_inicio         IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                            i_intervalo_repeticion IN VARCHAR2 DEFAULT NULL,
                            i_fecha_fin            IN TIMESTAMP WITH TIME ZONE DEFAULT NULL);

  -- Edita un trabajo en el sistema
  -- Edición de la acción o programa del trabajo no implementada
  -- %param
  PROCEDURE p_editar_trabajo(i_id_trabajo           IN NUMBER,
                             i_parametros           IN CLOB DEFAULT NULL,
                             i_fecha_inicio         IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                             i_intervalo_repeticion IN VARCHAR2 DEFAULT NULL,
                             i_fecha_fin            IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                             i_editar_accion        IN BOOLEAN DEFAULT FALSE);

  -- Crea o edita un trabajo en el sistema
  -- Edición de la acción o programa del trabajo no implementada
  -- %param
  PROCEDURE p_crear_o_editar_trabajo(i_id_trabajo           IN NUMBER,
                                     i_parametros           IN CLOB DEFAULT NULL,
                                     i_fecha_inicio         IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
                                     i_intervalo_repeticion IN VARCHAR2 DEFAULT NULL,
                                     i_fecha_fin            IN TIMESTAMP WITH TIME ZONE DEFAULT NULL);

  -- Elimina un trabajo en el sistema
  -- %param
  PROCEDURE p_eliminar_trabajo(i_id_trabajo IN NUMBER,
                               i_parametros IN CLOB DEFAULT NULL);

END;
/
