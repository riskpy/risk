CREATE OR REPLACE PACKAGE BODY k_sistema IS

  TYPE ly_parametros IS TABLE OF anydata INDEX BY VARCHAR2(50);
  TYPE ly_cola IS TABLE OF VARCHAR2(32767);

  g_indice     VARCHAR2(50);
  g_parametros ly_parametros;
  g_cola       ly_cola;

  FUNCTION f_es_produccion RETURN BOOLEAN IS
  BEGIN
    RETURN upper(k_util.f_valor_parametro('BASE_DATOS_PRODUCCION')) = upper(k_util.f_base_datos);
  END;

  FUNCTION f_fecha RETURN DATE IS
  BEGIN
    RETURN f_valor_parametro_date(c_fecha);
  END;

  FUNCTION f_id_usuario RETURN NUMBER IS
  BEGIN
    RETURN f_valor_parametro_number(c_id_usuario);
  END;

  FUNCTION f_usuario RETURN VARCHAR2 IS
  BEGIN
    RETURN f_valor_parametro_string(c_usuario);
  END;

  FUNCTION f_pais RETURN NUMBER IS
  BEGIN
    RETURN f_valor_parametro_number(c_id_pais);
  END;

  FUNCTION f_zona_horaria RETURN VARCHAR2 IS
  BEGIN
    RETURN f_valor_parametro_string(c_zona_horaria);
  END;

  FUNCTION f_idioma RETURN NUMBER IS
  BEGIN
    RETURN f_valor_parametro_number(c_id_idioma);
  END;

  FUNCTION f_valor_parametro(i_parametro IN VARCHAR2) RETURN anydata IS
    l_valor anydata;
  BEGIN
    IF g_parametros.exists(i_parametro) THEN
      l_valor := g_parametros(i_parametro);
    END IF;
  
    -- Si el parámetro no se encuentra en la lista carga un valor nulo de tipo
    -- VARCHAR2 para evitar el error ORA-30625 al acceder al valor a través de
    -- AnyData.Access*
    IF l_valor IS NULL THEN
      l_valor := anydata.convertvarchar2(NULL);
    END IF;
  
    RETURN l_valor;
  END;

  FUNCTION f_valor_parametro_string(i_parametro IN VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN anydata.accessvarchar2(f_valor_parametro(i_parametro));
  END;

  FUNCTION f_valor_parametro_number(i_parametro IN VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN anydata.accessnumber(f_valor_parametro(i_parametro));
  END;

  FUNCTION f_valor_parametro_boolean(i_parametro IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN sys.diutil.int_to_bool(anydata.accessnumber(f_valor_parametro(i_parametro)));
  END;

  FUNCTION f_valor_parametro_date(i_parametro IN VARCHAR2) RETURN DATE IS
  BEGIN
    RETURN anydata.accessdate(f_valor_parametro(i_parametro));
  END;

  PROCEDURE p_definir_parametro(i_parametro IN VARCHAR2,
                                i_valor     IN anydata) IS
  BEGIN
    g_parametros(i_parametro) := i_valor;
  END;

  PROCEDURE p_definir_parametro_string(i_parametro IN VARCHAR2,
                                       i_valor     IN VARCHAR2) IS
  BEGIN
    p_definir_parametro(i_parametro, anydata.convertvarchar2(i_valor));
  END;

  PROCEDURE p_definir_parametro_number(i_parametro IN VARCHAR2,
                                       i_valor     IN NUMBER) IS
  BEGIN
    p_definir_parametro(i_parametro, anydata.convertnumber(i_valor));
  END;

  PROCEDURE p_definir_parametro_boolean(i_parametro IN VARCHAR2,
                                        i_valor     IN BOOLEAN) IS
  BEGIN
    p_definir_parametro(i_parametro,
                        anydata.convertnumber(sys.diutil.bool_to_int(i_valor)));
  END;

  PROCEDURE p_definir_parametro_date(i_parametro IN VARCHAR2,
                                     i_valor     IN DATE) IS
  BEGIN
    p_definir_parametro(i_parametro, anydata.convertdate(i_valor));
  END;

  PROCEDURE p_inicializar_parametros IS
  BEGIN
    -- Elimina parámetros
    p_eliminar_parametros;
  
    -- Define parámetros por defecto
    DECLARE
      l_nombre         t_modulos.nombre%TYPE;
      l_version_actual t_modulos.version_actual%TYPE;
      l_fecha_actual   t_modulos.fecha_actual%TYPE;
    BEGIN
      SELECT nombre, version_actual, fecha_actual
        INTO l_nombre, l_version_actual, l_fecha_actual
        FROM t_modulos
       WHERE id_modulo = 'RISK';
      p_definir_parametro_string(c_sistema, l_nombre);
      p_definir_parametro_string(c_version, l_version_actual);
      p_definir_parametro_date(c_fecha, l_fecha_actual);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
    p_definir_parametro_string(c_usuario, USER);
  
    DECLARE
      l_id_pais t_paises.id_pais%TYPE;
    BEGIN
      SELECT p.id_pais
        INTO l_id_pais
        FROM t_paises p
       WHERE p.iso_alpha_2 = k_util.f_valor_parametro('ID_PAIS_ISO');
      p_definir_parametro_number(c_id_pais, l_id_pais);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  
    p_definir_parametro_string(c_zona_horaria,
                               k_util.f_valor_parametro('ZONA_HORARIA'));
  
    DECLARE
      l_id_idioma t_idiomas.id_idioma%TYPE;
    BEGIN
      SELECT i.id_idioma
        INTO l_id_idioma
        FROM t_idiomas i
       WHERE i.iso_639_1 = k_util.f_valor_parametro('ID_IDIOMA_ISO');
      p_definir_parametro_number(c_id_idioma, l_id_idioma);
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  
  END;

  PROCEDURE p_limpiar_parametros IS
  BEGIN
    g_indice := g_parametros.first;
    WHILE g_indice IS NOT NULL LOOP
      g_parametros(g_indice) := NULL;
      g_indice := g_parametros.next(g_indice);
    END LOOP;
  END;

  PROCEDURE p_eliminar_parametros IS
  BEGIN
    g_parametros.delete;
  END;

  PROCEDURE p_imprimir_parametros IS
    l_typeinfo anytype;
    l_typecode PLS_INTEGER;
  BEGIN
    g_indice := g_parametros.first;
    WHILE g_indice IS NOT NULL LOOP
      dbms_output.put(g_indice || ': ');
      IF g_parametros(g_indice) IS NOT NULL THEN
        l_typecode := g_parametros(g_indice).gettype(l_typeinfo);
        IF l_typecode = dbms_types.typecode_varchar2 THEN
          dbms_output.put(anydata.accessvarchar2(g_parametros(g_indice)));
        ELSIF l_typecode = dbms_types.typecode_number THEN
          dbms_output.put(to_char(anydata.accessnumber(g_parametros(g_indice))));
        ELSIF l_typecode = dbms_types.typecode_date THEN
          dbms_output.put(to_char(anydata.accessdate(g_parametros(g_indice)),
                                  'YYYY-MM-DD'));
        ELSE
          dbms_output.put('Tipo de dato no soportado');
        END IF;
      END IF;
      dbms_output.new_line;
      g_indice := g_parametros.next(g_indice);
    END LOOP;
  END;

  --
  PROCEDURE p_inicializar_cola IS
  BEGIN
    g_cola := NEW ly_cola();
  END;

  PROCEDURE p_encolar(i_valor IN VARCHAR2) IS
  BEGIN
    IF g_cola IS NULL THEN
      p_inicializar_cola;
    END IF;
    g_cola.extend;
    g_cola(g_cola.count) := i_valor;
  END;

  FUNCTION f_desencolar RETURN VARCHAR2 IS
    l_valor VARCHAR2(32767);
  BEGIN
    IF g_cola IS NULL THEN
      p_inicializar_cola;
    END IF;
    IF g_cola.exists(g_cola.first) THEN
      l_valor := g_cola(g_cola.first);
      g_cola.delete(g_cola.first);
    END IF;
    RETURN l_valor;
  END;

  PROCEDURE p_imprimir_cola IS
    i INTEGER;
  BEGIN
    IF g_cola IS NOT NULL THEN
      i := g_cola.first;
      WHILE i IS NOT NULL LOOP
        dbms_output.put_line(to_char(i) || ': ' || g_cola(i));
        i := g_cola.next(i);
      END LOOP;
    END IF;
  END;
  --

BEGIN
  -- Define parámetros por defecto
  p_inicializar_parametros;
END;
/
