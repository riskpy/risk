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

declare
  v_app_name varchar2(100) := 'RISK';

  type objeto_rt is record(
    owner       all_objects.owner%type,
    object_name all_objects.object_name%type,
    sentencia   varchar2(4000),
    granted     varchar2(1));

  type objetos_t is table of objeto_rt;
  l_sentencias objetos_t;

  l_owner varchar2(100);
  i       integer;
  j       integer;
begin
  select o.owner as owner,
         o.object_name as object_name,
         'grant ' ||
         decode(o.object_type,
                'TABLE',
                'select, insert, delete, update, references',
                'VIEW',
                'select',
                'SEQUENCE',
                'select',
                'TYPE',
                'execute' || decode(t.final, 'NO', ', under', ''),
                'execute') || ' on ' ||
         decode(o.object_type,
                'JAVA SOURCE',
                'java source ' || o.owner || '.' || o.object_name,
                o.owner || '.' || o.object_name) || ' to ' ||
         (select listagg(u.username, ',') within group(order by u.username)
            from all_users u
           where u.username in
                 (v_app_name || '_UTIL', v_app_name, 'MSJ', 'FLJ')
             and u.username not in
                 (o.owner, sys_context('USERENV', 'CURRENT_SCHEMA'))) ||
         ' with grant option' as sentencia,
         'N' as granted
    bulk collect
    into l_sentencias
    from all_objects o, all_types t
   where t.owner(+) = o.owner
     and t.type_name(+) = o.object_name
     and o.owner in (v_app_name || '_UTIL', v_app_name, 'MSJ', 'FLJ')
     and o.object_type in ('FUNCTION',
                           'PACKAGE',
                           'PROCEDURE',
                           'SEQUENCE',
                           'TABLE',
                           'VIEW',
                           'TYPE',
                           'JAVA SOURCE')
        /*and not exists (select 1
         from all_tab_privs p
        where p.grantor = o.owner
          and p.table_name = o.object_name)*/
        /*and exists (select 1
         from all_synonyms s
        where s.owner = 'PUBLIC'
          and s.table_name = o.object_name)*/
     and trim((select listagg(u.username, ',') within group(order by u.username)
                from all_users u
               where u.username in
                     (v_app_name || '_UTIL', v_app_name, 'MSJ', 'FLJ')
                 and u.username not in
                     (o.owner, sys_context('USERENV', 'CURRENT_SCHEMA')))) is not null
   order by decode(o.owner, v_app_name, 1, 99),
            o.owner,
            o.object_type,
            o.object_name;

  j := 1;
  while j <= 2 loop
    dbms_output.put_line('Granting objects (attempt ' || to_char(j) ||
                         ')...');
    dbms_output.put_line('-----------------------------------');
  
    i := l_sentencias.first;
    while i is not null loop
      if l_sentencias(i).granted = 'N' then
        if l_sentencias(i).owner <> nvl(l_owner, 'X') then
          l_owner := l_sentencias(i).owner;
          dbms_output.put_line('Granting objects for schema ' ||
                               upper(l_owner) || '...');
          dbms_output.put_line('-----------------------------------');
        end if;
      
        --dbms_output.put_line(l_sentencias(i).sentencia);
        begin
          execute immediate l_sentencias(i).sentencia;
          l_sentencias(i).granted := 'Y';
        exception
          when others then
            dbms_output.put_line(sqlerrm);
        end;
      end if;
      i := l_sentencias.next(i);
    end loop;
    j := j + 1;
  end loop;
end;
/

set serveroutput off
