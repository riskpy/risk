CREATE OR REPLACE PACKAGE k_servicio_aut IS

  /**
  Agrupa operaciones relacionadas con los Servicios Web del dominio AUT
  
  %author jtsoya539 27/3/2020 16:42:26
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

  -- Códigos de respuesta
  c_usuario_externo_existente CONSTANT VARCHAR2(10) := 'aut0010';

  FUNCTION registrar_usuario(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION cambiar_estado_usuario(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION registrar_clave(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION cambiar_clave(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION validar_credenciales(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION validar_clave_aplicacion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION validar_sesion(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION iniciar_sesion(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION refrescar_sesion(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION cambiar_estado_sesion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION datos_usuario(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION registrar_dispositivo(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION datos_dispositivo(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION registrar_ubicacion(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION tiempo_expiracion_token(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION editar_usuario(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION editar_dato_usuario(i_parametros IN y_parametros)
    RETURN y_respuesta;

  FUNCTION generar_otp(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION validar_otp(i_parametros IN y_parametros) RETURN y_respuesta;

  FUNCTION validar_permiso(i_parametros IN y_parametros) RETURN y_respuesta;

END;
/
