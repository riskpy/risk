/* ==================== T_OPERACIONES ==================== */
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

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!I!';
  l_clob(3) :=q'!IMPORTAR_PAISES_CAMPOS_FIJOS!';
  l_clob(4) :=q'!GEN!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!Importa archivo de paises con campos de longitud fija!';
  l_clob(7) :=q'!0.1.0!';
  l_varchar2(8) :=q'!1!';
  l_clob(9) :=q'!!';
  l_clob(10) :=q'!K!';
  l_clob(11) :=q'!!';


  insert into t_operaciones
  (
     "ID_OPERACION"
    ,"TIPO"
    ,"NOMBRE"
    ,"DOMINIO"
    ,"ACTIVO"
    ,"DETALLE"
    ,"VERSION_ACTUAL"
    ,"NIVEL_LOG"
    ,"PARAMETROS_AUTOMATICOS"
    ,"TIPO_IMPLEMENTACION"
    ,"APLICACIONES_PERMITIDAS"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_char(l_clob(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
  );

end;
/
/* ==================== T_OPERACION_PARAMETROS ==================== */
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

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ID_PAIS!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!1!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!N!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Identificador del país!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!NOMBRE!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!2!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!S!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Nombre del país!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!NACIONALIDAD!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!3!';
  l_clob(5) :=q'!N!';
  l_clob(6) :=q'!S!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Nacionalidad!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_ALPHA_2!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!4!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!S!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Código ISO Alpha 2!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_ALPHA_3!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!5!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!S!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Código ISO Alpha 3!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_NUMERIC!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!6!';
  l_clob(5) :=q'!S!';
  l_clob(6) :=q'!N!';
  l_clob(7) :=q'!!';
  l_varchar2(8) :=q'!!';
  l_clob(9) :=q'!S!';
  l_clob(10) :=q'!!';
  l_clob(11) :=q'!Código ISO Numérico!';
  l_clob(12) :=q'!!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!N!';


  insert into t_operacion_parametros
  (
     "ID_OPERACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"ORDEN"
    ,"ACTIVO"
    ,"TIPO_DATO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"DETALLE"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_number(l_varchar2(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_char(l_clob(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
  );

end;
/
/* ==================== T_SERVICIOS ==================== */
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

end;
/
/* ==================== T_REPORTES ==================== */
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

end;
/
/* ==================== T_TRABAJOS ==================== */
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

end;
/
/* ==================== T_MONITOREOS ==================== */
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

end;
/
/* ==================== T_IMPORTACIONES ==================== */
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

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!!';
  l_clob(3) :=q'!!';
  l_varchar2(4) :=q'!2!';
  l_clob(5) :=q'!T_PAISES!';
  l_clob(6) :=q'!N!';
  l_clob(7) :=q'!!';
  l_clob(8) :=q'!!';


  insert into t_importaciones
  (
     "ID_IMPORTACION"
    ,"SEPARADOR_CAMPOS"
    ,"DELIMITADOR_CAMPO"
    ,"LINEA_INICIAL"
    ,"NOMBRE_TABLA"
    ,"TRUNCAR_TABLA"
    ,"PROCESO_PREVIO"
    ,"PROCESO_POSTERIOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_char(l_clob(8))
  );

end;
/
/* ==================== T_IMPORTACION_PARAMETROS ==================== */
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

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ID_PAIS!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!1!';
  l_varchar2(5) :=q'!9!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!trim(:variable)!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!NOMBRE!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!10!';
  l_varchar2(5) :=q'!20!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!upper(trim(:variable))!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!NACIONALIDAD!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!30!';
  l_varchar2(5) :=q'!20!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!trim(:variable)!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_ALPHA_2!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!50!';
  l_varchar2(5) :=q'!3!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!trim(:variable)!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_ALPHA_3!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!53!';
  l_varchar2(5) :=q'!3!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!trim(:variable)!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

  l_varchar2(1) :=q'!10001!';
  l_clob(2) :=q'!ISO_NUMERIC!';
  l_clob(3) :=q'!0.1.0!';
  l_varchar2(4) :=q'!56!';
  l_varchar2(5) :=q'!3!';
  l_varchar2(6) :=q'!!';
  l_clob(7) :=q'!trim(:variable)!';


  insert into t_importacion_parametros
  (
     "ID_IMPORTACION"
    ,"NOMBRE"
    ,"VERSION"
    ,"POSICION_INICIAL"
    ,"LONGITUD"
    ,"POSICION_DECIMAL"
    ,"MAPEADOR"
  )
  values
  (
     to_number(l_varchar2(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_number(l_varchar2(5))
    ,to_number(l_varchar2(6))
    ,to_char(l_clob(7))
  );

end;
/
/* ==================== T_ROL_PERMISOS ==================== */
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

end;
/
