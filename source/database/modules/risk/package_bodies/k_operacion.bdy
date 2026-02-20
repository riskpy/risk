create or replace package body k_operacion is

  procedure p_crear_parametro(i_id_operacion     in t_operacion_parametros.id_operacion %type,
                              i_nombre           in t_operacion_parametros.nombre%type,
                              i_tipo_dato        in t_operacion_parametros.tipo_dato%type,
                              i_orden            in t_operacion_parametros.orden%type,
                              i_obligatorio      in t_operacion_parametros.obligatorio%type default 'N',
                              i_version          in t_operacion_parametros.version%type default '0.1.0',
                              i_formato          in t_operacion_parametros.formato%type default null,
                              i_longitud_maxima  in t_operacion_parametros.longitud_maxima%type default null,
                              i_valor_defecto    in t_operacion_parametros.valor_defecto%type default null,
                              i_valores_posibles in t_operacion_parametros.valores_posibles%type default null,
                              i_etiqueta         in t_operacion_parametros.etiqueta%type default null,
                              i_detalle          in t_operacion_parametros.detalle%type default null,
                              i_encriptado       in t_operacion_parametros.encriptado%type default 'N') is
  begin
    insert into t_operacion_parametros
      (id_operacion,
       nombre,
       version,
       orden,
       activo,
       tipo_dato,
       formato,
       longitud_maxima,
       obligatorio,
       valor_defecto,
       etiqueta,
       detalle,
       valores_posibles,
       encriptado)
    values
      (i_id_operacion,
       i_nombre,
       nvl(i_version, '0.1.0'),
       i_orden,
       'S',
       i_tipo_dato,
       i_formato,
       i_longitud_maxima,
       nvl(i_obligatorio, 'N'),
       i_valor_defecto,
       i_etiqueta,
       i_detalle,
       i_valores_posibles,
       nvl(i_encriptado, 'N'));
  end;

  procedure p_registrar_log(io_id_log          in out number,
                            i_id_operacion     in number,
                            i_parametros       in clob,
                            i_codigo_respuesta in varchar2 default null,
                            i_respuesta        in clob default null,
                            i_contexto         in clob default null,
                            i_version          in varchar2 default null) is
    pragma autonomous_transaction;
    l_nivel_log t_operaciones.nivel_log%type;
  begin
    begin
      select nivel_log
        into l_nivel_log
        from t_operaciones
       where id_operacion = i_id_operacion;
    exception
      when others then
        l_nivel_log := cg_nivel_log_error;
    end;
  
    if (l_nivel_log > cg_nivel_log_error and
       nvl(i_codigo_respuesta, c_ok) = c_ok) or
       (l_nivel_log > cg_nivel_log_off and
       nvl(i_codigo_respuesta, c_ok) <> c_ok) then
      if io_id_log is not null then
        -- Actualiza log
        update t_operacion_logs l
           set l.id_operacion = i_id_operacion,
               l.contexto     = i_contexto,
               l.version      = substr(i_version, 1, 100),
               l.parametros   = i_parametros,
               l.respuesta    = i_respuesta,
               --l.fecha_hora_inicio = null,
               l.fecha_hora_fin = current_timestamp,
               l.duracion       = current_timestamp -
                                  nvl(l.fecha_hora_inicio, current_timestamp),
               l.sql_ejecucion  = k_sistema.f_valor_parametro_string(k_operacion.c_sql_ejecucion),
               l.id_usuario     = k_sistema.f_id_usuario,
               l.id_entidad     = k_sistema.f_id_entidad,
               l.id_sesion      = k_sistema.f_valor_parametro_number(k_sistema.c_id_sesion),
               l.id_dispositivo = k_sistema.f_valor_parametro_number(k_sistema.c_id_dispositivo)
         where l.id_operacion_log = io_id_log;
      else
        -- Inserta log
        insert into t_operacion_logs
          (id_operacion,
           contexto,
           version,
           parametros,
           respuesta,
           fecha_hora_inicio,
           fecha_hora_fin,
           duracion,
           sql_ejecucion,
           id_usuario,
           id_entidad,
           id_sesion,
           id_dispositivo)
        values
          (i_id_operacion,
           i_contexto,
           substr(i_version, 1, 100),
           i_parametros,
           i_respuesta,
           current_timestamp,
           case when i_respuesta is not null then current_timestamp else null end,
           case when i_respuesta is not null then
           current_timestamp - current_timestamp else null end,
           k_sistema.f_valor_parametro_string(k_operacion.c_sql_ejecucion),
           k_sistema.f_id_usuario,
           k_sistema.f_id_entidad,
           k_sistema.f_valor_parametro_number(k_sistema.c_id_sesion),
           k_sistema.f_valor_parametro_number(k_sistema.c_id_dispositivo))
        returning id_operacion_log into io_id_log;
      end if;
    end if;
  
    commit;
  exception
    when others then
      console.error('Error al registrar log: ' || sqlerrm);
      rollback;
  end;

  procedure p_respuesta_ok(io_respuesta in out nocopy y_respuesta,
                           i_datos      in y_objeto default null) is
  begin
    io_respuesta.codigo     := c_ok;
    io_respuesta.mensaje    := nvl(io_respuesta.mensaje, 'OK');
    io_respuesta.mensaje_bd := null;
    io_respuesta.tipo_error := null;
    io_respuesta.lugar      := null;
    io_respuesta.datos      := i_datos;
  end;

  procedure p_respuesta_error(io_respuesta in out nocopy y_respuesta,
                              i_codigo     in varchar2,
                              i_mensaje    in varchar2 default null,
                              i_mensaje_bd in varchar2 default null,
                              i_datos      in y_objeto default null,
                              i_tipo_error in varchar2 default null) is
    l_mensaje varchar2(32767);
  begin
    if i_codigo = c_ok then
      io_respuesta.codigo := c_error_general;
    else
      io_respuesta.codigo := substr(i_codigo, 1, 100);
    end if;
    l_mensaje               := substr(i_mensaje, 1, 32767);
    io_respuesta.mensaje    := substr(k_error.f_mensaje_excepcion(nvl(l_mensaje,
                                                                      k_error.f_mensaje_error(i_codigo))),
                                      1,
                                      4000);
    io_respuesta.mensaje_bd := substr(i_mensaje_bd, 1, 4000);
    io_respuesta.tipo_error := substr(nvl(i_tipo_error,
                                          k_error.c_user_defined_error),
                                      1,
                                      3);
    io_respuesta.datos      := i_datos;
  end;

  procedure p_respuesta_excepcion(io_respuesta   in out nocopy y_respuesta,
                                  i_error_number in number,
                                  i_error_msg    in varchar2,
                                  i_error_stack  in varchar2) is
    l_codigo_error varchar2(100);
  begin
    if k_error.f_tipo_excepcion(i_error_number) =
       k_error.c_user_defined_error then
      p_respuesta_error(io_respuesta,
                        c_error_general,
                        i_error_msg,
                        i_error_stack,
                        io_respuesta.datos,
                        k_error.c_user_defined_error);
    elsif k_error.f_tipo_excepcion(i_error_number) =
          k_error.c_oracle_predefined_error then
      if abs(i_error_number) = 1 or i_error_stack like '%ORA-00001%' then
        -- https://docs.oracle.com/en/error-help/db/ora-00001/
        l_codigo_error := c_error_clave_duplicada;
      elsif abs(i_error_number) = 54 or i_error_stack like '%ORA-00054%' then
        -- https://docs.oracle.com/en/error-help/db/ora-00054/
        l_codigo_error := c_error_registro_bloqueado;
      else
        l_codigo_error := c_error_inesperado;
      end if;
      p_respuesta_error(io_respuesta,
                        l_codigo_error,
                        k_error.f_mensaje_error(l_codigo_error, c_id_log),
                        i_error_stack,
                        io_respuesta.datos,
                        k_error.c_oracle_predefined_error);
    end if;
  end;

  procedure p_validar_parametro(io_respuesta in out nocopy y_respuesta,
                                i_expresion  in boolean,
                                i_mensaje    in varchar2) is
  begin
    if not nvl(i_expresion, false) then
      p_respuesta_error(io_respuesta,
                        c_error_parametro,
                        nvl(i_mensaje,
                            k_error.f_mensaje_error(c_error_parametro)));
      raise ex_error_parametro;
    end if;
  end;

  procedure p_definir_parametros(i_id_operacion in number,
                                 i_contexto     in y_parametros) is
    l_id_sesion      t_sesiones.id_sesion%type;
    l_id_dispositivo t_dispositivos.id_dispositivo%type;
    l_dispositivo    y_dispositivo;
    --
    l_sub_session_iid number;
    l_device_iid      number;
  begin
    declare
      l_nombre_operacion  t_operaciones.nombre%type;
      l_dominio_operacion t_operaciones.dominio%type;
    begin
      if i_id_operacion is not null then
        select upper(o.nombre), o.dominio
          into l_nombre_operacion, l_dominio_operacion
          from t_operaciones o
         where o.id_operacion = i_id_operacion;
      
        k_sistema.p_definir_parametro_number(k_sistema.c_id_operacion,
                                             i_id_operacion);
        k_sistema.p_definir_parametro_string(k_sistema.c_nombre_operacion,
                                             l_nombre_operacion);
        k_sistema.p_definir_parametro_string(k_sistema.c_dominio_operacion,
                                             l_dominio_operacion);
      end if;
    exception
      when others then
        null;
    end;
    --
    k_sistema.p_definir_parametro_string(k_sistema.c_usuario,
                                         f_valor_parametro_string(i_contexto,
                                                                  'usuario'));
    k_sistema.p_definir_parametro_number(k_sistema.c_id_usuario,
                                         nvl(f_valor_parametro_number(i_contexto,
                                                                      k_sistema.c_id_usuario),
                                             k_usuario.f_id_usuario(f_valor_parametro_string(i_contexto,
                                                                                             'usuario'))));
    k_sistema.p_definir_parametro_string(k_sistema.c_entidad,
                                         f_valor_parametro_string(i_contexto,
                                                                  'entidad'));
    k_sistema.p_definir_parametro_number(k_sistema.c_id_entidad,
                                         nvl(f_valor_parametro_number(i_contexto,
                                                                      k_sistema.c_id_entidad),
                                             k_entidad.f_id_entidad(f_valor_parametro_string(i_contexto,
                                                                                             'entidad'))));
    --
    k_sistema.p_definir_parametro_string(k_sistema.c_direccion_ip,
                                         f_valor_parametro_string(i_contexto,
                                                                  'direccion_ip'));
    --
    k_sistema.p_definir_parametro_string(k_sistema.c_clave_aplicacion,
                                         f_valor_parametro_string(i_contexto,
                                                                  'clave_aplicacion'));
    k_sistema.p_definir_parametro_string(k_sistema.c_id_aplicacion,
                                         nvl(f_valor_parametro_string(i_contexto,
                                                                      k_sistema.c_id_aplicacion),
                                             k_aplicacion.f_id_aplicacion(f_valor_parametro_string(i_contexto,
                                                                                                   'clave_aplicacion'))));
    --
    k_sistema.p_definir_parametro_string(k_sistema.c_access_token,
                                         f_valor_parametro_string(i_contexto,
                                                                  'access_token'));
    l_id_sesion := k_sesion.f_id_sesion(f_valor_parametro_string(i_contexto,
                                                                 'access_token'));
  
    k_sistema.p_definir_parametro_number(k_sistema.c_id_sesion,
                                         coalesce(l_id_sesion,
                                                  l_sub_session_iid));
    --
    l_id_dispositivo := k_dispositivo.f_id_dispositivo(f_valor_parametro_string(i_contexto,
                                                                                'token_dispositivo'));
    if l_id_dispositivo is null and l_id_sesion is not null then
      l_id_dispositivo := k_sesion.f_dispositivo_sesion(l_id_sesion);
    end if;
  
    k_sistema.p_definir_parametro_number(k_sistema.c_id_dispositivo,
                                         coalesce(l_id_dispositivo,
                                                  l_device_iid));
  
    if l_id_dispositivo is not null then
      l_dispositivo := k_dispositivo.f_datos_dispositivo(l_id_dispositivo);
    
      declare
        l_id_pais t_paises.id_pais%type;
      begin
        if l_dispositivo.id_pais_iso2 is not null then
          select p.id_pais
            into l_id_pais
            from t_paises p
           where p.iso_alpha_2 = l_dispositivo.id_pais_iso2;
          k_sistema.p_definir_parametro_number(k_sistema.c_id_pais,
                                               l_id_pais);
        end if;
      exception
        when others then
          null;
      end;
    
      if l_dispositivo.zona_horaria is not null then
        k_sistema.p_definir_parametro_string(k_sistema.c_zona_horaria,
                                             l_dispositivo.zona_horaria);
      end if;
    
      declare
        l_id_idioma t_idiomas.id_idioma%type;
      begin
        if l_dispositivo.id_idioma_iso369_1 is not null then
          select i.id_idioma
            into l_id_idioma
            from t_idiomas i
           where i.iso_639_1 = l_dispositivo.id_idioma_iso369_1;
          k_sistema.p_definir_parametro_number(k_sistema.c_id_idioma,
                                               l_id_idioma);
        end if;
      exception
        when others then
          null;
      end;
    end if;
  
    -- Se agregan los valores nuevos del contexto.
    k_sistema.p_definir_parametro_string(k_sistema.cg_id_ejecucion,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_id_ejecucion));
  
    k_sistema.p_definir_parametro_string(k_sistema.cg_id_tracking,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_id_tracking));
  
    k_sistema.p_definir_parametro_string(k_sistema.cg_dispositivo_origen,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_dispositivo_origen));
  
    k_sistema.p_definir_parametro_string(k_sistema.cg_timestamp,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_timestamp));
  
    k_sistema.p_definir_parametro_string(k_sistema.cg_tipo_persona,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_tipo_persona));
  
    k_sistema.p_definir_parametro_string(k_sistema.cg_dato_usuario,
                                         f_valor_parametro_string(i_contexto,
                                                                  k_sistema.cg_dato_usuario));
    -- Inicializa permisos de la sesión
    k_autorizacion.p_inicializar_permisos;
  end;

  function f_operacion(i_id_operacion in number) return t_operaciones%rowtype is
    rw_operacion t_operaciones%rowtype;
  begin
    begin
      select a.*
        into rw_operacion
        from t_operaciones a
       where a.id_operacion = i_id_operacion;
    exception
      when no_data_found then
        rw_operacion := null;
      when others then
        rw_operacion := null;
    end;
    return rw_operacion;
  end;

  function f_id_operacion(i_tipo    in varchar2,
                          i_nombre  in varchar2,
                          i_dominio in varchar2) return number is
    l_id_operacion t_operaciones.id_operacion%type;
  begin
    begin
      select a.id_operacion
        into l_id_operacion
        from t_operaciones a
       where a.tipo = i_tipo
         and a.nombre = i_nombre
         and a.dominio = i_dominio;
    exception
      when no_data_found then
        l_id_operacion := null;
      when others then
        l_id_operacion := null;
    end;
    return l_id_operacion;
  end;

  function f_id_permiso(i_id_operacion in number) return varchar2 is
    l_id_permiso t_permisos.id_permiso%type;
  begin
    begin
      select p.id_permiso
        into l_id_permiso
        from t_permisos p, t_operaciones a
       where upper(p.id_permiso) =
             upper(k_significado.f_significado_codigo('TIPO_OPERACION',
                                                      a.tipo) || ':' ||
                   a.dominio || ':' || a.nombre)
         and a.id_operacion = i_id_operacion;
    exception
      when no_data_found then
        l_id_permiso := null;
      when others then
        l_id_permiso := null;
    end;
    return l_id_permiso;
  end;

  function f_id_modulo(i_id_operacion in number) return varchar2 is
    l_id_modulo t_modulos.id_modulo%type;
  begin
    begin
      select m.id_modulo
        into l_id_modulo
        from t_operaciones a, t_dominios d, t_modulos m
       where d.id_dominio = nvl(a.dominio, k_dominio.c_id_dominio_defecto)
         and m.id_modulo = d.id_modulo
         and a.id_operacion = i_id_operacion;
    exception
      when no_data_found then
        l_id_modulo := null;
      when others then
        l_id_modulo := null;
    end;
    return l_id_modulo;
  end;

  function f_validar_permiso_aplicacion(i_id_aplicacion in varchar2,
                                        i_id_operacion  in number)
    return boolean is
    l_permiso    varchar2(1);
    rw_operacion t_operaciones%rowtype;
  begin
    rw_operacion := f_operacion(i_id_operacion);
  
    select decode(nvl(count(*), 0), 0, 'N', 'S')
      into l_permiso
      from t_aplicaciones a
     where a.id_aplicacion = i_id_aplicacion
       and (rw_operacion.aplicaciones_permitidas is null or
           (rw_operacion.aplicaciones_permitidas is not null and
           upper(a.id_aplicacion) in
           (select upper(trim(column_value))
                from k_cadena.f_separar_cadenas(rw_operacion.aplicaciones_permitidas,
                                                ','))));
  
    return k_util.string_to_bool(l_permiso);
  exception
    when others then
      return false;
  end;

  function f_procesar_parametros(i_id_operacion in number,
                                 i_parametros   in clob,
                                 i_version      in varchar2 default null)
    return y_parametros is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new y_lista_parametros(i_parametros,
                                                 i_id_operacion,
                                                 i_version,
                                                 null,
                                                 null);
    return l_lista_parametros.parametros;
  end;

  function f_nombre_programa(i_id_operacion in number,
                             i_version      in varchar2 default null)
    return varchar2 is
    l_nombre_programa                varchar2(4000);
    l_tipo_operacion                 t_operaciones.tipo%type;
    l_nombre_operacion               t_operaciones.nombre%type;
    l_dominio_operacion              t_operaciones.dominio%type;
    l_version_actual                 t_operaciones.version_actual%type;
    l_tipo_implementacion            t_operaciones.tipo_implementacion%type;
    l_nombre_programa_implementacion t_operaciones.nombre_programa_implementacion%type;
  begin
  
    begin
      select o.tipo,
             upper(o.nombre),
             upper(o.dominio),
             o.version_actual,
             nvl(o.tipo_implementacion, c_tipo_implementacion_paquete),
             o.nombre_programa_implementacion
        into l_tipo_operacion,
             l_nombre_operacion,
             l_dominio_operacion,
             l_version_actual,
             l_tipo_implementacion,
             l_nombre_programa_implementacion
        from t_operaciones o
       where o.id_operacion = i_id_operacion;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Operación inexistente');
    end;
  
    if l_nombre_programa_implementacion is not null then
      l_nombre_programa := l_nombre_programa_implementacion;
    else
      if l_tipo_implementacion in
         (c_tipo_implementacion_paquete, c_tipo_implementacion_funcion) then
        l_nombre_programa := k_significado.f_referencia_codigo('TIPO_IMPLEMENTACION',
                                                               l_tipo_implementacion) || '_' ||
                             k_significado.f_significado_codigo('TIPO_OPERACION',
                                                                l_tipo_operacion) || '_' ||
                             l_dominio_operacion ||
                             case l_tipo_implementacion
                               when c_tipo_implementacion_paquete then
                                '.'
                               else
                                '_'
                             end || l_nombre_operacion;
      elsif l_tipo_implementacion = c_tipo_implementacion_bloque then
        l_nombre_programa := l_nombre_operacion;
      end if;
    end if;
  
    if nvl(i_version, l_version_actual) <> l_version_actual then
      l_nombre_programa := l_nombre_programa || '_' ||
                           replace(i_version, '.', '_');
    end if;
  
    return l_nombre_programa;
  end;

  function f_tipo_argumento_parametros(i_id_operacion in number,
                                       i_version      in varchar2 default null)
    return varchar2 is
    l_tipo_argumento_parametros varchar2(4000);
  begin
    begin
      select arg.type_name
        into l_tipo_argumento_parametros
        from all_arguments arg
       where upper(f_nombre_programa(i_id_operacion, i_version)) in
             (arg.object_name, arg.package_name || '.' || arg.object_name)
         and arg.in_out = 'IN'
         and arg.argument_name like '%I%PARAMETROS%';
    exception
      when others then
        l_tipo_argumento_parametros := null;
    end;
  
    return l_tipo_argumento_parametros;
  end;

  function f_filtros_sql(i_parametros      in y_parametros,
                         i_nombres_excluir in y_cadenas default null)
    return clob is
    l_filtros_sql     clob;
    i                 integer;
    l_typeinfo        anytype;
    l_typecode        pls_integer;
    l_seen_one        boolean := false;
    l_existe          varchar2(1);
    l_nombres_excluir y_cadenas;
  begin
    if i_parametros is not null then
    
      if i_nombres_excluir is not null then
        l_nombres_excluir := i_nombres_excluir;
      else
        l_nombres_excluir := new y_cadenas();
      end if;
    
      -- Carga la lista de nombres a excluir
      select x.nombre
        bulk collect
        into l_nombres_excluir
        from (select lower(p.nombre) nombre
                from t_operacion_parametros p
               where p.id_operacion = c_id_ope_par_automaticos
              union
              select lower(column_value)
                from table(l_nombres_excluir)) x;
    
      i := i_parametros.first;
      while i is not null loop
      
        -- Busca si existe en la lista de nombres a excluir
        begin
          select 'S'
            into l_existe
            from table(l_nombres_excluir)
           where lower(column_value) = lower(i_parametros(i).nombre);
        exception
          when no_data_found then
            l_existe := 'N';
          when too_many_rows then
            l_existe := 'S';
        end;
      
        -- Sólo si no existe en la lista de nombres a excluir
        if l_existe = 'N' then
          if i_parametros(i).valor is not null then
            l_typecode := i_parametros(i).valor.gettype(l_typeinfo);
          
            if l_typecode = dbms_types.typecode_varchar2 then
              if anydata.accessvarchar2(i_parametros(i).valor) is not null then
                l_filtros_sql := l_filtros_sql || case l_seen_one
                                   when true then
                                    ' AND '
                                   else
                                    ' WHERE '
                                 end || i_parametros(i).nombre || ' = ' ||
                                 dbms_assert.enquote_literal('''' ||
                                                             replace(anydata.accessvarchar2(i_parametros(i).valor),
                                                                     '''',
                                                                     '''''') || '''');
                l_seen_one    := true;
              end if;
            elsif l_typecode = dbms_types.typecode_number then
              if anydata.accessnumber(i_parametros(i).valor) is not null then
                l_filtros_sql := l_filtros_sql || case l_seen_one
                                   when true then
                                    ' AND '
                                   else
                                    ' WHERE '
                                 end || 'to_char(' || i_parametros(i).nombre ||
                                 ', ''TM'', ''NLS_NUMERIC_CHARACTERS = ''''.,'''''') = ' ||
                                 dbms_assert.enquote_literal('''' ||
                                                             to_char(anydata.accessnumber(i_parametros(i).valor),
                                                                     'TM',
                                                                     'NLS_NUMERIC_CHARACTERS = ''.,''') || '''');
                l_seen_one    := true;
              end if;
            elsif l_typecode = dbms_types.typecode_date then
              if anydata.accessdate(i_parametros(i).valor) is not null then
                l_filtros_sql := l_filtros_sql || case l_seen_one
                                   when true then
                                    ' AND '
                                   else
                                    ' WHERE '
                                 end || 'to_char(' || i_parametros(i).nombre ||
                                 ', ''YYYY-MM-DD'') = ' ||
                                 dbms_assert.enquote_literal('''' ||
                                                             to_char(anydata.accessdate(i_parametros(i).valor),
                                                                     'YYYY-MM-DD') || '''');
                l_seen_one    := true;
              end if;
            else
              raise_application_error(-20000,
                                      k_error.f_mensaje_error('ora0002',
                                                              'filtro',
                                                              i_parametros(i).nombre));
            end if;
          end if;
        end if;
      
        i := i_parametros.next(i);
      end loop;
    end if;
  
    return l_filtros_sql;
  exception
    when value_error then
      raise_application_error(-20000, k_error.f_mensaje_error('ora0001'));
  end;

  function f_filtros_sql_dinamico(i_parametros      in y_parametros,
                                  i_consulta_sql    in clob default null,
                                  i_nombres_excluir in y_cadenas default null)
    return clob is
    -- l_resultado           clob;
    l_filtros_sql         clob := '';
    l_consulta_modificada clob;
    l_seen_one            boolean := false;
    l_nombres_excluir     y_cadenas;
    l_parametros_usados   y_cadenas := new y_cadenas();
    c_id_ope_par_automaticos constant pls_integer := 1000;
  
    -- Función auxiliar para verificar si un parámetro debe ser excluido
    function f_debe_excluir(p_nombre in varchar2) return boolean is
      l_existe varchar2(1);
    begin
      begin
        select 'S'
          into l_existe
          from table(l_nombres_excluir)
         where lower(column_value) = lower(p_nombre);
        return true;
      exception
        when no_data_found then
          return false;
      end;
    end f_debe_excluir;
  
    -- Función auxiliar para procesar el valor de un parámetro
    function f_procesar_valor(p_valor in anydata) return varchar2 is
      l_typecode pls_integer;
      l_typeinfo anytype;
    begin
      l_typecode := p_valor.gettype(l_typeinfo);
    
      if l_typecode = dbms_types.typecode_varchar2 then
        return '''' || replace(anydata.accessvarchar2(p_valor),
                               '''',
                               '''''') || '''';
      elsif l_typecode = dbms_types.typecode_number then
        return to_char(anydata.accessnumber(p_valor),
                       'TM',
                       'NLS_NUMERIC_CHARACTERS = ''.,''');
      elsif l_typecode = dbms_types.typecode_date then
        return 'DATE ''' || to_char(anydata.accessdate(p_valor),
                                    'YYYY-MM-DD') || '''';
      else
        raise_application_error(-20000,
                                k_error.f_mensaje_error('ora0002',
                                                        'tipo de parámetro',
                                                        'no soportado'));
      end if;
    end f_procesar_valor;
  
  begin
    if i_parametros is null then
      return '';
    end if;
  
    -- Inicializar lista de exclusiones
    if i_nombres_excluir is not null then
      l_nombres_excluir := i_nombres_excluir;
    else
      l_nombres_excluir := new y_cadenas();
    end if;
  
    -- Cargar lista de nombres a excluir (parámetros automáticos)
    select x.nombre
      bulk collect
      into l_nombres_excluir
      from (select lower(p.nombre) nombre
              from t_operacion_parametros p
             where p.id_operacion = c_id_ope_par_automaticos
            union
            select lower(column_value)
              from table(l_nombres_excluir)) x;
  
    -- Inicializar consulta modificada si se proporcionó SQL
    if i_consulta_sql is not null then
      l_consulta_modificada := i_consulta_sql;
    end if;
  
    -- Procesar todos los parámetros
    for i in 1 .. i_parametros.count loop
      if i_parametros(i)
       .nombre is not null and not f_debe_excluir(i_parametros(i).nombre) then
        -- Verificar si es un parámetro dinámico en la consulta SQL
        if i_consulta_sql is not null and
           instr(upper(i_consulta_sql),
                 ':' || upper(i_parametros(i).nombre)) > 0 then
        
          -- Marcar parámetro como usado
          l_parametros_usados.extend;
          l_parametros_usados(l_parametros_usados.count) := lower(i_parametros(i).nombre);
        
          -- Reemplazar en la consulta SQL
          if i_parametros(i).valor is not null then
            l_consulta_modificada := replace(l_consulta_modificada,
                                             ':' || i_parametros(i).nombre,
                                             f_procesar_valor(i_parametros(i).valor));
          else
            l_consulta_modificada := replace(l_consulta_modificada,
                                             ':' || i_parametros(i).nombre,
                                             'NULL');
          end if;
        else
          -- Si no es parámetro dinámico o no hay consulta SQL, agregar a filtros WHERE
          if i_parametros(i).valor is not null then
            l_filtros_sql := l_filtros_sql || case
                               when l_seen_one then
                                ' AND '
                               else
                                ' WHERE '
                             end || i_parametros(i).nombre || ' = ' ||
                             f_procesar_valor(i_parametros(i).valor);
            l_seen_one    := true;
          end if;
        end if;
      end if;
    end loop;
  
    -- Validar parámetros dinámicos no reemplazados
    if i_consulta_sql is not null then
      if regexp_count(l_consulta_modificada, ':[A-Za-z_][A-Za-z0-9_]*') > 0 then
        raise_application_error(-20001,
                                'Existen parámetros dinámicos sin reemplazar en la consulta');
      end if;
    
      -- Si había parámetros dinámicos, devolver la consulta modificada
      if l_parametros_usados.count > 0 then
        return l_consulta_modificada;
      end if;
    end if;
  
    -- Devolver los filtros WHERE construidos
    return l_filtros_sql;
  exception
    when value_error then
      raise_application_error(-20000, k_error.f_mensaje_error('ora0001'));
  end;

  function f_valor_parametro(i_parametros in y_parametros,
                             i_nombre     in varchar2) return anydata is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro(i_nombre);
  end;

  function f_valor_parametro_string(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return varchar2 is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_string(i_nombre);
  end;

  function f_valor_parametro_number(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return number is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_number(i_nombre);
  end;

  function f_valor_parametro_boolean(i_parametros in y_parametros,
                                     i_nombre     in varchar2) return boolean is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_boolean(i_nombre);
  end;

  function f_valor_parametro_date(i_parametros in y_parametros,
                                  i_nombre     in varchar2) return date is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_date(i_nombre);
  end;

  function f_valor_parametro_object(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return y_objeto is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_object(i_nombre);
  end;

  function f_valor_parametro_json_object(i_parametros in y_parametros,
                                         i_nombre     in varchar2)
    return json_object_t is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_json_object(i_nombre);
  end;

  function f_valor_parametro_json_array(i_parametros in y_parametros,
                                        i_nombre     in varchar2)
    return json_array_t is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new
                          y_lista_parametros(i_parametros => i_parametros);
    return l_lista_parametros.f_valor_parametro_json_array(i_nombre);
  end;

end;
/

