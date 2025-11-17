CREATE OR REPLACE TYPE BODY y_mensaje IS

  CONSTRUCTOR FUNCTION y_mensaje RETURN SELF AS RESULT AS
  BEGIN
    self.id_mensaje      := NULL;
    self.numero_telefono := NULL;
    self.contenido       := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_mensaje;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := NEW y_mensaje();
    l_objeto.id_mensaje      := l_json_object.get_number('id_mensaje');
    l_objeto.numero_telefono := l_json_object.get_string('numero_telefono');
    l_objeto.contenido       := l_json_object.get_string('contenido');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_mensaje', self.id_mensaje);
    l_json_object.put('numero_telefono', self.numero_telefono);
    l_json_object.put('contenido', self.contenido);
    RETURN l_json_object.to_clob;
  END;

END;
/
