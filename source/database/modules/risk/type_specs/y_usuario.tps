CREATE OR REPLACE TYPE y_usuario UNDER y_objeto
(
/**
Agrupa datos de un usuario.

%author jtsoya539 30/3/2020 10:57:43
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

/** Identificador del usuario */
  id_usuario NUMBER(10),
/** Alias del usuario (identificador para autenticacion) */
  alias VARCHAR2(300),
/** Nombre de la persona */
  nombre VARCHAR2(100),
/** Apellido de la persona */
  apellido VARCHAR2(100),
/** Tipo de la persona */
  tipo_persona CHAR(1),
/** Estado del usuario */
  estado CHAR(1),
/** Direccion de correo electronico principal del usuario */
  direccion_correo VARCHAR2(320),
/** Numero de telefono principal del usuario */
  numero_telefono VARCHAR2(160),
/** Version del avatar del usuario */
  version_avatar NUMBER(10),
/** Origen del usuario */
  origen CHAR(1),
/** Roles del usuario */
  roles y_objetos,

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_usuario.
*/
  CONSTRUCTOR FUNCTION y_usuario RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.
  
%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
