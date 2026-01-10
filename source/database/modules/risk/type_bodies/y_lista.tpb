create or replace type body y_lista is

  constructor function y_lista return self as result as
  begin
    self.elementos := new y_objetos();
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
  begin
    return k_objeto_util.parse_json(i_json);
  end;

  overriding member function to_json return clob is
  begin
    return k_objeto_util.to_json(self);
  end;

end;
/

