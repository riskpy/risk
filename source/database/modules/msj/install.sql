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
@@../../set_compiler_flags.sql msj
@@../risk/package_specs/k_modulo.spc

prompt
prompt Creating sequences...
prompt -----------------------------------
prompt

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_correo_adjuntos.tab
@@tables/t_correos.tab
@@tables/t_dispositivo_suscripciones.tab
@@tables/t_mensajes.tab
@@tables/t_notificacion_plantillas.tab
@@tables/t_notificaciones.tab
@@tables/t_usuario_suscripciones.tab

prompt
prompt Creating foreign keys...
prompt -----------------------------------
prompt
@@foreign_keys/fk_correo_adjuntos.sql
@@foreign_keys/fk_correos.sql
@@foreign_keys/fk_dispositivo_suscripciones.sql
@@foreign_keys/fk_mensajes.sql
@@foreign_keys/fk_notificacion_plantillas.sql
@@foreign_keys/fk_notificaciones.sql
@@foreign_keys/fk_usuario_suscripciones.sql

prompt
prompt Creating views...
prompt -----------------------------------
prompt

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
@@package_specs/k_modulo.spc
@@package_specs/k_servicio_msj.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_mensajeria.bdy
@@package_bodies/k_modulo.bdy
@@package_bodies/k_servicio_msj.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/gb_mensajes.trg

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
