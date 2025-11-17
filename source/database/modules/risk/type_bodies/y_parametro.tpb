CREATE OR REPLACE TYPE BODY y_parametro IS

  CONSTRUCTOR FUNCTION y_parametro RETURN SELF AS RESULT AS
  BEGIN
    self.nombre := NULL;
    self.valor  := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_parametro   y_parametro;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_parametro        := NEW y_parametro();
    l_parametro.nombre := l_json_object.get_string('nombre');
    l_parametro.valor  := NULL; -- TODO
  
    RETURN l_parametro;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('nombre', self.nombre);
    IF self.valor IS NULL OR k_util.objeto_to_json(self.valor) IS NULL THEN
      l_json_object.put_null('valor');
    ELSE
      l_json_object.put('valor',
                        json_element_t.parse(k_util.objeto_to_json(self.valor)));
    END IF;
    RETURN l_json_object.to_clob;
  END;

END;
/
