create or replace package k_dispositivo is

  /**
  Agrupa operaciones relacionadas con los dispositivos
  
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

  c_suscripcion_defecto constant varchar2(120) := 'default';
  c_suscripcion_usuario constant varchar2(120) := 'user';

  function f_suscripcion_defecto return varchar2;

  function f_suscripcion_usuario(i_id_usuario in number) return varchar2;

  function f_id_dispositivo(i_token_dispositivo in varchar2) return number;

  function f_registrar_dispositivo(i_id_aplicacion             in varchar2,
                                   i_token_dispositivo         in varchar2,
                                   i_token_notificacion        in varchar2 default null,
                                   i_nombre_sistema_operativo  in varchar2 default null,
                                   i_version_sistema_operativo in varchar2 default null,
                                   i_tipo                      in varchar2 default null,
                                   i_nombre_navegador          in varchar2 default null,
                                   i_version_navegador         in varchar2 default null,
                                   i_version_aplicacion        in varchar2 default null,
                                   i_pais_iso_alpha_2          in varchar2 default null,
                                   i_zona_horaria              in varchar2 default null,
                                   i_idioma_iso369_1           in varchar2 default null)
    return number;

  function f_datos_dispositivo(i_id_dispositivo in number)
    return y_dispositivo;

  $if k_modulo.c_instalado_msj $then
  procedure p_suscribir_notificacion(i_id_dispositivo   in number,
                                     i_suscripcion_alta in varchar2);

  /**
  Suscribe a una notificación a partir de otra suscripción
  
  %author dmezac 24/6/2021 10:05:15
  %param i_suscripcion Suscripción original
  %param i_suscripcion_alta Suscripción a dar de alta
  */
  procedure p_suscribir_notificacion_s(i_suscripcion      in varchar2,
                                       i_suscripcion_alta in varchar2);

  /**
  Suscribe el dispositivo a las notificaciones de un usuario
  
  %author dmezac 15/7/2021 23:30:15
  %param i_id_dispositivo Identificador del dispositivo
  %param i_id_usuario Identificador del usuario
  */
  procedure p_suscribir_notificacion_usuario(i_id_dispositivo in number,
                                             i_id_usuario     in number);

  procedure p_desuscribir_notificacion(i_id_dispositivo   in number,
                                       i_suscripcion_baja in varchar2);

  /**
  Desuscribe de una notificación a partir de otra suscripción
  
  %author dmezac 24/6/2021 10:05:15
  %param i_suscripcion Suscripción original
  %param i_suscripcion_alta Suscripción a dar de baja
  */
  procedure p_desuscribir_notificacion_s(i_suscripcion      in varchar2,
                                         i_suscripcion_baja in varchar2);

  /**
  Desuscribe el dispositivo de las notificaciones de un usuario
  
  %author dmezac 15/7/2021 23:30:15
  %param i_id_dispositivo Identificador del dispositivo
  %param i_id_usuario Identificador del usuario
  */
  procedure p_desuscribir_notificacion_usuario(i_id_dispositivo in number,
                                               i_id_usuario     in number);
  $end

  procedure p_registrar_ubicacion(i_id_dispositivo in number,
                                  i_latitud        in number,
                                  i_longitud       in number);

end;
/
