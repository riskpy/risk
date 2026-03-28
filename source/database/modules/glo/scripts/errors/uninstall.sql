prompt
prompt Desinstalando errores...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = GLO ==================== */
delete t_errores where k_dominio.f_id_modulo(nvl(id_dominio, 'API')) = 'GLO';

