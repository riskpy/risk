CREATE OR REPLACE TYPE BODY y_departamento IS

  CONSTRUCTOR FUNCTION y_departamento RETURN SELF AS RESULT AS
  BEGIN
    self.id_departamento := NULL;
    self.nombre          := NULL;
    self.id_pais         := NULL;
  
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_departamento;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := NEW y_departamento();
    l_objeto.id_departamento := l_json_object.get_number('id_departamento');
    l_objeto.nombre          := l_json_object.get_string('nombre');
    l_objeto.id_pais         := l_json_object.get_number('id_pais');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_departamento', self.id_departamento);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('id_pais', self.id_pais);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
