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
drop trigger ga_aplicacion_parametros;
drop trigger ga_aplicaciones;
drop trigger ga_archivo_definiciones;
drop trigger ga_archivos;
drop trigger ga_archivos_hist;
drop trigger ga_autenticacion_origenes;
drop trigger ga_autenticacion_tipos;
drop trigger ga_barrios;
drop trigger ga_ciudades;
drop trigger ga_dato_definiciones;
drop trigger ga_datos;
drop trigger ga_departamentos;
drop trigger ga_dispositivo_ubicaciones;
drop trigger ga_dispositivos;
drop trigger ga_documento_tipos;
drop trigger ga_dominios;
drop trigger ga_entidad_roles;
drop trigger ga_entidad_usuarios;
drop trigger ga_entidades;
drop trigger ga_errores;
drop trigger ga_idiomas;
drop trigger ga_importacion_parametros;
drop trigger ga_importaciones;
drop trigger ga_migraciones;
drop trigger ga_modulos;
drop trigger ga_monedas;
drop trigger ga_monitoreo_ejecuciones;
drop trigger ga_monitoreos;
drop trigger ga_operacion_logs;
drop trigger ga_operacion_parametros;
drop trigger ga_operaciones;
drop trigger ga_paises;
drop trigger ga_parametro_definiciones;
drop trigger ga_parametros;
drop trigger ga_permisos;
drop trigger ga_personas;
drop trigger ga_reportes;
drop trigger ga_rol_permisos;
drop trigger ga_rol_usuarios;
drop trigger ga_roles;
drop trigger ga_servicios;
drop trigger ga_sesiones;
drop trigger ga_significado_dominios;
drop trigger ga_significados;
drop trigger ga_trabajos;
drop trigger ga_usuario_claves;
drop trigger ga_usuarios;
drop trigger gb_archivos;
drop trigger gb_datos;
drop trigger gb_entidades;
drop trigger gb_errores_actualizar_clave;
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
drop trigger t_aplicacion_parametros_ioiud;
drop trigger t_aplicaciones_ioiud;
drop trigger t_archivo_definiciones_ioiud;
drop trigger t_archivos_hist_ioiud;
drop trigger t_archivos_ioiud;
drop trigger t_autenticacion_origenes_ioiud;
drop trigger t_autenticacion_tipos_ioiud;
drop trigger t_barrios_ioiud;
drop trigger t_ciudades_ioiud;
drop trigger t_dato_definiciones_ioiud;
drop trigger t_datos_ioiud;
drop trigger t_departamentos_ioiud;
drop trigger t_dispositivo_ubicaciones_ioiud;
drop trigger t_dispositivos_ioiud;
drop trigger t_documento_tipos_ioiud;
drop trigger t_dominios_ioiud;
drop trigger t_entidad_roles_ioiud;
drop trigger t_entidad_usuarios_ioiud;
drop trigger t_entidades_ioiud;
drop trigger t_errores_ioiud;
drop trigger t_idiomas_ioiud;
drop trigger t_importacion_parametros_ioiud;
drop trigger t_importaciones_ioiud;
drop trigger t_migraciones_ioiud;
drop trigger t_modulos_ioiud;
drop trigger t_monedas_ioiud;
drop trigger t_monitoreo_ejecuciones_ioiud;
drop trigger t_monitoreos_ioiud;
drop trigger t_operacion_logs_ioiud;
drop trigger t_operacion_parametros_ioiud;
drop trigger t_operaciones_ioiud;
drop trigger t_paises_ioiud;
drop trigger t_parametro_definiciones_ioiud;
drop trigger t_parametros_ioiud;
drop trigger t_permisos_ioiud;
drop trigger t_personas_ioiud;
drop trigger t_reportes_ioiud;
drop trigger t_rol_permisos_ioiud;
drop trigger t_rol_usuarios_ioiud;
drop trigger t_roles_ioiud;
drop trigger t_servicios_ioiud;
drop trigger t_sesiones_ioiud;
drop trigger t_significado_dominios_ioiud;
drop trigger t_significados_ioiud;
drop trigger t_trabajos_ioiud;
drop trigger t_usuario_claves_ioiud;
drop trigger t_usuarios_ioiud;

prompt
prompt Dropping packages...
prompt -----------------------------------
prompt
drop package k_aplicacion;
drop package k_aplicacion_util;
drop package k_archivo;
drop package k_async;
drop package k_auditoria;
drop package k_autenticacion;
drop package k_autorizacion;
drop package k_cadena;
drop package k_clave;
drop package k_dato;
drop package k_dispositivo;
drop package k_dominio;
drop package k_entidad;
drop package k_error;
drop package k_error_util;
drop package k_html;
drop package k_importacion;
drop package k_json_util;
drop package k_lob_util;
drop package k_modulo;
drop package k_modulo_util;
drop package k_monitoreo;
drop package k_monitoreo_aut;
drop package k_objeto_util;
drop package k_operacion;
drop package k_operacion_util;
drop package k_parametro;
drop package k_parametro_util;
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
drop package t_aplicacion_parametros_api;
drop package t_aplicaciones_api;
drop package t_archivo_definiciones_api;
drop package t_archivos_api;
drop package t_archivos_hist_api;
drop package t_autenticacion_origenes_api;
drop package t_autenticacion_tipos_api;
drop package t_barrios_api;
drop package t_ciudades_api;
drop package t_dato_definiciones_api;
drop package t_datos_api;
drop package t_departamentos_api;
drop package t_dispositivo_ubicaciones_api;
drop package t_dispositivos_api;
drop package t_documento_tipos_api;
drop package t_dominios_api;
drop package t_entidad_roles_api;
drop package t_entidad_usuarios_api;
drop package t_entidades_api;
drop package t_errores_api;
drop package t_idiomas_api;
drop package t_importacion_parametros_api;
drop package t_importaciones_api;
drop package t_migraciones_api;
drop package t_modulos_api;
drop package t_monedas_api;
drop package t_monitoreo_ejecuciones_api;
drop package t_monitoreos_api;
drop package t_operacion_logs_api;
drop package t_operacion_parametros_api;
drop package t_operaciones_api;
drop package t_paises_api;
drop package t_parametro_definiciones_api;
drop package t_parametros_api;
drop package t_permisos_api;
drop package t_personas_api;
drop package t_reportes_api;
drop package t_rol_permisos_api;
drop package t_rol_usuarios_api;
drop package t_roles_api;
drop package t_servicios_api;
drop package t_sesiones_api;
drop package t_significado_dominios_api;
drop package t_significados_api;
drop package t_trabajos_api;
drop package t_usuario_claves_api;
drop package t_usuarios_api;

prompt
prompt Dropping procedures...
prompt -----------------------------------
prompt
drop procedure p_configurar_modificacion;
drop procedure p_control_auditoria;

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
drop type y_permiso force;
drop type y_permisos force;
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
drop view t_aplicacion_parametros_dml_v cascade constraints;
drop view t_aplicacion_parametros_v cascade constraints;
drop view t_aplicaciones_dml_v cascade constraints;
drop view t_aplicaciones_v cascade constraints;
drop view t_archivo_definiciones_dml_v cascade constraints;
drop view t_archivo_definiciones_v cascade constraints;
drop view t_archivos_dml_v cascade constraints;
drop view t_archivos_hist_dml_v cascade constraints;
drop view t_archivos_hist_v cascade constraints;
drop view t_archivos_v cascade constraints;
drop view t_autenticacion_origenes_dml_v cascade constraints;
drop view t_autenticacion_origenes_v cascade constraints;
drop view t_autenticacion_tipos_dml_v cascade constraints;
drop view t_autenticacion_tipos_v cascade constraints;
drop view t_barrios_dml_v cascade constraints;
drop view t_barrios_v cascade constraints;
drop view t_ciudades_dml_v cascade constraints;
drop view t_ciudades_v cascade constraints;
drop view t_dato_definiciones_dml_v cascade constraints;
drop view t_dato_definiciones_v cascade constraints;
drop view t_datos_dml_v cascade constraints;
drop view t_datos_v cascade constraints;
drop view t_departamentos_dml_v cascade constraints;
drop view t_departamentos_v cascade constraints;
drop view t_dispositivo_ubicaciones_dml_v cascade constraints;
drop view t_dispositivo_ubicaciones_v cascade constraints;
drop view t_dispositivos_dml_v cascade constraints;
drop view t_dispositivos_v cascade constraints;
drop view t_documento_tipos_dml_v cascade constraints;
drop view t_documento_tipos_v cascade constraints;
drop view t_dominios_dml_v cascade constraints;
drop view t_dominios_v cascade constraints;
drop view t_entidad_roles_dml_v cascade constraints;
drop view t_entidad_roles_v cascade constraints;
drop view t_entidad_usuarios_dml_v cascade constraints;
drop view t_entidad_usuarios_v cascade constraints;
drop view t_entidades_dml_v cascade constraints;
drop view t_entidades_v cascade constraints;
drop view t_errores_dml_v cascade constraints;
drop view t_errores_v cascade constraints;
drop view t_idiomas_dml_v cascade constraints;
drop view t_idiomas_v cascade constraints;
drop view t_importacion_parametros_dml_v cascade constraints;
drop view t_importacion_parametros_v cascade constraints;
drop view t_importaciones_dml_v cascade constraints;
drop view t_importaciones_v cascade constraints;
drop view t_migraciones_dml_v cascade constraints;
drop view t_migraciones_v cascade constraints;
drop view t_modulos_dml_v cascade constraints;
drop view t_modulos_v cascade constraints;
drop view t_monedas_dml_v cascade constraints;
drop view t_monedas_v cascade constraints;
drop view t_monitoreo_ejecuciones_dml_v cascade constraints;
drop view t_monitoreo_ejecuciones_v cascade constraints;
drop view t_monitoreos_dml_v cascade constraints;
drop view t_monitoreos_v cascade constraints;
drop view t_operacion_logs_dml_v cascade constraints;
drop view t_operacion_logs_v cascade constraints;
drop view t_operacion_parametros_dml_v cascade constraints;
drop view t_operacion_parametros_v cascade constraints;
drop view t_operaciones_dml_v cascade constraints;
drop view t_operaciones_v cascade constraints;
drop view t_paises_dml_v cascade constraints;
drop view t_paises_v cascade constraints;
drop view t_parametro_definiciones_dml_v cascade constraints;
drop view t_parametro_definiciones_v cascade constraints;
drop view t_parametros_dml_v cascade constraints;
drop view t_parametros_v cascade constraints;
drop view t_permisos_dml_v cascade constraints;
drop view t_permisos_v cascade constraints;
drop view t_personas_dml_v cascade constraints;
drop view t_personas_v cascade constraints;
drop view t_reportes_dml_v cascade constraints;
drop view t_reportes_v cascade constraints;
drop view t_rol_permisos_dml_v cascade constraints;
drop view t_rol_permisos_v cascade constraints;
drop view t_rol_usuarios_dml_v cascade constraints;
drop view t_rol_usuarios_v cascade constraints;
drop view t_roles_dml_v cascade constraints;
drop view t_roles_v cascade constraints;
drop view t_servicios_dml_v cascade constraints;
drop view t_servicios_v cascade constraints;
drop view t_sesiones_dml_v cascade constraints;
drop view t_sesiones_v cascade constraints;
drop view t_significado_dominios_dml_v cascade constraints;
drop view t_significado_dominios_v cascade constraints;
drop view t_significados_dml_v cascade constraints;
drop view t_significados_v cascade constraints;
drop view t_trabajos_dml_v cascade constraints;
drop view t_trabajos_v cascade constraints;
drop view t_usuario_claves_dml_v cascade constraints;
drop view t_usuario_claves_v cascade constraints;
drop view t_usuarios_dml_v cascade constraints;
drop view t_usuarios_v cascade constraints;
drop view v_monitoreo_datos cascade constraints;
drop view v_monitoreo_roles_responsables cascade constraints;
drop view v_monitoreo_usu_responsables cascade constraints;
drop view v_operacion_logs cascade constraints;

prompt
prompt Dropping tables...
prompt -----------------------------------
prompt
drop table t_aplicacion_parametros cascade constraints purge;
drop table t_aplicaciones cascade constraints purge;
drop table t_archivo_definiciones cascade constraints purge;
drop table t_archivos cascade constraints purge;
drop table t_archivos_hist cascade constraints purge;
drop table t_async_ejecuciones cascade constraints purge;
drop table t_autenticacion_origenes cascade constraints purge;
drop table t_autenticacion_tipos cascade constraints purge;
drop table t_barrios cascade constraints purge;
drop table t_ciudades cascade constraints purge;
drop table t_dato_definiciones cascade constraints purge;
drop table t_datos cascade constraints purge;
drop table t_departamentos cascade constraints purge;
drop table t_dispositivo_ubicaciones cascade constraints purge;
drop table t_dispositivos cascade constraints purge;
drop table t_documento_tipos cascade constraints purge;
drop table t_dominios cascade constraints purge;
drop table t_entidad_roles cascade constraints purge;
drop table t_entidad_usuarios cascade constraints purge;
drop table t_entidades cascade constraints purge;
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
