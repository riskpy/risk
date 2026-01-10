create or replace type y_tipo_atributo force as object
(
-- Author  : DMEZAC
-- Created : 17/04/2025
-- Purpose : Objeto con atributos de un tipo de objeto para almacenamiento en caché de la sesión

  nombre          varchar2(128),
  tipo            varchar2(128),
  modificador     varchar2(30),
  codigo_tipo     varchar2(128), --COLLECTION/OBJECT
  nombre_elemento varchar2(128),

  constructor function y_tipo_atributo return self as result
)
/

