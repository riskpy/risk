/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 jtsoya539

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
prompt Tests installation started
prompt ===================================
prompt

prompt
prompt Creating package specs...
prompt -----------------------------------
prompt
@@package_specs/test_gb_personas.spc
--
@@package_specs/test_k_aplicacion.spc
@@package_specs/test_k_archivo.spc
@@package_specs/test_k_auditoria.spc
@@package_specs/test_k_autenticacion.spc
@@package_specs/test_k_autorizacion.spc
@@package_specs/test_k_cadena.spc
@@package_specs/test_k_clave.spc
@@package_specs/test_k_dato.spc
@@package_specs/test_k_dispositivo.spc
@@package_specs/test_k_dominio.spc
@@package_specs/test_k_error.spc
@@package_specs/test_k_html.spc
@@package_specs/test_k_mensajeria.spc
@@package_specs/test_k_modulo.spc
@@package_specs/test_k_operacion.spc
@@package_specs/test_k_reporte.spc
@@package_specs/test_k_servicio.spc
@@package_specs/test_k_sesion.spc
@@package_specs/test_k_significado.spc
@@package_specs/test_k_sistema.spc
@@package_specs/test_k_trabajo.spc
@@package_specs/test_k_usuario.spc
@@package_specs/test_k_util.spc
--
@@package_specs/test_y_dato.spc
@@package_specs/test_y_respuesta.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/test_gb_personas.bdy
--
@@package_bodies/test_k_aplicacion.bdy
@@package_bodies/test_k_archivo.bdy
@@package_bodies/test_k_auditoria.bdy
@@package_bodies/test_k_autenticacion.bdy
@@package_bodies/test_k_autorizacion.bdy
@@package_bodies/test_k_cadena.bdy
@@package_bodies/test_k_clave.bdy
@@package_bodies/test_k_dato.bdy
@@package_bodies/test_k_dispositivo.bdy
@@package_bodies/test_k_dominio.bdy
@@package_bodies/test_k_error.bdy
@@package_bodies/test_k_html.bdy
@@package_bodies/test_k_mensajeria.bdy
@@package_bodies/test_k_modulo.bdy
@@package_bodies/test_k_operacion.bdy
@@package_bodies/test_k_reporte.bdy
@@package_bodies/test_k_servicio.bdy
@@package_bodies/test_k_sesion.bdy
@@package_bodies/test_k_significado.bdy
@@package_bodies/test_k_sistema.bdy
@@package_bodies/test_k_trabajo.bdy
@@package_bodies/test_k_usuario.bdy
@@package_bodies/test_k_util.bdy
--
@@package_bodies/test_y_dato.bdy
@@package_bodies/test_y_respuesta.bdy

prompt
prompt ===================================
prompt Tests installation completed
prompt ===================================
prompt

spool off
