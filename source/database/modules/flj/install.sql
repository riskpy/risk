/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-------------------------------------------------------------------------------
*/

spool install.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Installation started
prompt ===================================
prompt
@@../../define_variables.sql
@@../../set_compiler_flags.sql flj

prompt
prompt Creating sequences...
prompt -----------------------------------
prompt

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_flujo_instancia_aprobaciones.tab
@@tables/t_flujo_instancia_historial.tab
@@tables/t_flujo_instancia_pasos.tab
@@tables/t_flujo_instancias.tab
@@tables/t_flujo_pasos.tab
@@tables/t_flujo_transiciones.tab
@@tables/t_flujos.tab

prompt
prompt Creating foreign keys...
prompt -----------------------------------
prompt
@@foreign_keys/fk_flujo_instancia_aprobaciones.sql
@@foreign_keys/fk_flujo_instancia_historial.sql
@@foreign_keys/fk_flujo_instancia_pasos.sql
@@foreign_keys/fk_flujo_instancias.sql
@@foreign_keys/fk_flujo_pasos.sql
@@foreign_keys/fk_flujo_transiciones.sql

prompt
prompt Creating views...
prompt -----------------------------------
prompt
@@views/t_flujo_instancia_aprobaciones_dml_v.vw
@@views/t_flujo_instancia_aprobaciones_v.vw
@@views/t_flujo_instancia_historial_dml_v.vw
@@views/t_flujo_instancia_historial_v.vw
@@views/t_flujo_instancia_pasos_dml_v.vw
@@views/t_flujo_instancia_pasos_v.vw
@@views/t_flujo_instancias_dml_v.vw
@@views/t_flujo_instancias_v.vw
@@views/t_flujo_pasos_dml_v.vw
@@views/t_flujo_pasos_v.vw
@@views/t_flujo_transiciones_dml_v.vw
@@views/t_flujo_transiciones_v.vw
@@views/t_flujos_dml_v.vw
@@views/t_flujos_v.vw
@@views/v_estado_flujo.vw
@@views/v_flujo_aprobador.vw
@@views/v_historial_aprobaciones.vw
@@views/v_historial_instancia.vw
@@views/v_pasos_en_progreso.vw
@@views/v_proximos_pasos.vw
@@views/v_roles_responsables_en_progreso.vw
@@views/v_roles_responsables_paso.vw
@@views/v_usuarios_responsables_paso.vw

prompt
prompt Creating type specs...
prompt -----------------------------------
prompt

prompt
prompt Creating type bodies...
prompt -----------------------------------
prompt

prompt
prompt Creating java sources...
prompt -----------------------------------
prompt

prompt
prompt Creating functions...
prompt -----------------------------------
prompt

prompt
prompt Creating procedures...
prompt -----------------------------------
prompt

prompt
prompt Creating package specs...
prompt -----------------------------------
prompt
@@package_specs/k_flujo.spc
@@package_specs/k_flujo_util.spc
@@package_specs/t_flujo_instancia_aprobaciones_api.spc
@@package_specs/t_flujo_instancia_historial_api.spc
@@package_specs/t_flujo_instancia_pasos_api.spc
@@package_specs/t_flujo_instancias_api.spc
@@package_specs/t_flujo_pasos_api.spc
@@package_specs/t_flujo_transiciones_api.spc
@@package_specs/t_flujos_api.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_flujo.bdy
@@package_bodies/k_flujo_util.bdy
@@package_bodies/t_flujo_instancia_aprobaciones_api.bdy
@@package_bodies/t_flujo_instancia_historial_api.bdy
@@package_bodies/t_flujo_instancia_pasos_api.bdy
@@package_bodies/t_flujo_instancias_api.bdy
@@package_bodies/t_flujo_pasos_api.bdy
@@package_bodies/t_flujo_transiciones_api.bdy
@@package_bodies/t_flujos_api.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/ga_flujo_instancia_aprobaciones.trg
@@triggers/ga_flujo_instancia_historial.trg
@@triggers/ga_flujo_instancia_pasos.trg
@@triggers/ga_flujo_instancias.trg
@@triggers/ga_flujo_pasos.trg
@@triggers/ga_flujo_transiciones.trg
@@triggers/ga_flujos.trg
@@triggers/gb_flujo_instancia_pasos.trg
@@triggers/gb_roles.trg
@@triggers/t_flujo_instancia_aprobaciones_ioiud.trg
@@triggers/t_flujo_instancia_historial_ioiud.trg
@@triggers/t_flujo_instancia_pasos_ioiud.trg
@@triggers/t_flujo_instancias_ioiud.trg
@@triggers/t_flujo_pasos_ioiud.trg
@@triggers/t_flujo_transiciones_ioiud.trg
@@triggers/t_flujos_ioiud.trg

set define on
@@../../create_private_synonyms.sql &v_app_name
@@../../grant_objects.sql &v_app_name
set define off
@@../../compile_schema.sql

prompt
prompt Running scripts...
prompt -----------------------------------
prompt
@@scripts/module/install.sql
@@scripts/parameters/install.sql
@@scripts/meanings/install.sql
@@scripts/errors/install.sql
@@scripts/applications/install.sql
@@scripts/operations/install.sql
commit;
/

prompt
prompt Running additional scripts...
prompt -----------------------------------
prompt
@@install_scripts.sql
commit;
/

prompt
prompt ===================================
prompt Installation completed
prompt ===================================
prompt

spool off
