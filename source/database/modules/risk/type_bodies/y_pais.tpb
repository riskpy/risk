create or replace type body y_pais is

  constructor function y_pais return self as result as
  begin
    self.id_pais     := null;
    self.nombre      := null;
    self.iso_alpha_2 := null;
    self.iso_alpha_3 := null;
    self.iso_numeric := null;
  
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_pais;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto             := new y_pais();
    l_objeto.id_pais     := l_json_object.get_number('id_pais');
    l_objeto.nombre      := l_json_object.get_string('nombre');
    l_objeto.iso_alpha_2 := l_json_object.get_string('iso_alpha_2');
    l_objeto.iso_alpha_3 := l_json_object.get_string('iso_alpha_3');
    l_objeto.iso_numeric := l_json_object.get_number('iso_numeric');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_pais', self.id_pais);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('iso_alpha_2', self.iso_alpha_2);
    l_json_object.put('iso_alpha_3', self.iso_alpha_3);
    l_json_object.put('iso_numeric', self.iso_numeric);
  
    return l_json_object.to_clob;
  end;

end;
/
