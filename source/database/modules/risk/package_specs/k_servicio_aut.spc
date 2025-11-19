create or replace package k_servicio_aut is

  /**
  Agrupa operaciones relacionadas con los Servicios Web del dominio AUT
  
  %author jtsoya539 27/3/2020 16:42:26
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

  -- Códigos de respuesta
  c_usuario_externo_existente constant varchar2(10) := 'aut0010';

  function registrar_usuario(i_parametros in y_parametros) return y_respuesta;

  function cambiar_estado_usuario(i_parametros in y_parametros)
    return y_respuesta;

  function registrar_clave(i_parametros in y_parametros) return y_respuesta;

  function cambiar_clave(i_parametros in y_parametros) return y_respuesta;

  function validar_credenciales(i_parametros in y_parametros)
    return y_respuesta;

  function validar_clave_aplicacion(i_parametros in y_parametros)
    return y_respuesta;

  function validar_sesion(i_parametros in y_parametros) return y_respuesta;

  function iniciar_sesion(i_parametros in y_parametros) return y_respuesta;

  function refrescar_sesion(i_parametros in y_parametros) return y_respuesta;

  function cambiar_estado_sesion(i_parametros in y_parametros)
    return y_respuesta;

  function datos_usuario(i_parametros in y_parametros) return y_respuesta;

  function registrar_dispositivo(i_parametros in y_parametros)
    return y_respuesta;

  function datos_dispositivo(i_parametros in y_parametros) return y_respuesta;

  function registrar_ubicacion(i_parametros in y_parametros)
    return y_respuesta;

  function tiempo_expiracion_token(i_parametros in y_parametros)
    return y_respuesta;

  function editar_usuario(i_parametros in y_parametros) return y_respuesta;

  function editar_dato_usuario(i_parametros in y_parametros)
    return y_respuesta;

  function generar_otp(i_parametros in y_parametros) return y_respuesta;

  function validar_otp(i_parametros in y_parametros) return y_respuesta;

  function validar_permiso(i_parametros in y_parametros) return y_respuesta;

end;
/
