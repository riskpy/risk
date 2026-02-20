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

  l_clob(1) :=q'!MSJ!';
  l_clob(2) :=q'!RISK MSJ!';
  l_clob(3) :=q'!S!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!Servicio para envío de mensajes a los usuarios a través de Correo electrónico (E-mail), Mensaje de texto (SMS) y Notificación push!';
  l_clob(6) :=q'!MSJ!';

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

  l_clob(1) :=q'!MSJ!';
  l_clob(2) :=q'!CLAVE!';
  l_clob(3) :=q'!Hkru7cXdu6FdIqhA9Q4XJqTgW/pW651rDjlSyLczKwI=!';

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

  l_clob(1) :=q'!MSJ!';
  l_clob(2) :=q'!TIEMPO_EXPIRACION_ACCESS_TOKEN!';
  l_clob(3) :=q'!86400!';

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

  l_clob(1) :=q'!MSJ!';
  l_clob(2) :=q'!TIEMPO_EXPIRACION_REFRESH_TOKEN!';
  l_clob(3) :=q'!10000!';

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

  l_clob(1) :=q'!MSJ!';
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
