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

set serveroutput on size unlimited
set define on

DEFINE 1 = ''
COLUMN c1 NEW_VALUE v_app_name NOPRINT
select nvl(nullif('&1', ''), 'RISK') c1 from dual;

declare
  cursor cr_usuarios is
    select u.username
      from all_users u
     where u.username like '&v_app_name.\_%' escape '\';

  cursor cr_statements(i_owner in varchar2) is
    select 'drop ' || lower(x.object_type) || ' ' || lower(i_owner) || '.' ||
           lower(x.object_name) ||
           decode(x.object_type, 'VIEW', ' cascade constraints') as drop_statement
      from table(om_tapigen.view_naming_conflicts(p_owner => i_owner)) x
     where x.object_type in ('PACKAGE', 'VIEW');
begin
  for u in cr_usuarios loop
    for s in cr_statements(u.username) loop
      begin
        execute immediate s.drop_statement;
      exception
        when others then
          dbms_output.put_line(sqlerrm);
      end;
    end loop;
  end loop;
end;
/

set define off
set serveroutput off

@@compile_schema.sql
