prompt --application/pages/page_00004
begin
--   Manifest
--     PAGE: 00004
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
 p_id=>4
,p_name=>unistr('Par\00E1metros')
,p_alias=>'PARAMETROS'
,p_step_title=>unistr('Par\00E1metros')
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(112436974916196601)
,p_plug_name=>'Report 1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(86086331603308303)
,p_plug_display_sequence=>10
,p_query_type=>'TABLE'
,p_query_table=>'T_PARAMETROS'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_page_header=>'Report 1'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(112437439760196601)
,p_name=>'Report 1'
,p_max_row_count_message=>'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.'
,p_no_data_found_message=>'No data found.'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'C'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_detail_link=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:RP:P5_ID_PARAMETRO:\#ID_PARAMETRO#\'
,p_detail_link_text=>'<span aria-label="Edit"><span class="fa fa-edit" aria-hidden="true" title="Edit"></span></span>'
,p_owner=>'JMEZA'
,p_internal_uid=>93907292778509286
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(112437490145196606)
,p_db_column_name=>'ID_PARAMETRO'
,p_display_order=>1
,p_column_identifier=>'A'
,p_column_label=>'Id Parametro'
,p_column_type=>'STRING'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(112437870099196613)
,p_db_column_name=>'DESCRIPCION'
,p_display_order=>2
,p_column_identifier=>'B'
,p_column_label=>'Descripcion'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(112438292180196613)
,p_db_column_name=>'VALOR'
,p_display_order=>3
,p_column_identifier=>'C'
,p_column_label=>'Valor'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(112438703068196613)
,p_db_column_name=>'ID_DOMINIO'
,p_display_order=>4
,p_column_identifier=>'D'
,p_column_label=>'Id Dominio'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(112831231142244703)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'943011'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID_PARAMETRO:DESCRIPCION:VALOR:ID_DOMINIO'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(112439922418196620)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(112436974916196601)
,p_button_name=>'CREATE'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(86150669999308397)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Create'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_alignment=>'RIGHT'
,p_button_redirect_url=>'f?p=&APP_ID.:5:&SESSION.::&DEBUG.:5'
);
wwv_flow_imp.component_end;
end;
/
