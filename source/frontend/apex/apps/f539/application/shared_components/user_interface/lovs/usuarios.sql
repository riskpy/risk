prompt --application/shared_components/user_interface/lovs/usuarios
begin
--   Manifest
--     USUARIOS
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
 p_id=>wwv_flow_imp.id(33830252082795850)
,p_lov_name=>'USUARIOS'
,p_lov_query=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.id_usuario      id_usuario,',
'       a.alias           alias,',
'       b.nombre_completo nombre_completo',
'  FROM t_usuarios a, t_personas b',
' WHERE b.id_persona(+) = a.id_persona'))
,p_source_type=>'SQL'
,p_location=>'LOCAL'
,p_use_local_sync_table=>false
,p_return_column_name=>'ID_USUARIO'
,p_display_column_name=>'ALIAS'
,p_group_sort_direction=>'ASC'
,p_default_sort_column_name=>'ALIAS'
,p_default_sort_direction=>'ASC'
,p_version_scn=>39539363225095
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(35431403960999486)
,p_query_column_name=>'ID_USUARIO'
,p_heading=>'ID'
,p_display_sequence=>10
,p_data_type=>'NUMBER'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(35431823185999487)
,p_query_column_name=>'ALIAS'
,p_heading=>'Alias'
,p_display_sequence=>20
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp_shared.create_list_of_values_cols(
 p_id=>wwv_flow_imp.id(35432191806999488)
,p_query_column_name=>'NOMBRE_COMPLETO'
,p_heading=>'Nombre Completo'
,p_display_sequence=>30
,p_data_type=>'VARCHAR2'
);
wwv_flow_imp.component_end;
end;
/
