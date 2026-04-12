prompt Importing table t_mensaje_plantillas...
set feedback off
set define off

insert into t_mensaje_plantillas (ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA)
values ('PLANTILLA_DEMO', 'Plantilla Demo para Envío de SMS', 'S', 270, null, '$(entidad) le informa. Este es un mensaje de prueba');

insert into t_mensaje_plantillas (ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA)
values ('PLANTILLA_MONITOREO', 'Plantilla para Envío de Monitoreo de Conflictos', 'S', 269, null, '$(contenido)');

prompt Done.
