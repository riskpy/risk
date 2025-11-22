create or replace type body y_error is

  constructor function y_error return self as result as
  begin
    self.clave   := null;
    self.mensaje := null;
  
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_error;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto         := new y_error();
    l_objeto.clave   := l_json_object.get_string('clave');
    l_objeto.mensaje := l_json_object.get_string('mensaje');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('clave', self.clave);
    l_json_object.put('mensaje', self.mensaje);
  
    return l_json_object.to_clob;
  end;

end;
/
