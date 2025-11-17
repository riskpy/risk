CREATE OR REPLACE PACKAGE BODY k_dominio IS

  FUNCTION f_id_modulo(i_id_dominio IN VARCHAR2) RETURN VARCHAR2 IS
    l_id_modulo t_modulos.id_modulo%TYPE;
  BEGIN
    BEGIN
      SELECT a.id_modulo
        INTO l_id_modulo
        FROM t_dominios a
       WHERE a.id_dominio = i_id_dominio;
    EXCEPTION
      WHEN no_data_found THEN
        l_id_modulo := NULL;
      WHEN OTHERS THEN
        l_id_modulo := NULL;
    END;
    RETURN l_id_modulo;
  END;

END;
/

