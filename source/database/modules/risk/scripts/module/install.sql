prompt
prompt Instalando modulo...
prompt -----------------------------------
prompt
/* ==================== T_MODULOS ==================== */
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

  l_clob(1) :=q'!RISK!';
  l_clob(2) :=q'!RISK!';
  l_clob(3) :=q'!Módulo principal con manejo de Operaciones (Servicios Web, Reportes, Trabajos) y sus Parámetros, Autenticación y Autorización de Usuarios, Parámetros, Significados, Archivos, Datos Adicionales, entre otros!';
  l_clob(4) :=q'!S!';
  l_varchar2(5) :=q'!20.02.2026 00:00:00!';
  l_clob(6) :=q'!1.4.0!';

  insert into t_modulos
  (
     "ID_MODULO"
    ,"NOMBRE"
    ,"DETALLE"
    ,"ACTIVO"
    ,"FECHA_ACTUAL"
    ,"VERSION_ACTUAL"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_date(l_varchar2(5),'DD.MM.YYYY HH24:MI:SS')
    ,to_char(l_clob(6))
  );

end;
/
/* ==================== T_DOMINIOS ==================== */
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

  l_clob(1) :=q'!API!';
  l_clob(2) :=q'!OPERACIONES!';
  l_clob(3) :=q'!Dominio de Operaciones (Servicios Web, Reportes, Trabajos) y sus Parámetros!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!RISK!';

  insert into t_dominios
  (
     "ID_DOMINIO"
    ,"NOMBRE"
    ,"DETALLE"
    ,"ACTIVO"
    ,"ID_MODULO"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
  );

  l_clob(1) :=q'!AUT!';
  l_clob(2) :=q'!AUTENTICACIÓN!';
  l_clob(3) :=q'!Dominio de Autenticación y Autorización de Usuarios!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!RISK!';

  insert into t_dominios
  (
     "ID_DOMINIO"
    ,"NOMBRE"
    ,"DETALLE"
    ,"ACTIVO"
    ,"ID_MODULO"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
  );

  l_clob(1) :=q'!GEN!';
  l_clob(2) :=q'!GENERAL!';
  l_clob(3) :=q'!Dominio General!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!RISK!';

  insert into t_dominios
  (
     "ID_DOMINIO"
    ,"NOMBRE"
    ,"DETALLE"
    ,"ACTIVO"
    ,"ID_MODULO"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
  );

  l_clob(1) :=q'!GLO!';
  l_clob(2) :=q'!GLOBAL!';
  l_clob(3) :=q'!Dominio Global!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!RISK!';

  insert into t_dominios
  (
     "ID_DOMINIO"
    ,"NOMBRE"
    ,"DETALLE"
    ,"ACTIVO"
    ,"ID_MODULO"
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

