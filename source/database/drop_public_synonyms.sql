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
  cursor cr_objetos is
    select s.owner as syn_owner,
           s.synonym_name as syn_name,
           s.table_owner as obj_owner,
           s.table_name as obj_name,
           case
             when o.owner is null then
              'MISSING'
             else
              o.status
           end as obj_status,
           'drop public synonym ' || s.synonym_name as sentencia
      from all_synonyms s
      left join all_objects o
        on s.table_owner = o.owner
       and s.table_name = o.object_name
     where o.owner is null
       and s.table_owner like '&v_app_name.\_%' escape '\';
begin
  dbms_output.put_line('Dropping public synonyms...');
  dbms_output.put_line('-----------------------------------');
  for t in cr_objetos loop
    --dbms_output.put_line(t.sentencia);
    execute immediate t.sentencia;
  end loop;
end;
/

set define off
set serveroutput off
