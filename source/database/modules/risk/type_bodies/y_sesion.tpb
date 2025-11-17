CREATE OR REPLACE TYPE BODY y_sesion IS

  CONSTRUCTOR FUNCTION y_sesion RETURN SELF AS RESULT AS
  BEGIN
    self.id_sesion                       := NULL;
    self.estado                          := NULL;
    self.access_token                    := NULL;
    self.refresh_token                   := NULL;
    self.tiempo_expiracion_access_token  := NULL;
    self.tiempo_expiracion_refresh_token := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_sesion      y_sesion;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_sesion                                 := NEW y_sesion();
    l_sesion.id_sesion                       := l_json_object.get_number('id_sesion');
    l_sesion.estado                          := l_json_object.get_string('estado');
    l_sesion.access_token                    := l_json_object.get_string('access_token');
    l_sesion.refresh_token                   := l_json_object.get_string('refresh_token');
    l_sesion.tiempo_expiracion_access_token  := l_json_object.get_number('tiempo_expiracion_access_token');
    l_sesion.tiempo_expiracion_refresh_token := l_json_object.get_number('tiempo_expiracion_refresh_token');
  
    RETURN l_sesion;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_sesion', self.id_sesion);
    l_json_object.put('estado', self.estado);
    l_json_object.put('access_token', self.access_token);
    l_json_object.put('refresh_token', self.refresh_token);
    l_json_object.put('tiempo_expiracion_access_token',
                      self.tiempo_expiracion_access_token);
    l_json_object.put('tiempo_expiracion_refresh_token',
                      self.tiempo_expiracion_refresh_token);
    RETURN l_json_object.to_clob;
  END;

END;
/
