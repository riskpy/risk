CREATE OR REPLACE PACKAGE BODY k_significado IS

  FUNCTION f_significado_codigo(i_dominio IN VARCHAR2,
                                i_codigo  IN VARCHAR2) RETURN VARCHAR2 IS
    l_significado t_significados.significado%TYPE;
  BEGIN
    BEGIN
      SELECT a.significado
        INTO l_significado
        FROM t_significados a
       WHERE a.dominio = i_dominio
         AND a.codigo = i_codigo;
    EXCEPTION
      WHEN OTHERS THEN
        l_significado := NULL;
    END;
    RETURN l_significado;
  END;

  FUNCTION f_referencia_codigo(i_dominio IN VARCHAR2,
                               i_codigo  IN VARCHAR2) RETURN VARCHAR2 IS
    l_referencia t_significados.referencia%TYPE;
  BEGIN
    BEGIN
      SELECT a.referencia
        INTO l_referencia
        FROM t_significados a
       WHERE a.dominio = i_dominio
         AND a.codigo = i_codigo;
    EXCEPTION
      WHEN OTHERS THEN
        l_referencia := NULL;
    END;
    RETURN l_referencia;
  END;

  FUNCTION f_existe_codigo(i_dominio IN VARCHAR2,
                           i_codigo  IN VARCHAR2) RETURN BOOLEAN IS
    l_existe VARCHAR2(1);
  BEGIN
    BEGIN
      SELECT 'S'
        INTO l_existe
        FROM t_significados a
       WHERE a.dominio = i_dominio
         AND a.codigo = i_codigo;
    EXCEPTION
      WHEN no_data_found THEN
        l_existe := 'N';
      WHEN too_many_rows THEN
        l_existe := 'S';
    END;
    RETURN k_util.string_to_bool(l_existe);
  END;

  FUNCTION f_id_modulo_dominio(i_dominio IN VARCHAR2) RETURN VARCHAR2 IS
    l_id_modulo t_modulos.id_modulo%TYPE;
  BEGIN
    BEGIN
      SELECT d.id_modulo
        INTO l_id_modulo
        FROM t_significado_dominios sd, t_dominios d
       WHERE d.id_dominio = sd.id_dominio
         AND sd.dominio = i_dominio;
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
