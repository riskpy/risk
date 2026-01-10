prompt Importing table t_autenticacion_origenes...
set feedback off
set define off

insert into t_autenticacion_origenes (ID_AUTENTICACION_ORIGEN, NOMBRE, DETALLE, ACTIVO, PREFIJO_DOMINIO, METODO_VALIDACION_CREDENCIALES, PARAMETROS_VALIDACION_CREDENCIALES)
values ('F', 'FACEBOOK', null, 'S', null, 'EXTERNO', '{}');

insert into t_autenticacion_origenes (ID_AUTENTICACION_ORIGEN, NOMBRE, DETALLE, ACTIVO, PREFIJO_DOMINIO, METODO_VALIDACION_CREDENCIALES, PARAMETROS_VALIDACION_CREDENCIALES)
values ('G', 'GOOGLE', null, 'S', null, 'EXTERNO', '{}');

insert into t_autenticacion_origenes (ID_AUTENTICACION_ORIGEN, NOMBRE, DETALLE, ACTIVO, PREFIJO_DOMINIO, METODO_VALIDACION_CREDENCIALES, PARAMETROS_VALIDACION_CREDENCIALES)
values ('O', 'ORACLE', null, 'S', 'ORACLE\', 'ORACLE', '{"dblink":"password_test_loopback","connect_string":"XEPDB1"}');

insert into t_autenticacion_origenes (ID_AUTENTICACION_ORIGEN, NOMBRE, DETALLE, ACTIVO, PREFIJO_DOMINIO, METODO_VALIDACION_CREDENCIALES, PARAMETROS_VALIDACION_CREDENCIALES)
values ('R', 'RISK', null, 'S', null, 'RISK', '{"tipo_clave":"A"}');

prompt Done.
