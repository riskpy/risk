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

spool install_headless.log

set define on

--accept v_app_name char default 'risk' prompt 'Enter app name (default ''risk''):'
--accept v_password char default 'risk' prompt 'Enter password (default ''risk''):' hide
DEFINE v_app_name = '&1'
DEFINE v_password = '&2'

prompt
prompt Creating roles...
prompt -----------------------------------
prompt
-- Create roles
DEFINE v_data_role = '&v_app_name._data_role'
DEFINE v_util_role = '&v_app_name._util_role'
DEFINE v_code_role = '&v_app_name._code_role'
DEFINE v_dev_role = '&v_app_name._dev_role'
DEFINE v_access_role = '&v_app_name._access_role'

CREATE ROLE &v_data_role;
CREATE ROLE &v_util_role;
CREATE ROLE &v_code_role;
CREATE ROLE &v_dev_role;
CREATE ROLE &v_access_role;

prompt
prompt Creating users...
prompt -----------------------------------
prompt
-- Create users
DEFINE v_data_user = '&v_app_name._data'
DEFINE v_util_user = '&v_app_name._util'
DEFINE v_code_user = '&v_app_name.'
DEFINE v_dev_user = '&v_app_name._dev'
DEFINE v_access_user = '&v_app_name._access'

CREATE USER &v_data_user NO AUTHENTICATION;
CREATE USER &v_util_user NO AUTHENTICATION;
CREATE USER &v_code_user NO AUTHENTICATION;
CREATE USER &v_dev_user IDENTIFIED BY &v_password;
CREATE USER &v_access_user IDENTIFIED BY &v_password;

ALTER USER &v_data_user GRANT CONNECT THROUGH &v_dev_user;
ALTER USER &v_util_user GRANT CONNECT THROUGH &v_dev_user;
ALTER USER &v_code_user GRANT CONNECT THROUGH &v_dev_user;

prompt
prompt Granting privileges to roles...
prompt -----------------------------------
prompt
-- Grant system privileges
GRANT CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK, CREATE MATERIALIZED VIEW, CREATE ANY PROCEDURE, ALTER ANY PROCEDURE, CREATE PUBLIC SYNONYM, DROP PUBLIC SYNONYM, CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, CREATE ANY TRIGGER, CREATE TYPE, CREATE VIEW TO &v_data_role, &v_util_role, &v_code_role;
GRANT DEBUG CONNECT SESSION TO &v_data_role, &v_util_role, &v_code_role;
--
GRANT CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK, CREATE MATERIALIZED VIEW, CREATE ANY PROCEDURE, ALTER ANY PROCEDURE, CREATE PUBLIC SYNONYM, DROP PUBLIC SYNONYM, CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, CREATE ANY TRIGGER, CREATE TYPE, CREATE VIEW TO &v_dev_role;
GRANT DEBUG CONNECT SESSION TO &v_dev_role;
GRANT ALL PRIVILEGES TO &v_dev_role;
--
GRANT CREATE SESSION TO &v_access_role;
-- Grant object privileges

prompt
prompt Granting privileges to users...
prompt -----------------------------------
prompt
-- Grant roles
GRANT &v_data_role TO &v_data_user;
GRANT &v_util_role TO &v_util_user;
GRANT &v_code_role TO &v_code_user;
GRANT &v_dev_role TO &v_dev_user;
GRANT &v_access_role TO &v_access_user;

-- Grant system privileges
GRANT UNLIMITED TABLESPACE TO &v_data_user;
GRANT CREATE JOB TO &v_data_user;
--
GRANT UNLIMITED TABLESPACE TO &v_util_user;
GRANT CREATE JOB TO &v_util_user;
--
GRANT UNLIMITED TABLESPACE TO &v_code_user;
GRANT CREATE JOB TO &v_code_user;
-- Grant object privileges
GRANT EXECUTE ON sys.dbms_crypto TO &v_util_user;
--
GRANT EXECUTE ON sys.dbms_crypto TO &v_code_user;
--
GRANT SELECT  ON sys.v_$session  TO &v_dev_user;
GRANT SELECT  ON sys.v_$sesstat  TO &v_dev_user;
GRANT SELECT  ON sys.v_$statname TO &v_dev_user;
GRANT EXECUTE ON sys.dbms_crypto TO &v_dev_user;
--
GRANT SELECT  ON sys.v_$session  TO &v_access_user;
GRANT SELECT  ON sys.v_$sesstat  TO &v_access_user;
GRANT SELECT  ON sys.v_$statname TO &v_access_user;

spool off
