prompt
prompt Desinstalando aplicaciones...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = FLJ ==================== */
delete t_aplicacion_parametros ap where (select k_dominio.f_id_modulo(nvl(a.id_dominio, 'API')) from t_aplicaciones a where a.id_aplicacion = ap.id_aplicacion) = 'FLJ';
delete t_aplicaciones where k_dominio.f_id_modulo(nvl(id_dominio, 'API')) = 'FLJ';

