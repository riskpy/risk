create or replace type body y_usuario is

  constructor function y_usuario return self as result as
  begin
    self.id_usuario       := null;
    self.alias            := null;
    self.nombre           := null;
    self.apellido         := null;
    self.tipo_persona     := null;
    self.estado           := null;
    self.direccion_correo := null;
    self.numero_telefono  := null;
    self.version_avatar   := null;
    self.origen           := null;
    self.roles            := new y_objetos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_usuario     y_usuario;
    l_json_object json_object_t;
    l_rol         y_rol;
    l_roles       y_objetos;
    l_json_array  json_array_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_usuario                  := new y_usuario();
    l_usuario.id_usuario       := l_json_object.get_number('id_usuario');
    l_usuario.alias            := l_json_object.get_string('alias');
    l_usuario.nombre           := l_json_object.get_string('nombre');
    l_usuario.apellido         := l_json_object.get_string('apellido');
    l_usuario.tipo_persona     := l_json_object.get_string('tipo_persona');
    l_usuario.estado           := l_json_object.get_string('estado');
    l_usuario.direccion_correo := l_json_object.get_string('direccion_correo');
    l_usuario.numero_telefono  := l_json_object.get_string('numero_telefono');
    l_usuario.version_avatar   := l_json_object.get_string('version_avatar');
    l_usuario.origen           := l_json_object.get_string('origen');
  
    l_json_array := l_json_object.get_array('roles');
  
    if l_json_array is null then
      l_usuario.roles := new y_objetos();
    else
      l_roles := new y_objetos();
      for i in 0 .. l_json_array.get_size - 1 loop
        l_rol := new y_rol();
        l_rol := treat(y_rol.parse_json(l_json_array.get(i).to_clob) as
                       y_rol);
        l_roles.extend;
        l_roles(l_roles.count) := l_rol;
      end loop;
      l_usuario.roles := l_roles;
    end if;
  
    return l_usuario;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             integer;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('id_usuario', self.id_usuario);
    l_json_object.put('alias', self.alias);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('apellido', self.apellido);
    l_json_object.put('tipo_persona', self.tipo_persona);
    l_json_object.put('estado', self.estado);
    l_json_object.put('direccion_correo', self.direccion_correo);
    l_json_object.put('numero_telefono', self.numero_telefono);
    l_json_object.put('version_avatar', self.version_avatar);
    l_json_object.put('origen', self.origen);
  
    if self.roles is null then
      l_json_object.put_null('roles');
    else
      l_json_array := new json_array_t();
      i            := self.roles.first;
      while i is not null loop
        l_json_array.append(json_object_t.parse(self.roles(i).to_json));
        i := self.roles.next(i);
      end loop;
      l_json_object.put('roles', l_json_array);
    end if;
  
    return l_json_object.to_clob;
  end;

end;
/
