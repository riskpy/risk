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
DEFINE v_app_name = '&1'

prompt
prompt Defining code user...
prompt -----------------------------------
prompt
-- Define code user
DEFINE v_code_user = '&v_app_name.'

prompt
prompt Defining access role...
prompt -----------------------------------
prompt
-- Define access role
DEFINE v_access_role = '&v_app_name._access_role'

prompt
prompt Granting privileges to role...
prompt -----------------------------------
prompt
GRANT EXECUTE ON &v_code_user..f_procesar_servicio TO &v_access_role;
GRANT EXECUTE ON &v_code_user..f_procesar_reporte TO &v_access_role;

spool off
