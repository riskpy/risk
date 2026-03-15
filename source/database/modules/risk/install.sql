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
@@../../set_compiler_flags.sql risk

prompt
prompt Creating sequences...
prompt -----------------------------------
prompt

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_aplicacion_parametros.tab
@@tables/t_aplicaciones.tab
@@tables/t_archivo_definiciones.tab
@@tables/t_archivos.tab
@@tables/t_archivos_hist.tab
@@tables/t_async_ejecuciones.tab
@@tables/t_autenticacion_origenes.tab
@@tables/t_autenticacion_tipos.tab
@@tables/t_barrios.tab
@@tables/t_ciudades.tab
@@tables/t_dato_definiciones.tab
@@tables/t_datos.tab
@@tables/t_departamentos.tab
@@tables/t_dispositivo_ubicaciones.tab
@@tables/t_dispositivos.tab
@@tables/t_documento_tipos.tab
@@tables/t_dominios.tab
@@tables/t_entidad_roles.tab
@@tables/t_entidad_usuarios.tab
@@tables/t_entidades.tab
@@tables/t_errores.tab
@@tables/t_idiomas.tab
@@tables/t_importacion_parametros.tab
@@tables/t_importaciones.tab
@@tables/t_migraciones.tab
@@tables/t_modulos.tab
@@tables/t_monedas.tab
@@tables/t_monitoreo_ejecuciones.tab
@@tables/t_monitoreos.tab
@@tables/t_operacion_logs.tab
@@tables/t_operacion_parametros.tab
@@tables/t_operaciones.tab
@@tables/t_paises.tab
@@tables/t_parametro_definiciones.tab
@@tables/t_parametros.tab
@@tables/t_permisos.tab
@@tables/t_personas.tab
@@tables/t_reportes.tab
@@tables/t_rol_permisos.tab
@@tables/t_rol_usuarios.tab
@@tables/t_roles.tab
@@tables/t_servicios.tab
@@tables/t_sesiones.tab
@@tables/t_significado_dominios.tab
@@tables/t_significados.tab
@@tables/t_trabajos.tab
@@tables/t_usuario_claves.tab
@@tables/t_usuarios.tab

prompt
prompt Creating foreign keys...
prompt -----------------------------------
prompt
@@foreign_keys/fk_aplicacion_parametros.sql
@@foreign_keys/fk_aplicaciones.sql
@@foreign_keys/fk_archivos.sql
@@foreign_keys/fk_archivos_hist.sql
@@foreign_keys/fk_barrios.sql
@@foreign_keys/fk_ciudades.sql
@@foreign_keys/fk_datos.sql
@@foreign_keys/fk_departamentos.sql
@@foreign_keys/fk_dispositivo_ubicaciones.sql
@@foreign_keys/fk_dispositivos.sql
@@foreign_keys/fk_dominios.sql
@@foreign_keys/fk_entidad_roles.sql
@@foreign_keys/fk_entidad_usuarios.sql
@@foreign_keys/fk_entidades.sql
@@foreign_keys/fk_errores.sql
@@foreign_keys/fk_importacion_parametros.sql
@@foreign_keys/fk_importaciones.sql
@@foreign_keys/fk_monedas.sql
@@foreign_keys/fk_monitoreo_ejecuciones.sql
@@foreign_keys/fk_monitoreos.sql
@@foreign_keys/fk_operacion_parametros.sql
@@foreign_keys/fk_operaciones.sql
@@foreign_keys/fk_parametro_definiciones.sql
@@foreign_keys/fk_personas.sql
@@foreign_keys/fk_reportes.sql
@@foreign_keys/fk_rol_permisos.sql
@@foreign_keys/fk_rol_usuarios.sql
@@foreign_keys/fk_roles.sql
@@foreign_keys/fk_servicios.sql
@@foreign_keys/fk_sesiones.sql
@@foreign_keys/fk_significado_dominios.sql
@@foreign_keys/fk_trabajos.sql
@@foreign_keys/fk_usuario_claves.sql
@@foreign_keys/fk_usuarios.sql

prompt
prompt Creating views...
prompt -----------------------------------
prompt
@@views/t_aplicacion_parametros_dml_v.vw
@@views/t_aplicacion_parametros_v.vw
@@views/t_aplicaciones_dml_v.vw
@@views/t_aplicaciones_v.vw
@@views/t_archivo_definiciones_dml_v.vw
@@views/t_archivo_definiciones_v.vw
@@views/t_archivos_dml_v.vw
@@views/t_archivos_hist_dml_v.vw
@@views/t_archivos_hist_v.vw
@@views/t_archivos_v.vw
@@views/t_autenticacion_origenes_dml_v.vw
@@views/t_autenticacion_origenes_v.vw
@@views/t_autenticacion_tipos_dml_v.vw
@@views/t_autenticacion_tipos_v.vw
@@views/t_barrios_dml_v.vw
@@views/t_barrios_v.vw
@@views/t_ciudades_dml_v.vw
@@views/t_ciudades_v.vw
@@views/t_dato_definiciones_dml_v.vw
@@views/t_dato_definiciones_v.vw
@@views/t_datos_dml_v.vw
@@views/t_datos_v.vw
@@views/t_departamentos_dml_v.vw
@@views/t_departamentos_v.vw
@@views/t_dispositivo_ubicaciones_dml_v.vw
@@views/t_dispositivo_ubicaciones_v.vw
@@views/t_dispositivos_dml_v.vw
@@views/t_dispositivos_v.vw
@@views/t_documento_tipos_dml_v.vw
@@views/t_documento_tipos_v.vw
@@views/t_dominios_dml_v.vw
@@views/t_dominios_v.vw
@@views/t_entidad_roles_dml_v.vw
@@views/t_entidad_roles_v.vw
@@views/t_entidad_usuarios_dml_v.vw
@@views/t_entidad_usuarios_v.vw
@@views/t_entidades_dml_v.vw
@@views/t_entidades_v.vw
@@views/t_errores_dml_v.vw
@@views/t_errores_v.vw
@@views/t_idiomas_dml_v.vw
@@views/t_idiomas_v.vw
@@views/t_importacion_parametros_dml_v.vw
@@views/t_importacion_parametros_v.vw
@@views/t_importaciones_dml_v.vw
@@views/t_importaciones_v.vw
@@views/t_migraciones_dml_v.vw
@@views/t_migraciones_v.vw
@@views/t_modulos_dml_v.vw
@@views/t_modulos_v.vw
@@views/t_monedas_dml_v.vw
@@views/t_monedas_v.vw
@@views/t_monitoreo_ejecuciones_dml_v.vw
@@views/t_monitoreo_ejecuciones_v.vw
@@views/t_monitoreos_dml_v.vw
@@views/t_monitoreos_v.vw
@@views/t_operacion_logs_dml_v.vw
@@views/t_operacion_logs_v.vw
@@views/t_operacion_parametros_dml_v.vw
@@views/t_operacion_parametros_v.vw
@@views/t_operaciones_dml_v.vw
@@views/t_operaciones_v.vw
@@views/t_paises_dml_v.vw
@@views/t_paises_v.vw
@@views/t_parametro_definiciones_dml_v.vw
@@views/t_parametro_definiciones_v.vw
@@views/t_parametros_dml_v.vw
@@views/t_parametros_v.vw
@@views/t_permisos_dml_v.vw
@@views/t_permisos_v.vw
@@views/t_personas_dml_v.vw
@@views/t_personas_v.vw
@@views/t_reportes_dml_v.vw
@@views/t_reportes_v.vw
@@views/t_rol_permisos_dml_v.vw
@@views/t_rol_permisos_v.vw
@@views/t_rol_usuarios_dml_v.vw
@@views/t_rol_usuarios_v.vw
@@views/t_roles_dml_v.vw
@@views/t_roles_v.vw
@@views/t_servicios_dml_v.vw
@@views/t_servicios_v.vw
@@views/t_sesiones_dml_v.vw
@@views/t_sesiones_v.vw
@@views/t_significado_dominios_dml_v.vw
@@views/t_significado_dominios_v.vw
@@views/t_significados_dml_v.vw
@@views/t_significados_v.vw
@@views/t_trabajos_dml_v.vw
@@views/t_trabajos_v.vw
@@views/t_usuario_claves_dml_v.vw
@@views/t_usuario_claves_v.vw
@@views/t_usuarios_dml_v.vw
@@views/t_usuarios_v.vw
@@views/v_monitoreo_datos.vw
@@views/v_monitoreo_roles_responsables.vw
@@views/v_monitoreo_usu_responsables.vw
@@views/v_operacion_logs.vw

prompt
prompt Creating type specs...
prompt -----------------------------------
prompt
@@type_specs/y_archivo.tps
@@type_specs/y_barrio.tps
@@type_specs/y_cadenas.tps
@@type_specs/y_ciudad.tps
@@type_specs/y_dato.tps
@@type_specs/y_datos.tps
@@type_specs/y_departamento.tps
@@type_specs/y_dispositivo.tps
@@type_specs/y_error.tps
@@type_specs/y_lista.tps
@@type_specs/y_lista_parametros.tps
@@type_specs/y_objeto.tps
@@type_specs/y_objetos.tps
@@type_specs/y_pagina.tps
@@type_specs/y_pagina_parametros.tps
@@type_specs/y_pais.tps
@@type_specs/y_parametro.tps
@@type_specs/y_parametros.tps
@@type_specs/y_permiso.tps
@@type_specs/y_permisos.tps
@@type_specs/y_plantilla.tps
@@type_specs/y_respuesta.tps
@@type_specs/y_rol.tps
@@type_specs/y_sesion.tps
@@type_specs/y_significado.tps
@@type_specs/y_tipo_atributo.tps
@@type_specs/y_tipo_atributos.tps
@@type_specs/y_usuario.tps

prompt
prompt Creating type bodies...
prompt -----------------------------------
prompt
@@type_bodies/y_archivo.tpb
@@type_bodies/y_barrio.tpb
@@type_bodies/y_ciudad.tpb
@@type_bodies/y_dato.tpb
@@type_bodies/y_departamento.tpb
@@type_bodies/y_dispositivo.tpb
@@type_bodies/y_error.tpb
@@type_bodies/y_lista.tpb
@@type_bodies/y_lista_parametros.tpb
@@type_bodies/y_pagina.tpb
@@type_bodies/y_pagina_parametros.tpb
@@type_bodies/y_pais.tpb
@@type_bodies/y_parametro.tpb
@@type_bodies/y_permiso.tpb
@@type_bodies/y_plantilla.tpb
@@type_bodies/y_respuesta.tpb
@@type_bodies/y_rol.tpb
@@type_bodies/y_sesion.tpb
@@type_bodies/y_significado.tpb
@@type_bodies/y_tipo_atributo.tpb
@@type_bodies/y_usuario.tpb

prompt
prompt Creating java sources...
prompt -----------------------------------
prompt

prompt
prompt Creating functions...
prompt -----------------------------------
prompt
@@functions/f_procesar_reporte.fnc
@@functions/f_procesar_servicio.fnc

prompt
prompt Creating procedures...
prompt -----------------------------------
prompt
@@procedures/p_configurar_modificacion.prc
@@procedures/p_control_auditoria.prc

prompt
prompt Creating package specs...
prompt -----------------------------------
prompt
@@package_specs/k_aplicacion.spc
@@package_specs/k_aplicacion_util.spc
@@package_specs/k_archivo.spc
@@package_specs/k_async.spc
@@package_specs/k_auditoria.spc
@@package_specs/k_autenticacion.spc
@@package_specs/k_autorizacion.spc
@@package_specs/k_cadena.spc
@@package_specs/k_clave.spc
@@package_specs/k_dato.spc
@@package_specs/k_dispositivo.spc
@@package_specs/k_dominio.spc
@@package_specs/k_entidad.spc
@@package_specs/k_error.spc
@@package_specs/k_error_util.spc
@@package_specs/k_html.spc
@@package_specs/k_importacion.spc
@@package_specs/k_json_util.spc
@@package_specs/k_lob_util.spc
@@package_specs/k_modulo.spc
@@package_specs/k_modulo_util.spc
@@package_specs/k_monitoreo.spc
@@package_specs/k_monitoreo_aut.spc
@@package_specs/k_objeto_util.spc
@@package_specs/k_operacion.spc
@@package_specs/k_operacion_util.spc
@@package_specs/k_parametro.spc
@@package_specs/k_parametro_util.spc
@@package_specs/k_reporte.spc
@@package_specs/k_reporte_gen.spc
@@package_specs/k_servicio.spc
@@package_specs/k_servicio_aut.spc
@@package_specs/k_servicio_gen.spc
@@package_specs/k_servicio_glo.spc
@@package_specs/k_sesion.spc
@@package_specs/k_significado.spc
@@package_specs/k_significado_util.spc
@@package_specs/k_sistema.spc
@@package_specs/k_trabajo.spc
@@package_specs/k_usuario.spc
@@package_specs/k_util.spc
@@package_specs/t_aplicacion_parametros_api.spc
@@package_specs/t_aplicaciones_api.spc
@@package_specs/t_archivo_definiciones_api.spc
@@package_specs/t_archivos_api.spc
@@package_specs/t_archivos_hist_api.spc
@@package_specs/t_autenticacion_origenes_api.spc
@@package_specs/t_autenticacion_tipos_api.spc
@@package_specs/t_barrios_api.spc
@@package_specs/t_ciudades_api.spc
@@package_specs/t_dato_definiciones_api.spc
@@package_specs/t_datos_api.spc
@@package_specs/t_departamentos_api.spc
@@package_specs/t_dispositivo_ubicaciones_api.spc
@@package_specs/t_dispositivos_api.spc
@@package_specs/t_documento_tipos_api.spc
@@package_specs/t_dominios_api.spc
@@package_specs/t_entidad_roles_api.spc
@@package_specs/t_entidad_usuarios_api.spc
@@package_specs/t_entidades_api.spc
@@package_specs/t_errores_api.spc
@@package_specs/t_idiomas_api.spc
@@package_specs/t_importacion_parametros_api.spc
@@package_specs/t_importaciones_api.spc
@@package_specs/t_migraciones_api.spc
@@package_specs/t_modulos_api.spc
@@package_specs/t_monedas_api.spc
@@package_specs/t_monitoreo_ejecuciones_api.spc
@@package_specs/t_monitoreos_api.spc
@@package_specs/t_operacion_logs_api.spc
@@package_specs/t_operacion_parametros_api.spc
@@package_specs/t_operaciones_api.spc
@@package_specs/t_paises_api.spc
@@package_specs/t_parametro_definiciones_api.spc
@@package_specs/t_parametros_api.spc
@@package_specs/t_permisos_api.spc
@@package_specs/t_personas_api.spc
@@package_specs/t_reportes_api.spc
@@package_specs/t_rol_permisos_api.spc
@@package_specs/t_rol_usuarios_api.spc
@@package_specs/t_roles_api.spc
@@package_specs/t_servicios_api.spc
@@package_specs/t_sesiones_api.spc
@@package_specs/t_significado_dominios_api.spc
@@package_specs/t_significados_api.spc
@@package_specs/t_trabajos_api.spc
@@package_specs/t_usuario_claves_api.spc
@@package_specs/t_usuarios_api.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_aplicacion.bdy
@@package_bodies/k_aplicacion_util.bdy
@@package_bodies/k_archivo.bdy
@@package_bodies/k_async.bdy
@@package_bodies/k_auditoria.bdy
@@package_bodies/k_autenticacion.bdy
@@package_bodies/k_autorizacion.bdy
@@package_bodies/k_cadena.bdy
@@package_bodies/k_clave.bdy
@@package_bodies/k_dato.bdy
@@package_bodies/k_dispositivo.bdy
@@package_bodies/k_dominio.bdy
@@package_bodies/k_entidad.bdy
@@package_bodies/k_error.bdy
@@package_bodies/k_error_util.bdy
@@package_bodies/k_html.bdy
@@package_bodies/k_importacion.bdy
@@package_bodies/k_json_util.bdy
@@package_bodies/k_lob_util.bdy
@@package_bodies/k_modulo.bdy
@@package_bodies/k_modulo_util.bdy
@@package_bodies/k_monitoreo.bdy
@@package_bodies/k_monitoreo_aut.bdy
@@package_bodies/k_objeto_util.bdy
@@package_bodies/k_operacion.bdy
@@package_bodies/k_operacion_util.bdy
@@package_bodies/k_parametro.bdy
@@package_bodies/k_parametro_util.bdy
@@package_bodies/k_reporte.bdy
@@package_bodies/k_reporte_gen.bdy
@@package_bodies/k_servicio.bdy
@@package_bodies/k_servicio_aut.bdy
@@package_bodies/k_servicio_gen.bdy
@@package_bodies/k_servicio_glo.bdy
@@package_bodies/k_sesion.bdy
@@package_bodies/k_significado.bdy
@@package_bodies/k_significado_util.bdy
@@package_bodies/k_sistema.bdy
@@package_bodies/k_trabajo.bdy
@@package_bodies/k_usuario.bdy
@@package_bodies/k_util.bdy
@@package_bodies/t_aplicacion_parametros_api.bdy
@@package_bodies/t_aplicaciones_api.bdy
@@package_bodies/t_archivo_definiciones_api.bdy
@@package_bodies/t_archivos_api.bdy
@@package_bodies/t_archivos_hist_api.bdy
@@package_bodies/t_autenticacion_origenes_api.bdy
@@package_bodies/t_autenticacion_tipos_api.bdy
@@package_bodies/t_barrios_api.bdy
@@package_bodies/t_ciudades_api.bdy
@@package_bodies/t_dato_definiciones_api.bdy
@@package_bodies/t_datos_api.bdy
@@package_bodies/t_departamentos_api.bdy
@@package_bodies/t_dispositivo_ubicaciones_api.bdy
@@package_bodies/t_dispositivos_api.bdy
@@package_bodies/t_documento_tipos_api.bdy
@@package_bodies/t_dominios_api.bdy
@@package_bodies/t_entidad_roles_api.bdy
@@package_bodies/t_entidad_usuarios_api.bdy
@@package_bodies/t_entidades_api.bdy
@@package_bodies/t_errores_api.bdy
@@package_bodies/t_idiomas_api.bdy
@@package_bodies/t_importacion_parametros_api.bdy
@@package_bodies/t_importaciones_api.bdy
@@package_bodies/t_migraciones_api.bdy
@@package_bodies/t_modulos_api.bdy
@@package_bodies/t_monedas_api.bdy
@@package_bodies/t_monitoreo_ejecuciones_api.bdy
@@package_bodies/t_monitoreos_api.bdy
@@package_bodies/t_operacion_logs_api.bdy
@@package_bodies/t_operacion_parametros_api.bdy
@@package_bodies/t_operaciones_api.bdy
@@package_bodies/t_paises_api.bdy
@@package_bodies/t_parametro_definiciones_api.bdy
@@package_bodies/t_parametros_api.bdy
@@package_bodies/t_permisos_api.bdy
@@package_bodies/t_personas_api.bdy
@@package_bodies/t_reportes_api.bdy
@@package_bodies/t_rol_permisos_api.bdy
@@package_bodies/t_rol_usuarios_api.bdy
@@package_bodies/t_roles_api.bdy
@@package_bodies/t_servicios_api.bdy
@@package_bodies/t_sesiones_api.bdy
@@package_bodies/t_significado_dominios_api.bdy
@@package_bodies/t_significados_api.bdy
@@package_bodies/t_trabajos_api.bdy
@@package_bodies/t_usuario_claves_api.bdy
@@package_bodies/t_usuarios_api.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/ga_aplicacion_parametros.trg
@@triggers/ga_aplicaciones.trg
@@triggers/ga_archivo_definiciones.trg
@@triggers/ga_archivos.trg
@@triggers/ga_archivos_hist.trg
@@triggers/ga_autenticacion_origenes.trg
@@triggers/ga_autenticacion_tipos.trg
@@triggers/ga_barrios.trg
@@triggers/ga_ciudades.trg
@@triggers/ga_dato_definiciones.trg
@@triggers/ga_datos.trg
@@triggers/ga_departamentos.trg
@@triggers/ga_dispositivo_ubicaciones.trg
@@triggers/ga_dispositivos.trg
@@triggers/ga_documento_tipos.trg
@@triggers/ga_dominios.trg
@@triggers/ga_entidad_roles.trg
@@triggers/ga_entidad_usuarios.trg
@@triggers/ga_entidades.trg
@@triggers/ga_errores.trg
@@triggers/ga_idiomas.trg
@@triggers/ga_importacion_parametros.trg
@@triggers/ga_importaciones.trg
@@triggers/ga_migraciones.trg
@@triggers/ga_modulos.trg
@@triggers/ga_monedas.trg
@@triggers/ga_monitoreo_ejecuciones.trg
@@triggers/ga_monitoreos.trg
@@triggers/ga_operacion_logs.trg
@@triggers/ga_operacion_parametros.trg
@@triggers/ga_operaciones.trg
@@triggers/ga_paises.trg
@@triggers/ga_parametro_definiciones.trg
@@triggers/ga_parametros.trg
@@triggers/ga_permisos.trg
@@triggers/ga_personas.trg
@@triggers/ga_reportes.trg
@@triggers/ga_rol_permisos.trg
@@triggers/ga_rol_usuarios.trg
@@triggers/ga_roles.trg
@@triggers/ga_servicios.trg
@@triggers/ga_sesiones.trg
@@triggers/ga_significado_dominios.trg
@@triggers/ga_significados.trg
@@triggers/ga_trabajos.trg
@@triggers/ga_usuario_claves.trg
@@triggers/ga_usuarios.trg
@@triggers/gb_archivos.trg
@@triggers/gb_datos.trg
@@triggers/gb_entidades.trg
@@triggers/gb_errores_actualizar_clave.trg
@@triggers/gb_operacion_parametros.trg
@@triggers/gb_operaciones.trg
@@triggers/gb_personas.trg
@@triggers/gb_reportes.trg
@@triggers/gb_servicios.trg
@@triggers/gb_sesiones.trg
@@triggers/gb_trabajos.trg
@@triggers/gb_usuarios.trg
@@triggers/gf_archivos.trg
@@triggers/gf_operaciones.trg
@@triggers/t_aplicacion_parametros_ioiud.trg
@@triggers/t_aplicaciones_ioiud.trg
@@triggers/t_archivo_definiciones_ioiud.trg
@@triggers/t_archivos_hist_ioiud.trg
@@triggers/t_archivos_ioiud.trg
@@triggers/t_autenticacion_origenes_ioiud.trg
@@triggers/t_autenticacion_tipos_ioiud.trg
@@triggers/t_barrios_ioiud.trg
@@triggers/t_ciudades_ioiud.trg
@@triggers/t_dato_definiciones_ioiud.trg
@@triggers/t_datos_ioiud.trg
@@triggers/t_departamentos_ioiud.trg
@@triggers/t_dispositivo_ubicaciones_ioiud.trg
@@triggers/t_dispositivos_ioiud.trg
@@triggers/t_documento_tipos_ioiud.trg
@@triggers/t_dominios_ioiud.trg
@@triggers/t_entidad_roles_ioiud.trg
@@triggers/t_entidad_usuarios_ioiud.trg
@@triggers/t_entidades_ioiud.trg
@@triggers/t_errores_ioiud.trg
@@triggers/t_idiomas_ioiud.trg
@@triggers/t_importacion_parametros_ioiud.trg
@@triggers/t_importaciones_ioiud.trg
@@triggers/t_migraciones_ioiud.trg
@@triggers/t_modulos_ioiud.trg
@@triggers/t_monedas_ioiud.trg
@@triggers/t_monitoreo_ejecuciones_ioiud.trg
@@triggers/t_monitoreos_ioiud.trg
@@triggers/t_operacion_logs_ioiud.trg
@@triggers/t_operacion_parametros_ioiud.trg
@@triggers/t_operaciones_ioiud.trg
@@triggers/t_paises_ioiud.trg
@@triggers/t_parametro_definiciones_ioiud.trg
@@triggers/t_parametros_ioiud.trg
@@triggers/t_permisos_ioiud.trg
@@triggers/t_personas_ioiud.trg
@@triggers/t_reportes_ioiud.trg
@@triggers/t_rol_permisos_ioiud.trg
@@triggers/t_rol_usuarios_ioiud.trg
@@triggers/t_roles_ioiud.trg
@@triggers/t_servicios_ioiud.trg
@@triggers/t_sesiones_ioiud.trg
@@triggers/t_significado_dominios_ioiud.trg
@@triggers/t_significados_ioiud.trg
@@triggers/t_trabajos_ioiud.trg
@@triggers/t_usuario_claves_ioiud.trg
@@triggers/t_usuarios_ioiud.trg

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
@@scripts/ins_t_autenticacion_origenes.sql
@@scripts/ins_t_roles.sql
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
