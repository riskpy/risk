prompt --application/deployment/install/install_ins_t_aplicaciones
begin
--   Manifest
--     INSTALL: INSTALL-ins_t_aplicaciones
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
 p_id=>wwv_flow_imp.id(90730451050824129)
,p_install_id=>wwv_flow_imp.id(87330315450195490)
,p_name=>'ins_t_aplicaciones'
,p_sequence=>10
,p_script_type=>'INSTALL'
,p_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_clave_aplicacion t_aplicaciones.clave%TYPE;',
'BEGIN',
'  -- l_clave_aplicacion := k_autenticacion.f_randombytes_base64;',
'  l_clave_aplicacion := ''wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='';',
'',
'  INSERT INTO t_aplicaciones',
'    (id_aplicacion, nombre, tipo, activo, clave, detalle, version_actual)',
'  VALUES',
'    (''ADMIN'',',
'     ''RISK ADMIN'',',
'     ''W'',',
'     ''S'',',
'     l_clave_aplicacion,',
unistr('     ''Aplicaci\00F3n Web para administrar el sistema'','),
'     ''0.1.0'');',
'',
'  -- apex_app_setting.set_value(''RISK_APP_KEY'', l_clave_aplicacion);',
'END;'))
);
wwv_flow_imp.component_end;
end;
/
