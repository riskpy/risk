create or replace package body k_modulo is

  function f_modulo(i_id_modulo in varchar2) return t_modulos%rowtype is
    rw_modulo t_modulos%rowtype;
  begin
    begin
      select a.*
        into rw_modulo
        from t_modulos a
       where a.id_modulo = i_id_modulo;
    exception
      when no_data_found then
        rw_modulo := null;
      when others then
        rw_modulo := null;
    end;
    return rw_modulo;
  end;

end;
/

