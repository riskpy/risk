create or replace package body k_aplicacion is

  function f_id_aplicacion(i_clave_aplicacion in varchar2,
                           i_activo           in varchar2 default null)
    return varchar2 is
    l_id_aplicacion t_aplicaciones.id_aplicacion%type;
  begin
    begin
      select id_aplicacion
        into l_id_aplicacion
        from t_aplicaciones
       where clave = i_clave_aplicacion
         and activo = nvl(i_activo, activo);
    exception
      when no_data_found then
        l_id_aplicacion := null;
      when others then
        l_id_aplicacion := null;
    end;
    return l_id_aplicacion;
  end;

  function f_validar_clave(i_clave_aplicacion in varchar2) return boolean is
  begin
    if f_id_aplicacion(i_clave_aplicacion, 'S') is null then
      return false;
    else
      return true;
    end if;
  exception
    when others then
      return false;
  end;

  procedure p_validar_clave(i_clave_aplicacion in varchar2) is
  begin
    if not f_validar_clave(i_clave_aplicacion) then
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    end if;
  end;

end;
/
