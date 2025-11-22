create or replace package body k_operacion is

  procedure p_inicializar_log(i_id_operacion in number) is
    l_nivel_log t_operaciones.nivel_log%type;
  begin
    begin
      select nivel_log
        into l_nivel_log
        from t_operaciones
       where id_operacion = i_id_operacion;
    exception
      when others then
        l_nivel_log := 0;
    end;
  
    if l_nivel_log > 0 then
      k_sistema.p_definir_parametro_number(c_id_log,
                                           s_id_operacion_log.nextval);
      k_sistema.p_definir_parametro_string(c_fecha_hora_inicio_log,
                                           to_char(current_timestamp,
                                                   'YYYY-MM-DD HH24:MI:SS.FF'));
    end if;
  exception
    when others then
      null;
  end;

  procedure p_registrar_log(i_id_operacion     in number,
                            i_parametros       in clob,
                            i_codigo_respuesta in varchar2,
                            i_respuesta        in clob,
                            i_contexto         in clob default null,
                            i_version          in varchar2 default null) is
    pragma autonomous_transaction;
    l_nivel_log         t_operaciones.nivel_log%type;
    l_fecha_hora_inicio t_operacion_logs.fecha_hora_inicio%type;
  begin
    begin
      select nivel_log
        into l_nivel_log
        from t_operaciones
       where id_operacion = i_id_operacion;
    exception
      when others then
        l_nivel_log := 0;
    end;
  
    if (l_nivel_log > 1 and i_codigo_respuesta = c_ok) or
       (l_nivel_log > 0 and i_codigo_respuesta <> c_ok) then
      l_fecha_hora_inicio := nvl(to_timestamp(k_sistema.f_valor_parametro_string(c_fecha_hora_inicio_log),
                                              'YYYY-MM-DD HH24:MI:SS.FF'),
                                 current_timestamp);
      insert into t_operacion_logs
        (id_operacion_log,
         id_operacion,
         contexto,
         version,
         parametros,
         respuesta,
         fecha_hora_inicio,
         fecha_hora_fin,
         duracion)
      values
        (k_sistema.f_valor_parametro_number(c_id_log),
         i_id_operacion,
         i_contexto,
         substr(i_version, 1, 100),
         i_parametros,
         i_respuesta,
         l_fecha_hora_inicio,
         current_timestamp,
         current_timestamp - l_fecha_hora_inicio);
    end if;
  
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_respuesta_ok(io_respuesta in out nocopy y_respuesta,
                           i_datos      in y_objeto default null) is
  begin
    io_respuesta.codigo     := c_ok;
    io_respuesta.mensaje    := 'OK';
    io_respuesta.mensaje_bd := null;
    io_respuesta.lugar      := null;
    io_respuesta.datos      := i_datos;
  end;

  procedure p_respuesta_error(io_respuesta in out nocopy y_respuesta,
                              i_codigo     in varchar2,
                              i_mensaje    in varchar2 default null,
                              i_mensaje_bd in varchar2 default null,
                              i_datos      in y_objeto default null) is
    l_mensaje varchar2(32767) := substr(i_mensaje, 1, 32767);
  begin
    if i_codigo = c_ok then
      io_respuesta.codigo := c_error_general;
    else
      io_respuesta.codigo := substr(i_codigo, 1, 10);
    end if;
    io_respuesta.mensaje    := substr(k_error.f_mensaje_excepcion(nvl(l_mensaje,
                                                                      k_error.f_mensaje_error(i_codigo))),
                                      1,
                                      4000);
    io_respuesta.mensaje_bd := substr(i_mensaje_bd, 1, 4000);
    io_respuesta.datos      := i_datos;
  end;

  procedure p_respuesta_excepcion(io_respuesta   in out nocopy y_respuesta,
                                  i_error_number in number,
                                  i_error_msg    in varchar2,
                                  i_error_stack  in varchar2) is
  begin
    if k_error.f_tipo_excepcion(i_error_number) =
       k_error.c_user_defined_error then
      p_respuesta_error(io_respuesta,
                        c_error_general,
                        i_error_msg,
                        i_error_stack);
    elsif k_error.f_tipo_excepcion(i_error_number) =
          k_error.c_oracle_predefined_error then
      p_respuesta_error(io_respuesta,
                        c_error_inesperado,
                        k_error.f_mensaje_error(c_error_inesperado,
                                                to_char(nvl(k_sistema.f_valor_parametro_number(c_id_log),
                                                            0))),
                        i_error_stack);
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
    k_sistema.p_definir_parametro_string(k_sistema.c_direccion_ip,
                                         k_operacion.f_valor_parametro_string(i_contexto,
                                                                              'direccion_ip'));
    k_sistema.p_definir_parametro_string(k_sistema.c_id_aplicacion,
                                         k_aplicacion.f_id_aplicacion(k_operacion.f_valor_parametro_string(i_contexto,
                                                                                                           'clave_aplicacion')));
    k_sistema.p_definir_parametro_string(k_sistema.c_usuario,
                                         k_operacion.f_valor_parametro_string(i_contexto,
                                                                              'usuario'));
    k_sistema.p_definir_parametro_number(k_sistema.c_id_usuario,
                                         k_usuario.f_id_usuario(k_operacion.f_valor_parametro_string(i_contexto,
                                                                                                     'usuario')));
    --
    l_id_sesion := k_sesion.f_id_sesion(k_operacion.f_valor_parametro_string(i_contexto,
                                                                             'access_token'));
    k_sistema.p_definir_parametro_number(k_sistema.c_id_sesion,
                                         l_id_sesion);
    --
    l_id_dispositivo := k_dispositivo.f_id_dispositivo(k_operacion.f_valor_parametro_string(i_contexto,
                                                                                            'token_dispositivo'));
  
    if l_id_dispositivo is null and l_id_sesion is not null then
      l_id_dispositivo := k_sesion.f_dispositivo_sesion(l_id_sesion);
    end if;
  
    k_sistema.p_definir_parametro_number(k_sistema.c_id_dispositivo,
                                         l_id_dispositivo);
  
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
       where d.id_dominio = nvl(a.dominio, 'API')
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
    l_parametros   y_parametros;
    l_parametro    y_parametro;
    l_json_object  json_object_t;
    l_json_element json_element_t;
  
    cursor cr_parametros is
      select op.id_operacion,
             lower(op.nombre) nombre,
             op.orden,
             op.activo,
             op.tipo_dato,
             op.formato,
             op.longitud_maxima,
             op.obligatorio,
             op.valor_defecto,
             op.etiqueta,
             op.detalle,
             op.valores_posibles,
             op.encriptado
        from t_operacion_parametros op, t_operaciones o
       where o.id_operacion = op.id_operacion
         and op.activo = 'S'
         and op.id_operacion = i_id_operacion
         and op.version = nvl(i_version, o.version_actual)
      union
      -- Parámetros automáticos
      select op.id_operacion,
             lower(op.nombre) nombre,
             op.orden,
             op.activo,
             op.tipo_dato,
             op.formato,
             op.longitud_maxima,
             op.obligatorio,
             op.valor_defecto,
             op.etiqueta,
             op.detalle,
             op.valores_posibles,
             op.encriptado
        from t_operacion_parametros op
       where op.activo = 'S'
         and op.id_operacion = c_id_ope_par_automaticos
         and exists (select 1
                from t_operaciones o
               where lower(op.nombre) in
                     (select lower(trim(column_value))
                        from k_cadena.f_separar_cadenas(o.parametros_automaticos,
                                                        ','))
                 and o.id_operacion = i_id_operacion)
       order by orden;
  begin
    -- Inicializa respuesta
    l_parametros := new y_parametros();
  
    if i_parametros is null or dbms_lob.getlength(i_parametros) = 0 then
      l_json_object := json_object_t.parse('{}');
    else
      l_json_object := json_object_t.parse(i_parametros);
    end if;
  
    for par in cr_parametros loop
      l_parametro        := new y_parametro();
      l_parametro.nombre := par.nombre;
    
      l_json_element := l_json_object.get(par.nombre);
    
      if par.obligatorio = 'S' then
        if not l_json_object.has(par.nombre) then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0003',
                                                          nvl(par.etiqueta,
                                                              par.nombre)));
        else
          if l_json_element.is_null then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        end if;
      end if;
    
      case par.tipo_dato
      
        when 'S' then
          -- String
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_string then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if par.encriptado = 'S' then
            begin
              l_parametro.valor := anydata.convertvarchar2(k_util.decrypt(l_json_object.get_string(par.nombre)));
            exception
              when value_error then
                raise_application_error(-20000,
                                        k_error.f_mensaje_error('ora0008',
                                                                nvl(par.etiqueta,
                                                                    par.nombre)));
              when others then
                raise_application_error(-20000,
                                        k_error.f_mensaje_error('ora0009',
                                                                nvl(par.etiqueta,
                                                                    par.nombre)));
            end;
          else
            l_parametro.valor := anydata.convertvarchar2(l_json_object.get_string(par.nombre));
          end if;
          if l_parametro.valor.accessvarchar2 is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertvarchar2(par.valor_defecto);
          end if;
          if l_parametro.valor.accessvarchar2 is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
          if par.longitud_maxima is not null and
             nvl(length(l_parametro.valor.accessvarchar2), 0) >
             par.longitud_maxima then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0006',
                                                            nvl(par.etiqueta,
                                                                par.nombre),
                                                            to_char(par.longitud_maxima)));
          end if;
          if par.valores_posibles is not null and
             l_parametro.valor.accessvarchar2 is not null and not
              k_significado.f_existe_codigo(par.valores_posibles,
                                                                                             l_parametro.valor.accessvarchar2) then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0007',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'N' then
          -- Number
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_number then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertnumber(l_json_object.get_number(par.nombre));
          if l_parametro.valor.accessnumber is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertnumber(to_number(par.valor_defecto));
          end if;
          if l_parametro.valor.accessnumber is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
          if par.longitud_maxima is not null and
             nvl(length(to_char(abs(trunc(l_parametro.valor.accessnumber)))),
                 0) > par.longitud_maxima then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0006',
                                                            nvl(par.etiqueta,
                                                                par.nombre),
                                                            to_char(par.longitud_maxima)));
          end if;
          if par.valores_posibles is not null and
             l_parametro.valor.accessnumber is not null and not
              k_significado.f_existe_codigo(par.valores_posibles,
                                                                                           to_char(l_parametro.valor.accessnumber)) then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0007',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'B' then
          -- Boolean
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_boolean then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertnumber(sys.diutil.bool_to_int(l_json_object.get_boolean(par.nombre)));
          if l_parametro.valor.accessnumber is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertnumber(to_number(par.valor_defecto));
          end if;
          if l_parametro.valor.accessnumber is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'D' then
          -- Date
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_string /*l_json_element.is_date*/
           then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertdate(l_json_object.get_date(par.nombre));
          if l_parametro.valor.accessdate is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertdate(to_date(par.valor_defecto,
                                                             par.formato));
          end if;
          if l_parametro.valor.accessdate is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'O' then
          -- Object
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_object then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if l_json_element is not null and l_json_element.is_object then
            l_parametro.valor := k_util.json_to_objeto(l_json_element.to_clob,
                                                       par.formato);
          end if;
        
          if l_parametro.valor is null and par.valor_defecto is not null then
            l_parametro.valor := k_util.json_to_objeto(par.valor_defecto,
                                                       par.formato);
          end if;
          if l_parametro.valor is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        else
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0002',
                                                          'parámetro',
                                                          nvl(par.etiqueta,
                                                              par.nombre)));
        
      end case;
    
      l_parametros.extend;
      l_parametros(l_parametros.count) := l_parametro;
    end loop;
    return l_parametros;
  end;

  function f_nombre_programa(i_id_operacion in number,
                             i_version      in varchar2 default null)
    return varchar2 is
    l_nombre_programa     varchar2(4000);
    l_tipo_operacion      t_operaciones.tipo%type;
    l_nombre_operacion    t_operaciones.nombre%type;
    l_dominio_operacion   t_operaciones.dominio%type;
    l_version_actual      t_operaciones.version_actual%type;
    l_tipo_implementacion t_operaciones.tipo_implementacion%type;
  begin
  
    begin
      select o.tipo,
             upper(o.nombre),
             upper(o.dominio),
             o.version_actual,
             nvl(o.tipo_implementacion, c_tipo_implementacion_paquete)
        into l_tipo_operacion,
             l_nombre_operacion,
             l_dominio_operacion,
             l_version_actual,
             l_tipo_implementacion
        from t_operaciones o
       where o.id_operacion = i_id_operacion;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Operación inexistente');
    end;
  
    if l_tipo_implementacion in
       (k_operacion.c_tipo_implementacion_paquete,
        k_operacion.c_tipo_implementacion_funcion) then
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
    elsif l_tipo_implementacion = k_operacion.c_tipo_implementacion_bloque then
      l_nombre_programa := l_nombre_operacion;
    end if;
  
    if nvl(i_version, l_version_actual) <> l_version_actual then
      l_nombre_programa := l_nombre_programa || '_' ||
                           replace(i_version, '.', '_');
    end if;
  
    return l_nombre_programa;
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

  function f_valor_parametro(i_parametros in y_parametros,
                             i_nombre     in varchar2) return anydata is
    l_valor anydata;
    i       integer;
  begin
    if i_parametros is not null then
      -- Busca el parámetro en la lista
      i := i_parametros.first;
      while i is not null and l_valor is null loop
        if lower(i_parametros(i).nombre) = lower(i_nombre) then
          l_valor := i_parametros(i).valor;
        end if;
        i := i_parametros.next(i);
      end loop;
    end if;
  
    -- Si el parámetro no se encuentra en la lista carga un valor nulo de tipo
    -- VARCHAR2 para evitar el error ORA-30625 al acceder al valor a través de
    -- AnyData.Access*
    if l_valor is null then
      l_valor := anydata.convertvarchar2(null);
    end if;
  
    return l_valor;
  end;

  function f_valor_parametro_string(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return varchar2 is
  begin
    return anydata.accessvarchar2(f_valor_parametro(i_parametros, i_nombre));
  end;

  function f_valor_parametro_number(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return number is
  begin
    return anydata.accessnumber(f_valor_parametro(i_parametros, i_nombre));
  end;

  function f_valor_parametro_boolean(i_parametros in y_parametros,
                                     i_nombre     in varchar2) return boolean is
  begin
    return sys.diutil.int_to_bool(anydata.accessnumber(f_valor_parametro(i_parametros,
                                                                         i_nombre)));
  end;

  function f_valor_parametro_date(i_parametros in y_parametros,
                                  i_nombre     in varchar2) return date is
  begin
    return anydata.accessdate(f_valor_parametro(i_parametros, i_nombre));
  end;

  function f_valor_parametro_object(i_parametros in y_parametros,
                                    i_nombre     in varchar2) return y_objeto is
    l_objeto   y_objeto;
    l_anydata  anydata;
    l_result   pls_integer;
    l_typeinfo anytype;
    l_typecode pls_integer;
  begin
    l_anydata := f_valor_parametro(i_parametros, i_nombre);
  
    l_typecode := l_anydata.gettype(l_typeinfo);
    if l_typecode = dbms_types.typecode_object then
      l_result := l_anydata.getobject(l_objeto);
    end if;
  
    return l_objeto;
  end;

  function f_inserts_operacion(i_operacion in t_operaciones%rowtype)
    return clob is
    l_inserts clob;
    l_insert  clob;
  
    procedure lp_comentar(i_comentario in varchar2) is
    begin
      l_inserts := l_inserts || '/* ' || lpad('=', 20, '=') || ' ' ||
                   upper(i_comentario) || ' ' || lpad('=', 20, '=') ||
                   ' */' || utl_tcp.crlf;
    end;
  begin
    lp_comentar('T_OPERACIONES');
    l_insert  := fn_gen_inserts('SELECT * FROM t_operaciones WHERE id_operacion = ' ||
                                to_char(i_operacion.id_operacion),
                                't_operaciones');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_OPERACION_PARAMETROS');
    l_insert  := fn_gen_inserts('SELECT * FROM t_operacion_parametros WHERE id_operacion = ' ||
                                to_char(i_operacion.id_operacion) ||
                                ' ORDER BY version, orden',
                                't_operacion_parametros');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_SERVICIOS');
    l_insert  := fn_gen_inserts('SELECT id_servicio, tipo, consulta_sql FROM t_servicios WHERE id_servicio = ' ||
                                to_char(i_operacion.id_operacion),
                                't_servicios');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_REPORTES');
    l_insert  := fn_gen_inserts('SELECT id_reporte, tipo, consulta_sql FROM t_reportes WHERE id_reporte = ' ||
                                to_char(i_operacion.id_operacion),
                                't_reportes');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_TRABAJOS');
    l_insert  := fn_gen_inserts('SELECT id_trabajo, tipo, accion, fecha_inicio, tiempo_inicio, intervalo_repeticion, fecha_fin, comentarios FROM t_trabajos WHERE id_trabajo = ' ||
                                to_char(i_operacion.id_operacion),
                                't_trabajos');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_MONITOREOS');
    l_insert  := fn_gen_inserts('SELECT id_monitoreo, causa, consulta_sql, plan_accion, prioridad, id_rol_responsable, id_usuario_responsable, nivel_aviso, frecuencia, comentarios FROM t_monitoreos WHERE id_monitoreo = ' ||
                                to_char(i_operacion.id_operacion),
                                't_monitoreos');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_IMPORTACIONES');
    l_insert  := fn_gen_inserts('SELECT id_importacion, separador_campos, delimitador_campo, linea_inicial, nombre_tabla, truncar_tabla, proceso_previo, proceso_posterior FROM t_importaciones WHERE id_importacion = ' ||
                                to_char(i_operacion.id_operacion),
                                't_importaciones');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_IMPORTACION_PARAMETROS');
    l_insert  := fn_gen_inserts('SELECT a.id_importacion, a.nombre, a.version, a.posicion_inicial, a.longitud, a.posicion_decimal, a.mapeador FROM t_importacion_parametros a, t_operacion_parametros b WHERE a.id_importacion = ' ||
                                to_char(i_operacion.id_operacion) ||
                                ' AND b.id_operacion=a.id_importacion AND b.nombre=a.nombre AND b.version=a.version ORDER BY b.version, b.orden',
                                't_importacion_parametros');
    l_inserts := l_inserts || l_insert;
    --
    lp_comentar('T_ROL_PERMISOS');
    l_insert  := fn_gen_inserts('SELECT * FROM t_rol_permisos WHERE id_permiso = k_operacion.f_id_permiso(' ||
                                to_char(i_operacion.id_operacion) ||
                                ') ORDER BY id_rol',
                                't_rol_permisos');
    l_inserts := l_inserts || l_insert;
    --
    if i_operacion.tipo_implementacion = c_tipo_implementacion_funcion then
      lp_comentar('FUNCTION');
      l_insert  := dbms_metadata.get_ddl('FUNCTION',
                                         upper(f_nombre_programa(i_operacion.id_operacion)));
      l_insert  := trim(utl_tcp.crlf from l_insert);
      l_insert  := trim(' ' from l_insert);
      l_insert  := l_insert || utl_tcp.crlf || '/';
      l_inserts := l_inserts || l_insert;
    end if;
  
    return l_inserts;
  end;

  function f_inserts_operacion(i_id_operacion in number) return clob is
  begin
    return f_inserts_operacion(f_operacion(i_id_operacion));
  end;

  function f_inserts_operacion(i_tipo    in varchar2,
                               i_nombre  in varchar2,
                               i_dominio in varchar2) return clob is
  begin
    return f_inserts_operacion(f_id_operacion(i_tipo, i_nombre, i_dominio));
  end;

  function f_deletes_operacion(i_operacion in t_operaciones%rowtype)
    return clob is
    l_deletes clob;
  
    procedure lp_comentar(i_comentario in varchar2) is
    begin
      l_deletes := l_deletes || '/* ' || lpad('=', 20, '=') || ' ' ||
                   upper(i_comentario) || ' ' || lpad('=', 20, '=') ||
                   ' */' || utl_tcp.crlf;
    end;
  begin
    lp_comentar('ID_OPERACION = ' || to_char(i_operacion.id_operacion));
    --
    l_deletes := l_deletes ||
                 'DELETE t_rol_permisos WHERE id_permiso = k_operacion.f_id_permiso(' ||
                 to_char(i_operacion.id_operacion) || ');' || utl_tcp.crlf;
    l_deletes := l_deletes ||
                 'DELETE t_importacion_parametros WHERE id_operacion = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes ||
                 'DELETE t_importaciones WHERE id_importacion = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes || 'DELETE t_monitoreos WHERE id_monitoreo = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes || 'DELETE t_trabajos WHERE id_trabajo = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes || 'DELETE t_reportes WHERE id_reporte = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes || 'DELETE t_servicios WHERE id_servicio = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes ||
                 'DELETE t_operacion_parametros WHERE id_operacion = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    l_deletes := l_deletes || 'DELETE t_operaciones WHERE id_operacion = ' ||
                 to_char(i_operacion.id_operacion) || ';' || utl_tcp.crlf;
    --
    if i_operacion.tipo_implementacion = c_tipo_implementacion_funcion then
      l_deletes := l_deletes || 'DROP FUNCTION ' ||
                   lower(f_nombre_programa(i_operacion.id_operacion)) || ';' ||
                   utl_tcp.crlf;
    end if;
  
    return l_deletes;
  end;

  function f_deletes_operacion(i_id_operacion in number) return clob is
  begin
    return f_deletes_operacion(f_operacion(i_id_operacion));
  end;

  function f_deletes_operacion(i_tipo    in varchar2,
                               i_nombre  in varchar2,
                               i_dominio in varchar2) return clob is
  begin
    return f_deletes_operacion(f_id_operacion(i_tipo, i_nombre, i_dominio));
  end;

  function f_scripts_operaciones(i_id_modulo in varchar2 default null)
    return blob is
    l_zip       blob;
    l_inserts   clob;
    l_deletes   clob;
    l_install   clob;
    l_uninstall clob;
  
    cursor c_modulos is
      select m.id_modulo
        from t_modulos m
       where m.id_modulo = nvl(i_id_modulo, m.id_modulo);
  
    cursor c_operaciones(i_id_modulo in varchar2) is
      select a.id_operacion,
             lower(f_id_modulo(a.id_operacion)) id_modulo,
             lower(k_cadena.f_reemplazar_acentos(k_significado.f_significado_codigo('TIPO_OPERACION',
                                                                                    a.tipo) || '/' ||
                                                 nvl(a.dominio, '_') || '/' ||
                                                 a.nombre)) || '.sql' nombre_archivo
        from t_operaciones a
       where f_id_modulo(a.id_operacion) = i_id_modulo
       order by 3;
  begin
    for m in c_modulos loop
      l_install := '';
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      l_install := l_install || 'prompt Instalando operaciones...' ||
                   utl_tcp.crlf;
      l_install := l_install ||
                   'prompt -----------------------------------' ||
                   utl_tcp.crlf;
      l_install := l_install || 'prompt' || utl_tcp.crlf;
      --
      l_uninstall := '';
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt Desinstalando operaciones...' ||
                     utl_tcp.crlf;
      l_uninstall := l_uninstall ||
                     'prompt -----------------------------------' ||
                     utl_tcp.crlf;
      l_uninstall := l_uninstall || 'prompt' || utl_tcp.crlf;
    
      for ope in c_operaciones(m.id_modulo) loop
        l_inserts := f_inserts_operacion(ope.id_operacion);
        l_deletes := f_deletes_operacion(ope.id_operacion);
        --
        l_install   := l_install || '@@scripts/operations/' ||
                       ope.nombre_archivo || utl_tcp.crlf;
        l_uninstall := l_uninstall || l_deletes || utl_tcp.crlf;
        --
        as_zip.add1file(l_zip,
                        ope.id_modulo || '/' || ope.nombre_archivo,
                        k_util.clob_to_blob(l_inserts));
      end loop;
    
      as_zip.add1file(l_zip,
                      lower(m.id_modulo) || '/' || 'install.sql',
                      k_util.clob_to_blob(l_install));
      as_zip.add1file(l_zip,
                      lower(m.id_modulo) || '/' || 'uninstall.sql',
                      k_util.clob_to_blob(l_uninstall));
    end loop;
  
    if l_zip is not null and dbms_lob.getlength(l_zip) > 0 then
      as_zip.finish_zip(l_zip);
    end if;
  
    return l_zip;
  end;

end;
/
