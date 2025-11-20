prompt --application/pages/page_00013
begin
--   Manifest
--     PAGE: 00013
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
 p_id=>13
,p_name=>unistr('Enviar Notificaci\00F3n')
,p_alias=>'ENVIAR_NOTIFICACION'
,p_step_title=>unistr('Enviar Notificaci\00F3n')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34131201500849936)
,p_plug_name=>unistr('Enviar Notificaci\00F3n')
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(86088180412308305)
,p_plug_display_sequence=>10
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'TEXT',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34131732310849942)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(86150669999308397)
,p_button_image_alt=>'Submit'
,p_button_position=>'CHANGE'
,p_button_alignment=>'RIGHT'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(34131640364849942)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_button_name=>'CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(86150669999308397)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CLOSE'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:1:&APP_SESSION.::&DEBUG.:::'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(34135304127849961)
,p_branch_action=>'f?p=&APP_ID.:11:&APP_SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(34131732310849942)
,p_branch_sequence=>1
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34132448551849951)
,p_name=>'P13_TITULO'
,p_is_required=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_prompt=>unistr('T\00EDtulo')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34132855236849957)
,p_name=>'P13_CONTENIDO'
,p_is_required=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_prompt=>'Contenido'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34133309445849958)
,p_name=>'P13_ID_USUARIO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_prompt=>'Usuario'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'USUARIOS'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT a.id_usuario      id_usuario,',
'       a.alias           alias,',
'       b.nombre_completo nombre_completo',
'  FROM t_usuarios a, t_personas b',
' WHERE b.id_persona(+) = a.id_persona'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'DIALOG'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34133668364849958)
,p_name=>'P13_SUSCRIPCION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_prompt=>unistr('Suscripci\00F3n')
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34134080401849958)
,p_name=>'P13_PRIORIDAD_ENVIO'
,p_is_required=>true
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_item_default=>'3'
,p_prompt=>'Prioridad'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'PRIORIDADES_ENVIO'
,p_lov=>'.'||wwv_flow_imp.id(33730269126785184)||'.'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34134535503849959)
,p_name=>'P13_DATOS_EXTRA'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(34131201500849936)
,p_prompt=>'Datos Extra'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(86149637626308392)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(34134848754849959)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Run Stored Procedure'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#OWNER#.K_MENSAJERIA.P_ENVIAR_NOTIFICACION(',
'"I_TITULO" => :P13_TITULO,',
'"I_CONTENIDO" => :P13_CONTENIDO,',
'"I_ID_USUARIO" => :P13_ID_USUARIO,',
'"I_SUSCRIPCION" => :P13_SUSCRIPCION,',
'"I_PRIORIDAD_ENVIO" => :P13_PRIORIDAD_ENVIO,',
'"I_DATOS_EXTRA" => :P13_DATOS_EXTRA);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(34131732310849942)
,p_internal_uid=>31734006952003967
);
wwv_flow_imp.component_end;
end;
/
