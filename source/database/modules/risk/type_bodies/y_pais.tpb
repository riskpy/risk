CREATE OR REPLACE TYPE BODY y_pais IS

  CONSTRUCTOR FUNCTION y_pais RETURN SELF AS RESULT AS
  BEGIN
    self.id_pais     := NULL;
    self.nombre      := NULL;
    self.iso_alpha_2 := NULL;
    self.iso_alpha_3 := NULL;
    self.iso_numeric := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_pais;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto             := NEW y_pais();
    l_objeto.id_pais     := l_json_object.get_number('id_pais');
    l_objeto.nombre      := l_json_object.get_string('nombre');
    l_objeto.iso_alpha_2 := l_json_object.get_string('iso_alpha_2');
    l_objeto.iso_alpha_3 := l_json_object.get_string('iso_alpha_3');
    l_objeto.iso_numeric := l_json_object.get_number('iso_numeric');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_pais', self.id_pais);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('iso_alpha_2', self.iso_alpha_2);
    l_json_object.put('iso_alpha_3', self.iso_alpha_3);
    l_json_object.put('iso_numeric', self.iso_numeric);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
