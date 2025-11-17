CREATE OR REPLACE TYPE BODY y_rol IS

  CONSTRUCTOR FUNCTION y_rol RETURN SELF AS RESULT AS
  BEGIN
    self.id_rol  := NULL;
    self.nombre  := NULL;
    self.activo  := NULL;
    self.detalle := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_rol         y_rol;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_rol         := NEW y_rol();
    l_rol.id_rol  := l_json_object.get_number('id_rol');
    l_rol.nombre  := l_json_object.get_string('nombre');
    l_rol.activo  := l_json_object.get_string('activo');
    l_rol.detalle := l_json_object.get_string('detalle');
  
    RETURN l_rol;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_rol', self.id_rol);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('activo', self.activo);
    l_json_object.put('detalle', self.detalle);
    RETURN l_json_object.to_clob;
  END;

END;
/
