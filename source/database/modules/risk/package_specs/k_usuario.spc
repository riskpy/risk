create or replace package k_usuario is

  /**
  Agrupa operaciones relacionadas con los usuarios
  
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

  -- Excepciones
  ex_usuario_inexistente exception;
  ex_usuario_existente   exception;

  function f_buscar_id(i_usuario in varchar2) return number;

  function f_id_usuario(i_alias in varchar2) return number;

  function f_id_usuario(i_id_persona in number,
                        i_origen     in varchar2 default null) return number;

  function f_id_persona(i_id_usuario in number) return number;

  function f_alias(i_id_usuario in number) return varchar2;

  function f_estado(i_id_usuario in number) return varchar2;

  function f_origen(i_id_usuario in number) return varchar2;

  function f_validar_alias(i_alias  varchar2,
                           i_origen in varchar2 default null) return boolean;

  procedure p_validar_alias(i_alias  varchar2,
                            i_origen in varchar2 default null);

  function f_version_avatar(i_alias in varchar2) return number;

  function f_datos_usuario(i_id_usuario in number) return y_usuario;

  function f_existe_usuario_externo(i_origen     in varchar2,
                                    i_id_externo in varchar2) return boolean;

  procedure p_separar_dominio_usuario(i_alias   in varchar2,
                                      o_dominio out varchar2,
                                      o_usuario out varchar2);

  procedure p_cambiar_estado(i_id_usuario in number,
                             i_estado     in varchar2);

  $if k_modulo.c_instalado_msj $then
  /**
  Suscribe usuario a una notificación
  
  %author dmezac 15/7/2021 23:05:15
  %param i_id_usuario Identificador del usuario
  %param i_suscripcion_alta Suscripción a dar de alta
  */
  procedure p_suscribir_notificacion(i_id_usuario       in number,
                                     i_suscripcion_alta in varchar2);

  /**
  Desuscribe usuario de una notificación
  
  %author dmezac 15/7/2021 23:05:15
  %param i_id_usuario Identificador del usuario
  %param i_suscripcion_baja Suscripción a dar de baja
  */
  procedure p_desuscribir_notificacion(i_id_usuario       in number,
                                       i_suscripcion_baja in varchar2);
  $end

  /**
  Guarda dato de un usuario
  
  %author dmezac 22/8/2021 15:05:15
  %param i_alias Alias del usuario
  %param i_campo Campo a guardar
  %param i_dato Dato a guardar
  */
  procedure p_guardar_dato_string(i_alias in varchar2,
                                  i_campo in varchar2,
                                  i_dato  in varchar2);

end;
/
