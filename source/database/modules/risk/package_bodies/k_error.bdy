CREATE OR REPLACE PACKAGE BODY k_error IS

  FUNCTION f_tipo_excepcion(i_sqlcode IN NUMBER) RETURN VARCHAR2 IS
    l_tipo_error VARCHAR2(3);
  BEGIN
    IF abs(i_sqlcode) BETWEEN 20000 AND 20999 THEN
      l_tipo_error := c_user_defined_error;
    ELSE
      l_tipo_error := c_oracle_predefined_error;
    END IF;
    RETURN l_tipo_error;
  END;

  FUNCTION f_mensaje_excepcion(i_sqlerrm IN VARCHAR2) RETURN VARCHAR2 IS
    l_posicion INTEGER;
    l_mensaje  VARCHAR2(32767);
  BEGIN
    l_mensaje := i_sqlerrm;
  
    -- ORA-NNNNN:
    l_posicion := regexp_instr(l_mensaje, 'ORA-[0-9]{5}:', 1, 2);
    IF l_posicion > length('ORA-NNNNN:') THEN
      l_mensaje := regexp_replace(substr(l_mensaje, 1, l_posicion - 1),
                                  'ORA-[0-9]{5}:');
    ELSE
      l_mensaje := regexp_replace(l_mensaje, 'ORA-[0-9]{5}:');
    END IF;
  
    -- PL/SQL:
    l_posicion := instr(l_mensaje, 'PL/SQL:', 1, 2);
    IF l_posicion > length('PL/SQL:') THEN
      l_mensaje := REPLACE(substr(l_mensaje, 1, l_posicion - 1), 'PL/SQL:');
    ELSE
      l_mensaje := REPLACE(l_mensaje, 'PL/SQL:');
    END IF;
  
    RETURN TRIM(l_mensaje);
  END;

  FUNCTION f_mensaje_error(i_clave     IN VARCHAR2,
                           i_cadenas   IN y_cadenas,
                           i_wrap_char IN VARCHAR2 DEFAULT c_wrap_char)
    RETURN VARCHAR2 IS
    l_mensaje   t_errores.mensaje%TYPE;
    l_id_idioma t_idiomas.id_idioma%TYPE;
    l_id_pais   t_paises.id_pais%TYPE;
  BEGIN
    l_id_idioma := k_sistema.f_idioma;
    l_id_pais   := k_sistema.f_pais;
  
    BEGIN
      WITH lv_mensajes AS
       (SELECT mensaje
          FROM t_errores
         WHERE clave = i_clave
           AND nvl(id_idioma, nvl(l_id_idioma, -1)) = nvl(l_id_idioma, -1)
           AND nvl(id_pais, nvl(l_id_pais, -1)) = nvl(l_id_pais, -1)
         ORDER BY decode(clave, NULL, 0, 1) + decode(id_idioma, NULL, 0, 1) +
                  decode(id_pais, NULL, 0, 1) DESC)
      SELECT mensaje INTO l_mensaje FROM lv_mensajes WHERE rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_mensaje := 'Error no registrado [' || i_clave || ']';
    END;
  
    RETURN k_cadena.f_unir_cadenas(l_mensaje,
                                   i_cadenas,
                                   nvl(i_wrap_char, c_wrap_char));
  END;

  FUNCTION f_mensaje_error(i_clave     IN VARCHAR2,
                           i_cadena1   IN VARCHAR2 DEFAULT NULL,
                           i_cadena2   IN VARCHAR2 DEFAULT NULL,
                           i_cadena3   IN VARCHAR2 DEFAULT NULL,
                           i_cadena4   IN VARCHAR2 DEFAULT NULL,
                           i_cadena5   IN VARCHAR2 DEFAULT NULL,
                           i_wrap_char IN VARCHAR2 DEFAULT c_wrap_char)
    RETURN VARCHAR2 IS
    l_mensaje   t_errores.mensaje%TYPE;
    l_id_idioma t_idiomas.id_idioma%TYPE;
    l_id_pais   t_paises.id_pais%TYPE;
  BEGIN
    l_id_idioma := k_sistema.f_idioma;
    l_id_pais   := k_sistema.f_pais;
  
    BEGIN
      WITH lv_mensajes AS
       (SELECT mensaje
          FROM t_errores
         WHERE clave = i_clave
           AND nvl(id_idioma, nvl(l_id_idioma, -1)) = nvl(l_id_idioma, -1)
           AND nvl(id_pais, nvl(l_id_pais, -1)) = nvl(l_id_pais, -1)
         ORDER BY decode(clave, NULL, 0, 1) + decode(id_idioma, NULL, 0, 1) +
                  decode(id_pais, NULL, 0, 1) DESC)
      SELECT mensaje INTO l_mensaje FROM lv_mensajes WHERE rownum = 1;
    EXCEPTION
      WHEN no_data_found THEN
        l_mensaje := 'Error no registrado [' || i_clave || ']';
    END;
  
    RETURN k_cadena.f_unir_cadenas(l_mensaje,
                                   i_cadena1,
                                   i_cadena2,
                                   i_cadena3,
                                   i_cadena4,
                                   i_cadena5,
                                   nvl(i_wrap_char, c_wrap_char));
  END;

END;
/
