prompt Importing table t_parametros...
set feedback off
set define off

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('METODO_VALIDACION_CREDENCIALES', 'RISK');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('CONFIRMACION_DIRECCION_CORREO', 'S');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ESTADOS_ACTIVOS_USUARIO', 'A');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('BASE_DATOS_PRODUCCION', 'RISK');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('CANTIDAD_MAXIMA_SESIONES_USUARIO', '2');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('CLAVE_ENCRIPTACION_DESENCRIPTACION', '26B9257BF16323A5919FAA48ABB7C575A50996698A0576C0DE0EE312AF6D2D60');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('CLAVE_VALIDACION_ACCESS_TOKEN', '9vVzzZbbUCcYE3cDnE+IVMrLF+8X8TPyK2cmC3Vu7M0=');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('NOMBRE_ROL_DEFECTO', 'USUARIO');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('TIEMPO_EXPIRACION_ACCESS_TOKEN', '300');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('TIEMPO_EXPIRACION_REFRESH_TOKEN', '5');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('URL_SERVICIOS_PRODUCCION', 'https://localhost:5001');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA', '30');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA', '100');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('GOOGLE_IDENTIFICADOR_CLIENTE', null);

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('GOOGLE_EMISOR_TOKEN', 'accounts.google.com');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('REPORTE_FORMATO_SALIDA_DEFECTO', 'PDF');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('REGEXP_VALIDAR_ALIAS_USUARIO', '^[A-Za-z0-9_]{1,50}$');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('TIEMPO_TOLERANCIA_VALIDAR_OTP', '120');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ZONA_HORARIA', '-4:0');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ID_IDIOMA_ISO', 'es');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('ID_PAIS_ISO', 'PY');

insert into t_parametros (ID_PARAMETRO, VALOR)
values ('AUTENTICACION_CANTIDAD_INTENTOS_PERMITIDOS', '3');

prompt Done.
