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

spool uninstall_headless.log

set define on

--accept v_app_name char default 'risk' prompt 'Enter app name (default ''risk''):'
DEFINE v_app_name = '&1'

prompt
prompt Dropping users...
prompt -----------------------------------
prompt
-- Drop users
DEFINE v_data_user = '&v_app_name._data'
DEFINE v_util_user = '&v_app_name._util'
DEFINE v_code_user = '&v_app_name.'
DEFINE v_dev_user = '&v_app_name._dev'
DEFINE v_access_user = '&v_app_name._access'

DROP USER &v_data_user CASCADE;
DROP USER &v_util_user CASCADE;
DROP USER &v_code_user CASCADE;
DROP USER msj CASCADE;
DROP USER flj CASCADE;
DROP USER &v_dev_user CASCADE;
DROP USER &v_access_user CASCADE;

prompt
prompt Dropping roles...
prompt -----------------------------------
prompt
-- Drop roles
DEFINE v_data_role = '&v_app_name._data_role'
DEFINE v_util_role = '&v_app_name._util_role'
DEFINE v_code_role = '&v_app_name._code_role'
DEFINE v_dev_role = '&v_app_name._dev_role'
DEFINE v_access_role = '&v_app_name._access_role'

DROP ROLE &v_data_role;
DROP ROLE &v_util_role;
DROP ROLE &v_code_role;
DROP ROLE &v_dev_role;
DROP ROLE &v_access_role;

spool off
