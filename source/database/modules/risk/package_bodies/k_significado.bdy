create or replace package body k_significado is

  function f_significado_codigo(i_dominio in varchar2,
                                i_codigo  in varchar2) return varchar2 is
    l_significado t_significados.significado%type;
  begin
    begin
      select a.significado
        into l_significado
        from t_significados a
       where a.dominio = i_dominio
         and a.codigo = i_codigo;
    exception
      when others then
        l_significado := null;
    end;
    return l_significado;
  end;

  function f_referencia_codigo(i_dominio in varchar2,
                               i_codigo  in varchar2) return varchar2 is
    l_referencia t_significados.referencia%type;
  begin
    begin
      select a.referencia
        into l_referencia
        from t_significados a
       where a.dominio = i_dominio
         and a.codigo = i_codigo;
    exception
      when others then
        l_referencia := null;
    end;
    return l_referencia;
  end;

  function f_existe_codigo(i_dominio in varchar2,
                           i_codigo  in varchar2) return boolean is
    l_existe varchar2(1);
  begin
    begin
      select 'S'
        into l_existe
        from t_significados a
       where a.dominio = i_dominio
         and a.codigo = i_codigo;
    exception
      when no_data_found then
        l_existe := 'N';
      when too_many_rows then
        l_existe := 'S';
    end;
    return k_util.string_to_bool(l_existe);
  end;

  function f_id_modulo_dominio(i_dominio in varchar2) return varchar2 is
    l_id_modulo t_modulos.id_modulo%type;
  begin
    begin
      select d.id_modulo
        into l_id_modulo
        from t_significado_dominios sd, t_dominios d
       where d.id_dominio = sd.id_dominio
         and sd.dominio = i_dominio;
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
