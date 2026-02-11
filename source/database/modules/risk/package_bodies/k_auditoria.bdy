create or replace package body k_auditoria is

  procedure lp_ejecutar_sentencias_ddl(i_sentencias in clob) is
  begin
    for c in (select trim(column_value) sentencia
                from k_cadena.f_separar_cadenas(replace(replace(i_sentencias,
                                                                unistr('\000D')),
                                                        unistr('\000A')),
                                                ';')
               where trim(column_value) is not null) loop
      execute immediate c.sentencia;
    end loop;
  end;

  procedure p_generar_campos_auditoria(o_sentencia out clob,
                                       i_esquema   in varchar2,
                                       i_tabla     in varchar2,
                                       i_ejecutar  in boolean default true) is
    l_sentencia clob;
  begin
    -- Genera campos
    l_sentencia := l_sentencia || 'alter table ' || i_esquema || '.' ||
                   i_tabla || ' add
(
  ' || g_nombre_campo_created_by || ' VARCHAR2(300) DEFAULT SUBSTR(USER, 1, 300) not null,
  ' || g_nombre_campo_created || ' TIMESTAMP(2) DEFAULT SYSTIMESTAMP not null,
  ' || g_nombre_campo_updated_by || ' VARCHAR2(300),
  ' || g_nombre_campo_updated || ' TIMESTAMP(2)
);' || utl_tcp.crlf;
  
    -- Genera comentarios
    l_sentencia := l_sentencia || 'comment on column ' || i_esquema || '.' ||
                   i_tabla || '.' || g_nombre_campo_created_by ||
                   ' is ''Usuario que realizó la creación del registro'';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'comment on column ' || i_esquema || '.' ||
                   i_tabla || '.' || g_nombre_campo_created ||
                   ' is ''Fecha en que se realizó la creación del registro'';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'comment on column ' || i_esquema || '.' ||
                   i_tabla || '.' || g_nombre_campo_updated_by ||
                   ' is ''Usuario que realizó la última edición del registro'';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'comment on column ' || i_esquema || '.' ||
                   i_tabla || '.' || g_nombre_campo_updated ||
                   ' is ''Fecha en que se realizó la última edición del registro'';' ||
                   utl_tcp.crlf;
  
    o_sentencia := l_sentencia;
  
    if i_ejecutar then
      lp_ejecutar_sentencias_ddl(o_sentencia);
    end if;
  end;

  procedure p_generar_trigger_auditoria(o_sentencia out clob,
                                        i_esquema   in varchar2,
                                        i_tabla     in varchar2,
                                        i_trigger   in varchar2 default null,
                                        i_ejecutar  in boolean default true) is
    l_sentencia clob;
    l_trigger   varchar2(300);
  begin
    l_trigger := lower(nvl(g_esquema_auditoria, i_esquema) || '.' ||
                       nvl(i_trigger,
                           g_prefijo_trigger_auditoria ||
                           substr(i_tabla, length(g_prefijo_tabla) + 1)));
  
    -- Genera trigger
    l_sentencia := l_sentencia || 'CREATE OR REPLACE TRIGGER ' || l_trigger || '
  BEFORE INSERT OR UPDATE ON ' ||
                   lower(i_esquema || '.' || i_tabla) || '
  FOR EACH ROW
BEGIN
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

  IF inserting THEN
    -- Auditoría para inserción de registros
    :new.' || lower(g_nombre_campo_created_by) ||
                   ' := substr(coalesce(k_sistema.f_usuario, USER), 1, 300);
    :new.' || lower(g_nombre_campo_created) || ' := SYSTIMESTAMP;
  END IF;

  -- Auditoría para modificación de registros
  :new.' || lower(g_nombre_campo_updated_by) || ' := substr(coalesce(k_sistema.f_usuario, USER), 1, 300);
  :new.' || lower(g_nombre_campo_updated) || ' := SYSTIMESTAMP;
END;';
  
    o_sentencia := l_sentencia;
  
    if i_ejecutar then
      execute immediate o_sentencia;
    end if;
  end;

  procedure p_eliminar_campos_auditoria(o_sentencia out clob,
                                        i_esquema   in varchar2,
                                        i_tabla     in varchar2,
                                        i_ejecutar  in boolean default true) is
    l_sentencia clob;
  begin
    -- Elimina campos
    l_sentencia := l_sentencia || 'alter table ' || i_esquema || '.' ||
                   i_tabla || ' drop column ' || g_nombre_campo_created_by || ';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'alter table ' || i_esquema || '.' ||
                   i_tabla || ' drop column ' || g_nombre_campo_created || ';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'alter table ' || i_esquema || '.' ||
                   i_tabla || ' drop column ' || g_nombre_campo_updated_by || ';' ||
                   utl_tcp.crlf;
    l_sentencia := l_sentencia || 'alter table ' || i_esquema || '.' ||
                   i_tabla || ' drop column ' || g_nombre_campo_updated || ';' ||
                   utl_tcp.crlf;
  
    o_sentencia := l_sentencia;
  
    if i_ejecutar then
      lp_ejecutar_sentencias_ddl(o_sentencia);
    end if;
  end;

  procedure p_eliminar_trigger_auditoria(o_sentencia out clob,
                                         i_esquema   in varchar2,
                                         i_tabla     in varchar2,
                                         i_trigger   in varchar2 default null,
                                         i_ejecutar  in boolean default true) is
    l_sentencia clob;
    l_trigger   varchar2(300);
  begin
    l_trigger := lower(nvl(g_esquema_auditoria, i_esquema) || '.' ||
                       nvl(i_trigger,
                           g_prefijo_trigger_auditoria ||
                           substr(i_tabla, length(g_prefijo_tabla) + 1)));
  
    -- Elimina trigger
    l_sentencia := l_sentencia || 'drop trigger ' || l_trigger || ';' ||
                   utl_tcp.crlf;
  
    o_sentencia := l_sentencia;
  
    if i_ejecutar then
      lp_ejecutar_sentencias_ddl(o_sentencia);
    end if;
  end;

end;
/

