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

  l_clob(1) :=q'!GLO!';
  l_clob(2) :=q'!GLOBAL!';
  l_clob(3) :=q'!Módulo para definiciones de Globalización!';
  l_clob(4) :=q'!S!';
  l_varchar2(5) :=q'!28.03.2026 00:00:00!';
  l_clob(6) :=q'!1.0.0!';

  insert into t_modulos_dml_v
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

  l_clob(1) :=q'!GLO!';
  l_clob(2) :=q'!GLOBAL!';
  l_clob(3) :=q'!Dominio de Globalización!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!GLO!';

  insert into t_dominios_dml_v
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

