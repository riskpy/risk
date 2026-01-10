create or replace package k_servicio is

  /**
  Agrupa operaciones relacionadas con los Servicios Web del sistema
  
  %author jtsoya539 27/3/2020 16:42:26
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

  procedure p_limpiar_historial;

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

  function f_servicio_sql(i_id_servicio in number,
                          i_parametros  in y_parametros) return y_respuesta;

  function f_procesar_servicio(i_id_servicio in number,
                               i_parametros  in clob,
                               i_contexto    in clob default null,
                               i_version     in varchar2 default null)
    return clob;

  function f_procesar_servicio(i_nombre     in varchar2,
                               i_dominio    in varchar2,
                               i_parametros in clob,
                               i_contexto   in clob default null,
                               i_version    in varchar2 default null)
    return clob;

end;
/
