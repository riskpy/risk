create or replace trigger gf_operaciones
  after insert or update or delete on t_operaciones
  for each row
declare
  l_id_permiso_old t_permisos.id_permiso%type;
  l_id_permiso_new t_permisos.id_permiso%type;
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

  l_id_permiso_old := upper(k_significado.f_significado_codigo('TIPO_OPERACION',
                                                               :old.tipo) || ':' ||
                            :old.dominio || ':' || :old.nombre);
  l_id_permiso_new := upper(k_significado.f_significado_codigo('TIPO_OPERACION',
                                                               :new.tipo) || ':' ||
                            :new.dominio || ':' || :new.nombre);

  if inserting then
  
    if :new.tipo in ('S', 'R') then
      -- SERVICIO, REPORTE
      insert into t_permisos
        (id_permiso, descripcion, detalle)
      values
        (l_id_permiso_new, null, null);
    end if;
  
  elsif updating and (nvl(:new.tipo, 'X') <> nvl(:old.tipo, 'X') or
        nvl(:new.nombre, 'X') <> nvl(:old.nombre, 'X') or
        nvl(:new.dominio, 'X') <> nvl(:old.dominio, 'X')) then
  
    if :old.tipo in ('S', 'R') then
      -- SERVICIO, REPORTE
      delete t_rol_permisos where id_permiso = l_id_permiso_old;
      delete t_permisos where id_permiso = l_id_permiso_old;
    end if;
  
    if :new.tipo in ('S', 'R') then
      -- SERVICIO, REPORTE
      insert into t_permisos
        (id_permiso, descripcion, detalle)
      values
        (l_id_permiso_new, null, null);
    end if;
  
  elsif deleting then
  
    if :old.tipo in ('S', 'R') then
      -- SERVICIO, REPORTE
      delete t_rol_permisos where id_permiso = l_id_permiso_old;
      delete t_permisos where id_permiso = l_id_permiso_old;
    end if;
  
  end if;
end;
/
