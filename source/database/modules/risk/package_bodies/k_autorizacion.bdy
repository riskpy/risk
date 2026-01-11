create or replace package body k_autorizacion is

  type y_cache_permisos is table of y_permisos index by varchar2(500);
  g_indice varchar2(500);

  -- Cache en memoria por sesión
  g_cache_permisos y_cache_permisos;

  procedure p_inicializar_permisos is
  begin
    -- Elimina permisos
    p_eliminar_permisos;

    -- Define permisos por defecto
    declare
      l_permisos y_permisos;
    begin
      l_permisos := f_permisos_usuario(k_sistema.f_id_usuario,
                                       k_sistema.f_id_entidad,
                                       null);
    exception
      when others then
        null;
    end;
  end;

  procedure p_limpiar_permisos is
  begin
    g_indice := g_cache_permisos.first;
    while g_indice is not null loop
      g_cache_permisos(g_indice) := null;
      g_indice := g_cache_permisos.next(g_indice);
    end loop;
  end;

  procedure p_eliminar_permisos is
  begin
    g_cache_permisos.delete;
  end;

  procedure p_imprimir_permisos is
  begin
    g_indice := g_cache_permisos.first;
    while g_indice is not null loop
      dbms_output.put(g_indice || ': ');
      if g_cache_permisos(g_indice) is not null then
        dbms_output.put(g_cache_permisos(g_indice).count);
      end if;
      dbms_output.new_line;
      g_indice := g_cache_permisos.next(g_indice);
    end loop;
  end;

  function f_permisos_usuario(i_id_usuario in number,
                              i_id_entidad in number default null,
                              i_grupo      in varchar2 default null)
    return y_permisos is
    l_permisos   y_permisos;
    l_permiso    y_permiso;
    l_id_entidad t_rol_usuarios.id_entidad%type;
    l_grupo      t_rol_usuarios.grupo%type;
    l_clave      varchar2(500);
  begin
    if i_id_entidad is not null then
      l_id_entidad := i_id_entidad;
      l_grupo      := nvl(i_grupo, 'AU');
    end if;

    l_clave := nvl(to_char(i_id_usuario), '_') || ':' ||
               nvl(to_char(l_id_entidad), '_') || ':' || nvl(l_grupo, '_');

    if g_cache_permisos.exists(l_clave) then
      return g_cache_permisos(l_clave);
    end if;

    l_permisos := new y_permisos();

    for per in (select rp.id_permiso,
                       max(rp.consultar) consultar,
                       max(rp.insertar) insertar,
                       max(rp.actualizar) actualizar,
                       max(rp.eliminar) eliminar,
                       max(rp.verificar) verificar,
                       max(rp.autorizar) autorizar
                  from t_rol_permisos rp
                 where rp.id_rol in
                       (select ru.id_rol
                          from t_rol_usuarios ru
                         where ru.id_usuario = i_id_usuario
                           and (
                               -- Roles del usuario
                                (l_id_entidad is null and l_grupo is null and
                                ru.id_entidad is null and ru.grupo is null) or
                               -- Roles del usuario por entidad/grupo
                                (l_id_entidad is not null and
                                l_grupo is not null and
                                ru.id_entidad = l_id_entidad and
                                ru.grupo = l_grupo))
                        union
                        -- Roles implícitos
                        select r.id_rol
                          from t_roles r, t_usuarios u
                         where nvl(r.origen, k_autenticacion.c_origen_risk) =
                               nvl(u.origen, k_autenticacion.c_origen_risk)
                           and u.id_usuario = i_id_usuario
                           and r.implicito = 'S')
                 group by rp.id_permiso) loop
      l_permiso            := new y_permiso();
      l_permiso.id_permiso := per.id_permiso;
      l_permiso.consultar  := per.consultar;
      l_permiso.insertar   := per.insertar;
      l_permiso.actualizar := per.actualizar;
      l_permiso.eliminar   := per.eliminar;
      l_permiso.verificar  := per.verificar;
      l_permiso.autorizar  := per.autorizar;

      l_permisos.extend;
      l_permisos(l_permisos.count) := l_permiso;
    end loop;

    g_cache_permisos(l_clave) := l_permisos;
    return l_permisos;
  end;

  function f_validar_permiso(i_id_usuario in number,
                             i_id_permiso in varchar2,
                             i_accion     in varchar2 default null,
                             i_id_entidad in number default null,
                             i_grupo      in varchar2 default null)
    return boolean is
    l_permiso varchar2(1);
  begin
    select decode(i_accion,
                  null,
                  decode(nvl(count(*), 0), 0, 'N', 'S'),
                  'C',
                  nvl(max(rp.consultar), 'N'),
                  'I',
                  nvl(max(rp.insertar), 'N'),
                  'A',
                  nvl(max(rp.actualizar), 'N'),
                  'E',
                  nvl(max(rp.eliminar), 'N'),
                  'V',
                  nvl(max(rp.verificar), 'N'),
                  'T',
                  nvl(max(rp.autorizar), 'N'),
                  'N')
      into l_permiso
      from table(f_permisos_usuario(i_id_usuario, i_id_entidad, i_grupo)) rp
     where upper(rp.id_permiso) = upper(i_id_permiso);
    return k_util.string_to_bool(l_permiso);
  exception
    when others then
      return false;
  end;

begin
  -- Define permisos por defecto
  p_inicializar_permisos;
end;
/

