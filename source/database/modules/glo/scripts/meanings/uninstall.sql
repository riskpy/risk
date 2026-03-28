prompt
prompt Desinstalando significados...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = GLO ==================== */
DELETE t_significados WHERE k_significado.f_id_modulo_dominio(dominio) = 'GLO';
DELETE t_significado_dominios WHERE k_significado.f_id_modulo_dominio(dominio) = 'GLO';

