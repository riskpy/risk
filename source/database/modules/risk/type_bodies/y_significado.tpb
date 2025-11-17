CREATE OR REPLACE TYPE BODY y_significado IS

  CONSTRUCTOR FUNCTION y_significado RETURN SELF AS RESULT AS
  BEGIN
    self.dominio     := NULL;
    self.codigo      := NULL;
    self.significado := NULL;
    self.referencia  := NULL;
    self.activo      := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_significado;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto             := NEW y_significado();
    l_objeto.dominio     := l_json_object.get_string('dominio');
    l_objeto.codigo      := l_json_object.get_string('codigo');
    l_objeto.significado := l_json_object.get_string('significado');
    l_objeto.referencia  := l_json_object.get_string('referencia');
    l_objeto.activo      := l_json_object.get_string('activo');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('dominio', self.dominio);
    l_json_object.put('codigo', self.codigo);
    l_json_object.put('significado', self.significado);
    l_json_object.put('referencia', self.referencia);
    l_json_object.put('activo', self.activo);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
