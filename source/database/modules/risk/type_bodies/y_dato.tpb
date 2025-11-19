create or replace type body y_dato is

  constructor function y_dato return self as result as
  begin
    self.contenido := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_dato        y_dato;
    l_json_object json_object_t;
  begin
    l_json_object    := json_object_t.parse(i_json);
    l_dato           := new y_dato();
    l_dato.contenido := l_json_object.get_clob('contenido');
    return l_dato;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('contenido', self.contenido);
    return l_json_object.to_clob;
  end;

end;
/
