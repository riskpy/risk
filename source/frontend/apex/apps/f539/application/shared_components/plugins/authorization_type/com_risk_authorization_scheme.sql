prompt --application/shared_components/plugins/authorization_type/com_risk_authorization_scheme
begin
--   Manifest
--     PLUGIN: COM.RISK.AUTHORIZATION_SCHEME
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(134030843901372757)
,p_plugin_type=>'AUTHORIZATION TYPE'
,p_name=>'COM.RISK.AUTHORIZATION_SCHEME'
,p_display_name=>'RISK Authorization Scheme'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('AUTHORIZATION TYPE','COM.RISK.AUTHORIZATION_SCHEME'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION is_authorized(p_authorization IN apex_plugin.t_authorization,',
'                       p_plugin        IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_authorization_exec_result IS',
'  l_result     apex_plugin.t_authorization_exec_result;',
'  l_id_permiso t_permisos.id_permiso%TYPE;',
'BEGIN',
'  l_id_permiso           := ''PAGE:'' || upper(:app_alias) || '':'' ||',
'                            upper(:app_page_alias);',
'  l_result.is_authorized := k_autorizacion.f_validar_permiso(k_usuario.f_buscar_id(:app_user),',
'                                                             l_id_permiso);',
'  RETURN l_result;',
'END;'))
,p_api_version=>2
,p_execution_function=>'is_authorized'
,p_substitute_attributes=>true
,p_version_scn=>39539363226869
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'v0.1.0'
,p_about_url=>'https://riskpy.github.io/risk/'
);
end;
/
begin
wwv_flow_imp.component_end;
end;
/
