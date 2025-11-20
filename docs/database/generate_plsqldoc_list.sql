/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors

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

spool generate_docs.sql

set feedback off
set define off
set serveroutput on size unlimited

declare
  v_app_name varchar2(100) := 'RISK';

  cursor cr_objetos is
    select 'plugin plsqldoc generate ' || lower(o.object_name) || ';' plsqldoc
      from all_objects o
     where o.owner in (v_app_name || '_DATA', v_app_name)
       and ((o.object_type = 'TABLE' and lower(o.object_name) like 't\_%'
            escape '\') or (o.object_type = 'VIEW' and
           lower(o.object_name) like 'v\_%' escape '\') or
           (o.object_type = 'TYPE' and lower(o.object_name) like 'y\_%'
            escape '\') or (o.object_type = 'PACKAGE' and
           lower(o.object_name) like 'k\_%' escape '\') or
           (o.object_type = 'FUNCTION' and
           lower(o.object_name) like 'f\_%' escape '\') or
           (o.object_type = 'PROCEDURE' and
           lower(o.object_name) like 'p\_%' escape '\') or
           (o.object_type = 'TRIGGER' and
           lower(o.object_name) like 'g%\_%' escape '\') or
           (o.object_type = 'TRIGGER' and
           lower(o.object_name) like 'tg\_%' escape '\'))
    --and o.object_type = 'TABLE'
     order by decode(o.object_type,
                     'TABLE',
                     1,
                     'VIEW',
                     2,
                     'TYPE',
                     3,
                     'PACKAGE',
                     4,
                     'FUNCTION',
                     5,
                     'PROCEDURE',
                     6,
                     'TRIGGER',
                     7,
                     99),
              o.object_type,
              o.object_name;
begin
  dbms_output.put_line('/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and RISK contributors

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

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | '' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Generation of docs started
prompt ===================================
prompt

prompt
prompt Deleting docs...
prompt -----------------------------------
prompt
plugin plsqldoc delete;

prompt
prompt Generating docs...
prompt -----------------------------------
prompt');

  for o in cr_objetos loop
    dbms_output.put_line(o.plsqldoc);
  end loop;

  dbms_output.put_line('
prompt
prompt Generating index...
prompt -----------------------------------
prompt
plugin plsqldoc rebuild;

prompt
prompt ===================================
prompt Generation of docs completed
prompt ===================================
prompt
exit application');

end;
/

spool off
exit application
