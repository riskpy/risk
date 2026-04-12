prompt Importing table t_notificacion_plantillas...
set feedback off
set define off

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_CONTENIDO)
values ('AND', 'GEN', 'GENERAL', 'S', 270, 'Notificaciones generales para la plataforma Android', '{"notification":{"title":"$(titulo)","body":"$(contenido)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_CONTENIDO)
values ('IOS', 'GEN', 'GENERAL', 'S', 270, 'Notificaciones generales para la plataforma iOS', '{"aps":{"alert":"$(contenido)"}}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_TITULO, PLANTILLA_CONTENIDO, PLANTILLA_DATOS_EXTRA)
values ('AND', 'PLANTILLA_DEMO', 'Plantilla Demo para Envío de Notificaciones', 'S', 270, null, '$(entidad) le informa', '$(entidad) le informa. Este es un mensaje de prueba', '{
  "data":{
     "image":"https://www.bancoatlas.com.py/web/bcamovil/banner/hb_atlas_mas.jpg"
  },
  "android":{
     "data":{
        "click_action":"ATLAS_BASIC_INFO_PUSH"
     }
  }
}');

insert into t_notificacion_plantillas (ID_APLICACION, ID_PLANTILLA, NOMBRE, ACTIVO, ID_CATEGORIA, DETALLE, PLANTILLA_TITULO, PLANTILLA_CONTENIDO, PLANTILLA_DATOS_EXTRA)
values ('AND', 'PLANTILLA_MONITOREO', 'Plantilla para Monitoreo de Conflictos', 'S', 269, null, 'BD: $(base_datos) - Monitoreo de Conflictos #$(id_ejecucion)', '$(contenido)', '{
  "android":{
     "data":{
        "click_action":"ATLAS_BASIC_INFO_PUSH"
     }
  }
}');

prompt Done.
