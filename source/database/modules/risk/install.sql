/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors

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
@@sequences/s_id_monitoreo_ejecucion.seq
@@sequences/s_id_operacion_log.seq

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_aplicaciones.tab
@@tables/t_archivo_definiciones.tab
@@tables/t_archivos.tab
@@tables/t_archivos_hist.tab
@@tables/t_autenticacion_origenes.tab
@@tables/t_autenticacion_tipos.tab
@@tables/t_barrios.tab
@@tables/t_ciudades.tab
@@tables/t_dato_definiciones.tab
@@tables/t_datos.tab
@@tables/t_departamentos.tab
@@tables/t_dispositivo_ubicaciones.tab
@@tables/t_dispositivos.tab
@@tables/t_dominios.tab
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
@@foreign_keys/fk_archivos.sql
@@foreign_keys/fk_archivos_hist.sql
@@foreign_keys/fk_barrios.sql
@@foreign_keys/fk_ciudades.sql
@@foreign_keys/fk_datos.sql
@@foreign_keys/fk_departamentos.sql
@@foreign_keys/fk_dispositivo_ubicaciones.sql
@@foreign_keys/fk_dispositivos.sql
@@foreign_keys/fk_dominios.sql
@@foreign_keys/fk_errores.sql
@@foreign_keys/fk_importacion_parametros.sql
@@foreign_keys/fk_importaciones.sql
@@foreign_keys/fk_monedas.sql
@@foreign_keys/fk_monitoreo_ejecuciones.sql
@@foreign_keys/fk_monitoreos.sql
@@foreign_keys/fk_operacion_logs.sql
@@foreign_keys/fk_operacion_parametros.sql
@@foreign_keys/fk_operaciones.sql
@@foreign_keys/fk_parametro_definiciones.sql
@@foreign_keys/fk_personas.sql
@@foreign_keys/fk_reportes.sql
@@foreign_keys/fk_rol_permisos.sql
@@foreign_keys/fk_rol_usuarios.sql
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
@@views/v_monitoreo_datos.vw
@@views/v_operacion_logs.vw

prompt
prompt Creating type specs...
prompt -----------------------------------
prompt
@@type_specs/y_archivo.tps
@@type_specs/y_archivos.tps
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

prompt
prompt Creating package specs...
prompt -----------------------------------
prompt
@@package_specs/k_aplicacion.spc
@@package_specs/k_archivo.spc
@@package_specs/k_auditoria.spc
@@package_specs/k_autenticacion.spc
@@package_specs/k_autorizacion.spc
@@package_specs/k_cadena.spc
@@package_specs/k_clave.spc
@@package_specs/k_dato.spc
@@package_specs/k_dispositivo.spc
@@package_specs/k_dominio.spc
@@package_specs/k_error.spc
@@package_specs/k_html.spc
@@package_specs/k_importacion.spc
@@package_specs/k_json_util.spc
@@package_specs/k_lob_util.spc
@@package_specs/k_modulo.spc
@@package_specs/k_monitoreo.spc
@@package_specs/k_monitoreo_aut.spc
@@package_specs/k_objeto_util.spc
@@package_specs/k_operacion.spc
@@package_specs/k_parametro.spc
@@package_specs/k_reporte.spc
@@package_specs/k_reporte_gen.spc
@@package_specs/k_servicio.spc
@@package_specs/k_servicio_aut.spc
@@package_specs/k_servicio_gen.spc
@@package_specs/k_servicio_glo.spc
@@package_specs/k_sesion.spc
@@package_specs/k_significado.spc
@@package_specs/k_sistema.spc
@@package_specs/k_trabajo.spc
@@package_specs/k_usuario.spc
@@package_specs/k_util.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_aplicacion.bdy
@@package_bodies/k_archivo.bdy
@@package_bodies/k_auditoria.bdy
@@package_bodies/k_autenticacion.bdy
@@package_bodies/k_autorizacion.bdy
@@package_bodies/k_cadena.bdy
@@package_bodies/k_clave.bdy
@@package_bodies/k_dato.bdy
@@package_bodies/k_dispositivo.bdy
@@package_bodies/k_dominio.bdy
@@package_bodies/k_error.bdy
@@package_bodies/k_html.bdy
@@package_bodies/k_importacion.bdy
@@package_bodies/k_json_util.bdy
@@package_bodies/k_lob_util.bdy
@@package_bodies/k_modulo.bdy
@@package_bodies/k_monitoreo.bdy
@@package_bodies/k_monitoreo_aut.bdy
@@package_bodies/k_objeto_util.bdy
@@package_bodies/k_operacion.bdy
@@package_bodies/k_parametro.bdy
@@package_bodies/k_reporte.bdy
@@package_bodies/k_reporte_gen.bdy
@@package_bodies/k_servicio.bdy
@@package_bodies/k_servicio_aut.bdy
@@package_bodies/k_servicio_gen.bdy
@@package_bodies/k_servicio_glo.bdy
@@package_bodies/k_sesion.bdy
@@package_bodies/k_significado.bdy
@@package_bodies/k_sistema.bdy
@@package_bodies/k_trabajo.bdy
@@package_bodies/k_usuario.bdy
@@package_bodies/k_util.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/gb_archivos.trg
@@triggers/gb_datos.trg
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
@@triggers/gs_monitoreo_ejecuciones.trg
@@triggers/gs_operacion_logs.trg
@@triggers/gs_operaciones.trg

@@../../compile_schema.sql

prompt
prompt Running scripts...
prompt -----------------------------------
prompt
@@scripts/ins_t_modulos.sql
@@scripts/ins_t_dominios.sql
@@scripts/ins_t_significado_dominios.sql
@@scripts/ins_t_significados.sql
@@scripts/ins_t_parametro_definiciones.sql
@@scripts/ins_t_parametros.sql
@@scripts/ins_t_aplicaciones.sql
@@scripts/ins_t_errores.sql
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
