CREATE OR REPLACE PACKAGE k_flujo AS
  /**
  Agrupa procesos relacionados con el motor de flujos del sistema
  
  %author dmezac 04/05/2025
  */

  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 jtsoya539
  
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
  c_estado_finalizado  CONSTANT VARCHAR2(30) := 'FINALIZADO';
  c_estado_en_progreso CONSTANT VARCHAR2(30) := 'EN_PROGRESO';
  c_estado_cancelado   CONSTANT VARCHAR2(30) := 'CANCELADO';

  --Tipos de pasos de los flujos
  c_tipo_paso_inicio     CONSTANT VARCHAR2(30) := 'INICIO';
  c_tipo_paso_manual     CONSTANT VARCHAR2(30) := 'MANUAL';
  c_tipo_paso_automatico CONSTANT VARCHAR2(30) := 'AUTOMATICO';
  c_tipo_paso_aprobacion CONSTANT VARCHAR2(30) := 'APROBACION';

  --Acción por defecto
  c_accion_aprobar CONSTANT VARCHAR2(30) := 'APROBAR';

  PROCEDURE iniciar_flujo(i_id_flujo     IN NUMBER,
                          i_usuario      IN VARCHAR2,
                          i_variables    IN CLOB,
                          o_id_instancia OUT NUMBER);

  FUNCTION obtener_estado_flujo(i_id_instancia IN NUMBER) RETURN CLOB;

  PROCEDURE avanzar_flujo(i_id_instancia IN NUMBER,
                          i_accion       IN VARCHAR2,
                          i_usuario      IN VARCHAR2,
                          i_comentario   IN VARCHAR2);

  PROCEDURE aprobar_paso(i_id_instancia IN NUMBER,
                         i_accion       IN VARCHAR2, --APROBAR / RECHAZAR / CONDICIONAR, ETC
                         i_usuario      IN VARCHAR2,
                         i_comentario   IN VARCHAR2);

END k_flujo;
/
