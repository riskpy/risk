create or replace package k_autorizacion is

  /**
  Agrupa operaciones relacionadas con la autorizacion de usuarios
  
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

  -- Acciones
  c_accion_consultar  constant varchar2(1) := 'C';
  c_accion_insertar   constant varchar2(1) := 'I';
  c_accion_actualizar constant varchar2(1) := 'A';
  c_accion_eliminar   constant varchar2(1) := 'E';
  c_accion_cargar     constant varchar2(1) := 'I';
  c_accion_verificar  constant varchar2(1) := 'V';
  c_accion_autorizar  constant varchar2(1) := 'T';

  procedure p_inicializar_permisos;

  procedure p_limpiar_permisos;

  procedure p_eliminar_permisos;

  procedure p_imprimir_permisos;

  function f_permisos_usuario(i_id_usuario in number,
                              i_id_entidad in number default null,
                              i_grupo      in varchar2 default null)
    return y_permisos;

  function f_validar_permiso(i_id_usuario in number,
                             i_id_permiso in varchar2,
                             i_accion     in varchar2 default null,
                             i_id_entidad in number default null,
                             i_grupo      in varchar2 default null)
    return boolean;

end;
/

