create or replace trigger gb_reportes
  before insert or update or delete on t_reportes
  for each row
declare
  l_tipo_operacion t_operaciones.tipo%type;
  l_cursor         pls_integer;
begin
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

  if inserting or updating then
  
    -- Valida operación
    begin
      select o.tipo
        into l_tipo_operacion
        from t_operaciones o
       where o.id_operacion = :new.id_reporte;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Operación inexistente');
    end;
  
    -- Valida tipo de operación
    if l_tipo_operacion <> 'R' then
      raise_application_error(-20000, 'Operación no es de tipo Reporte');
    end if;
  
    -- Valida consulta SQL
    if :new.consulta_sql is not null then
      begin
        l_cursor := dbms_sql.open_cursor;
        dbms_sql.parse(l_cursor, :new.consulta_sql, dbms_sql.native);
        dbms_sql.close_cursor(l_cursor);
      exception
        when others then
          raise_application_error(-20000,
                                  'Consulta SQL no válida: ' || sqlerrm);
      end;
    end if;
  
  end if;

end;
/
