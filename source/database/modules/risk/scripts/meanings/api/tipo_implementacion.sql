/* ==================== T_SIGNIFICADO_DOMINIOS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

  l_clob(1) :=q'!TIPO_IMPLEMENTACION!';
  l_clob(2) :=q'!Tipos de implementación de operaciones!';
  l_clob(3) :=q'!El valor de la referencia se utiliza para armar el nombre del programa a ejecutar para la operación. Ver la función k_operacion.f_nombre_programa!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!API!';

  insert into t_significado_dominios
  (
     "DOMINIO"
    ,"DESCRIPCION"
    ,"DETALLE"
    ,"ACTIVO"
    ,"ID_DOMINIO"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
  );

end;
/
/* ==================== T_SIGNIFICADOS ==================== */
set define off
declare
  type   t_clob is table of clob index by binary_integer;
  l_clob t_clob;
  type   t_varchar2 is table of varchar2(64) index by binary_integer;
  l_varchar2 t_varchar2;
begin

  null;
  -- start generation of records
  -----------------------------------

  l_clob(1) :=q'!TIPO_IMPLEMENTACION!';
  l_clob(2) :=q'!B!';
  l_clob(3) :=q'!BLOQUE PL/SQL!';
  l_clob(4) :=q'!!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!!';

  insert into t_significados
  (
     "DOMINIO"
    ,"CODIGO"
    ,"SIGNIFICADO"
    ,"REFERENCIA"
    ,"ACTIVO"
    ,"REFERENCIA_2"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
  );

  l_clob(1) :=q'!TIPO_IMPLEMENTACION!';
  l_clob(2) :=q'!F!';
  l_clob(3) :=q'!FUNCIÓN!';
  l_clob(4) :=q'!F!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!!';

  insert into t_significados
  (
     "DOMINIO"
    ,"CODIGO"
    ,"SIGNIFICADO"
    ,"REFERENCIA"
    ,"ACTIVO"
    ,"REFERENCIA_2"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
  );

  l_clob(1) :=q'!TIPO_IMPLEMENTACION!';
  l_clob(2) :=q'!K!';
  l_clob(3) :=q'!PAQUETE!';
  l_clob(4) :=q'!K!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!!';

  insert into t_significados
  (
     "DOMINIO"
    ,"CODIGO"
    ,"SIGNIFICADO"
    ,"REFERENCIA"
    ,"ACTIVO"
    ,"REFERENCIA_2"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
  );

end;
/
