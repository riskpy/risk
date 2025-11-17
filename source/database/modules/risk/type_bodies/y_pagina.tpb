CREATE OR REPLACE TYPE BODY y_pagina IS

  CONSTRUCTOR FUNCTION y_pagina RETURN SELF AS RESULT AS
  BEGIN
    self.numero_actual      := NULL;
    self.numero_siguiente   := NULL;
    self.numero_ultima      := NULL;
    self.numero_primera     := NULL;
    self.numero_anterior    := NULL;
    self.cantidad_elementos := NULL;
    self.elementos          := NEW y_objetos();
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_pagina      y_pagina;
    l_json_object json_object_t;
    l_json_array  json_array_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_pagina                    := NEW y_pagina();
    l_pagina.numero_actual      := l_json_object.get_number('numero_actual');
    l_pagina.numero_siguiente   := l_json_object.get_number('numero_siguiente');
    l_pagina.numero_ultima      := l_json_object.get_number('numero_ultima');
    l_pagina.numero_primera     := l_json_object.get_number('numero_primera');
    l_pagina.numero_anterior    := l_json_object.get_number('numero_anterior');
    l_pagina.cantidad_elementos := l_json_object.get_number('cantidad_elementos');
  
    l_json_array := l_json_object.get_array('elementos');
  
    IF l_json_array IS NULL OR l_json_array.is_null OR
       l_json_array.get_size = 0 THEN
      l_pagina.elementos := NEW y_objetos();
    ELSE
      DECLARE
        l_anydata anydata;
        l_result  PLS_INTEGER;
        l_tipo    VARCHAR2(100);
        l_objeto  y_objeto;
        l_objetos y_objetos;
      BEGIN
        -- Busca nombre del tipo para hacer el parse
        l_tipo := k_sistema.f_desencolar;
        --
        l_objetos := NEW y_objetos();
        FOR i IN 0 .. l_json_array.get_size - 1 LOOP
          l_objeto  := NULL;
          l_anydata := k_util.json_to_objeto(l_json_array.get(i).to_clob,
                                             l_tipo);
          l_result  := l_anydata.getobject(l_objeto);
          l_objetos.extend;
          l_objetos(l_objetos.count) := l_objeto;
        END LOOP;
        l_pagina.elementos := l_objetos;
      EXCEPTION
        WHEN OTHERS THEN
          l_pagina.elementos := NEW y_objetos();
      END;
    END IF;
  
    RETURN l_pagina;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_json_array  json_array_t;
    i             INTEGER;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('numero_actual', self.numero_actual);
    l_json_object.put('numero_siguiente', self.numero_siguiente);
    l_json_object.put('numero_ultima', self.numero_ultima);
    l_json_object.put('numero_primera', self.numero_primera);
    l_json_object.put('numero_anterior', self.numero_anterior);
    l_json_object.put('cantidad_elementos', self.cantidad_elementos);
  
    IF self.elementos IS NULL THEN
      l_json_object.put_null('elementos');
    ELSE
      l_json_array := NEW json_array_t();
      i            := self.elementos.first;
      WHILE i IS NOT NULL LOOP
        l_json_array.append(json_object_t.parse(nvl(self.elementos(i).json,
                                                    self.elementos(i).to_json)));
        i := self.elementos.next(i);
      END LOOP;
      l_json_object.put('elementos', l_json_array);
    END IF;
  
    RETURN l_json_object.to_clob;
  END;

END;
/
