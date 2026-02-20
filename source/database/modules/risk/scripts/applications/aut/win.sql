/* ==================== T_APLICACIONES ==================== */
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

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!WINDOWS!';
  l_clob(3) :=q'!D!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!Aplicación para la plataforma Windows!';
  l_clob(6) :=q'!AUT!';

  insert into t_aplicaciones
  (
     "ID_APLICACION"
    ,"NOMBRE"
    ,"TIPO"
    ,"ACTIVO"
    ,"DETALLE"
    ,"ID_DOMINIO"
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
/* ==================== T_APLICACION_PARAMETROS ==================== */
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

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!CLAVE!';
  l_clob(3) :=q'!u0jVxK7vw3b4O1/pnJnFD5CzoY4lyvRfwC/yUfXscFk=!';

  insert into t_aplicacion_parametros
  (
     "ID_APLICACION"
    ,"ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
  );

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!PLATAFORMA_NOTIFICACION!';
  l_clob(3) :=q'!wns!';

  insert into t_aplicacion_parametros
  (
     "ID_APLICACION"
    ,"ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
  );

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!TIEMPO_EXPIRACION_ACCESS_TOKEN!';
  l_clob(3) :=q'!900!';

  insert into t_aplicacion_parametros
  (
     "ID_APLICACION"
    ,"ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
  );

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!TIEMPO_EXPIRACION_REFRESH_TOKEN!';
  l_clob(3) :=q'!5!';

  insert into t_aplicacion_parametros
  (
     "ID_APLICACION"
    ,"ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
  );

  l_clob(1) :=q'!WIN!';
  l_clob(2) :=q'!VERSION_ACTUAL!';
  l_clob(3) :=q'!0.1.0!';

  insert into t_aplicacion_parametros
  (
     "ID_APLICACION"
    ,"ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
  );

end;
/
