prompt --application/deployment/definition
begin
--   Manifest
--     INSTALL: 539
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2024.05.31'
,p_release=>'24.1.0'
,p_default_workspace_id=>2000988041184963
,p_default_application_id=>539
,p_default_id_offset=>4719811504912323
,p_default_owner=>'RISK'
);
wwv_flow_imp_shared.create_install(
 p_id=>wwv_flow_imp.id(87330315450195490)
,p_welcome_message=>'This application installer will guide you through the process of creating your database objects and seed data.'
,p_license_message=>wwv_flow_string.join(wwv_flow_t_varchar2(
'MIT License<br>',
'<br>',
'Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors<br>',
'<br>',
'Permission is hereby granted, free of charge, to any person obtaining a copy<br>',
'of this software and associated documentation files (the "Software"), to deal<br>',
'in the Software without restriction, including without limitation the rights<br>',
'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell<br>',
'copies of the Software, and to permit persons to whom the Software is<br>',
'furnished to do so, subject to the following conditions:<br>',
'<br>',
'The above copyright notice and this permission notice shall be included in all<br>',
'copies or substantial portions of the Software.<br>',
'<br>',
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR<br>',
'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,<br>',
'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE<br>',
'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER<br>',
'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,<br>',
'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE<br>',
'SOFTWARE.<br>'))
,p_configuration_message=>'You can configure the following attributes of your application.'
,p_build_options_message=>'You can choose to include the following build options.'
,p_validation_message=>'The following validations will be performed to ensure your system is compatible with this application.'
,p_install_message=>'Please confirm that you would like to install this application''s supporting objects.'
,p_upgrade_message=>'The application installer has detected that this application''s supporting objects were previously installed.  This wizard will guide you through the process of upgrading these supporting objects.'
,p_upgrade_confirm_message=>'Please confirm that you would like to install this application''s supporting objects.'
,p_upgrade_success_message=>'Your application''s supporting objects have been installed.'
,p_upgrade_failure_message=>'Installation of database objects and seed data has failed.'
,p_deinstall_success_message=>'Deinstallation complete.'
,p_deinstall_script_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DELETE t_rol_permisos WHERE id_permiso LIKE ''PAGE:%'';',
'DELETE t_permisos WHERE id_permiso LIKE ''PAGE:%'';',
'UPDATE t_dispositivos SET id_aplicacion = NULL WHERE id_aplicacion = k_aplicacion.f_id_aplicacion(''wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='');',
'UPDATE t_sesiones SET id_aplicacion = NULL WHERE id_aplicacion = k_aplicacion.f_id_aplicacion(''wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='');',
'DELETE t_aplicaciones WHERE clave = ''wc/bL7KghNc2OJxpnWdBh0GoRkLx1mGYEsYlDF9aof4='';'))
);
wwv_flow_imp.component_end;
end;
/
