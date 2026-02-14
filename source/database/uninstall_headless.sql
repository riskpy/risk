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

@@define_variables.sql

prompt
prompt Dropping users...
prompt -----------------------------------
prompt
-- Drop users
DROP USER &v_util_user CASCADE;
DROP USER &v_risk_module_user CASCADE;
DROP USER &v_msj_module_user CASCADE;
DROP USER &v_flj_module_user CASCADE;
DROP USER &v_dev_user CASCADE;
DROP USER &v_access_user CASCADE;

prompt
prompt Dropping roles...
prompt -----------------------------------
prompt
-- Drop roles
DROP ROLE &v_util_role;
DROP ROLE &v_module_role;
DROP ROLE &v_dev_role;
DROP ROLE &v_access_role;

spool off
