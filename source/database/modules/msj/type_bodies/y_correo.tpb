CREATE OR REPLACE TYPE BODY y_correo IS

  CONSTRUCTOR FUNCTION y_correo RETURN SELF AS RESULT AS
  BEGIN
    self.id_correo        := NULL;
    self.mensaje_to       := NULL;
    self.mensaje_subject  := NULL;
    self.mensaje_body     := NULL;
    self.mensaje_from     := NULL;
    self.mensaje_reply_to := NULL;
    self.mensaje_cc       := NULL;
    self.mensaje_bcc      := NULL;
    self.adjuntos         := NEW y_archivos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_correo;
    l_json_object json_object_t;
    l_archivo     y_archivo;
    l_adjuntos    y_archivos;
    l_json_array  json_array_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                  := NEW y_correo();
    l_objeto.id_correo        := l_json_object.get_number('id_correo');
    l_objeto.mensaje_to       := l_json_object.get_string('mensaje_to');
    l_objeto.mensaje_subject  := l_json_object.get_string('mensaje_subject');
    l_objeto.mensaje_body     := l_json_object.get_string('mensaje_body');
    l_objeto.mensaje_from     := l_json_object.get_string('mensaje_from');
    l_objeto.mensaje_reply_to := l_json_object.get_string('mensaje_reply_to');
    l_objeto.mensaje_cc       := l_json_object.get_string('mensaje_cc');
    l_objeto.mensaje_bcc      := l_json_object.get_string('mensaje_bcc');
  
    l_json_array := l_json_object.get_array('adjuntos');
  
    IF l_json_array IS NULL THEN
      l_objeto.adjuntos := NEW y_archivos();
    ELSE
      l_adjuntos := NEW y_archivos();
      FOR i IN 0 .. l_json_array.get_size - 1 LOOP
        l_archivo := NEW y_archivo();
        l_archivo := treat(y_archivo.parse_json(l_json_array.get(i).to_clob) AS
                           y_archivo);
        l_adjuntos.extend;
        l_adjuntos(l_adjuntos.count) := l_archivo;
      END LOOP;
      l_objeto.adjuntos := l_adjuntos;
    END IF;
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('id_correo', self.id_correo);
    l_json_object.put('mensaje_to', self.mensaje_to);
    l_json_object.put('mensaje_subject', self.mensaje_subject);
    l_json_object.put('mensaje_body', self.mensaje_body);
    l_json_object.put('mensaje_from', self.mensaje_from);
    l_json_object.put('mensaje_reply_to', self.mensaje_reply_to);
    l_json_object.put('mensaje_cc', self.mensaje_cc);
    l_json_object.put('mensaje_bcc', self.mensaje_bcc);
  
    IF self.adjuntos IS NULL THEN
      l_json_object.put_null('adjuntos');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.adjuntos.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(self.adjuntos(i).to_json));
        i := self.adjuntos.next(i);
      END LOOP;
      l_json_object.put('adjuntos', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
