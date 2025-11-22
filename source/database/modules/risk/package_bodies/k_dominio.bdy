create or replace package body k_dominio is

  function f_id_modulo(i_id_dominio in varchar2) return varchar2 is
    l_id_modulo t_modulos.id_modulo%type;
  begin
    begin
      select a.id_modulo
        into l_id_modulo
        from t_dominios a
       where a.id_dominio = i_id_dominio;
    exception
      when no_data_found then
        l_id_modulo := null;
      when others then
        l_id_modulo := null;
    end;
    return l_id_modulo;
  end;

end;
/
