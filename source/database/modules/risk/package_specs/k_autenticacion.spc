create or replace package k_autenticacion is

  /**
  Agrupa operaciones relacionadas con la autenticacion de usuarios
  
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

  -- Orígenes de autenticación
  c_origen_risk     constant varchar2(1) := 'R';
  c_origen_google   constant varchar2(1) := 'G';
  c_origen_facebook constant varchar2(1) := 'F';
  --
  c_origen_ldap   constant varchar2(1) := 'L';
  c_origen_oracle constant varchar2(1) := 'O';

  -- Métodos de validación de credenciales
  c_metodo_validacion_risk    constant varchar2(10) := 'RISK';
  c_metodo_validacion_oracle  constant varchar2(10) := 'ORACLE';
  c_metodo_validacion_ldap    constant varchar2(10) := 'LDAP';
  c_metodo_validacion_externo constant varchar2(10) := 'EXTERNO';

  -- Excepciones
  ex_credenciales_invalidas exception;
  ex_tokens_invalidos       exception;

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
                                       i_parametros in y_parametros)
    return boolean;

  function f_validar_credenciales_oracle(i_usuario    in varchar2,
                                         i_clave      in varchar2,
                                         i_parametros in y_parametros)
    return boolean;

  function f_validar_credenciales_ldap(i_usuario    in varchar2,
                                       i_clave      in varchar2,
                                       i_parametros in y_parametros)
    return boolean;

  function f_validar_credenciales(i_usuario in varchar2,
                                  i_clave   in varchar2,
                                  i_origen  in varchar2 default null)
    return boolean;

  procedure p_validar_credenciales(i_usuario in varchar2,
                                   i_clave   in varchar2,
                                   i_origen  in varchar2 default null);

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

  procedure p_importar_usuarios_ldap(i_origen  in varchar2,
                                     i_usuario in varchar2,
                                     i_clave   in varchar2);

end;
/
