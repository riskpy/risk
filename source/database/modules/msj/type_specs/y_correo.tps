CREATE OR REPLACE TYPE y_correo UNDER y_objeto
(
/**
Agrupa datos de un correo electrónico (E-mail).

%author jtsoya539 30/3/2020 11:13:53
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

/** Identificador del correo electrónico */
  id_correo NUMBER,
/** Campo To del mensaje */
  mensaje_to VARCHAR2(4000),
/** Campo Subject del mensaje */
  mensaje_subject VARCHAR2(2000),
/** Cuerpo del mensaje */
  mensaje_body CLOB,
/** Campo From del mensaje */
  mensaje_from VARCHAR2(2000),
/** Campo Reply-To del mensaje */
  mensaje_reply_to VARCHAR2(2000),
/** Campo Cc del mensaje */
  mensaje_cc VARCHAR2(4000),
/** Campo Bcc del mensaje */
  mensaje_bcc VARCHAR2(4000),
/** Archivos adjuntos */
  adjuntos y_archivos,

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_correo.
*/
  CONSTRUCTOR FUNCTION y_correo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
