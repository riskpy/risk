prompt Importing table t_parametros...
set feedback off
set define off

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('DIRECCION_CORREO_PRUEBAS', 'demouser@risk.com');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('DIRECCION_CORREO_REMITENTE', null);

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ENVIO_CORREOS_ACTIVO', 'N');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ENVIO_MENSAJES_ACTIVO', 'N');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ENVIO_NOTIFICACIONES_ACTIVO', 'N');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('NUMERO_TELEFONO_PRUEBAS', '+595991000000');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('NUMERO_TELEFONO_REMITENTE', null);

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('REGEXP_VALIDAR_DIRECCION_CORREO', '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('REGEXP_VALIDAR_NUMERO_TELEFONO', '^\+5959[6-9][1-9][0-9]{6}$');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('SUSCRIPCION_PRUEBAS', 'test');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('MENSAJERIA_CANTIDAD_INTENTOS_PERMITIDOS', '3');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('DIRECCION_CORREO_MONITOREOS', 'demouser@risk.com');

prompt Done.
