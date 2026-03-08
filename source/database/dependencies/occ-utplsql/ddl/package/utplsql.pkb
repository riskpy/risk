/*
occ-utplsql
Create utPLSQL unit tests from ora* CODECOP rules
*/
create or replace package body utplsql as
---------------------------------------------------------------------------------------------------------------------------------------------------------------
  procedure ut_package(
      i_package_name   in varchar2,
      i_create_package in boolean,
      i_print_source   in boolean)
  is
    c_package_name constant dbms_id_30 not null:=lower(i_package_name);
    c_create_package constant boolean not null:=i_create_package;
    c_print_source constant boolean not null:=i_print_source;
    c_pkg_end constant dbms_id_128:='end '||c_package_name||';';
    l_spec varchar2(32767 char):='create or replace package '||c_package_name||' authid definer as

  --%suite('||upper(c_package_name)||')

';
    l_body clob:='create or replace package body '||c_package_name||' as';
  begin
    for r in (select '--%test(Verify the rule '||code||' ('||rule_id||').)' as annotation,
                     'procedure rule_check_'||lower(replace(rule_id,'-','_'))||';' as testname
                from occ.ruleset)
    loop
      l_spec:=l_spec||'  '||r.annotation||'
  '||r.testname||'

';
    end loop;                  
    l_spec:=l_spec||c_pkg_end;

    for r in (select 'procedure rule_check_'||lower(replace(rule_id,'-','_'))||' is ' as opn,
                     '  l_number_of_failures pls_integer;' as dcl,
                     'begin' as beg,
                     '  select count(*) into l_number_of_failures from occ.api.verification_result(i_rule_id_or_code => '''||rule_id||''');' as qry,
                     '  ut.expect( a_actual => l_number_of_failures ).to_equal( a_expected => 0);' as chk,
                     'end rule_check_'||lower(replace(rule_id,'-','_'))||';' as cls
                from occ.ruleset)
    loop
      l_body:=l_body||'  '||r.opn||'
  '||r.dcl||'
  '||r.beg||'
  '||r.qry||'
  '||r.chk||'
  '||r.cls||'

';
    end loop;
    l_body:=l_body||c_pkg_end;

    if c_print_source then
      dbms_output.put_line(l_spec);
      dbms_output.put_line('/');
      dbms_output.put_line(l_body);
      dbms_output.put_line('/');
    end if;

    if c_create_package then
      execute immediate l_spec;
      execute immediate l_body;      
    end if;

  end ut_package;
---------------------------------------------------------------------------------------------------------------------------------------------------------------
end utplsql;
/