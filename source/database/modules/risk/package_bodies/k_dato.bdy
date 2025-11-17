CREATE OR REPLACE PACKAGE BODY k_dato IS

  FUNCTION f_recuperar_dato(i_tabla      IN VARCHAR2,
                            i_campo      IN VARCHAR2,
                            i_referencia IN VARCHAR2) RETURN anydata IS
    l_dato t_datos.contenido%TYPE;
  BEGIN
    BEGIN
      SELECT a.contenido
        INTO l_dato
        FROM t_datos a
       WHERE upper(a.tabla) = upper(i_tabla)
         AND upper(a.campo) = upper(i_campo)
         AND a.referencia = i_referencia;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(-20000, 'Dato adicional inexistente');
      WHEN OTHERS THEN
        raise_application_error(-20000,
                                'Error al recuperar dato adicional');
    END;
  
    RETURN l_dato;
  END;

  FUNCTION f_recuperar_dato_string(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN VARCHAR2 IS
  BEGIN
    RETURN anydata.accessvarchar2(f_recuperar_dato(i_tabla,
                                                   i_campo,
                                                   i_referencia));
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION f_recuperar_dato_number(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN NUMBER IS
  BEGIN
    RETURN anydata.accessnumber(f_recuperar_dato(i_tabla,
                                                 i_campo,
                                                 i_referencia));
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION f_recuperar_dato_boolean(i_tabla      IN VARCHAR2,
                                    i_campo      IN VARCHAR2,
                                    i_referencia IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN sys.diutil.int_to_bool(anydata.accessnumber(f_recuperar_dato(i_tabla,
                                                                        i_campo,
                                                                        i_referencia)));
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION f_recuperar_dato_date(i_tabla      IN VARCHAR2,
                                 i_campo      IN VARCHAR2,
                                 i_referencia IN VARCHAR2) RETURN DATE IS
  BEGIN
    RETURN anydata.accessdate(f_recuperar_dato(i_tabla,
                                               i_campo,
                                               i_referencia));
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  FUNCTION f_recuperar_dato_object(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2) RETURN y_objeto IS
    l_objeto   y_objeto;
    l_anydata  anydata;
    l_result   PLS_INTEGER;
    l_typeinfo anytype;
    l_typecode PLS_INTEGER;
  BEGIN
    l_anydata := f_recuperar_dato(i_tabla, i_campo, i_referencia);
  
    l_typecode := l_anydata.gettype(l_typeinfo);
    IF l_typecode = dbms_types.typecode_object THEN
      l_result := l_anydata.getobject(l_objeto);
    END IF;
  
    RETURN l_objeto;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  PROCEDURE p_guardar_dato(i_tabla      IN VARCHAR2,
                           i_campo      IN VARCHAR2,
                           i_referencia IN VARCHAR2,
                           i_dato       IN anydata) IS
  BEGIN
    UPDATE t_datos a
       SET a.contenido = i_dato
     WHERE upper(a.tabla) = upper(i_tabla)
       AND upper(a.campo) = upper(i_campo)
       AND a.referencia = i_referencia;
  
    IF SQL%NOTFOUND THEN
      INSERT INTO t_datos
        (tabla, campo, referencia, contenido)
      VALUES
        (upper(i_tabla), upper(i_campo), i_referencia, i_dato);
    END IF;
  END;

  PROCEDURE p_guardar_dato_string(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN VARCHAR2) IS
  BEGIN
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertvarchar2(i_dato));
  END;

  PROCEDURE p_guardar_dato_number(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN NUMBER) IS
  BEGIN
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertnumber(i_dato));
  END;

  PROCEDURE p_guardar_dato_boolean(i_tabla      IN VARCHAR2,
                                   i_campo      IN VARCHAR2,
                                   i_referencia IN VARCHAR2,
                                   i_dato       IN BOOLEAN) IS
  BEGIN
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertnumber(sys.diutil.bool_to_int(i_dato)));
  END;

  PROCEDURE p_guardar_dato_date(i_tabla      IN VARCHAR2,
                                i_campo      IN VARCHAR2,
                                i_referencia IN VARCHAR2,
                                i_dato       IN DATE) IS
  BEGIN
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertdate(i_dato));
  END;

  PROCEDURE p_guardar_dato_object(i_tabla      IN VARCHAR2,
                                  i_campo      IN VARCHAR2,
                                  i_referencia IN VARCHAR2,
                                  i_dato       IN y_objeto) IS
  BEGIN
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertobject(i_dato));
  END;

END;
/
