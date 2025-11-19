create or replace package k_autenticacion is

  /**
  Agrupa operaciones relacionadas con la autenticacion de usuarios
  
  %author jtsoya539 27/3/2020 16:16:59
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

  -- Origenes de usuario
  c_origen_risk     constant char(1) := 'R';
  c_origen_google   constant char(1) := 'G';
  c_origen_facebook constant char(1) := 'F';

  -- Métodos de validación de credenciales
  c_metodo_validacion_risk   constant varchar2(10) := 'RISK';
  c_metodo_validacion_oracle constant varchar2(10) := 'ORACLE';

  function f_registrar_usuario(i_alias            in varchar2,
                               i_clave            in varchar2,
                               i_nombre           in varchar2,
                               i_apellido         in varchar2,
                               i_direccion_correo in varchar2,
                               i_numero_telefono  in varchar2 default null,
                               i_origen           in varchar2 default null,
                               i_id_externo       in varchar2 default null)
    return varchar2;

  procedure p_editar_usuario(i_alias_antiguo    in varchar2,
                             i_alias_nuevo      in varchar2,
                             i_nombre           in varchar2,
                             i_apellido         in varchar2,
                             i_direccion_correo in varchar2,
                             i_numero_telefono  in varchar2 default null);

  function f_validar_credenciales_risk(i_id_usuario in number,
                                       i_clave      in varchar2,
                                       i_tipo_clave in char default 'A')
    return boolean;

  function f_validar_credenciales_oracle(i_usuario in varchar2,
                                         i_clave   in varchar2)
    return boolean;

  function f_validar_credenciales(i_usuario    in varchar2,
                                  i_clave      in varchar2,
                                  i_tipo_clave in char default 'A',
                                  i_metodo     in varchar2 default null)
    return boolean;

  procedure p_validar_credenciales(i_usuario    in varchar2,
                                   i_clave      in varchar2,
                                   i_tipo_clave in char default 'A',
                                   i_metodo     in varchar2 default null);

  function f_iniciar_sesion(i_id_aplicacion     in varchar2,
                            i_usuario           in varchar2,
                            i_access_token      in varchar2,
                            i_refresh_token     in varchar2,
                            i_token_dispositivo in varchar2 default null,
                            i_origen            in varchar2 default null,
                            i_dato_externo      in varchar2 default null)
    return number;

  function f_refrescar_sesion(i_id_aplicacion         in varchar2,
                              i_access_token_antiguo  in varchar2,
                              i_refresh_token_antiguo in varchar2,
                              i_access_token_nuevo    in varchar2,
                              i_refresh_token_nuevo   in varchar2,
                              i_origen                in varchar2 default null,
                              i_dato_externo          in varchar2 default null)
    return number;

  function f_generar_url_activacion(i_alias in varchar2) return varchar2;

end;
/
