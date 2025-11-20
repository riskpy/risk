prompt --application/deployment/install/install_ins_t_rol_permisos
begin
--   Manifest
--     INSTALL: INSTALL-ins_t_rol_permisos
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_install_script(
 p_id=>wwv_flow_imp.id(91230439096954574)
,p_install_id=>wwv_flow_imp.id(87330315450195490)
,p_name=>'ins_t_rol_permisos'
,p_sequence=>30
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'INSERT INTO t_rol_permisos',
'  (id_rol, id_permiso, consultar, insertar, actualizar, eliminar)',
'  SELECT 1,',
'         ''PAGE:'' || upper(a.alias) || '':'' || upper(ap.page_alias),',
'         ''N'',',
'         ''N'',',
'         ''N'',',
'         ''N''',
'    FROM apex_application_pages ap, apex_applications a',
'   WHERE a.application_id = ap.application_id',
'     AND ap.page_alias IS NOT NULL',
'     AND a.alias =',
'         k_aplicacion.f_id_aplicacion(''wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='')',
'     AND NOT EXISTS (SELECT 1',
'            FROM t_rol_permisos rp',
'           WHERE rp.id_rol = 1',
'             AND rp.id_permiso = ''PAGE:'' || upper(a.alias) || '':'' ||',
'                 upper(ap.page_alias));'))
);
wwv_flow_imp.component_end;
end;
/
