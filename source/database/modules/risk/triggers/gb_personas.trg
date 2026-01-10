create or replace trigger gb_personas
  before insert or update or delete on t_personas
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

  if inserting or
     (updating and nvl(:new.nombre, 'X') <> nvl(:old.nombre, 'X')) then
    :new.nombre := upper(:new.nombre);
  end if;

  if inserting or
     (updating and nvl(:new.apellido, 'X') <> nvl(:old.apellido, 'X')) then
    :new.apellido := upper(:new.apellido);
  end if;

  if inserting or (updating and nvl(:new.nombre_completo, 'X') <>
     nvl(:old.nombre_completo, 'X')) then
    :new.nombre_completo := upper(:new.nombre_completo);
  end if;
end;
/
