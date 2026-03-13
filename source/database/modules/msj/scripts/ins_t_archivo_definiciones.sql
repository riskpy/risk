prompt Importing table t_archivo_definiciones...
set feedback off
set define off

insert into t_archivo_definiciones_dml_v (TABLA, CAMPO, DESCRIPCION, TAMANO_MAXIMO, ORDEN, NOMBRE_REFERENCIA, EXTENSIONES_PERMITIDAS)
values ('T_CORREO_ADJUNTOS', 'ARCHIVO', 'Archivo adjunto', 10000000, 1, 'ID_CORREO_ADJUNTO', 'EXTENSION_ADJUNTO');

prompt Done.
