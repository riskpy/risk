prompt --application/deployment/checks
begin
--   Manifest
--     INSTALL CHECKS: 539
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_install_check(
 p_id=>wwv_flow_imp.id(90330286919429494)
,p_install_id=>wwv_flow_imp.id(87330315450195490)
,p_name=>'Proyecto RISK instalado'
,p_sequence=>10
,p_check_type=>'EXISTS'
,p_check_condition=>'SELECT * FROM t_modulos WHERE id_modulo = ''RISK'';'
,p_failure_message=>'El Proyecto RISK debe estar instalado'
);
wwv_flow_imp.component_end;
end;
/
