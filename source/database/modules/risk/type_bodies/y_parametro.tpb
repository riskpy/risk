create or replace type body y_parametro is

  constructor function y_parametro return self as result as
  begin
    self.nombre := null;
    self.valor  := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_parametro   y_parametro;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);

    l_parametro        := new y_parametro();
    l_parametro.nombre := l_json_object.get_string('nombre');
    l_parametro.valor  := null; -- TODO

    return l_parametro;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('nombre', self.nombre);
    if self.valor is null or
       k_objeto_util.objeto_to_json(self.valor) is null then
      l_json_object.put_null('valor');
    else
      l_json_object.put('valor',
                        json_element_t.parse(k_objeto_util.objeto_to_json(self.valor)));
    end if;
    return l_json_object.to_clob;
  end;

end;
/

