CREATE OR REPLACE PACKAGE k_importacion IS

  /**
  Agrupa operaciones relacionadas con la Importación de Archivos del sistema
  
  %author dmezac 09/11/2025 11:32:15
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

  -- Códigos de respuesta
  c_error_general_importacion CONSTANT VARCHAR2(10) := 'import0001';

  FUNCTION f_procesar_importacion_local(i_id_importacion         IN NUMBER,
                                        i_archivo                IN BLOB,
                                        i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                        i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta;

  FUNCTION f_procesar_importacion_autonoma(i_id_importacion         IN NUMBER,
                                           i_archivo                IN BLOB,
                                           i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                           i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta;

  FUNCTION f_procesar_importacion(i_id_importacion         IN NUMBER,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN DEFAULT FALSE,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

  FUNCTION f_procesar_importacion(i_nombre                 IN VARCHAR2,
                                  i_dominio                IN VARCHAR2,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN DEFAULT FALSE,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB;

END;
/
CREATE OR REPLACE PACKAGE BODY k_importacion IS

  FUNCTION f_procesar_importacion_local(i_id_importacion         IN NUMBER,
                                        i_archivo                IN BLOB,
                                        i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                        i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta IS
    l_rsp y_respuesta;
    --
    l_nombre_importacion     t_operaciones.nombre%TYPE;
    l_version_importacion    t_operaciones.version_actual%TYPE;
    l_parametros_automaticos t_operaciones.parametros_automaticos%TYPE;
    l_separador_campos       t_importaciones.separador_campos%TYPE;
    l_linea_inicial          t_importaciones.linea_inicial%TYPE;
    l_nombre_tabla           t_importaciones.nombre_tabla%TYPE;
    l_truncar_tabla          t_importaciones.truncar_tabla%TYPE;
    --
    l_registros_ok    NUMBER;
    l_registros_error NUMBER;
    l_detalle_errores json_array_t := json_array_t();
    --
    l_contador PLS_INTEGER := 0;
    --
    l_funcion               VARCHAR2(30);
    l_parametros_funcion    VARCHAR2(4000);
    l_variables             VARCHAR2(4000);
    l_variable1             VARCHAR2(100);
    l_columnas              CLOB;
    l_columnas_lobs         CLOB;
    l_sentencia             CLOB;
    l_declaracion_tipos     CLOB;
    l_declaracion_variables CLOB;
    l_campos_simples        CLOB;
    l_variables_simples     CLOB;
    l_variables_indexadas   CLOB;
    l_campos_extras         VARCHAR2(4000);
    l_variables_extras      VARCHAR2(4000);
    --
    CURSOR c_parametros(i_id_importacion IN NUMBER,
                        i_version        IN VARCHAR2) IS
      SELECT a.id_operacion,
             a.nombre,
             a.version,
             a.orden,
             a.activo,
             a.tipo_dato,
             a.formato,
             a.obligatorio,
             a.valor_defecto,
             a.detalle,
             a.valores_posibles,
             a.encriptado,
             b.posicion_inicial,
             b.longitud,
             b.posicion_decimal,
             b.mapeador
        FROM t_operacion_parametros a, t_importacion_parametros b
       WHERE a.id_operacion = b.id_importacion(+)
         AND a.nombre = b.nombre(+)
         AND a.version = b.version(+)
         AND a.id_operacion = i_id_importacion
         AND a.version = i_version
       ORDER BY a.orden;
  BEGIN
    SAVEPOINT inicio_importacion_sin_commit;
    -- Inicializa respuesta
    l_rsp := NEW y_respuesta();
  
    l_rsp.lugar := 'Buscando datos de la importación';
    BEGIN
      SELECT o.nombre,
             o.version_actual,
             lower(o.parametros_automaticos),
             i.separador_campos,
             nvl(i.linea_inicial, 1),
             i.nombre_tabla,
             i.truncar_tabla
        INTO l_nombre_importacion,
             l_version_importacion,
             l_parametros_automaticos,
             l_separador_campos,
             l_linea_inicial,
             l_nombre_tabla,
             l_truncar_tabla
        FROM t_importaciones i, t_operaciones o
       WHERE o.id_operacion = i.id_importacion
         AND o.activo = 'S'
         AND o.id_operacion = i_id_importacion
         AND o.version_actual = nvl(i_version, o.version_actual);
    EXCEPTION
      WHEN no_data_found THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      'Importación inexistente o inactiva',
                                      'i_id_importacion=[' ||
                                      i_id_importacion || '], i_version=[' ||
                                      i_version || ']');
        RAISE k_operacion.ex_error_parametro;
    END;
  
    l_rsp.lugar := 'Validando parámetros adicionales de la importación de archivo';
    DECLARE
      l_valores_faltantes VARCHAR2(1000);
    BEGIN
      l_valores_faltantes := substr(k_json_util.f_contiene_valores(l_parametros_automaticos,
                                                                   i_parametros_adicionales),
                                    1,
                                    1000);
      IF nvl(l_valores_faltantes, 'OK') <> 'OK' THEN
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      'Faltan parámetros adicionales: ' ||
                                      l_valores_faltantes);
        RAISE k_operacion.ex_error_parametro;
      END IF;
    END;
  
    l_rsp.lugar := 'Armando parámetros adicionales de la importación de archivo';
    DECLARE
      -- tu JSON adicional
      l_json_obj json_object_t := json_object_t.parse(nvl(i_parametros_adicionales,
                                                          '{}'));
      l_claves   json_key_list := l_json_obj.get_keys;
      l_valor    VARCHAR2(4000);
    BEGIN
      FOR i IN 1 .. l_claves.count LOOP
        l_campos_extras    := l_campos_extras || ', ';
        l_variables_extras := l_variables_extras || ', ';
      
        l_campos_extras := l_campos_extras || l_claves(i);
        l_valor         := l_json_obj.get_string(l_claves(i));
      
        IF l_json_obj.has(l_claves(i)) THEN
          l_valor := l_json_obj.get_string(l_claves(i));
        ELSE
          l_valor := NULL;
        END IF;
      
        IF l_valor IS NULL THEN
          -- Valor NULL
          l_variables_extras := l_variables_extras || 'null';
        ELSIF k_util.f_es_valor_numerico(l_valor) THEN
          -- Valor numérico
          l_variables_extras := l_variables_extras || l_valor;
        ELSIF regexp_like(l_valor, '^\d{4}-\d{2}-\d{2}$') THEN
          -- Formato ISO (YYYY-MM-DD)
          l_variables_extras := l_variables_extras || 'to_date(''' ||
                                l_valor || ''',''YYYY-MM-DD'')';
        
        ELSIF regexp_like(l_valor, '^\d{2}/\d{2}/\d{4}$') THEN
          -- Formato latino (DD/MM/YYYY)
          l_variables_extras := l_variables_extras || 'to_date(''' ||
                                l_valor || ''',''DD/MM/YYYY'')';
        ELSE
          -- Texto genérico
          l_variables_extras := l_variables_extras || '''' ||
                                REPLACE(l_valor, '''', '''''') || '''';
        END IF;
      END LOOP;
    END;
  
    l_rsp.lugar := 'Preparando variables de importación de archivo';
    FOR c IN c_parametros(i_id_importacion, l_version_importacion) LOOP
      l_contador := l_contador + 1;
    
      IF c.activo = 'S' THEN
      
        IF l_variable1 IS NULL THEN
          l_variable1 := lower(c.nombre);
        END IF;
      
        l_variables := l_variables || CASE
                         WHEN l_variables IS NOT NULL THEN
                          ','
                       END || lower(c.nombre);
      
        l_columnas := l_columnas || CASE
                        WHEN l_columnas IS NOT NULL THEN
                         ',' || chr(10)
                      END || '             ' ||
                      REPLACE(nvl(lower(c.mapeador), ':variable'),
                              ':variable',
                              't.column' || l_contador) || ' ' || lower(c.nombre);
      END IF;
    
      l_columnas_lobs := l_columnas_lobs || CASE
                           WHEN l_columnas_lobs IS NOT NULL THEN
                            ',' || chr(10) ||
                            '                                                     '
                         END || 'lob_column(' || c.posicion_inicial || ', ' ||
                         c.longitud || ')';
    END LOOP;
  
    l_rsp.lugar := 'Preparando bloques de sentencia de importación de archivo';
    BEGIN
      l_declaracion_tipos := k_cadena.f_formatear_cadena(l_variables,
                                                         '      TYPE t_#_tab IS TABLE OF ' ||
                                                         lower(l_nombre_tabla) ||
                                                         '.#%TYPE;',
                                                         chr(10));
    
      l_declaracion_variables := k_cadena.f_formatear_cadena(l_variables,
                                                             '      l_# t_#_tab;',
                                                             chr(10));
    
      l_campos_simples := k_cadena.f_formatear_cadena(l_variables,
                                                      '#',
                                                      ', ');
    
      l_variables_indexadas := k_cadena.f_formatear_cadena(l_variables,
                                                           'l_#(i)',
                                                           ', ');
    
      l_variables_simples := k_cadena.f_formatear_cadena(l_variables,
                                                         'l_#',
                                                         ', ');
    END;
  
    IF l_separador_campos IS NULL THEN
      l_rsp.lugar          := 'Definiendo función de importación de archivo con campos fijos';
      l_funcion            := 'fixedcolumns';
      l_parametros_funcion := q'[                          lob_columns( :columnas_lobs: )]';
    ELSE
      l_rsp.lugar          := 'Definiendo función de importación de archivo con campos separados por caracter';
      l_funcion            := 'separatedcolumns';
      l_parametros_funcion := q'[                          ',',     /* separador de campos */
                          null,    /* juego de caracteres (optional) */
                          '"'      /* delimitador (optional) */]';
    END IF;
  
    l_rsp.lugar := 'Inicializando sentencia de importación de archivo (etiquetada)';
    l_sentencia := q'[
    DECLARE
:declaracion_tipos:

:declaracion_variables:

      v_ok     NUMBER := 0;
      v_err    NUMBER := 0;
      v_errmsg JSON_ARRAY_T := JSON_ARRAY_T();

    BEGIN
      -- Cargar datos del origen
      SELECT --t.row_no,
             -- Campos del archivo
:columnas:
             --
      BULK COLLECT INTO :variables_simples:
      FROM TABLE(lob2table.:funcion:(:in_archivo,
                          chr(10), /* separador de registros */
:parametros_funcion: )) t;

      BEGIN
          FORALL i IN :linea_inicial: .. l_:variable1:.LAST SAVE EXCEPTIONS
            INSERT INTO :nombre_tabla: (:campos_simples::campos_extras:)
            VALUES (:variables_indexadas::variables_extras:);

          v_ok := SQL%ROWCOUNT;

      EXCEPTION
        WHEN OTHERS THEN
          v_err := SQL%BULK_EXCEPTIONS.COUNT;
          v_ok  := l_:variable1:.COUNT - v_err - (:linea_inicial: - 1);

          DECLARE
            v_json_array JSON_ARRAY_T := JSON_ARRAY_T();
            v_json_obj   JSON_OBJECT_T;
          BEGIN
            FOR j IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
              v_json_obj := JSON_OBJECT_T();
              v_json_obj.put('id', SQL%BULK_EXCEPTIONS(j).ERROR_INDEX + (:linea_inicial: - 1));
              v_json_obj.put('codigo', SQL%BULK_EXCEPTIONS(j).ERROR_CODE);
              v_json_obj.put('mensaje', SQLERRM(-SQL%BULK_EXCEPTIONS(j).ERROR_CODE));
              v_json_array.append(v_json_obj);
            END LOOP;
            v_errmsg := v_json_array;
          END;
      END;

      -- Pasar resultados al exterior
      :out_rows_ok     := v_ok;
      :out_rows_err    := v_err;
      :out_detail_errs := v_errmsg;
    END;
  ]';
  
    l_rsp.lugar := 'Reemplazando etiquetas de sentencia de importación de archivo';
    BEGIN
      l_sentencia := k_cadena.f_reemplazar_etiquetas(i_cadena       => l_sentencia,
                                                     i_etiquetas    => y_cadenas('funcion',
                                                                                 'parametros_funcion',
                                                                                 'declaracion_tipos',
                                                                                 'declaracion_variables',
                                                                                 'campos_simples',
                                                                                 'variables_simples',
                                                                                 'variables_indexadas',
                                                                                 'campos_extras',
                                                                                 'variables_extras',
                                                                                 'variable1',
                                                                                 'linea_inicial',
                                                                                 'nombre_tabla',
                                                                                 'columnas',
                                                                                 'columnas_lobs'),
                                                     i_valores      => y_cadenas(l_funcion,
                                                                                 l_parametros_funcion,
                                                                                 l_declaracion_tipos,
                                                                                 l_declaracion_variables,
                                                                                 l_campos_simples,
                                                                                 l_variables_simples,
                                                                                 l_variables_indexadas,
                                                                                 l_campos_extras,
                                                                                 l_variables_extras,
                                                                                 l_variable1,
                                                                                 l_linea_inicial,
                                                                                 l_nombre_tabla,
                                                                                 l_columnas,
                                                                                 l_columnas_lobs),
                                                     i_encapsulador => ':');
    END;
  
    l_rsp.lugar := 'Ejecutando sentencia de importación de archivo';
    dbms_output.put_line(l_sentencia);
    EXECUTE IMMEDIATE l_sentencia
      USING IN i_archivo, OUT l_registros_ok, OUT l_registros_error, OUT l_detalle_errores;
  
    l_rsp.lugar := 'Imprimiendo resultados de importación de archivo';
    dbms_output.put_line('Filas insertadas   : ' || l_registros_ok);
    dbms_output.put_line('Filas con error    : ' || l_registros_error);
    dbms_output.put_line('Detalle de errores :' || chr(10) ||
                         l_detalle_errores.to_clob);
  
    IF l_registros_error > 0 THEN
      ROLLBACK TO SAVEPOINT inicio_importacion_sin_commit;
      l_rsp.lugar := NULL;
    
      DECLARE
        l_errores_clob    CLOB := l_detalle_errores.to_clob;
        l_resumen_errores VARCHAR2(4000);
        --
        l_elementos y_datos := NEW y_datos();
        l_elemento  y_dato := NEW y_dato();
      BEGIN
        SELECT listagg(id, ', ') within GROUP(ORDER BY id)
          INTO l_resumen_errores
          FROM json_table(l_errores_clob,
                          '$[*]' columns(id NUMBER path '$.id'));
      
        l_elemento      := NEW y_dato();
        l_elemento.json := l_errores_clob;
      
        l_elementos.extend;
        l_elementos(l_elementos.count) := l_elemento;
      
        k_operacion.p_respuesta_error(l_rsp,
                                      k_importacion.c_error_general_importacion,
                                      k_error.f_mensaje_error(k_importacion.c_error_general_importacion,
                                                              l_resumen_errores),
                                      dbms_utility.format_error_stack,
                                      l_elemento);
        RAISE k_operacion.ex_error_general;
      END;
    
    END IF;
  
    l_rsp.lugar      := NULL;
    l_rsp.mensaje_bd := 'Filas insertadas : ' || l_registros_ok;
    RETURN l_rsp;
  EXCEPTION
    WHEN k_operacion.ex_error_parametro THEN
      RETURN l_rsp;
    WHEN k_operacion.ex_error_general THEN
      RETURN l_rsp;
    WHEN OTHERS THEN
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      RETURN l_rsp;
  END;

  FUNCTION f_procesar_importacion_autonoma(i_id_importacion         IN NUMBER,
                                           i_archivo                IN BLOB,
                                           i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                           i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN y_respuesta IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    l_rsp y_respuesta;
  BEGIN
    -- Procesa importación
    l_rsp := f_procesar_importacion_local(i_id_importacion,
                                          i_archivo,
                                          i_parametros_adicionales,
                                          i_version);
    --
    IF l_rsp.codigo = k_operacion.c_ok THEN
      COMMIT;
    ELSE
      ROLLBACK;
    END IF;
    --
    RETURN l_rsp;
  END;

  FUNCTION f_procesar_importacion(i_id_importacion         IN NUMBER,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    l_rsp y_respuesta;
  BEGIN
    -- Procesa importación
    IF nvl(i_transaccion_autonoma, FALSE) THEN
      l_rsp := f_procesar_importacion_autonoma(i_id_importacion,
                                               i_archivo,
                                               i_parametros_adicionales,
                                               i_version);
    ELSE
      l_rsp := f_procesar_importacion_local(i_id_importacion,
                                            i_archivo,
                                            i_parametros_adicionales,
                                            i_version);
    END IF;
    --
    RETURN l_rsp.to_json;
  END;

  FUNCTION f_procesar_importacion(i_nombre                 IN VARCHAR2,
                                  i_dominio                IN VARCHAR2,
                                  i_archivo                IN BLOB,
                                  i_parametros_adicionales IN VARCHAR2 DEFAULT NULL,
                                  i_transaccion_autonoma   IN BOOLEAN DEFAULT FALSE,
                                  i_version                IN VARCHAR2 DEFAULT NULL)
    RETURN CLOB IS
    l_rsp            y_respuesta;
    l_id_importacion t_importaciones.id_importacion%TYPE;
  BEGIN
    -- Busca importación
    l_id_importacion := k_operacion.f_id_operacion('I', i_nombre, i_dominio);
    -- Procesa importación
    IF nvl(i_transaccion_autonoma, FALSE) THEN
      l_rsp := f_procesar_importacion_autonoma(l_id_importacion,
                                               i_archivo,
                                               i_parametros_adicionales,
                                               i_version);
    ELSE
      l_rsp := f_procesar_importacion_local(l_id_importacion,
                                            i_archivo,
                                            i_parametros_adicionales,
                                            i_version);
    END IF;
    --
    RETURN l_rsp.to_json;
  END;

END;
/
