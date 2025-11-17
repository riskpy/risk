CREATE OR REPLACE TYPE BODY y_respuesta IS

  CONSTRUCTOR FUNCTION y_respuesta RETURN SELF AS RESULT AS
  BEGIN
    self.codigo     := '0';
    self.mensaje    := 'OK';
    self.mensaje_bd := NULL;
    self.lugar      := NULL;
    self.datos      := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_respuesta    y_respuesta;
    l_json_object  json_object_t;
    l_json_element json_element_t;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_respuesta            := NEW y_respuesta();
    l_respuesta.codigo     := l_json_object.get_string('codigo');
    l_respuesta.mensaje    := l_json_object.get_string('mensaje');
    l_respuesta.mensaje_bd := l_json_object.get_string('mensaje_bd');
    l_respuesta.lugar      := l_json_object.get_string('lugar');
  
    l_json_element := l_json_object.get('datos');
  
    IF l_json_element IS NULL OR l_json_element.is_null THEN
      l_respuesta.datos := NULL;
    ELSE
      DECLARE
        l_anydata anydata;
        l_result  PLS_INTEGER;
        l_tipo    VARCHAR2(100);
      BEGIN
        -- Busca nombre del tipo para hacer el parse
        l_tipo := k_sistema.f_desencolar;
        --
        l_anydata := k_util.json_to_objeto(l_json_element.to_clob, l_tipo);
        l_result  := l_anydata.getobject(l_respuesta.datos);
      EXCEPTION
        WHEN OTHERS THEN
          l_respuesta.datos := NULL;
      END;
    END IF;
  
    RETURN l_respuesta;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
  BEGIN
    l_json_object := NEW json_object_t();
    l_json_object.put('codigo', self.codigo);
    l_json_object.put('mensaje', self.mensaje);
    l_json_object.put('mensaje_bd', self.mensaje_bd);
    l_json_object.put('lugar', self.lugar);
    IF self.datos IS NULL THEN
      l_json_object.put_null('datos');
    ELSE
      l_json_object.put('datos', json_element_t.parse(self.datos.to_json));
    END IF;
    RETURN l_json_object.to_clob;
  END;

END;
/
