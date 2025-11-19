create or replace type body y_mensaje is

  constructor function y_mensaje return self as result as
  begin
    self.id_mensaje      := null;
    self.numero_telefono := null;
    self.contenido       := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_mensaje;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := new y_mensaje();
    l_objeto.id_mensaje      := l_json_object.get_number('id_mensaje');
    l_objeto.numero_telefono := l_json_object.get_string('numero_telefono');
    l_objeto.contenido       := l_json_object.get_string('contenido');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_mensaje', self.id_mensaje);
    l_json_object.put('numero_telefono', self.numero_telefono);
    l_json_object.put('contenido', self.contenido);
    return l_json_object.to_clob;
  end;

end;
/
