CREATE OR REPLACE PACKAGE k_error IS

  /**
  Agrupa operaciones relacionadas con los errores o textos
  
  %author jtsoya539 27/3/2020 16:22:16
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

  -- Tipos de error
  c_oracle_predefined_error CONSTANT VARCHAR2(3) := 'OPE';
  c_user_defined_error      CONSTANT VARCHAR2(3) := 'UDE';

  c_wrap_char CONSTANT VARCHAR2(1) := '@';

  FUNCTION f_tipo_excepcion(i_sqlcode IN NUMBER) RETURN VARCHAR2;

  /**
  Retorna el mensaje de error de una excepcion de Oracle
  
  %author jtsoya539 27/3/2020 16:23:08
  %param i_sqlerrm Mensaje de la excepcion (SQLERRM)
  %return Mensaje de error
  */
  FUNCTION f_mensaje_excepcion(i_sqlerrm IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION f_mensaje_error(i_clave     IN VARCHAR2,
                           i_cadenas   IN y_cadenas,
                           i_wrap_char IN VARCHAR2 DEFAULT c_wrap_char)
    RETURN VARCHAR2;

  FUNCTION f_mensaje_error(i_clave     IN VARCHAR2,
                           i_cadena1   IN VARCHAR2 DEFAULT NULL,
                           i_cadena2   IN VARCHAR2 DEFAULT NULL,
                           i_cadena3   IN VARCHAR2 DEFAULT NULL,
                           i_cadena4   IN VARCHAR2 DEFAULT NULL,
                           i_cadena5   IN VARCHAR2 DEFAULT NULL,
                           i_wrap_char IN VARCHAR2 DEFAULT c_wrap_char)
    RETURN VARCHAR2;

END;
/
