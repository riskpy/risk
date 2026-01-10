create or replace type body y_respuesta is

  constructor function y_respuesta return self as result as
  begin
    self.codigo     := '0';
    self.mensaje    := 'OK';
    self.mensaje_bd := null;
    self.lugar      := null;
    self.datos      := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_respuesta    y_respuesta;
    l_json_object  json_object_t;
    l_json_element json_element_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_respuesta            := new y_respuesta();
    l_respuesta.codigo     := l_json_object.get_string('codigo');
    l_respuesta.mensaje    := l_json_object.get_string('mensaje');
    l_respuesta.mensaje_bd := l_json_object.get_string('mensaje_bd');
    l_respuesta.lugar      := l_json_object.get_string('lugar');
  
    l_json_element := l_json_object.get('datos');
  
    if l_json_element is null or l_json_element.is_null then
      l_respuesta.datos := null;
    else
      declare
        l_anydata anydata;
        l_result  pls_integer;
        l_tipo    varchar2(100);
      begin
        -- Busca nombre del tipo para hacer el parse
        l_tipo := k_sistema.f_desencolar;
        --
        l_anydata := k_objeto_util.json_to_objeto(l_json_element.to_clob,
                                                  l_tipo);
        l_result  := l_anydata.getobject(l_respuesta.datos);
      exception
        when others then
          l_respuesta.datos := null;
      end;
    end if;
  
    return l_respuesta;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('codigo', self.codigo);
    l_json_object.put('mensaje', self.mensaje);
    l_json_object.put('mensaje_bd', self.mensaje_bd);
    l_json_object.put('lugar', self.lugar);
    if self.datos is null then
      l_json_object.put_null('datos');
    else
      l_json_object.put('datos', json_element_t.parse(self.datos.to_json));
    end if;
    return l_json_object.to_clob;
  end;

end;
/

