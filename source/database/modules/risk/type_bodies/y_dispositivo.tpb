CREATE OR REPLACE TYPE BODY y_dispositivo IS

  CONSTRUCTOR FUNCTION y_dispositivo RETURN SELF AS RESULT AS
  BEGIN
    self.id_dispositivo            := NULL;
    self.token_dispositivo         := NULL;
    self.nombre_sistema_operativo  := NULL;
    self.version_sistema_operativo := NULL;
    self.tipo                      := NULL;
    self.nombre_navegador          := NULL;
    self.version_navegador         := NULL;
    self.token_notificacion        := NULL;
    self.plataforma_notificacion   := NULL;
    self.version_aplicacion        := NULL;
    self.id_pais_iso2              := NULL;
    self.zona_horaria              := NULL;
    self.id_idioma_iso369_1        := NULL;
    self.plantillas                := NEW y_datos();
    self.suscripciones             := NEW y_datos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_dispositivo   y_dispositivo;
    l_json_object   json_object_t;
    l_dato          y_dato;
    l_plantillas    y_datos;
    l_suscripciones y_datos;
    l_json_array    json_array_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_dispositivo                           := NEW y_dispositivo();
    l_dispositivo.id_dispositivo            := l_json_object.get_number('id_dispositivo');
    l_dispositivo.token_dispositivo         := l_json_object.get_string('token_dispositivo');
    l_dispositivo.nombre_sistema_operativo  := l_json_object.get_string('nombre_sistema_operativo');
    l_dispositivo.version_sistema_operativo := l_json_object.get_string('version_sistema_operativo');
    l_dispositivo.tipo                      := l_json_object.get_string('tipo');
    l_dispositivo.nombre_navegador          := l_json_object.get_string('nombre_navegador');
    l_dispositivo.version_navegador         := l_json_object.get_string('version_navegador');
    l_dispositivo.token_notificacion        := l_json_object.get_string('token_notificacion');
    l_dispositivo.plataforma_notificacion   := l_json_object.get_string('plataforma_notificacion');
    l_dispositivo.version_aplicacion        := l_json_object.get_string('version_aplicacion');
    l_dispositivo.id_pais_iso2              := l_json_object.get_string('id_pais_iso2');
    l_dispositivo.zona_horaria              := l_json_object.get_string('zona_horaria');
    l_dispositivo.id_idioma_iso369_1        := l_json_object.get_string('id_idioma_iso369_1');
  
    l_json_array := l_json_object.get_array('plantillas');
  
    IF l_json_array IS NULL THEN
      l_dispositivo.plantillas := NEW y_datos();
    ELSE
      l_plantillas := NEW y_datos();
      FOR i IN 0 .. l_json_array.get_size - 1 LOOP
        l_dato := NEW y_dato();
        l_dato := treat(y_dato.parse_json(l_json_array.get(i).to_clob) AS
                        y_dato);
        l_plantillas.extend;
        l_plantillas(l_plantillas.count) := l_dato;
      END LOOP;
      l_dispositivo.plantillas := l_plantillas;
    END IF;
  
    l_json_array := l_json_object.get_array('suscripciones');
  
    IF l_json_array IS NULL THEN
      l_dispositivo.suscripciones := NEW y_datos();
    ELSE
      l_suscripciones := NEW y_datos();
      FOR i IN 0 .. l_json_array.get_size - 1 LOOP
        l_dato := NEW y_dato();
        l_dato := treat(y_dato.parse_json(l_json_array.get(i).to_clob) AS
                        y_dato);
        l_suscripciones.extend;
        l_suscripciones(l_suscripciones.count) := l_dato;
      END LOOP;
      l_dispositivo.suscripciones := l_suscripciones;
    END IF;
  
    RETURN l_dispositivo;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_dispositivo', self.id_dispositivo);
    l_json_object.put('token_dispositivo', self.token_dispositivo);
    l_json_object.put('nombre_sistema_operativo',
                      self.nombre_sistema_operativo);
    l_json_object.put('version_sistema_operativo',
                      self.version_sistema_operativo);
    l_json_object.put('tipo', self.tipo);
    l_json_object.put('nombre_navegador', self.nombre_navegador);
    l_json_object.put('version_navegador', self.version_navegador);
    l_json_object.put('token_notificacion', self.token_notificacion);
    l_json_object.put('plataforma_notificacion',
                      self.plataforma_notificacion);
    l_json_object.put('version_aplicacion', self.version_aplicacion);
    l_json_object.put('id_pais_iso2', self.id_pais_iso2);
    l_json_object.put('zona_horaria', self.zona_horaria);
    l_json_object.put('id_idioma_iso369_1', self.id_idioma_iso369_1);
  
    IF self.plantillas IS NULL THEN
      l_json_object.put_null('plantillas');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.plantillas.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.plantillas(i).to_json));
        i := self.plantillas.next(i);
      END LOOP;
      l_json_object.put('plantillas', l_json_array);
    END IF;
  
    IF self.suscripciones IS NULL THEN
      l_json_object.put_null('suscripciones');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.suscripciones.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.suscripciones(i).to_json));
        i := self.suscripciones.next(i);
      END LOOP;
      l_json_object.put('suscripciones', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
