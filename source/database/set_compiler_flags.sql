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

set define on

--accept v_module char default 'risk'
DEFINE v_module = '&1'

prompt - Set compiler flags
declare
  l_module           varchar2(30) := '&v_module';
  l_risk_module_user varchar2(30);
  l_plsql_ccflags    varchar2(4000);
begin
  begin
    select owner
      into l_risk_module_user
      from all_objects
     where object_type = 'PACKAGE'
       and object_name = 'K_MODULO';
  exception
    when no_data_found then
      l_risk_module_user := null;
  end;

  begin
    select plsql_ccflags
      into l_plsql_ccflags
      from all_plsql_object_settings
     where type = 'PACKAGE'
       and name = 'K_MODULO';
  exception
    when no_data_found then
      l_plsql_ccflags := null;
  end;

  if l_module is not null then
    if l_plsql_ccflags is null then
      l_plsql_ccflags := 'mi_' || l_module || ':true';
    else
      l_plsql_ccflags := l_plsql_ccflags || ',mi_' || l_module || ':true';
    end if;
  
    execute immediate 'alter session set plsql_ccflags = ''' ||
                      l_plsql_ccflags || '''';
    if l_risk_module_user is not null then
      execute immediate 'alter package ' || lower(l_risk_module_user) ||
                        '.k_modulo compile package';
    end if;
  end if;
end;
/

set define off
