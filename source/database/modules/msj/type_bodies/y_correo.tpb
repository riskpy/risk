create or replace type body y_correo is

  constructor function y_correo return self as result as
  begin
    self.id_correo        := null;
    self.mensaje_to       := null;
    self.mensaje_subject  := null;
    self.mensaje_body     := null;
    self.mensaje_from     := null;
    self.mensaje_reply_to := null;
    self.mensaje_cc       := null;
    self.mensaje_bcc      := null;
    self.adjuntos         := new y_archivos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_correo;
    l_json_object json_object_t;
    l_archivo     y_archivo;
    l_adjuntos    y_archivos;
    l_json_array  json_array_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto                  := new y_correo();
    l_objeto.id_correo        := l_json_object.get_number('id_correo');
    l_objeto.mensaje_to       := l_json_object.get_string('mensaje_to');
    l_objeto.mensaje_subject  := l_json_object.get_string('mensaje_subject');
    l_objeto.mensaje_body     := l_json_object.get_string('mensaje_body');
    l_objeto.mensaje_from     := l_json_object.get_string('mensaje_from');
    l_objeto.mensaje_reply_to := l_json_object.get_string('mensaje_reply_to');
    l_objeto.mensaje_cc       := l_json_object.get_string('mensaje_cc');
    l_objeto.mensaje_bcc      := l_json_object.get_string('mensaje_bcc');
  
    l_json_array := l_json_object.get_array('adjuntos');
  
    if l_json_array is null then
      l_objeto.adjuntos := new y_archivos();
    else
      l_adjuntos := new y_archivos();
      for i in 0 .. l_json_array.get_size - 1 loop
        l_archivo := new y_archivo();
        l_archivo := treat(y_archivo.parse_json(l_json_array.get(i).to_clob) as
                           y_archivo);
        l_adjuntos.extend;
        l_adjuntos(l_adjuntos.count) := l_archivo;
      end loop;
      l_objeto.adjuntos := l_adjuntos;
    end if;
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             integer;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_correo', self.id_correo);
    l_json_object.put('mensaje_to', self.mensaje_to);
    l_json_object.put('mensaje_subject', self.mensaje_subject);
    l_json_object.put('mensaje_body', self.mensaje_body);
    l_json_object.put('mensaje_from', self.mensaje_from);
    l_json_object.put('mensaje_reply_to', self.mensaje_reply_to);
    l_json_object.put('mensaje_cc', self.mensaje_cc);
    l_json_object.put('mensaje_bcc', self.mensaje_bcc);
  
    if self.adjuntos is null then
      l_json_object.put_null('adjuntos');
    else
      l_json_array := new json_array_t();
      i            := self.adjuntos.first;
      while i is not null loop
        l_json_array.append(json_object_t.parse(self.adjuntos(i).to_json));
        i := self.adjuntos.next(i);
      end loop;
      l_json_object.put('adjuntos', l_json_array);
    end if;
  
    return l_json_object.to_clob;
  end;

end;
/
