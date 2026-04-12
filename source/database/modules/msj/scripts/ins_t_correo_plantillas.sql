prompt Importing table t_correo_plantillas...
set feedback off
set define off

insert into t_correo_plantillas (ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_ASUNTO, PLANTILLA_CONTENIDO)
values ('PLANTILLA_DEMO', 'Plantilla Demo para Envío de Correos Electrónicos', 'S', 270, null, '$(entidad) - $(asunto)', '$(contenido)');

insert into t_correo_plantillas (ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_ASUNTO, PLANTILLA_CONTENIDO)
values ('PLANTILLA_MONITOREO', 'Plantilla para Envío de Monitoreo de Conflictos', 'S', 269, null, 'BD: $(base_datos) - Monitoreo de Conflictos #$(id_ejecucion)', '$(contenido)');

prompt Done.
