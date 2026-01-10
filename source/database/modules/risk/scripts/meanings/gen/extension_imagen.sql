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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!Extensiones permitidas para archivos de imágenes!';
  l_clob(3) :=q'!El valor de la referencia indica el tipo MIME relacionado a la extensión!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!GEN!';

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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!BMP!';
  l_clob(3) :=q'!IMAGEN BMP!';
  l_clob(4) :=q'!image/bmp!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!GIF!';
  l_clob(3) :=q'!IMAGEN GIF!';
  l_clob(4) :=q'!image/gif!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!JPEG!';
  l_clob(3) :=q'!IMAGEN JPEG!';
  l_clob(4) :=q'!image/jpeg!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!JPG!';
  l_clob(3) :=q'!IMAGEN JPG!';
  l_clob(4) :=q'!image/jpeg!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!PNG!';
  l_clob(3) :=q'!IMAGEN PNG!';
  l_clob(4) :=q'!image/png!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!SVG!';
  l_clob(3) :=q'!IMAGEN SVG!';
  l_clob(4) :=q'!image/svg+xml!';
  l_clob(5) :=q'!N!';
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

  l_clob(1) :=q'!EXTENSION_IMAGEN!';
  l_clob(2) :=q'!WEBP!';
  l_clob(3) :=q'!IMAGEN WEBP!';
  l_clob(4) :=q'!image/webp!';
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
