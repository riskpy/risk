create or replace package k_modulo is

  /**
  Agrupa operaciones relacionadas con los módulos
  
  %author jtsoya539 27/3/2020 16:58:36
  */

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

  -- Constantes

  -- Indicadores de instalación
  $if $$mi_risk $then
  c_instalado_risk constant boolean := true;
  $else
  c_instalado_risk constant boolean := false;
  $end
  $if $$mi_msj $then
  c_instalado_msj constant boolean := true;
  $else
  c_instalado_msj constant boolean := false;
  $end
  $if $$mi_flj $then
  c_instalado_flj constant boolean := true;
  $else
  c_instalado_flj constant boolean := false;
  $end

  -- Identificadores de módulos
  c_id_risk constant varchar2(30) := 'RISK';
  c_id_msj  constant varchar2(30) := 'MSJ';
  c_id_flj  constant varchar2(30) := 'FLJ';

end;
/
