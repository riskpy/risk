CREATE OR REPLACE PACKAGE k_importacion IS

  /**
  Agrupa operaciones relacionadas con la Importación de Archivos del sistema
  
  %author dmezac 09/11/2025 11:32:15
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

  -- Códigos de respuesta
  c_error_general_importacion CONSTANT VARCHAR2(10) := 'import0001';

  FUNCTION f_procesar_importacion_local(i_id_importacion         IN NUMBER,
                                        i_archivo                IN BLOB,
                                        i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                        i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta;

  FUNCTION f_procesar_importacion_autonoma(i_id_importacion         IN NUMBER,
                                           i_archivo                IN BLOB,
                                           i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                           i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta;

  FUNCTION f_procesar_importacion(i_id_importacion         IN NUMBER,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN DEFAULT FALSE,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_procesar_importacion(i_nombre                 IN VARCHAR2,
                                  i_dominio                IN VARCHAR2,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN DEFAULT FALSE,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

END;
/
