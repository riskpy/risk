create or replace package k_clave is

  /**
  Agrupa operaciones relacionadas con claves de usuarios
  
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

  -- Tipos de clave
  c_clave_acceso        constant char(1) := 'A';
  c_clave_transaccional constant char(1) := 'T';

  function f_randombytes_hex return varchar2;

  function f_randombytes_base64 return varchar2;

  function f_salt return varchar2;

  function f_hash(i_clave in varchar2,
                  i_salt  in varchar2) return varchar2;

  function f_validar_clave(i_id_usuario in number,
                           i_clave      in varchar2,
                           i_tipo_clave in char default 'A') return boolean;

  procedure p_registrar_intento_fallido(i_id_usuario in number,
                                        i_tipo_clave in char default 'A');

  procedure p_registrar_autenticacion(i_id_usuario in number,
                                      i_tipo_clave in char default 'A');

  procedure p_validar_politicas(i_alias      in varchar2,
                                i_clave      in varchar2,
                                i_tipo_clave in char default 'A');

  procedure p_registrar_clave(i_alias      in varchar2,
                              i_clave      in varchar2,
                              i_tipo_clave in char default 'A');

  procedure p_desbloquear_clave(i_alias      in varchar2,
                                i_tipo_clave in char default 'A');

  procedure p_restablecer_clave(i_alias      in varchar2,
                                i_clave      in varchar2,
                                i_tipo_clave in char default 'A');

  procedure p_cambiar_clave(i_alias         in varchar2,
                            i_clave_antigua in varchar2,
                            i_clave_nueva   in varchar2,
                            i_tipo_clave    in char default 'A');

end;
/
