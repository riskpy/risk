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

spool uninstall.log

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
prompt Uninstallation started
prompt ===================================
prompt

prompt
prompt Dropping triggers...
prompt -----------------------------------
prompt
drop trigger gb_flujo_instancia_pasos;
drop trigger gb_roles;

prompt
prompt Dropping packages...
prompt -----------------------------------
prompt
drop package k_flujo;
drop package k_flujo_util;

prompt
prompt Dropping procedures...
prompt -----------------------------------
prompt

prompt
prompt Dropping functions...
prompt -----------------------------------
prompt

prompt
prompt Dropping java sources...
prompt -----------------------------------
prompt

prompt
prompt Dropping types...
prompt -----------------------------------
prompt

prompt
prompt Dropping views...
prompt -----------------------------------
prompt
drop view v_estado_flujo cascade constraints;
drop view v_flujo_aprobador cascade constraints;
drop view v_historial_aprobaciones cascade constraints;
drop view v_historial_instancia cascade constraints;
drop view v_pasos_en_progreso cascade constraints;
drop view v_proximos_pasos cascade constraints;
drop view v_roles_responsables_en_progreso cascade constraints;
drop view v_roles_responsables_paso cascade constraints;
drop view v_usuarios_responsables_paso cascade constraints;

prompt
prompt Dropping tables...
prompt -----------------------------------
prompt
drop table t_flujo_instancia_aprobaciones cascade constraints purge;
drop table t_flujo_instancia_historial cascade constraints purge;
drop table t_flujo_instancia_pasos cascade constraints purge;
drop table t_flujo_instancias cascade constraints purge;
drop table t_flujo_pasos cascade constraints purge;
drop table t_flujo_transiciones cascade constraints purge;
drop table t_flujos cascade constraints purge;

prompt
prompt Dropping sequences...
prompt -----------------------------------
prompt

prompt
prompt Purging recycle bin...
prompt -----------------------------------
prompt
purge recyclebin;

--@@../../packages/k_modulo.pck
@@../../compile_schema.sql

prompt
prompt Running additional scripts...
prompt -----------------------------------
prompt
@@uninstall_scripts.sql
commit;
/

prompt
prompt Running scripts...
prompt -----------------------------------
prompt
@@scripts/meanings/uninstall.sql
@@scripts/del_t_errores.sql
@@scripts/del_t_aplicaciones.sql
@@scripts/del_t_parametros.sql
@@scripts/del_t_parametro_definiciones.sql
@@scripts/del_t_dominios.sql
@@scripts/del_t_modulos.sql
commit;
/

prompt
prompt ===================================
prompt Uninstallation completed
prompt ===================================
prompt

spool off
