CREATE OR REPLACE PACKAGE k_servicio IS

  /**
  Agrupa operaciones relacionadas con los Servicios Web del sistema
  
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

  PROCEDURE p_limpiar_historial;

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

  FUNCTION f_servicio_sql(i_id_servicio IN NUMBER,
                          i_parametros  IN y_parametros) RETURN y_respuesta;

  FUNCTION f_procesar_servicio(i_id_servicio IN NUMBER,
                               i_parametros  IN CLOB,
                               i_contexto    IN CLOB DEFAULT NULL,
                               i_version     IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_procesar_servicio(i_nombre     IN VARCHAR2,
                               i_dominio    IN VARCHAR2,
                               i_parametros IN CLOB,
                               i_contexto   IN CLOB DEFAULT NULL,
                               i_version    IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

END;
/
