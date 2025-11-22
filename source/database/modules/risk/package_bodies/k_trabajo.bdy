create or replace package body k_trabajo is

  -- Crea un trabajo en el sistema
  procedure p_crear_trabajo(i_id_trabajo           in number,
                            i_parametros           in clob default null,
                            i_fecha_inicio         in timestamp with time zone default null,
                            i_intervalo_repeticion in varchar2 default null,
                            i_fecha_fin            in timestamp with time zone default null) is
    l_prms y_parametros;
    --
    l_tipo_trabajo         t_trabajos.tipo%type;
    l_nombre_trabajo       t_operaciones.nombre%type;
    l_nombre_programa      t_operaciones.nombre%type;
    l_dominio_trabajo      t_operaciones.dominio%type;
    l_accion_trabajo       t_trabajos.accion%type;
    l_fecha_inicio         t_trabajos.fecha_inicio%type;
    l_intervalo_repeticion t_trabajos.intervalo_repeticion%type;
    l_fecha_fin            t_trabajos.fecha_fin%type;
    l_comentarios          t_trabajos.comentarios%type;
  begin
    -- Buscar datos del trabajo
    begin
      select t.tipo,
             upper(o.nombre),
             upper(o.dominio),
             t.accion,
             nvl(i_fecha_inicio, nvl(t.fecha_inicio, current_timestamp)) +
             (nvl(t.tiempo_inicio, 0) / 86400),
             nvl(i_intervalo_repeticion, t.intervalo_repeticion),
             nvl(i_fecha_fin, t.fecha_fin),
             t.comentarios,
             t.programa
        into l_tipo_trabajo,
             l_nombre_trabajo,
             l_dominio_trabajo,
             l_accion_trabajo,
             l_fecha_inicio,
             l_intervalo_repeticion,
             l_fecha_fin,
             l_comentarios,
             l_nombre_programa
        from t_trabajos t, t_operaciones o
       where o.id_operacion = t.id_trabajo
         and o.activo = 'S'
         and t.id_trabajo = i_id_trabajo;
    exception
      when no_data_found then
        raise ex_trabajo_no_implementado;
    end;
  
    -- Obtener parámetros del trabajo
    begin
      l_prms := k_operacion.f_procesar_parametros(i_id_trabajo,
                                                  i_parametros);
    exception
      when others then
        raise ex_error_parametro;
    end;
  
    -- Procesar parámetros del trabajo
    declare
      i pls_integer;
    begin
      i := l_prms.first;
      while i is not null loop
        l_nombre_trabajo := replace(l_nombre_trabajo,
                                    '{' || upper(l_prms(i).nombre) || '}',
                                    k_operacion.f_valor_parametro_string(l_prms,
                                                                         l_prms(i).nombre));
        l_accion_trabajo := replace(l_accion_trabajo,
                                    '&' || upper(l_prms(i).nombre),
                                    k_operacion.f_valor_parametro_string(l_prms,
                                                                         l_prms(i).nombre));
        i                := l_prms.next(i);
      end loop;
    end;
  
    if l_tipo_trabajo = 'STORED_PROCEDURE' then
      -- Registrar el programa del trabajo
      begin
        if l_nombre_programa is null then
          l_nombre_programa := 'P_' || replace(l_nombre_trabajo, '.', '_');
        end if;
        dbms_scheduler.create_program(program_name        => l_nombre_programa,
                                      program_action      => l_accion_trabajo,
                                      program_type        => l_tipo_trabajo,
                                      number_of_arguments => l_prms.count,
                                      enabled             => false);
      exception
        when ex_trabajo_ya_existe then
          null;
      end;
    
      -- Procesar parámetros del programa
      declare
        i pls_integer;
      begin
        i := l_prms.first;
        while i is not null loop
          dbms_scheduler.define_program_argument(program_name      => l_nombre_programa,
                                                 argument_name     => upper(l_prms(i).nombre),
                                                 argument_position => i,
                                                 argument_type     => 'VARCHAR2',
                                                 default_value     => null);
          i := l_prms.next(i);
        end loop;
      end;
    
      -- Habilitar el programa
      dbms_scheduler.enable(l_nombre_programa);
    
      dbms_scheduler.create_job(job_name        => l_nombre_trabajo,
                                program_name    => l_nombre_programa,
                                start_date      => l_fecha_inicio,
                                repeat_interval => l_intervalo_repeticion,
                                end_date        => l_fecha_fin,
                                enabled         => false,
                                comments        => l_comentarios);
    
      -- Asignar parámetros del trabajo
      declare
        i pls_integer;
      begin
        i := l_prms.first;
        while i is not null loop
          dbms_scheduler.set_job_argument_value(l_nombre_trabajo,
                                                i,
                                                k_operacion.f_valor_parametro_string(l_prms,
                                                                                     l_prms(i).nombre));
          i := l_prms.next(i);
        end loop;
      end;
    
      -- Habilitar el trabajo
      dbms_scheduler.enable(l_nombre_trabajo);
    
    else
      -- Registrar el trabajo
      --dbms_output.put_line(l_nombre_trabajo);
      --dbms_output.put_line(l_accion_trabajo);
      dbms_scheduler.create_job(job_name        => l_nombre_trabajo,
                                job_type        => l_tipo_trabajo,
                                job_action      => l_accion_trabajo,
                                start_date      => l_fecha_inicio,
                                repeat_interval => l_intervalo_repeticion,
                                end_date        => l_fecha_fin,
                                enabled         => true,
                                comments        => l_comentarios);
    
    end if;
  
  end;

  -- Edita un trabajo en el sistema
  procedure p_editar_trabajo(i_id_trabajo           in number,
                             i_parametros           in clob default null,
                             i_fecha_inicio         in timestamp with time zone default null,
                             i_intervalo_repeticion in varchar2 default null,
                             i_fecha_fin            in timestamp with time zone default null,
                             i_editar_accion        in boolean default false) is
    l_prms y_parametros;
    --
    l_tipo_trabajo         t_trabajos.tipo%type;
    l_nombre_trabajo       t_operaciones.nombre%type;
    l_dominio_trabajo      t_operaciones.dominio%type;
    l_accion_trabajo       t_trabajos.accion%type;
    l_fecha_inicio         t_trabajos.fecha_inicio%type;
    l_intervalo_repeticion t_trabajos.intervalo_repeticion%type;
    l_fecha_fin            t_trabajos.fecha_fin%type;
    l_comentarios          t_trabajos.comentarios%type;
  begin
    -- Buscar datos del trabajo
    begin
      select t.tipo,
             upper(o.nombre),
             upper(o.dominio),
             t.accion,
             i_fecha_inicio + (nvl(t.tiempo_inicio, 0) / 86400),
             i_intervalo_repeticion,
             i_fecha_fin,
             t.comentarios
        into l_tipo_trabajo,
             l_nombre_trabajo,
             l_dominio_trabajo,
             l_accion_trabajo,
             l_fecha_inicio,
             l_intervalo_repeticion,
             l_fecha_fin,
             l_comentarios
        from t_trabajos t, t_operaciones o
       where o.id_operacion = t.id_trabajo
         and o.activo = 'S'
         and t.id_trabajo = i_id_trabajo;
    exception
      when no_data_found then
        raise ex_trabajo_no_implementado;
    end;
  
    if i_parametros is not null then
      -- Obtener parámetros del trabajo
      begin
        l_prms := k_operacion.f_procesar_parametros(i_id_trabajo,
                                                    i_parametros);
      exception
        when others then
          raise ex_error_parametro;
      end;
    
      -- Procesar parámetros del trabajo
      declare
        i pls_integer;
      begin
        i := l_prms.first;
        while i is not null loop
          l_nombre_trabajo := replace(l_nombre_trabajo,
                                      '{' || upper(l_prms(i).nombre) || '}',
                                      k_operacion.f_valor_parametro_string(l_prms,
                                                                           l_prms(i).nombre));
          l_accion_trabajo := replace(l_accion_trabajo,
                                      '&' || upper(l_prms(i).nombre),
                                      k_operacion.f_valor_parametro_string(l_prms,
                                                                           l_prms(i).nombre));
          i                := l_prms.next(i);
        end loop;
      end;
    end if;
  
    -- Verificar si el trabajo existe
    begin
      dbms_scheduler.get_attribute(name      => l_nombre_trabajo,
                                   attribute => 'job_type',
                                   value     => l_tipo_trabajo);
    end;
  
    -- Editar fecha de inicio del trabajo
    if i_fecha_inicio is not null then
      dbms_scheduler.set_attribute(name      => l_nombre_trabajo,
                                   attribute => 'start_date',
                                   value     => l_fecha_inicio);
    end if;
  
    -- Editar intérvalo de repetición del trabajo
    if i_intervalo_repeticion is not null then
      dbms_scheduler.set_attribute(name      => l_nombre_trabajo,
                                   attribute => 'repeat_interval',
                                   value     => l_intervalo_repeticion);
    end if;
  
    -- Editar fecha de fin del trabajo
    if i_fecha_fin is not null then
      dbms_scheduler.set_attribute(name      => l_nombre_trabajo,
                                   attribute => 'end_date',
                                   value     => l_fecha_fin);
    end if;
  
    -- Editar la acción del trabajo.
    -- Lanza error en caso de procedimiento almacenado
    if i_editar_accion then
      if l_tipo_trabajo = 'STORED_PROCEDURE' then
        raise ex_error_parametro;
      else
        dbms_scheduler.set_attribute(name      => l_nombre_trabajo,
                                     attribute => 'job_action',
                                     value     => l_accion_trabajo);
      end if;
    end if;
  end;

  -- Crea o edita un trabajo en el sistema
  procedure p_crear_o_editar_trabajo(i_id_trabajo           in number,
                                     i_parametros           in clob default null,
                                     i_fecha_inicio         in timestamp with time zone default null,
                                     i_intervalo_repeticion in varchar2 default null,
                                     i_fecha_fin            in timestamp with time zone default null) is
  begin
    begin
      p_editar_trabajo(i_id_trabajo           => i_id_trabajo,
                       i_parametros           => i_parametros,
                       i_fecha_inicio         => i_fecha_inicio,
                       i_intervalo_repeticion => i_intervalo_repeticion,
                       i_fecha_fin            => i_fecha_fin);
    exception
      when ex_trabajo_no_existe then
        -- Crea el trabajo si no existe
        p_crear_trabajo(i_id_trabajo           => i_id_trabajo,
                        i_parametros           => i_parametros,
                        i_fecha_inicio         => i_fecha_inicio,
                        i_intervalo_repeticion => i_intervalo_repeticion,
                        i_fecha_fin            => i_fecha_fin);
    end;
  end;

  -- Elimina un trabajo en el sistema
  procedure p_eliminar_trabajo(i_id_trabajo in number,
                               i_parametros in clob default null) is
    l_prms y_parametros;
    --
    l_tipo_trabajo    t_trabajos.tipo%type;
    l_nombre_trabajo  t_operaciones.nombre%type;
    l_nombre_programa t_operaciones.nombre%type;
    l_dominio_trabajo t_operaciones.dominio%type;
  begin
    -- Buscar datos del trabajo
    begin
      select t.tipo, upper(o.nombre), upper(o.dominio), t.programa
        into l_tipo_trabajo,
             l_nombre_trabajo,
             l_dominio_trabajo,
             l_nombre_programa
        from t_trabajos t, t_operaciones o
       where o.id_operacion = t.id_trabajo
         and o.activo = 'S'
         and t.id_trabajo = i_id_trabajo;
    exception
      when no_data_found then
        raise ex_trabajo_no_implementado;
    end;
  
    if i_parametros is not null then
      -- Obtener parámetros del trabajo
      begin
        l_prms := k_operacion.f_procesar_parametros(i_id_trabajo,
                                                    i_parametros);
      exception
        when others then
          raise ex_error_parametro;
      end;
    
      -- Procesar parámetros del trabajo
      declare
        i pls_integer;
      begin
        i := l_prms.first;
        while i is not null loop
          l_nombre_trabajo := replace(l_nombre_trabajo,
                                      '{' || upper(l_prms(i).nombre) || '}',
                                      k_operacion.f_valor_parametro_string(l_prms,
                                                                           l_prms(i).nombre));
          i                := l_prms.next(i);
        end loop;
      end;
    end if;
  
    -- Elimina el trabajo
    dbms_scheduler.drop_job(l_nombre_trabajo);
  
    -- Elimina el programa
    if l_tipo_trabajo = 'STORED_PROCEDURE' then
      begin
        if l_nombre_programa is null then
          l_nombre_programa := 'P_' || replace(l_nombre_trabajo, '.', '_');
        end if;
        dbms_scheduler.drop_program(l_nombre_programa);
      exception
        when ex_programa_con_dependencia then
          null;
      end;
    end if;
  
  end;

end;
/
