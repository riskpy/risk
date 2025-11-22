prompt --application/shared_components/user_interface/lovs/prioridades_envio
begin
--   Manifest
--     PRIORIDADES_ENVIO
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_list_of_values(
 p_id=>wwv_flow_imp.id(33730269126785184)
,p_lov_name=>'PRIORIDADES_ENVIO'
,p_lov_query=>'.'||wwv_flow_imp.id(33730269126785184)||'.'
,p_location=>'STATIC'
,p_version_scn=>39539363225008
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(33730577715785236)
,p_lov_disp_sequence=>1
,p_lov_disp_value=>'1-URGENTE'
,p_lov_return_value=>'1'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(33731033462785237)
,p_lov_disp_sequence=>2
,p_lov_disp_value=>'2-IMPORTANTE'
,p_lov_return_value=>'2'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(33731438262785237)
,p_lov_disp_sequence=>3
,p_lov_disp_value=>'3-MEDIA'
,p_lov_return_value=>'3'
);
wwv_flow_imp_shared.create_static_lov_data(
 p_id=>wwv_flow_imp.id(33731777378785238)
,p_lov_disp_sequence=>4
,p_lov_disp_value=>'4-BAJA'
,p_lov_return_value=>'4'
);
wwv_flow_imp.component_end;
end;
/
