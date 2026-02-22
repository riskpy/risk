create or replace type body y_correo is

  constructor function y_correo return self as result as
  begin
    self.adjuntos := new y_objetos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
  begin
    return k_objeto_util.parse_json(i_json,
                                    k_objeto_util.y_tipo_objetos(k_objeto_util.ry_tipo_objeto(null,
                                                                                              'Y_ARCHIVO')));
  end;

  overriding member function to_json return clob is
  begin
    return k_objeto_util.to_json(self);
  end;

end;
/

