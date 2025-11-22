create or replace package k_flujo as
  /**
  Agrupa procesos relacionados con el motor de flujos del sistema
  
  %author dmezac 04/05/2025
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
  --Constantes
  --Estados de instancias y pasos de los flujos
  c_estado_finalizado  constant varchar2(30) := 'FINALIZADO';
  c_estado_en_progreso constant varchar2(30) := 'EN_PROGRESO';
  c_estado_cancelado   constant varchar2(30) := 'CANCELADO';

  --Tipos de pasos de los flujos
  c_tipo_paso_inicio     constant varchar2(30) := 'INICIO';
  c_tipo_paso_manual     constant varchar2(30) := 'MANUAL';
  c_tipo_paso_automatico constant varchar2(30) := 'AUTOMATICO';
  c_tipo_paso_aprobacion constant varchar2(30) := 'APROBACION';

  --Acción por defecto
  c_accion_aprobar constant varchar2(30) := 'APROBAR';

  procedure iniciar_flujo(i_id_flujo     in number,
                          i_usuario      in varchar2,
                          i_variables    in clob,
                          o_id_instancia out number);

  function obtener_estado_flujo(i_id_instancia in number) return clob;

  procedure avanzar_flujo(i_id_instancia in number,
                          i_accion       in varchar2,
                          i_usuario      in varchar2,
                          i_comentario   in varchar2);

  procedure aprobar_paso(i_id_instancia in number,
                         i_accion       in varchar2, --APROBAR / RECHAZAR / CONDICIONAR, ETC
                         i_usuario      in varchar2,
                         i_comentario   in varchar2);

end k_flujo;
/
