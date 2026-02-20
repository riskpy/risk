/* ==================== T_ERRORES ==================== */
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

  l_clob(1) :=q'!ora0009!';
  l_clob(2) :=q'!Error al desencriptar valor del parámetro @1@!';
  l_clob(3) :=q'!API!';
  l_varchar2(4) :=q'!!';
  l_varchar2(5) :=q'!!';

  insert into t_errores
  (
     "CLAVE"
    ,"MENSAJE"
    ,"ID_DOMINIO"
    ,"ID_IDIOMA"
    ,"ID_PAIS"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
  );

end;
/
