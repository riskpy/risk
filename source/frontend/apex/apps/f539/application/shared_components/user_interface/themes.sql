prompt --application/shared_components/user_interface/themes
begin
--   Manifest
--     THEME: 539
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_theme(
 p_id=>wwv_flow_imp.id(86153737047308419)
,p_theme_id=>42
,p_theme_name=>'Universal Theme'
,p_theme_internal_name=>'UNIVERSAL_THEME'
,p_version_identifier=>'1.6'
,p_navigation_type=>'L'
,p_nav_bar_type=>'LIST'
,p_reference_id=>4070917134413059350
,p_is_locked=>false
,p_default_page_template=>wwv_flow_imp.id(86053611578308255)
,p_default_dialog_template=>wwv_flow_imp.id(86047320855308249)
,p_error_template=>wwv_flow_imp.id(86048785305308250)
,p_printer_friendly_template=>wwv_flow_imp.id(86053611578308255)
,p_breadcrumb_display_point=>'REGION_POSITION_01'
,p_sidebar_display_point=>'REGION_POSITION_02'
,p_login_template=>wwv_flow_imp.id(86048785305308250)
,p_default_button_template=>wwv_flow_imp.id(86150669999308397)
,p_default_region_template=>wwv_flow_imp.id(86088180412308305)
,p_default_chart_template=>wwv_flow_imp.id(86088180412308305)
,p_default_form_template=>wwv_flow_imp.id(86088180412308305)
,p_default_reportr_template=>wwv_flow_imp.id(86088180412308305)
,p_default_tabform_template=>wwv_flow_imp.id(86088180412308305)
,p_default_wizard_template=>wwv_flow_imp.id(86088180412308305)
,p_default_menur_template=>wwv_flow_imp.id(86097551960308315)
,p_default_listr_template=>wwv_flow_imp.id(86088180412308305)
,p_default_irr_template=>wwv_flow_imp.id(86086331603308303)
,p_default_report_template=>wwv_flow_imp.id(86117068162308343)
,p_default_label_template=>wwv_flow_imp.id(86149637626308392)
,p_default_menu_template=>wwv_flow_imp.id(86152135198308399)
,p_default_calendar_template=>wwv_flow_imp.id(86152158656308401)
,p_default_list_template=>wwv_flow_imp.id(86147673405308382)
,p_default_nav_list_template=>wwv_flow_imp.id(86138693608308373)
,p_default_top_nav_list_temp=>wwv_flow_imp.id(86138693608308373)
,p_default_side_nav_list_temp=>wwv_flow_imp.id(86136889657308370)
,p_default_nav_list_position=>'SIDE'
,p_default_dialogbtnr_template=>wwv_flow_imp.id(86060818435308273)
,p_default_dialogr_template=>wwv_flow_imp.id(86059750888308271)
,p_default_option_label=>wwv_flow_imp.id(86149637626308392)
,p_default_required_label=>wwv_flow_imp.id(86149905266308393)
,p_default_navbar_list_template=>wwv_flow_imp.id(86139680200308374)
,p_file_prefix => nvl(wwv_flow_application_install.get_static_theme_file_prefix(42),'#IMAGE_PREFIX#themes/theme_42/1.6/')
,p_files_version=>64
,p_icon_library=>'FONTAPEX'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#IMAGE_PREFIX#libraries/apex/#MIN_DIRECTORY#widget.stickyWidget#MIN#.js?v=#APEX_VERSION#',
'#THEME_IMAGES#js/theme42#MIN#.js?v=#APEX_VERSION#'))
,p_css_file_urls=>'#THEME_IMAGES#css/Core#MIN#.css?v=#APEX_VERSION#'
);
wwv_flow_imp.component_end;
end;
/
