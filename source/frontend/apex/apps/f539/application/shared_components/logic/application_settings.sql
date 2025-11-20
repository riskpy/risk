prompt --application/shared_components/logic/application_settings
begin
--   Manifest
--     APPLICATION SETTINGS: 539
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_app_setting(
 p_id=>wwv_flow_imp.id(90630370969664940)
,p_name=>'RISK_APP_KEY'
,p_value=>'wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='
,p_is_required=>'N'
,p_comments=>unistr('Clave de la aplicaci\00F3n habilitada para consumir servicios')
,p_version_scn=>39539363224998
);
wwv_flow_imp.component_end;
end;
/
