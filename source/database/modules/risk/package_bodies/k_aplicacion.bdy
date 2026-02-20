create or replace package body k_aplicacion is

  function f_aplicacion(i_id_aplicacion in varchar2)
    return t_aplicaciones%rowtype is
    rw_aplicacion t_aplicaciones%rowtype;
  begin
    begin
      select a.*
        into rw_aplicacion
        from t_aplicaciones a
       where a.id_aplicacion = i_id_aplicacion;
    exception
      when no_data_found then
        rw_aplicacion := null;
      when others then
        rw_aplicacion := null;
    end;
    return rw_aplicacion;
  end;

  function f_id_aplicacion(i_clave_aplicacion in varchar2,
                           i_activo           in varchar2 default null)
    return varchar2 is
    l_id_aplicacion t_aplicaciones.id_aplicacion%type;
  begin
    begin
      select id_aplicacion
        into l_id_aplicacion
        from t_aplicaciones
       where k_parametro.f_valor_parametro(k_parametro.c_tabla_aplicaciones,
                                           'CLAVE',
                                           id_aplicacion) =
             i_clave_aplicacion
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

  function f_nombre_aplicacion(i_id_aplicacion in varchar2,
                               i_activo        in varchar2 default null)
    return varchar2 is
    l_id_aplicacion     t_aplicaciones.id_aplicacion%type := i_id_aplicacion;
    l_activo            t_aplicaciones.activo%type := i_activo;
    l_nombre_aplicacion t_aplicaciones.nombre%type;
  begin
    begin
      select nombre
        into l_nombre_aplicacion
        from t_aplicaciones
       where id_aplicacion = l_id_aplicacion
         and activo = nvl(l_activo, activo);
    exception
      when no_data_found then
        l_nombre_aplicacion := null;
      when others then
        l_nombre_aplicacion := null;
    end;
    return l_nombre_aplicacion;
  end;

  function f_parametro_aplicacion(i_id_aplicacion in varchar2,
                                  i_parametro     in varchar2)
    return varchar2 is
  begin
    return k_parametro.f_valor_parametro(k_parametro.c_tabla_aplicaciones,
                                         i_parametro,
                                         i_id_aplicacion);
  exception
    when others then
      return null;
  end;

end;
/

