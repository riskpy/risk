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
@@../../set_compiler_flags.sql glo

prompt
prompt Creating sequences...
prompt -----------------------------------
prompt

prompt
prompt Creating tables...
prompt -----------------------------------
prompt
@@tables/t_barrios.tab
@@tables/t_ciudades.tab
@@tables/t_departamentos.tab
@@tables/t_distritos.tab
@@tables/t_idiomas.tab
@@tables/t_monedas.tab
@@tables/t_paises.tab

prompt
prompt Creating foreign keys...
prompt -----------------------------------
prompt
@@foreign_keys/fk_barrios.sql
@@foreign_keys/fk_ciudades.sql
@@foreign_keys/fk_departamentos.sql
@@foreign_keys/fk_distritos.sql
@@foreign_keys/fk_monedas.sql

prompt
prompt Creating views...
prompt -----------------------------------
prompt
@@views/t_barrios_dml_v.vw
@@views/t_barrios_v.vw
@@views/t_ciudades_dml_v.vw
@@views/t_ciudades_v.vw
@@views/t_departamentos_dml_v.vw
@@views/t_departamentos_v.vw
@@views/t_distritos_dml_v.vw
@@views/t_distritos_v.vw
@@views/t_idiomas_dml_v.vw
@@views/t_idiomas_v.vw
@@views/t_monedas_dml_v.vw
@@views/t_monedas_v.vw
@@views/t_paises_dml_v.vw
@@views/t_paises_v.vw

prompt
prompt Creating type specs...
prompt -----------------------------------
prompt
@@type_specs/y_barrio.tps
@@type_specs/y_ciudad.tps
@@type_specs/y_departamento.tps
@@type_specs/y_distrito.tps
@@type_specs/y_pais.tps

prompt
prompt Creating type bodies...
prompt -----------------------------------
prompt
@@type_bodies/y_barrio.tpb
@@type_bodies/y_ciudad.tpb
@@type_bodies/y_departamento.tpb
@@type_bodies/y_distrito.tpb
@@type_bodies/y_pais.tpb

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
@@package_specs/k_servicio_glo.spc
@@package_specs/t_barrios_api.spc
@@package_specs/t_ciudades_api.spc
@@package_specs/t_departamentos_api.spc
@@package_specs/t_distritos_api.spc
@@package_specs/t_idiomas_api.spc
@@package_specs/t_monedas_api.spc
@@package_specs/t_paises_api.spc

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
@@package_bodies/k_servicio_glo.bdy
@@package_bodies/t_barrios_api.bdy
@@package_bodies/t_ciudades_api.bdy
@@package_bodies/t_departamentos_api.bdy
@@package_bodies/t_distritos_api.bdy
@@package_bodies/t_idiomas_api.bdy
@@package_bodies/t_monedas_api.bdy
@@package_bodies/t_paises_api.bdy

prompt
prompt Creating triggers...
prompt -----------------------------------
prompt
@@triggers/ga_barrios.trg
@@triggers/ga_ciudades.trg
@@triggers/ga_departamentos.trg
@@triggers/ga_distritos.trg
@@triggers/ga_idiomas.trg
@@triggers/ga_monedas.trg
@@triggers/ga_paises.trg
@@triggers/t_barrios_ioiud.trg
@@triggers/t_ciudades_ioiud.trg
@@triggers/t_departamentos_ioiud.trg
@@triggers/t_idiomas_ioiud.trg
@@triggers/t_monedas_ioiud.trg
@@triggers/t_paises_ioiud.trg

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
