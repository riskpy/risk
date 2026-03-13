prompt
prompt Desinstalando operaciones...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = RISK ==================== */
DELETE t_rol_permisos WHERE id_permiso IN (SELECT k_operacion.f_id_permiso(o.id_operacion) FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_importacion_parametros WHERE id_importacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_importaciones WHERE id_importacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_monitoreos WHERE id_monitoreo IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_trabajos WHERE id_trabajo IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_reportes WHERE id_reporte IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_servicios WHERE id_servicio IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_operacion_parametros WHERE id_operacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');
DELETE t_operaciones WHERE id_operacion IN (SELECT o.id_operacion FROM t_operaciones o WHERE k_dominio.f_id_modulo(o.dominio) = 'RISK');

