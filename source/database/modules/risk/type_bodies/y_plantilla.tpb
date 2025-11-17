CREATE OR REPLACE TYPE BODY y_plantilla IS

  CONSTRUCTOR FUNCTION y_plantilla RETURN SELF AS RESULT AS
  BEGIN
    self.contenido := NULL;
    self.nombre    := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_dato        y_plantilla;
    l_json_object json_object_t;
  BEGIN
    l_json_object    := json_object_t.parse(i_json);
    l_dato           := NEW y_plantilla();
    l_dato.contenido := l_json_object.get_clob('contenido');
    l_dato.nombre    := l_json_object.get_clob('nombre');
    RETURN l_dato;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('contenido', self.contenido);
    l_json_object.put('nombre', self.nombre);
    RETURN l_json_object.to_clob;
  END;

END;
/
