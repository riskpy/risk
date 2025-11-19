CREATE OR REPLACE PACKAGE k_monitoreo IS

  /**
  Agrupa operaciones relacionadas con los Monitoreos de Conflictos del sistema
  
  %author dmezac 24/5/2022 10:42:26
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

  -- Constantes
  c_id_ejecucion CONSTANT VARCHAR2(50) := 'ID_EJECUCION';

  -- Excepciones
  ex_frecuencia_no_existe EXCEPTION;

  PROCEDURE p_limpiar_historial;

  PROCEDURE p_aviso_resumido(i_id_ejecucion IN NUMBER);

  PROCEDURE p_aviso_detallado(i_id_ejecucion IN NUMBER,
                              i_id_monitoreo IN NUMBER);

  FUNCTION f_pagina_parametros(i_parametros IN y_parametros)
    RETURN y_pagina_parametros;

  FUNCTION f_paginar_elementos(i_elementos           IN y_objetos,
                               i_numero_pagina       IN INTEGER DEFAULT NULL,
                               i_cantidad_por_pagina IN INTEGER DEFAULT NULL,
                               i_no_paginar          IN VARCHAR2 DEFAULT NULL)
    RETURN y_pagina;

  FUNCTION f_paginar_elementos(i_elementos         IN y_objetos,
                               i_pagina_parametros IN y_pagina_parametros)
    RETURN y_pagina;

  FUNCTION f_monitoreo_sql(i_id_monitoreo    IN NUMBER,
                           i_version         IN VARCHAR2 DEFAULT NULL,
                           o_tiene_conflicto OUT BOOLEAN) RETURN y_respuesta;

  FUNCTION f_monitoreo_columnas_sql(i_id_monitoreo IN NUMBER) RETURN CLOB;

  FUNCTION f_procesar_monitoreo(i_id_monitoreo IN NUMBER,
                                i_version      IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_procesar_monitoreo(i_nombre  IN VARCHAR2,
                                i_dominio IN VARCHAR2,
                                i_version IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  PROCEDURE p_procesar_monitoreos(i_frecuencia IN VARCHAR2 DEFAULT NULL);

END;
/
