create or replace type y_pagina_parametros under y_objeto
(
/**
Parámetros para paginación de elementos.

%author jtsoya539 30/3/2020 10:57:43
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

/** Número de la página */
  pagina integer,
/** Cantidad de elementos por página */
  por_pagina integer,
/** No paginar? (S/N) */
  no_paginar varchar2(1),

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_pagina_parametros.
*/
  constructor function y_pagina_parametros return self as result,

  static function parse_json(i_json in clob) return y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  overriding member function to_json return clob
)
/
