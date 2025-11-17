CREATE OR REPLACE TYPE BODY y_notificacion IS

  CONSTRUCTOR FUNCTION y_notificacion RETURN SELF AS RESULT AS
  BEGIN
    self.id_notificacion := NULL;
    self.suscripcion     := NULL;
    self.titulo          := NULL;
    self.contenido       := NULL;
    self.datos_extra     := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_notificacion;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                 := NEW y_notificacion();
    l_objeto.id_notificacion := l_json_object.get_number('id_notificacion');
    l_objeto.suscripcion     := l_json_object.get_string('suscripcion');
    l_objeto.titulo          := l_json_object.get_string('titulo');
    l_objeto.contenido       := l_json_object.get_string('contenido');
    l_objeto.datos_extra     := l_json_object.get_clob('datos_extra');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_notificacion', self.id_notificacion);
    l_json_object.put('suscripcion', self.suscripcion);
    l_json_object.put('titulo', self.titulo);
    l_json_object.put('contenido', self.contenido);
    l_json_object.put('datos_extra', self.datos_extra);
  
    RETURN l_json_object.to_clob;
  END;

END;
/
