CREATE OR REPLACE TYPE BODY y_dato IS

  CONSTRUCTOR FUNCTION y_dato RETURN SELF AS RESULT AS
  BEGIN
    self.contenido := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_dato        y_dato;
    l_json_object json_object_t;
  BEGIN
    l_json_object    := json_object_t.parse(i_json);
    l_dato           := NEW y_dato();
    l_dato.contenido := l_json_object.get_clob('contenido');
    RETURN l_dato;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('contenido', self.contenido);
    RETURN l_json_object.to_clob;
  END;

END;
/
