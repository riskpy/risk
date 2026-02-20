prompt
prompt Desinstalando parametros...
prompt -----------------------------------
prompt
/* ==================== ID_MODULO = RISK ==================== */
delete t_parametros p where (select k_dominio.f_id_modulo(nvl(pd.id_dominio, 'API')) from t_parametro_definiciones pd where pd.tabla = 'T_PARAMETROS' and pd.id_parametro = p.id_parametro) = 'RISK';
delete t_parametro_definiciones where k_dominio.f_id_modulo(nvl(id_dominio, 'API')) = 'RISK';

