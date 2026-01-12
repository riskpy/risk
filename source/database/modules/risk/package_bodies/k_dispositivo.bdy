create or replace package body k_dispositivo is

  -- Tiempo de expiración de la suscripción en días
  c_tiempo_expiracion_suscripcion constant pls_integer := 30;

  function f_suscripcion_defecto return varchar2 is
  begin
    return c_suscripcion_defecto;
  end;

  function f_suscripcion_usuario(i_id_usuario in number) return varchar2 is
  begin
    return c_suscripcion_usuario || '_' || to_char(i_id_usuario);
  end;

  function f_id_dispositivo(i_token_dispositivo in varchar2) return number is
    l_id_dispositivo t_dispositivos.id_dispositivo%type;
  begin
    begin
      select id_dispositivo
        into l_id_dispositivo
        from t_dispositivos
       where token_dispositivo = i_token_dispositivo;
    exception
      when no_data_found then
        l_id_dispositivo := null;
      when others then
        l_id_dispositivo := null;
    end;
    return l_id_dispositivo;
  end;

  function f_registrar_dispositivo(i_id_aplicacion             in varchar2,
                                   i_token_dispositivo         in varchar2,
                                   i_token_notificacion        in varchar2 default null,
                                   i_nombre_sistema_operativo  in varchar2 default null,
                                   i_version_sistema_operativo in varchar2 default null,
                                   i_tipo                      in varchar2 default null,
                                   i_nombre_navegador          in varchar2 default null,
                                   i_version_navegador         in varchar2 default null,
                                   i_version_aplicacion        in varchar2 default null,
                                   i_pais_iso_alpha_2          in varchar2 default null,
                                   i_zona_horaria              in varchar2 default null,
                                   i_idioma_iso369_1           in varchar2 default null)
    return number is
    l_id_dispositivo t_dispositivos.id_dispositivo%type;
    l_id_pais        t_dispositivos.id_pais%type;
    l_id_idioma      t_dispositivos.id_idioma%type;
  begin
    -- Valida aplicación
    if i_id_aplicacion is null then
      raise_application_error(-20000, 'Aplicación inexistente o inactiva');
    end if;
  
    if i_token_dispositivo is null then
      raise_application_error(-20000, 'Parámetro Token es requerido');
    end if;
  
    -- Busca dispositivo
    l_id_dispositivo := f_id_dispositivo(i_token_dispositivo);
  
    -- Busca el pais
    if i_pais_iso_alpha_2 is not null then
      begin
        select p.id_pais
          into l_id_pais
          from t_paises p
         where p.iso_alpha_2 = upper(i_pais_iso_alpha_2);
      exception
        when others then
          l_id_pais := null;
      end;
    end if;
  
    -- Busca el idioma
    if i_idioma_iso369_1 is not null then
      begin
        select i.id_idioma
          into l_id_idioma
          from t_idiomas i
         where i.iso_639_1 = lower(i_idioma_iso369_1);
      exception
        when others then
          l_id_idioma := null;
      end;
    end if;
  
    if l_id_dispositivo is not null then
      -- Actualiza dispositivo
      update t_dispositivos
         set fecha_ultimo_acceso       = sysdate,
             id_aplicacion             = i_id_aplicacion,
             nombre_sistema_operativo  = nvl(i_nombre_sistema_operativo,
                                             nombre_sistema_operativo),
             version_sistema_operativo = nvl(i_version_sistema_operativo,
                                             version_sistema_operativo),
             tipo                      = nvl(i_tipo, tipo),
             nombre_navegador          = nvl(i_nombre_navegador,
                                             nombre_navegador),
             version_navegador         = nvl(i_version_navegador,
                                             version_navegador),
             token_notificacion        = nvl(i_token_notificacion,
                                             token_notificacion),
             version_aplicacion        = nvl(i_version_aplicacion,
                                             version_aplicacion),
             id_pais                   = nvl(l_id_pais, id_pais),
             zona_horaria              = nvl(k_util.f_zona_horaria(i_zona_horaria),
                                             zona_horaria),
             id_idioma                 = nvl(l_id_idioma, id_idioma)
       where id_dispositivo = l_id_dispositivo;
    else
      -- Inserta dispositivo
      insert into t_dispositivos
        (token_dispositivo,
         fecha_ultimo_acceso,
         id_aplicacion,
         nombre_sistema_operativo,
         version_sistema_operativo,
         tipo,
         nombre_navegador,
         version_navegador,
         token_notificacion,
         version_aplicacion,
         id_pais,
         zona_horaria,
         id_idioma)
      values
        (i_token_dispositivo,
         sysdate,
         i_id_aplicacion,
         i_nombre_sistema_operativo,
         i_version_sistema_operativo,
         i_tipo,
         i_nombre_navegador,
         i_version_navegador,
         i_token_notificacion,
         i_version_aplicacion,
         l_id_pais,
         k_util.f_zona_horaria(i_zona_horaria),
         l_id_idioma)
      returning id_dispositivo into l_id_dispositivo;
    end if;
  
    $if k_modulo.c_instalado_msj $then
    if l_id_dispositivo is not null then
      -- Inserta o actualiza una suscripción por defecto en el dispositivo
      p_suscribir_notificacion(l_id_dispositivo, c_suscripcion_defecto);
    end if;
    $end
  
    return l_id_dispositivo;
  end;

  function f_datos_dispositivo(i_id_dispositivo in number)
    return y_dispositivo is
    l_dispositivo   y_dispositivo;
    l_suscripciones y_datos;
    l_suscripcion   y_dato;
    l_plantilla     y_plantilla;
    l_plantillas    y_datos;
    l_id_aplicacion t_aplicaciones.id_aplicacion%type;
  
    $if k_modulo.c_instalado_msj $then
    cursor cr_plantillas(i_id_aplicacion in varchar2) is
      select n.nombre, n.plantilla
        from t_notificacion_plantillas n
       where n.id_aplicacion = i_id_aplicacion;
    $end
  
    $if k_modulo.c_instalado_msj $then
    cursor cr_suscripciones(i_id_dispositivo in number) is
      select s.suscripcion
        from t_dispositivo_suscripciones s
       where (s.fecha_expiracion is null or s.fecha_expiracion > sysdate)
         and s.id_dispositivo = i_id_dispositivo;
    $end
  begin
    -- Inicializa respuesta
    l_dispositivo   := new y_dispositivo();
    l_suscripciones := new y_datos();
    l_plantillas    := new y_datos();
  
    -- Buscando datos del dispositivo
    begin
      select d.id_dispositivo,
             d.token_dispositivo,
             d.nombre_sistema_operativo,
             d.version_sistema_operativo,
             d.tipo,
             d.nombre_navegador,
             d.version_navegador,
             d.token_notificacion,
             k_parametro.f_valor_parametro(k_parametro.c_tabla_aplicaciones,
                                           'PLATAFORMA_NOTIFICACION',
                                           a.id_aplicacion),
             d.version_aplicacion,
             (select p.iso_alpha_2
                from t_paises p
               where p.id_pais = d.id_pais),
             d.zona_horaria,
             (select i.iso_639_1
                from t_idiomas i
               where i.id_idioma = d.id_idioma),
             a.id_aplicacion
        into l_dispositivo.id_dispositivo,
             l_dispositivo.token_dispositivo,
             l_dispositivo.nombre_sistema_operativo,
             l_dispositivo.version_sistema_operativo,
             l_dispositivo.tipo,
             l_dispositivo.nombre_navegador,
             l_dispositivo.version_navegador,
             l_dispositivo.token_notificacion,
             l_dispositivo.plataforma_notificacion,
             l_dispositivo.version_aplicacion,
             l_dispositivo.id_pais_iso2,
             l_dispositivo.zona_horaria,
             l_dispositivo.id_idioma_iso369_1,
             l_id_aplicacion
        from t_dispositivos d, t_aplicaciones a
       where a.id_aplicacion(+) = d.id_aplicacion
         and d.id_dispositivo = i_id_dispositivo;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Dispositivo inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al buscar datos del dispositivo');
    end;
  
    -- Buscando plantillas de la aplicación
    $if k_modulo.c_instalado_msj $then
    for c in cr_plantillas(l_id_aplicacion) loop
      l_plantilla           := new y_plantilla();
      l_plantilla.contenido := c.plantilla;
      l_plantilla.nombre    := c.nombre;
    
      l_plantillas.extend;
      l_plantillas(l_plantillas.count) := l_plantilla;
    end loop;
    $end
    l_dispositivo.plantillas := l_plantillas;
  
    -- Buscando suscripciones del dispositivo
    $if k_modulo.c_instalado_msj $then
    for c in cr_suscripciones(l_dispositivo.id_dispositivo) loop
      l_suscripcion           := new y_dato();
      l_suscripcion.contenido := c.suscripcion;
    
      l_suscripciones.extend;
      l_suscripciones(l_suscripciones.count) := l_suscripcion;
    end loop;
    $end
    l_dispositivo.suscripciones := l_suscripciones;
  
    return l_dispositivo;
  end;

  $if k_modulo.c_instalado_msj $then
  procedure p_suscribir_notificacion(i_id_dispositivo   in number,
                                     i_suscripcion_alta in varchar2) is
  begin
    -- Actualiza suscripción
    update t_dispositivo_suscripciones s
       set s.suscripcion      = lower(i_suscripcion_alta),
           s.fecha_expiracion = sysdate + c_tiempo_expiracion_suscripcion
     where s.id_dispositivo = i_id_dispositivo
       and lower(s.suscripcion) = lower(i_suscripcion_alta);
  
    if sql%notfound then
      -- Inserta suscripción
      insert into t_dispositivo_suscripciones
        (id_dispositivo, suscripcion, fecha_expiracion)
      values
        (i_id_dispositivo,
         lower(i_suscripcion_alta),
         sysdate + c_tiempo_expiracion_suscripcion);
    end if;
  end;

  procedure p_suscribir_notificacion_s(i_suscripcion      in varchar2,
                                       i_suscripcion_alta in varchar2) is
    cursor cr_dispositivos(i_suscripcion in varchar2) is
      select s.id_dispositivo
        from t_dispositivo_suscripciones s
       where lower(s.suscripcion) = lower(i_suscripcion)
         and (s.fecha_expiracion is null or s.fecha_expiracion > sysdate);
  begin
    for c in cr_dispositivos(i_suscripcion) loop
      p_suscribir_notificacion(c.id_dispositivo, i_suscripcion_alta);
    end loop;
  end;

  procedure p_suscribir_notificacion_usuario(i_id_dispositivo in number,
                                             i_id_usuario     in number) is
  begin
    -- Inserta suscripción de dispositivo a partir de un usuario
    insert into t_dispositivo_suscripciones
      (id_dispositivo, suscripcion, fecha_expiracion)
      select i_id_dispositivo, us.suscripcion, us.fecha_expiracion
        from t_usuario_suscripciones us
       where us.id_usuario = i_id_usuario
         and us.suscripcion not in
             (select ds.suscripcion
                from t_dispositivo_suscripciones ds
               where ds.id_dispositivo = i_id_dispositivo);
  end;

  procedure p_desuscribir_notificacion(i_id_dispositivo   in number,
                                       i_suscripcion_baja in varchar2) is
  begin
    delete t_dispositivo_suscripciones s
     where s.id_dispositivo = i_id_dispositivo
       and lower(s.suscripcion) = lower(i_suscripcion_baja);
  end;

  procedure p_desuscribir_notificacion_s(i_suscripcion      in varchar2,
                                         i_suscripcion_baja in varchar2) is
    cursor cr_dispositivos(i_suscripcion in varchar2) is
      select s.id_dispositivo
        from t_dispositivo_suscripciones s
       where lower(s.suscripcion) = lower(i_suscripcion)
         and (s.fecha_expiracion is null or s.fecha_expiracion > sysdate);
  begin
    for c in cr_dispositivos(i_suscripcion) loop
      p_desuscribir_notificacion(c.id_dispositivo, i_suscripcion_baja);
    end loop;
  end;

  procedure p_desuscribir_notificacion_usuario(i_id_dispositivo in number,
                                               i_id_usuario     in number) is
  begin
    -- Elimina suscripción a dispositivo de un usuario
    delete from t_dispositivo_suscripciones ds
     where ds.id_dispositivo = i_id_dispositivo
       and ds.suscripcion in
           (select us.suscripcion
              from t_usuario_suscripciones us
             where us.id_usuario = i_id_usuario);
  end;
  $end

  procedure p_registrar_ubicacion(i_id_dispositivo in number,
                                  i_latitud        in number,
                                  i_longitud       in number) is
    l_orden t_dispositivo_ubicaciones.orden%type;
  begin
    select nvl(max(du.orden), 0) + 1
      into l_orden
      from t_dispositivo_ubicaciones du
     where du.id_dispositivo = i_id_dispositivo;
  
    -- Inserta ubicación
    insert into t_dispositivo_ubicaciones
      (id_dispositivo, orden, fecha, latitud, longitud)
    values
      (i_id_dispositivo, l_orden, sysdate, i_latitud, i_longitud);
  end;

end;
/

