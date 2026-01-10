create or replace type y_plantilla under y_dato
(
/**
Contiene una plantilla de notificación push.

%author dmezac 20/6/2021 20:35:55
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

/** Contenido en formato de texto. */
  nombre varchar2(100),

/**
Constructor del objeto sin parámetros.

%author dmezac 20/6/2021 20:08:08
%return Objeto del tipo y_plantilla.
*/
  constructor function y_plantilla return self as result,

  static function parse_json(i_json in clob) return y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author dmezac 20/6/2021 19:42:09
%return JSON con los atributos del objeto.
*/
  overriding member function to_json return clob
)
/
