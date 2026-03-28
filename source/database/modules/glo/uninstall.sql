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
drop trigger ga_barrios;
drop trigger ga_ciudades;
drop trigger ga_departamentos;
drop trigger ga_distritos;
drop trigger ga_idiomas;
drop trigger ga_monedas;
drop trigger ga_paises;
drop trigger t_barrios_ioiud;
drop trigger t_ciudades_ioiud;
drop trigger t_departamentos_ioiud;
drop trigger t_idiomas_ioiud;
drop trigger t_monedas_ioiud;
drop trigger t_paises_ioiud;

prompt
prompt Dropping packages...
prompt -----------------------------------
prompt
drop package k_servicio_glo;
drop package t_barrios_api;
drop package t_ciudades_api;
drop package t_departamentos_api;
drop package t_distritos_api;
drop package t_idiomas_api;
drop package t_monedas_api;
drop package t_paises_api;

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
drop type y_barrio force;
drop type y_ciudad force;
drop type y_departamento force;
drop type y_distrito force;
drop type y_pais force;

prompt
prompt Dropping views...
prompt -----------------------------------
prompt
drop view t_barrios_dml_v cascade constraints;
drop view t_barrios_v cascade constraints;
drop view t_ciudades_dml_v cascade constraints;
drop view t_ciudades_v cascade constraints;
drop view t_departamentos_dml_v cascade constraints;
drop view t_departamentos_v cascade constraints;
drop view t_distritos_dml_v cascade constraints;
drop view t_distritos_v cascade constraints;
drop view t_idiomas_dml_v cascade constraints;
drop view t_idiomas_v cascade constraints;
drop view t_monedas_dml_v cascade constraints;
drop view t_monedas_v cascade constraints;
drop view t_paises_dml_v cascade constraints;
drop view t_paises_v cascade constraints;

prompt
prompt Dropping tables...
prompt -----------------------------------
prompt
drop table t_barrios cascade constraints purge;
drop table t_ciudades cascade constraints purge;
drop table t_departamentos cascade constraints purge;
drop table t_distritos cascade constraints purge;
drop table t_idiomas cascade constraints purge;
drop table t_monedas cascade constraints purge;
drop table t_paises cascade constraints purge;

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
@@scripts/operations/uninstall.sql
@@scripts/applications/uninstall.sql
@@scripts/errors/uninstall.sql
@@scripts/meanings/uninstall.sql
@@scripts/parameters/uninstall.sql
@@scripts/module/uninstall.sql
commit;
/

prompt
prompt ===================================
prompt Uninstallation completed
prompt ===================================
prompt

spool off
