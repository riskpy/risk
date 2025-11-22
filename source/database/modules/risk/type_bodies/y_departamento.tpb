create or replace type body y_departamento is

  constructor function y_departamento return self as result as
  begin
    self.id_departamento := null;
    self.nombre          := null;
    self.id_pais         := null;
  
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_departamento;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := new y_departamento();
    l_objeto.id_departamento := l_json_object.get_number('id_departamento');
    l_objeto.nombre          := l_json_object.get_string('nombre');
    l_objeto.id_pais         := l_json_object.get_number('id_pais');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_departamento', self.id_departamento);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('id_pais', self.id_pais);
  
    return l_json_object.to_clob;
  end;

end;
/
