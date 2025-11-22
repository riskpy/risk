create or replace package body k_auditoria is

  procedure p_generar_campos_auditoria(i_tabla    in varchar2,
                                       i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
  begin
    -- Genera campos
    l_sentencia := 'alter table ' || i_tabla || ' add
(
  ' || g_nombre_campo_created_by || ' VARCHAR2(300) DEFAULT SUBSTR(USER, 1, 300),
  ' || g_nombre_campo_created || ' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ' || g_nombre_campo_updated_by || ' VARCHAR2(300) DEFAULT SUBSTR(USER, 1, 300),
  ' || g_nombre_campo_updated || ' TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    -- Genera comentarios
    l_sentencia := 'comment on column ' || i_tabla || '.' ||
                   g_nombre_campo_created_by ||
                   ' is ''Usuario que realizó la inserción del registro''';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'comment on column ' || i_tabla || '.' ||
                   g_nombre_campo_created ||
                   ' is ''Fecha en que se realizó la inserción del registro''';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'comment on column ' || i_tabla || '.' ||
                   g_nombre_campo_updated_by ||
                   ' is ''Usuario que realizó la última modificación en el registro''';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'comment on column ' || i_tabla || '.' ||
                   g_nombre_campo_updated ||
                   ' is ''Fecha en que se realizó la última modificación en el registro''';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

  procedure p_generar_trigger_auditoria(i_tabla    in varchar2,
                                        i_trigger  in varchar2 default null,
                                        i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
    l_trigger   varchar2(30);
  begin
    l_trigger := lower(nvl(i_trigger,
                           g_prefijo_trigger_auditoria ||
                           substr(i_tabla, length(g_prefijo_tabla) + 1)));
  
    -- Genera trigger
    l_sentencia := 'CREATE OR REPLACE TRIGGER ' || l_trigger || '
  BEFORE INSERT OR UPDATE ON ' || lower(i_tabla) || '
  FOR EACH ROW
BEGIN
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

  IF inserting THEN
    -- Auditoría para inserción de registros
    :new.' || lower(g_nombre_campo_created_by) ||
                   ' := substr(coalesce(k_sistema.f_usuario, USER), 1, 300);
    :new.' || lower(g_nombre_campo_created) || ' := CURRENT_TIMESTAMP;
  END IF;

  -- Auditoría para modificación de registros
  :new.' || lower(g_nombre_campo_updated_by) || ' := substr(coalesce(k_sistema.f_usuario, USER), 1, 300);
  :new.' || lower(g_nombre_campo_updated) || ' := CURRENT_TIMESTAMP;
END;';
  
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

  procedure p_eliminar_campos_auditoria(i_tabla    in varchar2,
                                        i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
  begin
    -- Elimina campos
    l_sentencia := 'alter table ' || i_tabla || ' drop column ' ||
                   g_nombre_campo_created_by;
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'alter table ' || i_tabla || ' drop column ' ||
                   g_nombre_campo_created;
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'alter table ' || i_tabla || ' drop column ' ||
                   g_nombre_campo_updated_by;
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    l_sentencia := 'alter table ' || i_tabla || ' drop column ' ||
                   g_nombre_campo_updated;
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

  procedure p_eliminar_trigger_auditoria(i_tabla    in varchar2,
                                         i_trigger  in varchar2 default null,
                                         i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
    l_trigger   varchar2(30);
  begin
    l_trigger := lower(nvl(i_trigger,
                           g_prefijo_trigger_auditoria ||
                           substr(i_tabla, length(g_prefijo_tabla) + 1)));
  
    -- Genera trigger
    l_sentencia := 'drop trigger ' || l_trigger;
  
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

end;
/
