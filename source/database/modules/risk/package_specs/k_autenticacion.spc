CREATE OR REPLACE PACKAGE k_autenticacion IS

  /**
  Agrupa operaciones relacionadas con la autenticacion de usuarios
  
  %author jtsoya539 27/3/2020 16:16:59
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

  -- Origenes de usuario
  c_origen_risk     CONSTANT CHAR(1) := 'R';
  c_origen_google   CONSTANT CHAR(1) := 'G';
  c_origen_facebook CONSTANT CHAR(1) := 'F';

  -- Métodos de validación de credenciales
  c_metodo_validacion_risk   CONSTANT VARCHAR2(10) := 'RISK';
  c_metodo_validacion_oracle CONSTANT VARCHAR2(10) := 'ORACLE';

  FUNCTION f_registrar_usuario(i_alias            IN VARCHAR2,
                               i_clave            IN VARCHAR2,
                               i_nombre           IN VARCHAR2,
                               i_apellido         IN VARCHAR2,
                               i_direccion_correo IN VARCHAR2,
                               i_numero_telefono  IN VARCHAR2 DEFAULT NULL,
                               i_origen           IN VARCHAR2 DEFAULT NULL,
                               i_id_externo       IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2;

  PROCEDURE p_editar_usuario(i_alias_antiguo    IN VARCHAR2,
                             i_alias_nuevo      IN VARCHAR2,
                             i_nombre           IN VARCHAR2,
                             i_apellido         IN VARCHAR2,
                             i_direccion_correo IN VARCHAR2,
                             i_numero_telefono  IN VARCHAR2 DEFAULT NULL);

  FUNCTION f_validar_credenciales_risk(i_id_usuario IN NUMBER,
                                       i_clave      IN VARCHAR2,
                                       i_tipo_clave IN CHAR DEFAULT 'A')
    RETURN BOOLEAN;

  FUNCTION f_validar_credenciales_oracle(i_usuario IN VARCHAR2,
                                         i_clave   IN VARCHAR2)
    RETURN BOOLEAN;

  FUNCTION f_validar_credenciales(i_usuario    IN VARCHAR2,
                                  i_clave      IN VARCHAR2,
                                  i_tipo_clave IN CHAR DEFAULT 'A',
                                  i_metodo     IN VARCHAR2 DEFAULT NULL)
    RETURN BOOLEAN;

  PROCEDURE p_validar_credenciales(i_usuario    IN VARCHAR2,
                                   i_clave      IN VARCHAR2,
                                   i_tipo_clave IN CHAR DEFAULT 'A',
                                   i_metodo     IN VARCHAR2 DEFAULT NULL);

  FUNCTION f_iniciar_sesion(i_id_aplicacion     IN VARCHAR2,
                            i_usuario           IN VARCHAR2,
                            i_access_token      IN VARCHAR2,
                            i_refresh_token     IN VARCHAR2,
                            i_token_dispositivo IN VARCHAR2 DEFAULT NULL,
                            i_origen            IN VARCHAR2 DEFAULT NULL,
                            i_dato_externo      IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  FUNCTION f_refrescar_sesion(i_id_aplicacion         IN VARCHAR2,
                              i_access_token_antiguo  IN VARCHAR2,
                              i_refresh_token_antiguo IN VARCHAR2,
                              i_access_token_nuevo    IN VARCHAR2,
                              i_refresh_token_nuevo   IN VARCHAR2,
                              i_origen                IN VARCHAR2 DEFAULT NULL,
                              i_dato_externo          IN VARCHAR2 DEFAULT NULL)
    RETURN NUMBER;

  FUNCTION f_generar_url_activacion(i_alias IN VARCHAR2) RETURN VARCHAR2;

END;
/
