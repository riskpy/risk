create or replace type body y_sesion is

  constructor function y_sesion return self as result as
  begin
    self.id_sesion                       := null;
    self.estado                          := null;
    self.access_token                    := null;
    self.refresh_token                   := null;
    self.tiempo_expiracion_access_token  := null;
    self.tiempo_expiracion_refresh_token := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_sesion      y_sesion;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_sesion                                 := new y_sesion();
    l_sesion.id_sesion                       := l_json_object.get_number('id_sesion');
    l_sesion.estado                          := l_json_object.get_string('estado');
    l_sesion.access_token                    := l_json_object.get_string('access_token');
    l_sesion.refresh_token                   := l_json_object.get_string('refresh_token');
    l_sesion.tiempo_expiracion_access_token  := l_json_object.get_number('tiempo_expiracion_access_token');
    l_sesion.tiempo_expiracion_refresh_token := l_json_object.get_number('tiempo_expiracion_refresh_token');
  
    return l_sesion;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_sesion', self.id_sesion);
    l_json_object.put('estado', self.estado);
    l_json_object.put('access_token', self.access_token);
    l_json_object.put('refresh_token', self.refresh_token);
    l_json_object.put('tiempo_expiracion_access_token',
                      self.tiempo_expiracion_access_token);
    l_json_object.put('tiempo_expiracion_refresh_token',
                      self.tiempo_expiracion_refresh_token);
    return l_json_object.to_clob;
  end;

end;
/
