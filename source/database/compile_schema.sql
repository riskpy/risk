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

@@define_variables.sql

set serveroutput on size unlimited

declare
  cursor cr_usuarios is
    select distinct o.owner as username
      from all_objects o
     where o.status = 'INVALID'
       and (o.owner in (sys_context('USERENV', 'CURRENT_SCHEMA')) or
           o.owner like '&v_app_name.\_%' escape '\')
       and o.owner not in ('SYS');

  cursor cr_sinonimos is
    select 'alter public synonym ' || o.object_name || ' compile' as sentencia
      from all_objects o
     where o.object_type = 'SYNONYM'
       and o.owner = 'PUBLIC'
       and o.status = 'INVALID';
begin
  for u in cr_usuarios loop
    dbms_output.put_line('Compiling invalid objects for schema ' ||
                         upper(u.username) || '...');
    dbms_output.put_line('-----------------------------------');
    dbms_utility.compile_schema(schema => u.username, compile_all => false);
  end loop;

  dbms_output.put_line('Compiling invalid public synonyms...');
  dbms_output.put_line('-----------------------------------');
  for t in cr_sinonimos loop
    --dbms_output.put_line(t.sentencia);
    execute immediate t.sentencia;
  end loop;
end;
/

set serveroutput off
