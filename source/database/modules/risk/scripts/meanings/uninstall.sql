prompt
prompt Desinstalando significados...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = RISK ==================== */
DELETE t_significados WHERE k_significado.f_id_modulo_dominio(dominio) = 'RISK';
DELETE t_significado_dominios WHERE k_dominio.f_id_modulo(id_dominio) = 'RISK';

