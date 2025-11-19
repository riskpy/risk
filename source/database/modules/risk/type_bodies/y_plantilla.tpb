create or replace type body y_plantilla is

  constructor function y_plantilla return self as result as
  begin
    self.contenido := null;
    self.nombre    := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_dato        y_plantilla;
    l_json_object json_object_t;
  begin
    l_json_object    := json_object_t.parse(i_json);
    l_dato           := new y_plantilla();
    l_dato.contenido := l_json_object.get_clob('contenido');
    l_dato.nombre    := l_json_object.get_clob('nombre');
    return l_dato;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('contenido', self.contenido);
    l_json_object.put('nombre', self.nombre);
    return l_json_object.to_clob;
  end;

end;
/
