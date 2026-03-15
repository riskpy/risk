create or replace package k_async is

  /**
  Agrupa operaciones relacionadas con las ejecuciones asíncronas de procesos
  
  %author jtsoya539 27/3/2020 16:16:59
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

  c_aplicacion_async constant t_aplicaciones.nombre%type := 'JB_PROCESO_ASYNC';

  function f_registrar_ejecucion(i_bloque_plsql in clob,
                                 i_descripcion  in varchar2 default null,
                                 i_referencia   in varchar2 default null)
    return number;

  procedure p_iniciar_ejecucion(i_id_ejecucion in number);

  procedure p_finalizar_ejecucion_ok(i_id_ejecucion in number);

  procedure p_finalizar_ejecucion_error(i_id_ejecucion in number,
                                        i_detalle      in varchar2 default null);

  procedure p_ejecutar(i_id_ejecucion in number);

end;
/

