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

spool install_headless.log

set define on

--accept v_app_name char default 'risk' prompt 'Enter app name (default ''risk''):'
--accept v_password char default 'risk' prompt 'Enter password (default ''risk''):' hide
DEFINE v_app_name = '&1'
DEFINE v_password = '&2'

-- Create roles
DEFINE v_data_role = '&v_app_name._data_role'
DEFINE v_code_role = '&v_app_name._code_role'
DEFINE v_dev_role = '&v_app_name._dev_role'
DEFINE v_access_role = '&v_app_name._access_role'

CREATE ROLE &v_data_role;
CREATE ROLE &v_code_role;
CREATE ROLE &v_dev_role;
CREATE ROLE &v_access_role;

-- Grant system privileges
GRANT CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK, CREATE MATERIALIZED VIEW, CREATE ANY PROCEDURE, CREATE PUBLIC SYNONYM, CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, CREATE ANY TRIGGER, CREATE TYPE, CREATE VIEW TO &v_data_role, &v_code_role;
GRANT DEBUG CONNECT SESSION TO &v_data_role, &v_code_role;
-- Grant object privileges

-- Grant system privileges
GRANT CREATE SESSION, ALTER SESSION, CREATE DATABASE LINK, CREATE MATERIALIZED VIEW, CREATE ANY PROCEDURE, CREATE PUBLIC SYNONYM, CREATE ROLE, CREATE SEQUENCE, CREATE SYNONYM, CREATE TABLE, CREATE ANY TRIGGER, CREATE TYPE, CREATE VIEW TO &v_dev_role;
GRANT DEBUG CONNECT SESSION TO &v_dev_role;
GRANT ALL PRIVILEGES TO &v_dev_role;
-- Grant object privileges

-- Grant system privileges
GRANT CREATE SESSION TO &v_access_role;
-- Grant object privileges

-- Create users
DEFINE v_dev_user = '&v_app_name.'
DEFINE v_access_user = '&v_app_name._access'

CREATE USER &v_dev_user IDENTIFIED BY &v_password;
-- Grant roles
GRANT &v_dev_role TO &v_dev_user;
-- Grant system privileges
-- Grant object privileges
GRANT SELECT  ON sys.v_$session  TO &v_dev_user;
GRANT SELECT  ON sys.v_$sesstat  TO &v_dev_user;
GRANT SELECT  ON sys.v_$statname TO &v_dev_user;
GRANT EXECUTE ON sys.dbms_crypto TO &v_dev_user;
--
CREATE USER &v_access_user IDENTIFIED BY &v_password;
-- Grant roles
GRANT &v_access_role TO &v_access_user;
-- Grant system privileges
-- Grant object privileges
GRANT SELECT  ON sys.v_$session  TO &v_access_user;
GRANT SELECT  ON sys.v_$sesstat  TO &v_access_user;
GRANT SELECT  ON sys.v_$statname TO &v_access_user;
--
-- CREATE USER RISK IDENTIFIED BY &v_password;
-- Grant roles
GRANT &v_code_role TO RISK;
-- Grant system privileges
GRANT UNLIMITED TABLESPACE TO RISK;
GRANT CREATE JOB TO RISK;
-- Grant object privileges
GRANT SELECT  ON sys.v_$session  TO RISK;
GRANT SELECT  ON sys.v_$sesstat  TO RISK;
GRANT SELECT  ON sys.v_$statname TO RISK;
GRANT EXECUTE ON sys.dbms_crypto TO RISK;

spool off
