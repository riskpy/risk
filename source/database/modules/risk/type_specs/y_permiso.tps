create or replace type y_permiso force under y_objeto
(
/**
Agrupa datos de un permiso.

%author jmeza 08/08/2025 08:32:01
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

/** Identificador del permiso o recurso */
  id_permiso varchar2(300),
/** Puede consultar? (S/N) */
  consultar varchar2(1),
/** Puede insertar/cargar? (S/N) */
  insertar varchar2(1),
/** Puede actualizar? (S/N) */
  actualizar varchar2(1),
/** Puede eliminar? (S/N) */
  eliminar varchar2(1),
/** Puede verificar? (S/N) */
  verificar varchar2(1),
/** Puede autorizar? (S/N) */
  autorizar varchar2(1),

  constructor function y_permiso return self as result,

  static function parse_json(i_json in clob) return y_objeto,

  overriding member function to_json return clob
)
/

