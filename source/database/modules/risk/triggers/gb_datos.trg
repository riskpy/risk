create or replace trigger gb_datos
  before insert or update or delete on t_datos
  for each row
declare
  l_existe_registro   varchar2(1);
  l_nombre_referencia t_dato_definiciones.nombre_referencia%type;
begin
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

  :new.tabla := upper(:new.tabla);
  :new.campo := upper(:new.campo);

  if inserting or updating then
  
    -- Valida definición
    if not t_dato_definiciones_api.row_exists(:new.tabla, :new.campo) then
      raise_application_error(-20000,
                              'Definición de dato adicional inexistente');
    end if;
  
    l_nombre_referencia := t_dato_definiciones_api.get_nombre_referencia(:new.tabla,
                                                                         :new.campo);
  
    -- Valida registro relacionado
    if l_nombre_referencia is not null then
      execute immediate 'DECLARE
  l_existe VARCHAR2(1) := ''N'';
BEGIN
  BEGIN
    SELECT ''S''
      INTO l_existe
      FROM ' || :new.tabla || '
     WHERE to_char(' || l_nombre_referencia || ') = :1;
  EXCEPTION
    WHEN no_data_found THEN
      l_existe := ''N'';
    WHEN too_many_rows THEN
      l_existe := ''S'';
    WHEN OTHERS THEN
      l_existe := ''N'';
  END;
  :2 := l_existe;
END;'
        using in :new.referencia, out l_existe_registro;
    
      if l_existe_registro = 'N' then
        raise_application_error(-20000, 'Registro relacionado inexistente');
      end if;
    end if;
  
  end if;

end;
/

