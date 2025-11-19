create or replace type body y_pagina_parametros is

  constructor function y_pagina_parametros return self as result as
  begin
    self.pagina     := null;
    self.por_pagina := null;
    self.no_paginar := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_objeto      y_pagina_parametros;
    l_json_object json_object_t;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto            := new y_pagina_parametros();
    l_objeto.pagina     := l_json_object.get_number('pagina');
    l_objeto.por_pagina := l_json_object.get_number('por_pagina');
    l_objeto.no_paginar := l_json_object.get_string('no_paginar');
  
    return l_objeto;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
  begin
    l_json_object := new json_object_t();
    l_json_object.put('pagina', self.pagina);
    l_json_object.put('por_pagina', self.por_pagina);
    l_json_object.put('no_paginar', self.no_paginar);
    return l_json_object.to_clob;
  end;

end;
/
