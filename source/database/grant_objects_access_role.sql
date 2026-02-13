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

spool grant_objects_access_role.log

set define on

--accept v_app_name char default 'risk' prompt 'Enter app name (default ''risk''):'
DEFINE 1 = ''
COLUMN c1 NEW_VALUE v_app_name NOPRINT
select nvl(nullif('&1', ''), 'RISK') c1 from dual;

prompt
prompt Defining roles...
prompt -----------------------------------
prompt
DEFINE v_access_role = '&v_app_name._access_role'

prompt
prompt Defining users...
prompt -----------------------------------
prompt
DEFINE v_risk_module_user = '&v_app_name._risk'

prompt
prompt Granting privileges to role...
prompt -----------------------------------
prompt
GRANT EXECUTE ON &v_risk_module_user..f_procesar_servicio TO &v_access_role;
GRANT EXECUTE ON &v_risk_module_user..f_procesar_reporte TO &v_access_role;

spool off
