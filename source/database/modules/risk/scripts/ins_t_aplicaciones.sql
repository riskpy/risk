prompt Importing table t_aplicaciones...
set feedback off
set define off
insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, DETALLE)
values ('WIN', 'WINDOWS', 'D', 'S', 'Aplicación para la plataforma Windows');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, DETALLE)
values ('AND', 'ANDROID', 'M', 'S', 'Aplicación móvil para la plataforma Android');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, DETALLE)
values ('IOS', 'IOS', 'M', 'S', 'Aplicación móvil para la plataforma iOS');

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, DETALLE)
values ('TEST', 'RISK TEST', 'W', 'S', 'Cliente HTTP para pruebas de Servicios Web');

prompt Done.
