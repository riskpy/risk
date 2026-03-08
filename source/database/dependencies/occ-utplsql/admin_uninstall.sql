clear screen

  /*****************************************/
 /** UNINSTALL ora*CODECOP (OCC-UTPLSQL) **/
/*****************************************/

whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

set serveroutput on
set feedback on
set echo off
set heading off
set verify off

alter session set current_schema=occ;
--------------------------------------------------------------------------------
prompt >>> drop package

drop package utplsql;

--------------------------------------------------------------------------------
prompt >>> done <<<