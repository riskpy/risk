create or replace type body y_notificacion is

  constructor function y_notificacion return self as result as
  begin
    self.id_notificacion := null;
    self.suscripcion     := null;
    self.titulo          := null;
    self.contenido       := null;
    self.datos_extra     := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_notificacion;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := new y_notificacion();
    l_objeto.id_notificacion := l_json_object.get_number('id_notificacion');
    l_objeto.suscripcion     := l_json_object.get_string('suscripcion');
    l_objeto.titulo          := l_json_object.get_string('titulo');
    l_objeto.contenido       := l_json_object.get_string('contenido');
    l_objeto.datos_extra     := l_json_object.get_clob('datos_extra');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_notificacion', self.id_notificacion);
    l_json_object.put('suscripcion', self.suscripcion);
    l_json_object.put('titulo', self.titulo);
    l_json_object.put('contenido', self.contenido);
    l_json_object.put('datos_extra', self.datos_extra);
  
    return l_json_object.to_clob;
  end;

end;
/
