CREATE OR REPLACE PACKAGE k_clave IS

  /**
  Agrupa operaciones relacionadas con claves de usuarios
  
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

  -- Tipos de clave
  c_clave_acceso        CONSTANT CHAR(1) := 'A';
  c_clave_transaccional CONSTANT CHAR(1) := 'T';

  FUNCTION f_randombytes_hex RETURN VARCHAR2;

  FUNCTION f_randombytes_base64 RETURN VARCHAR2;

  FUNCTION f_salt RETURN VARCHAR2;

  FUNCTION f_hash(i_clave IN VARCHAR2,
                  i_salt  IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_validar_clave(i_id_usuario IN NUMBER,
                           i_clave      IN VARCHAR2,
                           i_tipo_clave IN CHAR DEFAULT 'A') RETURN BOOLEAN;

  PROCEDURE p_registrar_intento_fallido(i_id_usuario IN NUMBER,
                                        i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_registrar_autenticacion(i_id_usuario IN NUMBER,
                                      i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_validar_politicas(i_alias      IN VARCHAR2,
                                i_clave      IN VARCHAR2,
                                i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_registrar_clave(i_alias      IN VARCHAR2,
                              i_clave      IN VARCHAR2,
                              i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_desbloquear_clave(i_alias      IN VARCHAR2,
                                i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_restablecer_clave(i_alias      IN VARCHAR2,
                                i_clave      IN VARCHAR2,
                                i_tipo_clave IN CHAR DEFAULT 'A');

  PROCEDURE p_cambiar_clave(i_alias         IN VARCHAR2,
                            i_clave_antigua IN VARCHAR2,
                            i_clave_nueva   IN VARCHAR2,
                            i_tipo_clave    IN CHAR DEFAULT 'A');

END;
/
