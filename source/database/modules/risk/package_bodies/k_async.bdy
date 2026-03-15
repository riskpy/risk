create or replace package body k_async is

  -- https://www.oratable.com/running-procedures-asynchronously-with-oracle-job-scheduler/
  -- https://medium.com/@bimands/invoke-long-running-pl-sql-asynchronously-from-oic-b714f83bf540

  function f_registrar_ejecucion(i_bloque_plsql in clob,
                                 i_descripcion  in varchar2 default null,
                                 i_referencia   in varchar2 default null)
    return number is
    l_id_async_ejecucion t_async_ejecuciones.id_async_ejecucion%type;
    l_nombre_job         t_async_ejecuciones.nombre_job%type;
  begin
    l_id_async_ejecucion := k_util.f_valor_secuencia_id('T_ASYNC_EJECUCIONES');
    l_nombre_job         := c_aplicacion_async || '_' ||
                            to_char(l_id_async_ejecucion);
  
    -- Inserta ejecución
    insert into t_async_ejecuciones
      (id_async_ejecucion,
       descripcion,
       nombre_job,
       estado,
       bloque_plsql,
       fecha_hora_inicio,
       fecha_hora_fin,
       duracion,
       detalle,
       referencia)
    values
      (l_id_async_ejecucion,
       substr(i_descripcion, 1, 500),
       l_nombre_job,
       'P', -- PENDIENTE DE EJECUCIÓN
       nvl(i_bloque_plsql, 'begin null; end;'),
       null,
       null,
       null,
       null,
       substr(i_referencia, 1, 500));
  
    dbms_scheduler.create_job(job_name   => l_nombre_job,
                              job_type   => 'PLSQL_BLOCK',
                              job_action => 'begin k_async.p_ejecutar(' ||
                                            to_char(l_id_async_ejecucion) ||
                                            '); end;',
                              start_date => systimestamp,
                              enabled    => true,
                              auto_drop  => true);
  
    return l_id_async_ejecucion;
  end;

  procedure p_iniciar_ejecucion(i_id_ejecucion in number) is
    pragma autonomous_transaction;
  begin
    -- Actualiza ejecución
    update t_async_ejecuciones a
       set a.estado            = 'E', -- EN EJECUCIÓN
           a.fecha_hora_inicio = systimestamp
     where a.id_async_ejecucion = i_id_ejecucion;
  
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_finalizar_ejecucion_ok(i_id_ejecucion in number) is
    pragma autonomous_transaction;
  begin
    -- Actualiza ejecución
    update t_async_ejecuciones a
       set a.estado         = 'F', -- EJECUTADO CON ÉXITO
           a.fecha_hora_fin = systimestamp,
           a.duracion       = systimestamp - a.fecha_hora_inicio,
           a.detalle        = 'OK'
     where a.id_async_ejecucion = i_id_ejecucion;
  
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_finalizar_ejecucion_error(i_id_ejecucion in number,
                                        i_detalle      in varchar2 default null) is
    pragma autonomous_transaction;
  begin
    -- Actualiza ejecución
    update t_async_ejecuciones a
       set a.estado         = 'E', -- EJECUTADO CON ERROR
           a.fecha_hora_fin = systimestamp,
           a.duracion       = systimestamp - a.fecha_hora_inicio,
           a.detalle        = i_detalle
     where a.id_async_ejecucion = i_id_ejecucion;
  
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_ejecutar(i_id_ejecucion in number) is
    l_bloque_plsql t_async_ejecuciones.bloque_plsql%type;
  begin
    -- Configura modificación (control de auditoría)
    p_configurar_modificacion(pin_aplicacion => c_aplicacion_async);
  
    begin
      select a.bloque_plsql
        into l_bloque_plsql
        from t_async_ejecuciones a
       where a.id_async_ejecucion = i_id_ejecucion;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Ejecución no registrada');
    end;
  
    p_iniciar_ejecucion(i_id_ejecucion);
  
    -- Ejecuta bloque asíncrono
    execute immediate l_bloque_plsql;
  
    p_finalizar_ejecucion_ok(i_id_ejecucion);
  exception
    when others then
      p_finalizar_ejecucion_error(i_id_ejecucion,
                                  dbms_utility.format_error_stack);
  end;

end;
/

