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

set define on
set verify off

--accept v_app_name char default 'RISK' prompt 'Enter app name (default ''RISK''):'

-- https://paulstuartoracle.wordpress.com/2015/05/24/running-sql-scripts-with-default-parameters/
col p1 new_value 1

select null p1 from dual where 1 = 2;
select nvl(upper('&1'), 'RISK') p1 from dual;

define v_app_name=&1

undefine 1

prompt ===================================
prompt App Name: &v_app_name
prompt ===================================

-- Define roles
DEFINE v_util_role = '&v_app_name._UTIL_ROLE'
DEFINE v_module_role = '&v_app_name._MODULE_ROLE'
DEFINE v_dev_role = '&v_app_name._DEV_ROLE'
DEFINE v_access_role = '&v_app_name._ACCESS_ROLE'

-- Define users
DEFINE v_util_user = '&v_app_name._UTIL'
DEFINE v_risk_module_user = '&v_app_name._RISK'
DEFINE v_msj_module_user = '&v_app_name._MSJ'
DEFINE v_flj_module_user = '&v_app_name._FLJ'
DEFINE v_dev_user = '&v_app_name._DEV'
DEFINE v_access_user = '&v_app_name._ACCESS'
