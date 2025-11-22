prompt --application/shared_components/security/authorizations/risk_authorization_scheme
begin
--   Manifest
--     SECURITY SCHEME: RISK Authorization Scheme
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_security_scheme(
 p_id=>wwv_flow_imp.id(88230351769621965)
,p_name=>'RISK Authorization Scheme'
,p_scheme_type=>'PLUGIN_COM.RISK.AUTHORIZATION_SCHEME'
,p_error_message=>'Privilegios insuficientes'
,p_version_scn=>39539363224998
,p_caching=>'BY_USER_BY_PAGE_VIEW'
);
wwv_flow_imp.component_end;
end;
/
