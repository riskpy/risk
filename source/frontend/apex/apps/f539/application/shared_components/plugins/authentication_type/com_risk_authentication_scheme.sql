prompt --application/shared_components/plugins/authentication_type/com_risk_authentication_scheme
begin
--   Manifest
--     PLUGIN: COM.RISK.AUTHENTICATION_SCHEME
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
 p_id=>wwv_flow_imp.id(133930969478369898)
,p_plugin_type=>'AUTHENTICATION TYPE'
,p_name=>'COM.RISK.AUTHENTICATION_SCHEME'
,p_display_name=>'RISK Authentication Scheme'
,p_image_prefix => nvl(wwv_flow_application_install.get_static_plugin_file_prefix('AUTHENTICATION TYPE','COM.RISK.AUTHENTICATION_SCHEME'),'')
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION authentication_sentry(p_authentication IN apex_plugin.t_authentication,',
'                               p_plugin         IN apex_plugin.t_plugin,',
'                               p_is_public_page IN BOOLEAN)',
'  RETURN apex_plugin.t_authentication_sentry_result IS',
'  l_result apex_plugin.t_authentication_sentry_result;',
'BEGIN',
'  l_result.is_valid := k_sesion.f_validar_sesion(to_char(p_authentication.session_id));',
'',
'  RETURN l_result;',
'END;',
'',
'FUNCTION authentication_inval(p_authentication IN apex_plugin.t_authentication,',
'                              p_plugin         IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_authentication_inval_result IS',
'  l_result apex_plugin.t_authentication_inval_result;',
'BEGIN',
'  IF k_sesion.f_validar_sesion(to_char(p_authentication.session_id)) THEN',
unistr('    k_sesion.p_cambiar_estado(to_char(p_authentication.session_id), ''I''); -- INV\00C1LIDO'),
'  END IF;',
'',
'  l_result.redirect_url := p_authentication.invalid_session_url;',
'',
'  RETURN l_result;',
'END;',
'',
'FUNCTION authentication_auth(p_authentication IN apex_plugin.t_authentication,',
'                             p_plugin         IN apex_plugin.t_plugin,',
'                             p_password       IN VARCHAR2)',
'  RETURN apex_plugin.t_authentication_auth_result IS',
'  l_result            apex_plugin.t_authentication_auth_result;',
'  l_id_sesion         t_sesiones.id_sesion%TYPE;',
'  l_token_dispositivo t_dispositivos.token_dispositivo%TYPE;',
'BEGIN',
'  l_result.is_authenticated := k_autenticacion.f_validar_credenciales(p_authentication.username,',
'                                                                      p_password,',
'                                                                      k_clave.c_clave_acceso);',
'',
'  IF l_result.is_authenticated THEN',
'    -- Busca el token del dispositivo en el collection DEVICE_TOKEN (en el servidor)',
'    BEGIN',
'      SELECT c001',
'        INTO l_token_dispositivo',
'        FROM apex_collections',
'       WHERE collection_name = ''DEVICE_TOKEN''',
'         AND rownum <= 1;',
'    EXCEPTION',
'      WHEN OTHERS THEN',
'        l_token_dispositivo := NULL;',
'    END;',
'  ',
'    l_id_sesion := k_autenticacion.f_iniciar_sesion(k_aplicacion.f_id_aplicacion(apex_app_setting.get_value(''RISK_APP_KEY'')),',
'                                                    p_authentication.username,',
'                                                    to_char(p_authentication.session_id),',
'                                                    NULL,',
'                                                    l_token_dispositivo,',
'                                                    k_autenticacion.c_origen_risk);',
'  ELSE',
unistr('    l_result.display_text := ''Credenciales inv\00E1lidas'';'),
'  END IF;',
'',
'  RETURN l_result;',
'END;',
'',
'FUNCTION authentication_logout(p_authentication IN apex_plugin.t_authentication,',
'                               p_plugin         IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_authentication_logout_result IS',
'  l_result apex_plugin.t_authentication_logout_result;',
'BEGIN',
'  IF k_sesion.f_validar_sesion(to_char(p_authentication.session_id)) THEN',
'    k_sesion.p_cambiar_estado(to_char(p_authentication.session_id), ''F''); -- FINALIZADO',
'  END IF;',
'',
'  l_result.redirect_url := p_authentication.logout_url;',
'',
'  RETURN l_result;',
'END;',
'',
'FUNCTION authentication_ajax(p_authentication IN apex_plugin.t_authentication,',
'                             p_plugin         IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_authentication_ajax_result IS',
'  l_result       apex_plugin.t_authentication_ajax_result;',
'  rw_dispositivo t_dispositivos%ROWTYPE;',
'BEGIN',
'  rw_dispositivo.token_dispositivo         := apex_application.g_x01;',
'  rw_dispositivo.nombre_sistema_operativo  := apex_application.g_x02;',
'  rw_dispositivo.version_sistema_operativo := apex_application.g_x03;',
'  rw_dispositivo.nombre_navegador          := apex_application.g_x04;',
'  rw_dispositivo.version_navegador         := apex_application.g_x05;',
'',
'  BEGIN',
'    SELECT s.codigo',
'      INTO rw_dispositivo.tipo',
'      FROM t_significados s',
'     WHERE s.dominio = ''TIPO_DISPOSITIVO''',
'       AND upper(s.significado) LIKE',
'           upper(''%'' || apex_application.g_x06 || ''%'');',
'  EXCEPTION',
'    WHEN OTHERS THEN',
'      rw_dispositivo.tipo := NULL;',
'  END;',
'',
'  IF rw_dispositivo.token_dispositivo IS NULL THEN',
'    rw_dispositivo.token_dispositivo := k_clave.f_randombytes_hex;',
'  END IF;',
'',
'  rw_dispositivo.id_dispositivo := k_dispositivo.f_registrar_dispositivo(i_id_aplicacion             => k_aplicacion.f_id_aplicacion(apex_app_setting.get_value(''RISK_APP_KEY'')),',
'                                                                         i_token_dispositivo         => rw_dispositivo.token_dispositivo,',
'                                                                         i_token_notificacion        => NULL,',
'                                                                         i_nombre_sistema_operativo  => rw_dispositivo.nombre_sistema_operativo,',
'                                                                         i_version_sistema_operativo => rw_dispositivo.version_sistema_operativo,',
'                                                                         i_tipo                      => rw_dispositivo.tipo,',
'                                                                         i_nombre_navegador          => rw_dispositivo.nombre_navegador,',
'                                                                         i_version_navegador         => rw_dispositivo.version_navegador);',
'',
'  apex_json.open_object;',
'  apex_json.write(''device_token'', rw_dispositivo.token_dispositivo);',
'  apex_json.close_object;',
'',
'  RETURN l_result;',
'END;'))
,p_api_version=>1
,p_ajax_function=>'authentication_ajax'
,p_session_sentry_function=>'authentication_sentry'
,p_invalid_session_function=>'authentication_inval'
,p_authentication_function=>'authentication_auth'
,p_post_logout_function=>'authentication_logout'
,p_substitute_attributes=>true
,p_version_scn=>39539364642181
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
