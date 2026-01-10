create or replace trigger gb_archivos
  before insert or update or delete on t_archivos
  for each row
declare
  l_existe_registro        varchar2(1);
  l_nombre_referencia      t_archivo_definiciones.nombre_referencia%type;
  l_tamano_maximo          t_archivo_definiciones.tamano_maximo%type;
  l_extensiones_permitidas t_archivo_definiciones.extensiones_permitidas%type;
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

  if inserting or updating then
  
    -- Valida definición
    begin
      select d.nombre_referencia, d.tamano_maximo, d.extensiones_permitidas
        into l_nombre_referencia, l_tamano_maximo, l_extensiones_permitidas
        from t_archivo_definiciones d
       where upper(d.tabla) = upper(:new.tabla)
         and upper(d.campo) = upper(:new.campo);
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Definición de archivo inexistente');
    end;
  
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
  
    if :new.contenido is not null or :new.url is not null then
      -- Valida nombre del archivo
      if :new.nombre is null then
        raise_application_error(-20000, 'Nombre del archivo obligatorio');
      end if;
    
      -- Valida extensión del archivo
      if :new.extension is null then
        raise_application_error(-20000,
                                'Extensión del archivo obligatorio');
      end if;
    
      if l_extensiones_permitidas is not null then
        if k_archivo.f_tipo_mime(l_extensiones_permitidas, :new.extension) is null then
          raise_application_error(-20000,
                                  'Extensión de archivo no permitida');
        end if;
      end if;
    end if;
  
    if :new.contenido is null or dbms_lob.getlength(:new.contenido) = 0 then
      :new.checksum := null;
      :new.tamano   := null;
    else
      -- Calcula propiedades del archivo
      if :old.contenido is null or
         dbms_lob.compare(:old.contenido, :new.contenido) <> 0 then
        k_archivo.p_calcular_propiedades(:new.contenido,
                                         :new.checksum,
                                         :new.tamano);
      end if;
    
      -- Valida tamaño del archivo
      if nvl(:new.tamano, 0) > nvl(l_tamano_maximo, 0) then
        raise_application_error(-20000,
                                'Archivo supera el tamaño máximo (' ||
                                trim(to_char(l_tamano_maximo / 1000000,
                                             '999G999G999D99')) || ' MB)');
      end if;
    end if;
  
  end if;

end;
/
