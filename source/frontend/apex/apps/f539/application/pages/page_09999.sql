prompt --application/pages/page_09999
begin
--   Manifest
--     PAGE: 09999
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_page.create_page(
 p_id=>9999
,p_name=>'Login Page'
,p_alias=>'LOGIN'
,p_step_title=>'RISK ADMIN - Sign In'
,p_warn_on_unsaved_changes=>'N'
,p_first_item=>'AUTO_FIRST_ITEM'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'#APP_IMAGES#bundled.js'
,p_step_template=>wwv_flow_imp.id(86048785305308250)
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_page_component_map=>'12'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(86177543984308601)
,p_plug_name=>'RISK ADMIN'
,p_icon_css_classes=>'app-icon'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(86086892512308304)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(86182092625308633)
,p_plug_name=>'Language Selector'
,p_parent_plug_id=>wwv_flow_imp.id(86177543984308601)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(86059750888308271)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>'apex_lang.emit_language_selector_list;'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_num_rows=>15
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(86180200993308627)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(86177543984308601)
,p_button_name=>'LOGIN'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(86150669999308397)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Sign In'
,p_button_position=>'NEXT'
,p_button_alignment=>'LEFT'
,p_grid_new_row=>'Y'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(86177783415308610)
,p_name=>'P9999_USERNAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(86177543984308601)
,p_prompt=>'Username'
,p_placeholder=>'Username'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(86149333946308388)
,p_item_icon_css_classes=>'fa-user'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(86178240582308611)
,p_name=>'P9999_PASSWORD'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(86177543984308601)
,p_prompt=>'Password'
,p_placeholder=>'Password'
,p_display_as=>'NATIVE_PASSWORD'
,p_cSize=>40
,p_cMaxlength=>100
,p_label_alignment=>'RIGHT'
,p_field_template=>wwv_flow_imp.id(86149333946308388)
,p_item_icon_css_classes=>'fa-key'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(86179282546308619)
,p_name=>'P9999_REMEMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(86177543984308601)
,p_prompt=>'Remember username'
,p_display_as=>'NATIVE_CHECKBOX'
,p_named_lov=>'LOGIN_REMEMBER_USERNAME'
,p_lov=>'.'||wwv_flow_imp.id(86178538238308612)||'.'
,p_label_alignment=>'RIGHT'
,p_display_when=>'apex_authentication.persistent_cookies_enabled'
,p_display_when2=>'PLSQL'
,p_display_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_imp.id(86149333946308388)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<p>',
'If you select this checkbox, the application will save your username in a persistent browser cookie named "LOGIN_USERNAME_COOKIE".',
'When you go to the login page the next time,',
'the username field will be automatically populated with this value.',
'</p>',
'<p>',
'If you deselect this checkbox and your username is already saved in the cookie,',
'the application will overwrite it with an empty value.',
'You can also use your browser''s developer tools to completely remove the cookie.',
'</p>'))
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'1'
,p_multi_value_type=>'SEPARATED'
,p_multi_value_separator=>':'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(93731619271648229)
,p_name=>'REGISTRAR_DISPOSITIVO'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(93731724086648230)
,p_event_id=>wwv_flow_imp.id(93731619271648229)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var deviceToken = apex.storage.getCookie("DEVICE_TOKEN");',
'var browser = bowser.parse(window.navigator.userAgent);',
'',
'apex.server.process("REGISTRAR_DISPOSITIVO", {',
'    x01: deviceToken, // token_dispositivo',
'    x02: browser.os.name, // nombre_sistema_operativo',
'    x03: browser.os.version, // version_sistema_operativo',
'    x04: browser.browser.name, // nombre_navegador',
'    x05: browser.browser.version, // version_navegador',
'    x06: browser.platform.type',
'}, {',
'    success: function (data) {',
'        // do something here',
'        console.log("Dispositivo registrado: ", data.device_token);',
'        apex.storage.setCookie("DEVICE_TOKEN", data.device_token);',
'    },',
'    error: function (jqXHR, textStatus, errorThrown) {',
'        // handle error',
'        console.log("Error al registrar dispositivo: ", errorThrown);',
'    }',
'});'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(86181027141308630)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Set Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.send_login_username_cookie (',
'    p_username => lower(:P9999_USERNAME),',
'    p_consent  => :P9999_REMEMBER = ''Y'' );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>83780185338462638
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(86180560998308629)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Login'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_authentication.login(',
'    p_username => :P9999_USERNAME,',
'    p_password => :P9999_PASSWORD );'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>83779719195462637
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(86181838187308632)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'Clear Page(s) Cache'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>83780996384462640
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(86181362486308631)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Get Username Cookie'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
':P9999_USERNAME := apex_authentication.get_login_username_cookie;',
':P9999_REMEMBER := case when :P9999_USERNAME is not null then ''Y'' end;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>83780520683462639
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(93731538379648228)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'REGISTRAR_DISPOSITIVO'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
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
'  -- Guarda el token del dispositivo en un collection (en el servidor)',
'  apex_collection.create_or_truncate_collection(p_collection_name => ''DEVICE_TOKEN'');',
'  apex_collection.add_member(p_collection_name => ''DEVICE_TOKEN'',',
'                             p_c001            => rw_dispositivo.token_dispositivo);',
'',
'  -- Retorna el token del dispositivo para guardar en un cookie (en el cliente)',
'  apex_json.open_object;',
'  apex_json.write(''device_token'', rw_dispositivo.token_dispositivo);',
'  apex_json.close_object;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>91330696576802236
);
wwv_flow_imp.component_end;
end;
/
