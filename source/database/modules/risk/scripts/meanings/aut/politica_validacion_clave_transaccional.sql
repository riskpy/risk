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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!Políticas para validación de claves transaccionales!';
  l_clob(3) :=q'!El valor de la referencia indica el tipo de clave!';
  l_clob(4) :=q'!S!';
  l_clob(5) :=q'!AUT!';

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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MAX_CARACTERES_IGUALES!';
  l_clob(3) :=q'!2!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MIN_CARACTERES_ESPECIALES!';
  l_clob(3) :=q'!1!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MIN_LETRAS_ABECEDARIO!';
  l_clob(3) :=q'!3!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MIN_MAYUSCULAS!';
  l_clob(3) :=q'!1!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MIN_MINUSCULAS!';
  l_clob(3) :=q'!1!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CAN_MIN_NUMEROS!';
  l_clob(3) :=q'!1!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!CARACTERES_PROHIBIDOS!';
  l_clob(3) :=q'!&:@!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!LONGITUD_MINIMA!';
  l_clob(3) :=q'!6!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!VAL_ALIAS_CONTENIDO!';
  l_clob(3) :=q'!S!';
  l_clob(4) :=q'!T!';
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

  l_clob(1) :=q'!POLITICA_VALIDACION_CLAVE_TRANSACCIONAL!';
  l_clob(2) :=q'!VAL_ALIAS_IGUAL!';
  l_clob(3) :=q'!S!';
  l_clob(4) :=q'!T!';
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
