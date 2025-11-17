CREATE OR REPLACE TYPE BODY y_pagina_parametros IS

  CONSTRUCTOR FUNCTION y_pagina_parametros RETURN SELF AS RESULT AS
  BEGIN
    self.pagina     := NULL;
    self.por_pagina := NULL;
    self.no_paginar := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_objeto      y_pagina_parametros;
    l_json_object json_object_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_objeto            := NEW y_pagina_parametros();
    l_objeto.pagina     := l_json_object.get_number('pagina');
    l_objeto.por_pagina := l_json_object.get_number('por_pagina');
    l_objeto.no_paginar := l_json_object.get_string('no_paginar');
  
    RETURN l_objeto;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('pagina', self.pagina);
    l_json_object.put('por_pagina', self.por_pagina);
    l_json_object.put('no_paginar', self.no_paginar);
    RETURN l_json_object.to_clob;
  END;

END;
/
