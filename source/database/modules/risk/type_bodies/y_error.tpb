CREATE OR REPLACE TYPE BODY y_error IS

  CONSTRUCTOR FUNCTION y_error RETURN SELF AS RESULT AS
  BEGIN
    self.clave   := NULL;
    self.mensaje := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_error;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto         := NEW y_error();
    l_objeto.clave   := l_json_object.get_string('clave');
    l_objeto.mensaje := l_json_object.get_string('mensaje');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('clave', self.clave);
    l_json_object.put('mensaje', self.mensaje);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
