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
  l_sentencia clob;

  cursor cr_tablas is
    select owner, lower(table_name) as tabla
      from all_tables
     where owner like '&v_app_name\_%' escape
     '\'
       and lower(table_name) like 't\_%' escape '\';
begin
  for t in cr_tablas loop
    dbms_output.put_line('Dropping audit triggers for table ' ||
                         upper(t.owner) || '.' || upper(t.tabla) || '...');
    dbms_output.put_line('-----------------------------------');
    begin
      k_auditoria.p_eliminar_trigger_auditoria(o_sentencia => l_sentencia,
                                               i_esquema   => t.owner,
                                               i_tabla     => t.tabla,
                                               i_trigger   => null,
                                               i_ejecutar  => true);
    exception
      when others then
        dbms_output.put_line(sqlerrm);
    end;
  
    dbms_output.put_line('Dropping audit columns for table ' ||
                         upper(t.owner) || '.' || upper(t.tabla) || '...');
    dbms_output.put_line('-----------------------------------');
    begin
      k_auditoria.p_eliminar_campos_auditoria(o_sentencia => l_sentencia,
                                              i_esquema   => t.owner,
                                              i_tabla     => t.tabla,
                                              i_ejecutar  => true);
    exception
      when others then
        dbms_output.put_line(sqlerrm);
    end;
  end loop;
end;
/

set serveroutput off

@@compile_schema.sql
