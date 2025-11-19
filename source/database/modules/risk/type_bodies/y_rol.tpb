create or replace type body y_rol is

  constructor function y_rol return self as result as
  begin
    self.id_rol  := null;
    self.nombre  := null;
    self.activo  := null;
    self.detalle := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_rol         y_rol;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_rol         := new y_rol();
    l_rol.id_rol  := l_json_object.get_number('id_rol');
    l_rol.nombre  := l_json_object.get_string('nombre');
    l_rol.activo  := l_json_object.get_string('activo');
    l_rol.detalle := l_json_object.get_string('detalle');
  
    return l_rol;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_rol', self.id_rol);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('activo', self.activo);
    l_json_object.put('detalle', self.detalle);
    return l_json_object.to_clob;
  end;

end;
/
