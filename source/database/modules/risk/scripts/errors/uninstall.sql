prompt
prompt Desinstalando errores...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = RISK ==================== */
delete t_errores where k_dominio.f_id_modulo(nvl(id_dominio, 'API')) = 'RISK';

