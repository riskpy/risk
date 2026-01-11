create or replace trigger gb_usuarios
  before insert or update or delete on t_usuarios
  for each row
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

  -- Valida alias de usuario
  if inserting or
     (updating and (nvl(:new.alias, 'X') <> nvl(:old.alias, 'X') or
     nvl(:new.origen, 'X') <> nvl(:old.origen, 'X'))) then
    k_usuario.p_validar_alias(:new.alias, :new.origen);
  end if;

  $if k_modulo.c_instalado_msj $then
  -- Valida dirección de correo
  if inserting or (updating and nvl(:new.direccion_correo, 'X') <>
     nvl(:old.direccion_correo, 'X')) then
    if not k_mensajeria.f_validar_direccion_correo(:new.direccion_correo) then
      raise_application_error(-20000,
                              'Dirección de correo electrónico inválida');
    end if;
  end if;
  $end

  $if k_modulo.c_instalado_msj $then
  -- Valida número de teléfono
  if inserting or (updating and nvl(:new.numero_telefono, 'X') <>
     nvl(:old.numero_telefono, 'X')) then
    if not k_mensajeria.f_validar_numero_telefono(:new.numero_telefono) then
      raise_application_error(-20000, 'Número de teléfono inválido');
    end if;
  end if;
  $end
end;
/
