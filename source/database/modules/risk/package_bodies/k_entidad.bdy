create or replace package body k_entidad is

  function f_buscar_id(i_entidad in varchar2) return number is
    l_id_entidad t_entidades.id_entidad%type;
  begin
    begin
      select id_entidad
        into l_id_entidad
        from t_entidades
       where (upper(alias) = upper(i_entidad) or
             upper(direccion_correo) = upper(i_entidad) or
             id_externo = i_entidad);
    exception
      when no_data_found then
        l_id_entidad := null;
      when others then
        l_id_entidad := null;
    end;
    return l_id_entidad;
  end;

  function f_id_entidad(i_alias in varchar2) return number is
    l_id_entidad t_entidades.id_entidad%type;
  begin
    begin
      select id_entidad
        into l_id_entidad
        from t_entidades
       where upper(alias) = upper(i_alias);
    exception
      when no_data_found then
        l_id_entidad := null;
      when others then
        l_id_entidad := null;
    end;
    return l_id_entidad;
  end;

  function f_id_entidad(i_id_persona in number,
                        i_origen     in varchar2 default null) return number is
    l_id_entidad t_entidades.id_entidad%type;
  begin
    begin
      select id_entidad
        into l_id_entidad
        from t_entidades
       where id_persona = i_id_persona
         and nvl(origen, k_autenticacion.c_origen_risk) =
             nvl(i_origen, k_autenticacion.c_origen_risk);
    exception
      when no_data_found then
        l_id_entidad := null;
      when others then
        l_id_entidad := null;
    end;
    return l_id_entidad;
  end;

  function f_id_persona(i_id_entidad in number) return number is
    l_id_persona t_entidades.id_persona%type;
  begin
    begin
      select u.id_persona
        into l_id_persona
        from t_entidades u
       where u.id_entidad = i_id_entidad;
    exception
      when no_data_found then
        l_id_persona := null;
      when others then
        l_id_persona := null;
    end;
    return l_id_persona;
  end;

  function f_alias(i_id_entidad in number) return varchar2 is
    l_alias t_entidades.alias%type;
  begin
    begin
      select u.alias
        into l_alias
        from t_entidades u
       where u.id_entidad = i_id_entidad;
    exception
      when no_data_found then
        l_alias := null;
      when others then
        l_alias := null;
    end;
    return l_alias;
  end;

  function f_estado(i_id_entidad in number) return varchar2 is
    l_estado t_entidades.estado%type;
  begin
    begin
      select u.estado
        into l_estado
        from t_entidades u
       where u.id_entidad = i_id_entidad;
    exception
      when no_data_found then
        l_estado := null;
      when others then
        l_estado := null;
    end;
    return l_estado;
  end;

  function f_origen(i_id_entidad in number) return varchar2 is
    l_origen t_entidades.origen%type;
  begin
    begin
      select u.origen
        into l_origen
        from t_entidades u
       where u.id_entidad = i_id_entidad;
    exception
      when no_data_found then
        l_origen := null;
      when others then
        l_origen := null;
    end;
    return l_origen;
  end;

  function f_validar_alias(i_alias  varchar2,
                           i_origen in varchar2 default null) return boolean is
    l_alias_valido    boolean := true;
    l_origen          t_entidades.origen%type;
    l_prefijo_dominio t_autenticacion_origenes.prefijo_dominio%type;
  begin
    l_origen := coalesce(i_origen, k_autenticacion.c_origen_risk);
  
    begin
      select a.prefijo_dominio
        into l_prefijo_dominio
        from t_autenticacion_origenes a
       where a.id_autenticacion_origen = l_origen;
    exception
      when others then
        l_prefijo_dominio := '';
    end;
  
    l_alias_valido := nvl(regexp_like(i_alias,
                                      k_util.f_valor_parametro('REGEXP_VALIDAR_ALIAS_ENTIDAD')),
                          true);
  
    if l_alias_valido and l_prefijo_dominio is not null then
      l_alias_valido := i_alias like l_prefijo_dominio || '%';
    end if;
  
    return l_alias_valido;
  end;

  procedure p_validar_alias(i_alias  varchar2,
                            i_origen in varchar2 default null) is
  begin
    if not f_validar_alias(i_alias, i_origen) then
      if nvl(i_origen, k_autenticacion.c_origen_risk) =
         k_autenticacion.c_origen_risk then
        raise_application_error(-20000,
                                'Caracteres no permitidos en la Entidad: ' ||
                                regexp_replace(i_alias,
                                               trim(translate(k_util.f_valor_parametro('REGEXP_VALIDAR_ALIAS_ENTIDAD'),
                                                              '^$',
                                                              '  ')),
                                               ''));
      else
        raise_application_error(-20000, 'Alias de entidad inválido');
      end if;
    end if;
  end;

  function f_grupo_usuario(i_id_entidad in number,
                           i_id_usuario in number) return varchar2 is
    l_grupo t_entidad_usuarios.grupo%type;
  begin
    begin
      select a.grupo
        into l_grupo
        from t_entidad_usuarios a
       where a.estado = 'A'
         and a.id_entidad = i_id_entidad
         and a.id_usuario = i_id_usuario;
    exception
      when no_data_found then
        l_grupo := null;
      when others then
        l_grupo := null;
    end;
    return l_grupo;
  end;

  procedure p_separar_dominio_entidad(i_alias   in varchar2,
                                      o_dominio out varchar2,
                                      o_entidad out varchar2) is
  begin
    if regexp_like(i_alias,
                   '^[A-Za-z0-9]{1,49}[_\]{1}[A-Za-z0-9:-]{1,250}$') then
      o_dominio := regexp_substr(i_alias, '^[A-Za-z0-9]{1,49}[_\]{1}');
      o_entidad := regexp_substr(i_alias, '[A-Za-z0-9:-]{1,250}$');
    elsif regexp_like(i_alias, '^[A-Za-z0-9:-]{1,300}$') then
      o_dominio := regexp_substr(i_alias, '^[A-Za-z0-9]{1,49}[_\]{1}');
      o_entidad := regexp_substr(i_alias, '[A-Za-z0-9:-]{1,250}$');
    end if;
  end;

end;
/
