create or replace type body y_significado is

  constructor function y_significado return self as result as
  begin
    self.dominio     := null;
    self.codigo      := null;
    self.significado := null;
    self.referencia  := null;
    self.activo      := null;
  
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_significado;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto             := new y_significado();
    l_objeto.dominio     := l_json_object.get_string('dominio');
    l_objeto.codigo      := l_json_object.get_string('codigo');
    l_objeto.significado := l_json_object.get_string('significado');
    l_objeto.referencia  := l_json_object.get_string('referencia');
    l_objeto.activo      := l_json_object.get_string('activo');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('dominio', self.dominio);
    l_json_object.put('codigo', self.codigo);
    l_json_object.put('significado', self.significado);
    l_json_object.put('referencia', self.referencia);
    l_json_object.put('activo', self.activo);
  
    return l_json_object.to_clob;
  end;

end;
/
