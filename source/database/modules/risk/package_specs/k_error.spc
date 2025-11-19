create or replace package k_error is

  /**
  Agrupa operaciones relacionadas con los errores o textos
  
  %author jtsoya539 27/3/2020 16:22:16
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

  -- Tipos de error
  c_oracle_predefined_error constant varchar2(3) := 'OPE';
  c_user_defined_error      constant varchar2(3) := 'UDE';

  c_wrap_char constant varchar2(1) := '@';

  function f_tipo_excepcion(i_sqlcode in number) return varchar2;

  /**
  Retorna el mensaje de error de una excepcion de Oracle
  
  %author jtsoya539 27/3/2020 16:23:08
  %param i_sqlerrm Mensaje de la excepcion (SQLERRM)
  %return Mensaje de error
  */
  function f_mensaje_excepcion(i_sqlerrm in varchar2) return varchar2;

  function f_mensaje_error(i_clave     in varchar2,
                           i_cadenas   in y_cadenas,
                           i_wrap_char in varchar2 default c_wrap_char)
    return varchar2;

  function f_mensaje_error(i_clave     in varchar2,
                           i_cadena1   in varchar2 default null,
                           i_cadena2   in varchar2 default null,
                           i_cadena3   in varchar2 default null,
                           i_cadena4   in varchar2 default null,
                           i_cadena5   in varchar2 default null,
                           i_wrap_char in varchar2 default c_wrap_char)
    return varchar2;

end;
/
