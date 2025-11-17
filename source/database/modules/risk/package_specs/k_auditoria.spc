CREATE OR REPLACE PACKAGE k_auditoria IS

  /**
  Agrupa operaciones relacionadas con la auditoria de tablas
  
  %author jtsoya539 27/3/2020 16:14:30
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

  -- Nombres de campos de auditoria
  g_nombre_campo_created_by VARCHAR2(30) := 'USUARIO_INSERCION';
  g_nombre_campo_created    VARCHAR2(30) := 'FECHA_INSERCION';
  g_nombre_campo_updated_by VARCHAR2(30) := 'USUARIO_MODIFICACION';
  g_nombre_campo_updated    VARCHAR2(30) := 'FECHA_MODIFICACION';

  -- Prefijos
  g_prefijo_tabla             VARCHAR2(30) := 't_';
  g_prefijo_trigger_auditoria VARCHAR2(30) := 'ga_';

  /**
  Genera campos de auditoria para una tabla
  
  %param i_tabla Tabla
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  PROCEDURE p_generar_campos_auditoria(i_tabla    IN VARCHAR2,
                                       i_ejecutar IN BOOLEAN DEFAULT TRUE);

  /**
  Genera trigger de auditoria para una tabla
  
  %param i_tabla Tabla
  %param i_trigger Trigger
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  PROCEDURE p_generar_trigger_auditoria(i_tabla    IN VARCHAR2,
                                        i_trigger  IN VARCHAR2 DEFAULT NULL,
                                        i_ejecutar IN BOOLEAN DEFAULT TRUE);

  /**
  Elimina campos de auditoria para una tabla
  
  %param i_tabla Tabla
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  PROCEDURE p_eliminar_campos_auditoria(i_tabla    IN VARCHAR2,
                                        i_ejecutar IN BOOLEAN DEFAULT TRUE);

  /**
  Elimina trigger de auditoria para una tabla
  
  %param i_tabla Tabla
  %param i_trigger Trigger
  %param i_ejecutar Ejecutar la(s) sentencia(s)?
  */
  PROCEDURE p_eliminar_trigger_auditoria(i_tabla    IN VARCHAR2,
                                         i_trigger  IN VARCHAR2 DEFAULT NULL,
                                         i_ejecutar IN BOOLEAN DEFAULT TRUE);

END;
/
