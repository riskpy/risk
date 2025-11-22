prompt --application/shared_components/security/authentications/risk_authentication_scheme
begin
--   Manifest
--     AUTHENTICATION: RISK Authentication Scheme
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_authentication(
 p_id=>wwv_flow_imp.id(92132494153121852)
,p_name=>'RISK Authentication Scheme'
,p_scheme_type=>'PLUGIN_COM.RISK.AUTHENTICATION_SCHEME'
,p_use_secure_cookie_yn=>'N'
,p_ras_mode=>0
,p_version_scn=>39539363226768
);
wwv_flow_imp.component_end;
end;
/
