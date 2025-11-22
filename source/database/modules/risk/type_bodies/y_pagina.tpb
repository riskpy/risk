create or replace type body y_pagina is

  constructor function y_pagina return self as result as
  begin
    self.numero_actual      := null;
    self.numero_siguiente   := null;
    self.numero_ultima      := null;
    self.numero_primera     := null;
    self.numero_anterior    := null;
    self.cantidad_elementos := null;
    self.elementos          := new y_objetos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_pagina      y_pagina;
    l_json_object json_object_t;
    l_json_array  json_array_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_pagina                    := new y_pagina();
    l_pagina.numero_actual      := l_json_object.get_number('numero_actual');
    l_pagina.numero_siguiente   := l_json_object.get_number('numero_siguiente');
    l_pagina.numero_ultima      := l_json_object.get_number('numero_ultima');
    l_pagina.numero_primera     := l_json_object.get_number('numero_primera');
    l_pagina.numero_anterior    := l_json_object.get_number('numero_anterior');
    l_pagina.cantidad_elementos := l_json_object.get_number('cantidad_elementos');
  
    l_json_array := l_json_object.get_array('elementos');
  
    if l_json_array is null or l_json_array.is_null or
       l_json_array.get_size = 0 then
      l_pagina.elementos := new y_objetos();
    else
      declare
        l_anydata anydata;
        l_result  pls_integer;
        l_tipo    varchar2(100);
        l_objeto  y_objeto;
        l_objetos y_objetos;
      begin
        -- Busca nombre del tipo para hacer el parse
        l_tipo := k_sistema.f_desencolar;
        --
        l_objetos := new y_objetos();
        for i in 0 .. l_json_array.get_size - 1 loop
          l_objeto  := null;
          l_anydata := k_util.json_to_objeto(l_json_array.get(i).to_clob,
                                             l_tipo);
          l_result  := l_anydata.getobject(l_objeto);
          l_objetos.extend;
          l_objetos(l_objetos.count) := l_objeto;
        end loop;
        l_pagina.elementos := l_objetos;
      exception
        when others then
          l_pagina.elementos := new y_objetos();
      end;
    end if;
  
    return l_pagina;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             integer;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('numero_actual', self.numero_actual);
    l_json_object.put('numero_siguiente', self.numero_siguiente);
    l_json_object.put('numero_ultima', self.numero_ultima);
    l_json_object.put('numero_primera', self.numero_primera);
    l_json_object.put('numero_anterior', self.numero_anterior);
    l_json_object.put('cantidad_elementos', self.cantidad_elementos);
  
    if self.elementos is null then
      l_json_object.put_null('elementos');
    else
      l_json_array := new json_array_t();
      i            := self.elementos.first;
      while i is not null loop
        l_json_array.append(json_object_t.parse(nvl(self.elementos(i).json,
                                                    self.elementos(i).to_json)));
        i := self.elementos.next(i);
      end loop;
      l_json_object.put('elementos', l_json_array);
    end if;
  
    return l_json_object.to_clob;
  end;

end;
/
