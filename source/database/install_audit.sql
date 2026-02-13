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
  l_sentencia clob;

  cursor cr_tablas is
    select a.owner, lower(table_name) as tabla
      from all_tables a
     where a.owner like '&v_app_name.\_%' escape
     '\'
       and lower(table_name) like 't\_%' escape '\';
begin
  for t in cr_tablas loop
    begin
      dbms_output.put_line('Generating audit columns for table ' ||
                           upper(t.owner) || '.' || upper(t.tabla) ||
                           '...');
      dbms_output.put_line('-----------------------------------');
      k_auditoria.p_generar_campos_auditoria(o_sentencia => l_sentencia,
                                             i_esquema   => t.owner,
                                             i_tabla     => t.tabla,
                                             i_ejecutar  => true);
      dbms_output.put_line('Generating audit triggers for table ' ||
                           upper(t.owner) || '.' || upper(t.tabla) ||
                           '...');
      dbms_output.put_line('-----------------------------------');
      k_auditoria.p_generar_trigger_auditoria(o_sentencia => l_sentencia,
                                              i_esquema   => t.owner,
                                              i_tabla     => t.tabla,
                                              i_trigger   => null,
                                              i_ejecutar  => true);
    exception
      when others then
        dbms_output.put_line('Error generating audit for table ' ||
                             upper(t.tabla) || ': ' || sqlerrm);
        dbms_output.put_line('-----------------------------------');
    end;
  end loop;
end;
/

set define off
set serveroutput off

@@compile_schema.sql
