CREATE OR REPLACE TYPE y_dispositivo UNDER y_objeto
(
/**
Agrupa datos de un dispositivo.

%author jtsoya539 30/3/2020 10:54:26
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

/** Identificador del dispositivo */
  id_dispositivo NUMBER(15),
/** Token del dispositivo */
  token_dispositivo VARCHAR2(500),
/** Nombre del sistema operativo */
  nombre_sistema_operativo VARCHAR2(100),
/** Version del sistema operativo */
  version_sistema_operativo VARCHAR2(100),
/** Tipo del dispositivo */
  tipo VARCHAR2(1),
/** Nombre del navegador */
  nombre_navegador VARCHAR2(100),
/** Version del navegador */
  version_navegador VARCHAR2(100),
/** Token de notificacion del dispositivo */
  token_notificacion VARCHAR2(500),
/** Plataforma para las notificaciones push de la aplicación */
  plataforma_notificacion VARCHAR2(10),
/** Version de la aplicacion */
  version_aplicacion VARCHAR2(100),
/** Pais del dispositivo */
  id_pais_iso2 VARCHAR2(2),
/** Zona horaria del dispositivo */
  zona_horaria VARCHAR2(8),
/** Idioma del dispositivo */
  id_idioma_iso369_1 VARCHAR2(2),
/** Plantillas para las notificaciones push de la aplicación */
  plantillas y_datos,
/** Suscripciones para notificaciones push del dispositivo */
  suscripciones y_datos,

/**
Constructor del objeto sin parámetros.

%author jtsoya539 30/3/2020 10:08:08
%return Objeto del tipo y_dispositivo.
*/
  CONSTRUCTOR FUNCTION y_dispositivo RETURN SELF AS RESULT,

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto,

/**
Retorna el objeto serializado en formato JSON.

%author jtsoya539 30/3/2020 09:42:09
%return JSON con los atributos del objeto.
*/
  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB
)
/
