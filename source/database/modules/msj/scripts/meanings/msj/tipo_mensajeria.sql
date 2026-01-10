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

  l_clob(1) :=q'!TIPO_MENSAJERIA!';
  l_clob(2) :=q'!Tipos de mensajerías!';
  l_clob(3) :=q'!!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!MSJ!';

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

  l_clob(1) :=q'!TIPO_MENSAJERIA!';
  l_clob(2) :=q'!M!';
  l_clob(3) :=q'!MAIL!';
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

  l_clob(1) :=q'!TIPO_MENSAJERIA!';
  l_clob(2) :=q'!P!';
  l_clob(3) :=q'!PUSH!';
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

  l_clob(1) :=q'!TIPO_MENSAJERIA!';
  l_clob(2) :=q'!S!';
  l_clob(3) :=q'!SMS!';
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

end;
/
