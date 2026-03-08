clear screen

  /***************************************/
 /** INSTALL ora*CODECOP (OCC-UTPLSQL) **/
/***************************************/

whenever sqlerror exit failure rollback
whenever oserror exit failure rollback

set serveroutput on
set feedback on
set echo off
set heading off
set verify off

alter session set current_schema=occ;
--------------------------------------------------------------------------------
prompt >>> create objects

@ddl/package/utplsql.pks
@ddl/package/utplsql.pkb
--------------------------------------------------------------------------------
prompt >>> grant permission

@dcl/public/utplsql.pks

--------------------------------------------------------------------------------
prompt >>> done <<<