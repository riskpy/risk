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
drop trigger gb_archivos;
drop trigger gb_datos;
drop trigger gb_operacion_parametros;
drop trigger gb_operaciones;
drop trigger gb_personas;
drop trigger gb_reportes;
drop trigger gb_servicios;
drop trigger gb_sesiones;
drop trigger gb_trabajos;
drop trigger gb_usuarios;
drop trigger gf_archivos;
drop trigger gf_operaciones;
drop trigger gs_monitoreo_ejecuciones;
drop trigger gs_operacion_logs;
drop trigger gs_operaciones;

prompt
prompt Dropping packages...
prompt -----------------------------------
prompt
drop package k_aplicacion;
drop package k_archivo;
drop package k_auditoria;
drop package k_autenticacion;
drop package k_autorizacion;
drop package k_cadena;
drop package k_clave;
drop package k_dato;
drop package k_dispositivo;
drop package k_dominio;
drop package k_error;
drop package k_html;
drop package k_importacion;
drop package k_json_util;
drop package k_lob_util;
drop package k_modulo;
drop package k_monitoreo;
drop package k_monitoreo_aut;
drop package k_objeto_util;
drop package k_operacion;
drop package k_parametro;
drop package k_reporte;
drop package k_reporte_gen;
drop package k_servicio;
drop package k_servicio_aut;
drop package k_servicio_gen;
drop package k_servicio_glo;
drop package k_sesion;
drop package k_significado;
drop package k_significado_util;
drop package k_sistema;
drop package k_trabajo;
drop package k_usuario;
drop package k_util;

prompt
prompt Dropping procedures...
prompt -----------------------------------
prompt

prompt
prompt Dropping functions...
prompt -----------------------------------
prompt
drop function f_procesar_reporte;
drop function f_procesar_servicio;

prompt
prompt Dropping java sources...
prompt -----------------------------------
prompt

prompt
prompt Dropping types...
prompt -----------------------------------
prompt
drop type y_archivo force;
drop type y_archivos force;
drop type y_barrio force;
drop type y_cadenas force;
drop type y_ciudad force;
drop type y_dato force;
drop type y_datos force;
drop type y_departamento force;
drop type y_dispositivo force;
drop type y_error force;
drop type y_lista force;
drop type y_lista_parametros force;
drop type y_objeto force;
drop type y_objetos force;
drop type y_pagina force;
drop type y_pagina_parametros force;
drop type y_pais force;
drop type y_parametro force;
drop type y_parametros force;
drop type y_plantilla force;
drop type y_respuesta force;
drop type y_rol force;
drop type y_sesion force;
drop type y_significado force;
drop type y_tipo_atributo force;
drop type y_tipo_atributos force;
drop type y_usuario force;

prompt
prompt Dropping views...
prompt -----------------------------------
prompt
drop view v_monitoreo_datos cascade constraints;
drop view v_operacion_logs cascade constraints;

prompt
prompt Dropping tables...
prompt -----------------------------------
prompt
drop table t_aplicaciones cascade constraints purge;
drop table t_archivo_definiciones cascade constraints purge;
drop table t_archivos cascade constraints purge;
drop table t_archivos_hist cascade constraints purge;
drop table t_autenticacion_origenes cascade constraints purge;
drop table t_autenticacion_tipos cascade constraints purge;
drop table t_barrios cascade constraints purge;
drop table t_ciudades cascade constraints purge;
drop table t_dato_definiciones cascade constraints purge;
drop table t_datos cascade constraints purge;
drop table t_departamentos cascade constraints purge;
drop table t_dispositivo_ubicaciones cascade constraints purge;
drop table t_dispositivos cascade constraints purge;
drop table t_dominios cascade constraints purge;
drop table t_errores cascade constraints purge;
drop table t_idiomas cascade constraints purge;
drop table t_importacion_parametros cascade constraints purge;
drop table t_importaciones cascade constraints purge;
drop table t_migraciones cascade constraints purge;
drop table t_modulos cascade constraints purge;
drop table t_monedas cascade constraints purge;
drop table t_monitoreo_ejecuciones cascade constraints purge;
drop table t_monitoreos cascade constraints purge;
drop table t_operacion_logs cascade constraints purge;
drop table t_operacion_parametros cascade constraints purge;
drop table t_operaciones cascade constraints purge;
drop table t_paises cascade constraints purge;
drop table t_parametro_definiciones cascade constraints purge;
drop table t_parametros cascade constraints purge;
drop table t_permisos cascade constraints purge;
drop table t_personas cascade constraints purge;
drop table t_reportes cascade constraints purge;
drop table t_rol_permisos cascade constraints purge;
drop table t_rol_usuarios cascade constraints purge;
drop table t_roles cascade constraints purge;
drop table t_servicios cascade constraints purge;
drop table t_sesiones cascade constraints purge;
drop table t_significado_dominios cascade constraints purge;
drop table t_significados cascade constraints purge;
drop table t_trabajos cascade constraints purge;
drop table t_usuario_claves cascade constraints purge;
drop table t_usuarios cascade constraints purge;

prompt
prompt Dropping sequences...
prompt -----------------------------------
prompt
drop sequence s_id_monitoreo_ejecucion;
drop sequence s_id_operacion_log;

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
commit;
/

prompt
prompt ===================================
prompt Uninstallation completed
prompt ===================================
prompt

spool off
