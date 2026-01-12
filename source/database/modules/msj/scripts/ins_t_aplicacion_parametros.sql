prompt Importing table t_aplicacion_parametros...
set feedback off
set define off

insert into t_aplicacion_parametros (ID_APLICACION, ID_PARAMETRO, VALOR)
values ('MSJ', 'CLAVE', 'Hkru7cXdu6FdIqhA9Q4XJqTgW/pW651rDjlSyLczKwI=');

insert into t_aplicacion_parametros (ID_APLICACION, ID_PARAMETRO, VALOR)
values ('MSJ', 'VERSION_ACTUAL', '0.1.0');

insert into t_aplicacion_parametros (ID_APLICACION, ID_PARAMETRO, VALOR)
values ('MSJ', 'TIEMPO_EXPIRACION_ACCESS_TOKEN', '86400');

insert into t_aplicacion_parametros (ID_APLICACION, ID_PARAMETRO, VALOR)
values ('MSJ', 'TIEMPO_EXPIRACION_REFRESH_TOKEN', '10000');

prompt Done.
