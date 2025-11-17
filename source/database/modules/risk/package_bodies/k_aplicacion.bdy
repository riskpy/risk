CREATE OR REPLACE PACKAGE BODY k_aplicacion IS

  FUNCTION f_id_aplicacion(i_clave_aplicacion IN VARCHAR2,
                           i_activo           IN VARCHAR2 DEFAULT NULL)
    RETURN VARCHAR2 IS
    l_id_aplicacion t_aplicaciones.id_aplicacion%TYPE;
  BEGIN
    BEGIN
      SELECT id_aplicacion
        INTO l_id_aplicacion
        FROM t_aplicaciones
       WHERE clave = i_clave_aplicacion
         AND activo = nvl(i_activo, activo);
    EXCEPTION
      WHEN no_data_found THEN
        l_id_aplicacion := NULL;
      WHEN OTHERS THEN
        l_id_aplicacion := NULL;
    END;
    RETURN l_id_aplicacion;
  END;

  FUNCTION f_validar_clave(i_clave_aplicacion IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    IF f_id_aplicacion(i_clave_aplicacion, 'S') IS NULL THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END;

  PROCEDURE p_validar_clave(i_clave_aplicacion IN VARCHAR2) IS
  BEGIN
    IF NOT f_validar_clave(i_clave_aplicacion) THEN
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    END IF;
  END;

END;
/
