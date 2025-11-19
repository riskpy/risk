create or replace type body y_dispositivo is

  constructor function y_dispositivo return self as result as
  begin
    self.id_dispositivo            := null;
    self.token_dispositivo         := null;
    self.nombre_sistema_operativo  := null;
    self.version_sistema_operativo := null;
    self.tipo                      := null;
    self.nombre_navegador          := null;
    self.version_navegador         := null;
    self.token_notificacion        := null;
    self.plataforma_notificacion   := null;
    self.version_aplicacion        := null;
    self.id_pais_iso2              := null;
    self.zona_horaria              := null;
    self.id_idioma_iso369_1        := null;
    self.plantillas                := new y_datos();
    self.suscripciones             := new y_datos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_dispositivo   y_dispositivo;
    l_json_object   json_object_t;
    l_dato          y_dato;
    l_plantillas    y_datos;
    l_suscripciones y_datos;
    l_json_array    json_array_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_dispositivo                           := new y_dispositivo();
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
  
    if l_json_array is null then
      l_dispositivo.plantillas := new y_datos();
    else
      l_plantillas := new y_datos();
      for i in 0 .. l_json_array.get_size - 1 loop
        l_dato := new y_dato();
        l_dato := treat(y_dato.parse_json(l_json_array.get(i).to_clob) as
                        y_dato);
        l_plantillas.extend;
        l_plantillas(l_plantillas.count) := l_dato;
      end loop;
      l_dispositivo.plantillas := l_plantillas;
    end if;
  
    l_json_array := l_json_object.get_array('suscripciones');
  
    if l_json_array is null then
      l_dispositivo.suscripciones := new y_datos();
    else
      l_suscripciones := new y_datos();
      for i in 0 .. l_json_array.get_size - 1 loop
        l_dato := new y_dato();
        l_dato := treat(y_dato.parse_json(l_json_array.get(i).to_clob) as
                        y_dato);
        l_suscripciones.extend;
        l_suscripciones(l_suscripciones.count) := l_dato;
      end loop;
      l_dispositivo.suscripciones := l_suscripciones;
    end if;
  
    return l_dispositivo;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             integer;
  begin
    l_json_object := new json_object_t();
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
  
    if self.plantillas is null then
      l_json_object.put_null('plantillas');
    else
      l_json_array := new json_array_t();
      i            := self.plantillas.first;
      while i is not null loop
        l_json_array.append(json_object_t.parse(self.plantillas(i).to_json));
        i := self.plantillas.next(i);
      end loop;
      l_json_object.put('plantillas', l_json_array);
    end if;
  
    if self.suscripciones is null then
      l_json_object.put_null('suscripciones');
    else
      l_json_array := new json_array_t();
      i            := self.suscripciones.first;
      while i is not null loop
        l_json_array.append(json_object_t.parse(self.suscripciones(i).to_json));
        i := self.suscripciones.next(i);
      end loop;
      l_json_object.put('suscripciones', l_json_array);
    end if;
  
    return l_json_object.to_clob;
  end;

end;
/
