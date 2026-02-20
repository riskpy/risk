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

  l_clob(1) :=q'!AND!';
  l_clob(2) :=q'!ANDROID!';
  l_clob(3) :=q'!M!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!Aplicación móvil para la plataforma Android!';
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

  l_clob(1) :=q'!AND!';
  l_clob(2) :=q'!CLAVE!';
  l_clob(3) :=q'!azVd94zazPu/+q5ZHqoL1v6wccamHV3oWoALYWQK0Z8=!';

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

  l_clob(1) :=q'!AND!';
  l_clob(2) :=q'!PLATAFORMA_NOTIFICACION!';
  l_clob(3) :=q'!fcm!';

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

  l_clob(1) :=q'!AND!';
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

  l_clob(1) :=q'!AND!';
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

  l_clob(1) :=q'!AND!';
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
