create or replace trigger gf_archivos
  after insert or update or delete on t_archivos
  for each row
declare
  l_historico_activo t_archivo_definiciones.historico_activo%type;
begin
  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
  
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

  if (updating and
     nvl(:new.version_actual, 0) <> nvl(:old.version_actual, 0)) or
     deleting then
  
    -- Verifica si el histórico de versiones está activo
    begin
      select d.historico_activo
        into l_historico_activo
        from t_archivo_definiciones d
       where upper(d.tabla) = upper(:old.tabla)
         and upper(d.campo) = upper(:old.campo);
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Definición de archivo inexistente');
    end;
  
    if l_historico_activo = 'S' then
      -- Guarda versión anterior en tabla histórica
      insert into t_archivos_hist
        (tabla,
         campo,
         referencia,
         version,
         contenido,
         url,
         checksum,
         tamano,
         nombre,
         extension)
      values
        (:old.tabla,
         :old.campo,
         :old.referencia,
         nvl(:old.version_actual, 0),
         :old.contenido,
         :old.url,
         :old.checksum,
         :old.tamano,
         :old.nombre,
         :old.extension);
    end if;
  
  end if;
end;
/
