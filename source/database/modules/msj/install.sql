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
@@../../set_compiler_flags.sql msj

prompt
prompt Creating sequences...
prompt -----------------------------------
prompt

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_correo_adjuntos.tab
@@tables/t_correo_plantillas.tab
@@tables/t_correos.tab
@@tables/t_dispositivo_suscripciones.tab
@@tables/t_mensaje_plantillas.tab
@@tables/t_mensajeria_categorias.tab
@@tables/t_mensajes.tab
@@tables/t_mensajes_recibidos.tab
@@tables/t_notificacion_plantillas.tab
@@tables/t_notificaciones.tab
@@tables/t_usuario_suscripciones.tab

prompt
prompt Creating foreign keys...
prompt -----------------------------------
prompt
@@foreign_keys/fk_correo_adjuntos.sql
@@foreign_keys/fk_correo_plantillas.sql
@@foreign_keys/fk_correos.sql
@@foreign_keys/fk_mensaje_plantillas.sql
@@foreign_keys/fk_mensajes.sql
@@foreign_keys/fk_notificaciones.sql

prompt
prompt Creating views...
prompt -----------------------------------
prompt
@@views/t_correo_adjuntos_dml_v.vw
@@views/t_correo_adjuntos_v.vw
@@views/t_correo_plantillas_dml_v.vw
@@views/t_correo_plantillas_v.vw
@@views/t_correos_dml_v.vw
@@views/t_correos_v.vw
@@views/t_dispositivo_suscripciones_dml_v.vw
@@views/t_dispositivo_suscripciones_v.vw
@@views/t_mensaje_plantillas_dml_v.vw
@@views/t_mensaje_plantillas_v.vw
@@views/t_mensajeria_categorias_dml_v.vw
@@views/t_mensajeria_categorias_v.vw
@@views/t_mensajes_dml_v.vw
@@views/t_mensajes_recibidos_dml_v.vw
@@views/t_mensajes_recibidos_v.vw
@@views/t_mensajes_v.vw
@@views/t_notificacion_plantillas_dml_v.vw
@@views/t_notificacion_plantillas_v.vw
@@views/t_notificaciones_dml_v.vw
@@views/t_notificaciones_v.vw
@@views/t_usuario_suscripciones_dml_v.vw
@@views/t_usuario_suscripciones_v.vw

prompt
prompt Creating type specs...
prompt -----------------------------------
prompt
@@type_specs/y_correo.tps
@@type_specs/y_mensaje.tps
@@type_specs/y_notificacion.tps

prompt
prompt Creating type bodies...
prompt -----------------------------------
prompt
@@type_bodies/y_correo.tpb
@@type_bodies/y_mensaje.tpb
@@type_bodies/y_notificacion.tpb

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
@@package_specs/k_mensajeria.spc
@@package_specs/k_servicio_msj.spc
@@package_specs/t_correo_adjuntos_api.spc
@@package_specs/t_correo_plantillas_api.spc
@@package_specs/t_correos_api.spc
@@package_specs/t_dispositivo_suscripciones_api.spc
@@package_specs/t_mensaje_plantillas_api.spc
@@package_specs/t_mensajeria_categorias_api.spc
@@package_specs/t_mensajes_api.spc
@@package_specs/t_mensajes_recibidos_api.spc
@@package_specs/t_notificacion_plantillas_api.spc
@@package_specs/t_notificaciones_api.spc
@@package_specs/t_usuario_suscripciones_api.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_mensajeria.bdy
@@package_bodies/k_servicio_msj.bdy
@@package_bodies/t_correo_adjuntos_api.bdy
@@package_bodies/t_correo_plantillas_api.bdy
@@package_bodies/t_correos_api.bdy
@@package_bodies/t_dispositivo_suscripciones_api.bdy
@@package_bodies/t_mensaje_plantillas_api.bdy
@@package_bodies/t_mensajeria_categorias_api.bdy
@@package_bodies/t_mensajes_api.bdy
@@package_bodies/t_mensajes_recibidos_api.bdy
@@package_bodies/t_notificacion_plantillas_api.bdy
@@package_bodies/t_notificaciones_api.bdy
@@package_bodies/t_usuario_suscripciones_api.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/ga_correo_adjuntos.trg
@@triggers/ga_correo_plantillas.trg
@@triggers/ga_correos.trg
@@triggers/ga_dispositivo_suscripciones.trg
@@triggers/ga_mensaje_plantillas.trg
@@triggers/ga_mensajeria_categorias.trg
@@triggers/ga_mensajes.trg
@@triggers/ga_mensajes_recibidos.trg
@@triggers/ga_notificacion_plantillas.trg
@@triggers/ga_notificaciones.trg
@@triggers/ga_usuario_suscripciones.trg
@@triggers/gb_mensajes.trg
@@triggers/t_correo_adjuntos_ioiud.trg
@@triggers/t_correo_plantillas_ioiud.trg
@@triggers/t_correos_ioiud.trg
@@triggers/t_dispositivo_suscripciones_ioiud.trg
@@triggers/t_mensaje_plantillas_ioiud.trg
@@triggers/t_mensajeria_categorias_ioiud.trg
@@triggers/t_mensajes_ioiud.trg
@@triggers/t_mensajes_recibidos_ioiud.trg
@@triggers/t_notificacion_plantillas_ioiud.trg
@@triggers/t_notificaciones_ioiud.trg
@@triggers/t_usuario_suscripciones_ioiud.trg

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
