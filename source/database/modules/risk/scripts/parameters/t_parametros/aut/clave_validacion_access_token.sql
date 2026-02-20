/* ==================== T_PARAMETRO_DEFINICIONES ==================== */
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

  l_clob(1) :=q'!T_PARAMETROS!';
  l_clob(2) :=q'!CLAVE_VALIDACION_ACCESS_TOKEN!';
  l_clob(3) :=q'!Clave de validación del Access Token. Generar con la función k_clave.f_randombytes_base64!';
  l_varchar2(4) :=q'!!';
  l_clob(5) :=q'!ID_PARAMETRO!';
  l_clob(6) :=q'!S!';
  l_clob(7) :=q'!!';
  l_clob(8) :=q'!AUT!';
  l_clob(9) :=q'!!';
  l_clob(10) :=q'!!';
  l_varchar2(11) :=q'!!';
  l_clob(12) :=q'!N!';
  l_clob(13) :=q'!!';
  l_clob(14) :=q'!!';
  l_clob(15) :=q'!!';
  l_clob(16) :=q'!N!';

  insert into t_parametro_definiciones
  (
     "TABLA"
    ,"ID_PARAMETRO"
    ,"DESCRIPCION"
    ,"ORDEN"
    ,"NOMBRE_REFERENCIA"
    ,"TIPO_DATO"
    ,"OBSERVACION"
    ,"ID_DOMINIO"
    ,"TIPO_FILTRO"
    ,"FORMATO"
    ,"LONGITUD_MAXIMA"
    ,"OBLIGATORIO"
    ,"VALOR_DEFECTO"
    ,"ETIQUETA"
    ,"VALORES_POSIBLES"
    ,"ENCRIPTADO"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
    ,to_char(l_clob(3))
    ,to_number(l_varchar2(4))
    ,to_char(l_clob(5))
    ,to_char(l_clob(6))
    ,to_char(l_clob(7))
    ,to_char(l_clob(8))
    ,to_char(l_clob(9))
    ,to_char(l_clob(10))
    ,to_number(l_varchar2(11))
    ,to_char(l_clob(12))
    ,to_char(l_clob(13))
    ,to_char(l_clob(14))
    ,to_char(l_clob(15))
    ,to_char(l_clob(16))
  );

end;
/
/* ==================== T_PARAMETROS ==================== */
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

  l_clob(1) :=q'!CLAVE_VALIDACION_ACCESS_TOKEN!';
  l_clob(2) :=q'!9vVzzZbbUCcYE3cDnE+IVMrLF+8X8TPyK2cmC3Vu7M0=!';

  insert into t_parametros
  (
     "ID_PARAMETRO"
    ,"VALOR"
  )
  values
  (
     to_char(l_clob(1))
    ,to_char(l_clob(2))
  );

end;
/
