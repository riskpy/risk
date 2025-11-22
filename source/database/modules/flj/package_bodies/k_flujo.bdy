create or replace package body k_flujo as

  procedure iniciar_flujo(i_id_flujo     in number,
                          i_usuario      in varchar2,
                          i_variables    in clob,
                          o_id_instancia out number) is
    l_id_paso_inicio t_flujo_pasos.id_paso%type;
    l_nombre_flujo   t_flujos.nombre%type;
  begin
    -- Obtener información actual
    begin
      select nombre
        into l_nombre_flujo
        from t_flujos f
       where f.id_flujo = i_id_flujo;
    exception
      when no_data_found then
        raise_application_error(-20001, 'Flujo no encontrado.');
    end;
  
    -- Crear nueva instancia
    insert into t_flujo_instancias
      (id_flujo, usuario_ingreso, variables)
    values
      (i_id_flujo, i_usuario, i_variables)
    returning id_instancia into o_id_instancia;
  
    -- Obtener primer paso (orden mínimo)
    select id_paso
      into l_id_paso_inicio
      from t_flujo_pasos
     where id_flujo = i_id_flujo
     order by orden
     fetch first 1 rows only;
  
    -- Insertar paso inicial
    insert into t_flujo_instancia_pasos
      (id_instancia, id_paso, estado)
    values
      (o_id_instancia, l_id_paso_inicio, c_estado_en_progreso);
  
    -- Si el siguiente paso es automático, avanzamos
    declare
      l_tipo t_flujo_pasos.tipo%type;
    begin
      select tipo
        into l_tipo
        from t_flujo_pasos
       where id_paso = l_id_paso_inicio;
    
      if l_tipo = c_tipo_paso_inicio then
        avanzar_flujo(o_id_instancia,
                      c_accion_aprobar,
                      i_usuario,
                      'Instancia inicializada');
      else
        raise_application_error(-20001,
                                'Error al inicializar instancia. Paso inicial no definido correctamente');
      end if;
    end;
  
  end iniciar_flujo;

  function obtener_estado_flujo(i_id_instancia in number) return clob is
    l_resultado clob;
  begin
    select json_object('id_instancia' value i.id_instancia,
                       'estado' value i.estado,
                       'variables' value
                       json_query(i.variables, '$' returning clob),
                       'pasos' value
                       (select json_arrayagg(json_object('id_paso' value
                                                         pi.id_paso,
                                                         'nombre' value
                                                         p.nombre,
                                                         'estado' value
                                                         pi.estado,
                                                         'resultado' value
                                                         pi.resultado,
                                                         'fecha_inicio' value
                                                         to_char(pi.fecha_inicio,
                                                                 'YYYY-MM-DD"T"HH24:MI:SS'),
                                                         'fecha_fin' value
                                                         to_char(pi.fecha_fin,
                                                                 'YYYY-MM-DD"T"HH24:MI:SS')))
                          from t_flujo_instancia_pasos pi
                          join t_flujo_pasos p
                            on pi.id_paso = p.id_paso
                         where pi.id_instancia = i.id_instancia))
      into l_resultado
      from t_flujo_instancias i
     where id_instancia = i_id_instancia;
  
    return l_resultado;
  end obtener_estado_flujo;

  procedure avanzar_flujo(i_id_instancia in number,
                          i_accion       in varchar2,
                          i_usuario      in varchar2,
                          i_comentario   in varchar2) is
    l_id_flujo t_flujos.id_flujo%type;
    --
    l_id_paso_actual    t_flujo_instancia_pasos.id_paso%type;
    l_variables         t_flujo_instancias.variables%type;
    l_id_paso_instancia t_flujo_instancia_pasos.id_paso_instancia%type;
    l_usuario_ingreso   t_flujo_instancias.usuario_ingreso%type;
    --
    l_nombre_paso       t_flujo_pasos.nombre%type;
    l_id_paso_sig       t_flujo_pasos.id_paso%type;
    l_acciones_posibles t_flujo_pasos.acciones_posibles%type;
    l_roles             t_flujo_pasos.roles_responsables%type;
    l_usuarios          t_flujo_pasos.usuarios_responsables%type;
    l_bloque_plsql      t_flujo_pasos.bloque_plsql%type;
    l_bloque_final      t_flujo_pasos.bloque_plsql%type;
    --
    l_aprobadores_requeridos pls_integer;
    l_pendientes             pls_integer;
    l_puede_avanzar          boolean := false;
    --
    l_es_final varchar2(1) := 'N';
  begin
    -- Obtener información actual
    begin
      select i.variables, i.id_flujo, i.usuario_ingreso
        into l_variables, l_id_flujo, l_usuario_ingreso
        from t_flujo_instancias i
       where id_instancia = i_id_instancia;
    exception
      when no_data_found then
        raise_application_error(-20001, 'Instancia no encontrada.');
    end;
  
    -- Obtener el paso actual activo
    begin
      select id_paso_instancia,
             id_paso,
             roles_responsables,
             usuarios_responsables
        into l_id_paso_instancia, l_id_paso_actual, l_roles, l_usuarios
        from t_flujo_instancia_pasos
       where id_instancia = i_id_instancia
         and estado = c_estado_en_progreso;
    exception
      when no_data_found then
        raise_application_error(-20001, 'Instancia ya fue finalizada.');
    end;
  
    -- Obtener datos del paso actual
    select nombre, acciones_posibles, bloque_plsql
      into l_nombre_paso, l_acciones_posibles, l_bloque_plsql
      from t_flujo_pasos
     where id_paso = l_id_paso_actual;
  
    -- Verificar si hay múltiples aprobadores y si todos aprobaron
    select count(*)
      into l_aprobadores_requeridos
      from v_flujo_aprobador
     where id_paso = l_id_paso_actual;
  
    select sum(nvl(pendientes, 0))
      into l_pendientes
      from v_roles_responsables_en_progreso
     where id_paso_instancia = l_id_paso_instancia;
  
    --DBMS_OUTPUT.PUT_LINE( UTL_CALL_STACK.SUBPROGRAM(UTL_CALL_STACK.DYNAMIC_DEPTH - 1)(2) );
    if l_aprobadores_requeridos > 0 and
       utl_call_stack.subprogram(utl_call_stack.dynamic_depth - 1)
     (2) not in ('APROBAR_PASO') then
      raise_application_error(-20001,
                              'No se puede avanzar. Faltan aprobaciones en el paso [' ||
                              l_nombre_paso || '].');
    end if;
  
    if i_accion = c_accion_aprobar then
      if l_aprobadores_requeridos > 0 and l_pendientes > 0 then
        raise_application_error(-20001,
                                'Faltan aprobaciones en el paso [' ||
                                l_nombre_paso || ']. Verifique.');
      end if;
    end if;
  
    -- Verificar las acciones permitidas
    if not k_flujo_util.f_contiene_valor(i_accion, l_acciones_posibles) then
      raise_application_error(-20001,
                              'Acción [' || i_accion ||
                              '] no permitida para el paso ' ||
                              l_nombre_paso || '. ' ||
                              'Acciones posibles: ' || l_acciones_posibles || '');
    end if;
  
    -- Verificar si el usuario tiene permiso a avanzar en el flujo
    if l_roles is null and l_usuarios is null then
      l_puede_avanzar := true;
    end if;
  
    if l_roles is not null then
      declare
        l_cant_roles pls_integer;
      begin
        select count(*) usuario_responsable
          into l_cant_roles
          from v_roles_responsables_paso a
         where a.id_paso_instancia = l_id_paso_instancia
           and exists
         (select 1
                  from t_rol_usuarios y
                 where y.id_usuario = k_usuario.f_id_usuario(i_usuario)
                   and (select z.nombre
                          from t_roles z
                         where z.id_rol = y.id_rol) = a.id_rol);
        if l_cant_roles > 0 then
          l_puede_avanzar := true;
        end if;
      end;
    end if;
  
    if l_usuarios is not null then
      declare
        l_cant_usuario pls_integer;
      begin
        select count(*) usuario_responsable
          into l_cant_usuario
          from v_usuarios_responsables_paso a
         where a.id_paso_instancia = l_id_paso_instancia
           and a.id_usuario = i_usuario;
        if l_cant_usuario > 0 then
          l_puede_avanzar := true;
        end if;
      end;
    end if;
  
    if not l_puede_avanzar then
      raise_application_error(-20002,
                              'Usuario no tiene permiso para avanzar en el paso [' ||
                              l_nombre_paso || '].');
    end if;
  
    -- Buscar transiciones posibles desde el paso actual al siguiente paso
    for t in (select id_transicion, id_paso_destino, condicion
                from t_flujo_transiciones
               where id_paso_origen = l_id_paso_actual
                 and accion = nvl(i_accion, c_accion_aprobar)) loop
      if t.condicion is null or
         k_flujo_util.f_evaluar_condicion(t.condicion, l_variables) then
        l_id_paso_sig := t.id_paso_destino;
        exit;
      end if;
    end loop;
  
    -- Ejecutar las acciones definidas en el bloque PLSQL
    begin
      if l_bloque_plsql is not null then
        l_bloque_plsql := k_flujo_util.f_reemplazar_variables(l_bloque_plsql,
                                                              l_variables);
        l_bloque_final := 'DECLARE' || chr(10) || chr(10) || 'BEGIN' ||
                          chr(10) || '    DECLARE' || chr(10) ||
                          '    BEGIN' || chr(10) || '      --' || chr(10) ||
                          '      ' || l_bloque_plsql || ' ' || chr(10) ||
                          '      --' || chr(10) || '    END;' || chr(10) ||
                         /*'  :2 := l_rsp;' || chr(10) ||*/
                          'END;';
      
        --DBMS_OUTPUT.PUT_LINE( l_bloque_final );
        execute immediate l_bloque_final
        /*USING IN i_prms, OUT io_rsp*/
        ;
      end if;
    end;
  
    -- Obtener si es paso final
    if l_id_paso_sig is null then
      l_es_final := 'S';
    end if;
  
    -- Cerrar paso actual
    update t_flujo_instancia_pasos
       set estado    = c_estado_finalizado,
           resultado = i_accion,
           fecha_fin = systimestamp
     where id_paso_instancia = l_id_paso_instancia;
  
    -- Registrar en historial
    insert into t_flujo_instancia_historial
      (id_instancia, id_paso, accion, usuario, comentario)
    values
      (i_id_instancia, l_id_paso_actual, i_accion, i_usuario, i_comentario);
  
    -- Si es el paso final se finaliza la instancia, sino se registra el siguiente paso
    if l_es_final = 'S' then
      update t_flujo_instancias
         set estado = c_estado_finalizado, fecha_fin = systimestamp
       where id_instancia = i_id_instancia;
      return;
    else
      declare
        l_tipo         t_flujo_pasos.tipo%type;
        l_roles_sig    t_flujo_pasos.roles_responsables%type;
        l_usuarios_sig t_flujo_pasos.usuarios_responsables%type;
      begin
        -- Obtener los roles y usuarios responsables del siguiente paso
        select tipo,
               roles_responsables,
               replace(usuarios_responsables,
                       ':usuario_ingreso',
                       l_usuario_ingreso)
          into l_tipo, l_roles_sig, l_usuarios_sig
          from t_flujo_pasos
         where id_paso = l_id_paso_sig;
      
        l_roles_sig    := k_flujo_util.f_reemplazar_variables(l_roles_sig,
                                                              l_variables,
                                                              null);
        l_usuarios_sig := k_flujo_util.f_reemplazar_variables(l_usuarios_sig,
                                                              l_variables,
                                                              null);
      
        -- Insertar nuevo paso
        insert into t_flujo_instancia_pasos
          (id_instancia,
           id_paso,
           estado,
           roles_responsables,
           usuarios_responsables)
        values
          (i_id_instancia,
           l_id_paso_sig,
           c_estado_en_progreso,
           l_roles_sig,
           l_usuarios_sig);
      
        -- Si el siguiente paso es automático, avanzamos
        if l_tipo = c_tipo_paso_automatico then
          avanzar_flujo(i_id_instancia,
                        c_accion_aprobar,
                        i_usuario,
                        'Realizado automaticamente');
        end if;
      end;
    end if;
  
  end;

  procedure aprobar_paso(i_id_instancia in number,
                         i_accion       in varchar2, --APROBAR / RECHAZAR / CONDICIONAR, ETC
                         i_usuario      in varchar2,
                         i_comentario   in varchar2) is
    l_id_flujo t_flujos.id_flujo%type;
    --
    l_variables t_flujo_instancias.variables%type;
    --
    l_nombre_paso       t_flujo_pasos.nombre%type;
    l_acciones_posibles t_flujo_pasos.acciones_posibles%type;
    l_roles             t_flujo_pasos.roles_responsables%type;
    l_usuarios          t_flujo_pasos.usuarios_responsables%type;
    --
    l_id_paso_instancia t_flujo_instancia_pasos.id_paso_instancia%type;
    l_id_paso_actual    t_flujo_instancia_pasos.id_paso%type;
    l_estado_actual     t_flujo_instancia_pasos.estado%type;
    --
    l_aprobado t_flujo_instancia_aprobaciones.aprobado%type := 'N';
    --
    l_aprobadores_requeridos pls_integer;
    l_pendientes             pls_integer;
    l_usuario_firmado        pls_integer;
    l_puede_avanzar          boolean := false;
  begin
    -- Obtener información actual
    begin
      select variables, i.id_flujo
        into l_variables, l_id_flujo
        from t_flujo_instancias i
       where id_instancia = i_id_instancia;
    exception
      when no_data_found then
        raise_application_error(-20001, 'Instancia no encontrada.');
    end;
  
    -- Obtener el paso actual activo
    begin
      select id_paso_instancia,
             id_paso,
             estado,
             roles_responsables,
             usuarios_responsables
        into l_id_paso_instancia,
             l_id_paso_actual,
             l_estado_actual,
             l_roles,
             l_usuarios
        from t_flujo_instancia_pasos
       where id_instancia = i_id_instancia
         and estado = c_estado_en_progreso;
    exception
      when no_data_found then
        raise_application_error(-20001, 'Instancia ya fue finalizada.');
    end;
  
    -- Verificar si el usuario ya aprobó el paso actual activo
    select count(*)
      into l_usuario_firmado
      from t_flujo_instancia_aprobaciones a
     where a.id_paso_instancia = l_id_paso_instancia
       and a.usuario_aprobador = i_usuario
       and a.aprobado = 'S';
    if l_usuario_firmado > 0 then
      raise_application_error(-20001,
                              'Paso actual ya fue aprobado por el usuario.');
    end if;
  
    -- Verificar las acciones permitidas
    select nombre, acciones_posibles
      into l_nombre_paso, l_acciones_posibles
      from t_flujo_pasos
     where id_paso = l_id_paso_actual;
  
    if not k_flujo_util.f_contiene_valor(i_accion, l_acciones_posibles) then
      raise_application_error(-20001,
                              'Acción [' || i_accion ||
                              '] no permitida para el paso ' ||
                              l_nombre_paso || '. ' ||
                              'Acciones posibles: ' || l_acciones_posibles || '');
    end if;
  
    -- Verificar si el usuario tiene permiso a avanzar en el flujo
    if l_roles is null and l_usuarios is null then
      l_puede_avanzar := true;
    end if;
  
    if l_roles is not null then
      declare
        l_cant_roles pls_integer;
      begin
        select count(*) usuario_responsable
          into l_cant_roles
          from v_roles_responsables_paso a
         where a.id_paso_instancia = l_id_paso_instancia
           and exists
         (select 1
                  from t_rol_usuarios y
                 where y.id_usuario = k_usuario.f_id_usuario(i_usuario)
                   and (select z.nombre
                          from t_roles z
                         where z.id_rol = y.id_rol) = a.id_rol);
        if l_cant_roles > 0 then
          l_puede_avanzar := true;
        end if;
      end;
    end if;
  
    if l_usuarios is not null then
      declare
        l_cant_usuario pls_integer;
      begin
        select count(*) usuario_responsable
          into l_cant_usuario
          from v_usuarios_responsables_paso a
         where a.id_paso_instancia = l_id_paso_instancia
           and a.id_usuario = i_usuario;
        if l_cant_usuario > 0 then
          l_puede_avanzar := true;
        end if;
      end;
    end if;
  
    -- Verificar si hay múltiples aprobadores
    select count(*)
      into l_aprobadores_requeridos
      from v_flujo_aprobador
     where id_paso = l_id_paso_actual;
  
    if l_aprobadores_requeridos = 0 then
      raise_application_error(-20001,
                              'Paso actual NO requiere aprobaciones.');
    end if;
  
    -- Lanzar mensaje de error si el usuario no tiene permiso a avanzar
    if not l_puede_avanzar then
      raise_application_error(-20002,
                              'Usuario no tiene permiso para realizar el paso [' ||
                              l_nombre_paso || '].');
    end if;
  
    -- Registro la aprobacion, rechazo o condicionamiento, etc
    if i_accion = c_accion_aprobar then
      l_aprobado := 'S';
    end if;
  
    insert into t_flujo_instancia_aprobaciones
      (rol_aprobador,
       id_paso_instancia,
       usuario_aprobador,
       aprobado,
       fecha_aprobacion,
       comentario)
    values
      ((select json_arrayagg(a.id_rol) as valores_json
         from v_roles_responsables_en_progreso a
        where a.id_paso_instancia = l_id_paso_instancia
          and exists
        (select 1
                 from t_rol_usuarios y
                where y.id_usuario = k_usuario.f_id_usuario(i_usuario)
                  and (select z.nombre
                         from t_roles z
                        where z.id_rol = y.id_rol) = a.id_rol)),
       l_id_paso_instancia,
       i_usuario,
       l_aprobado,
       systimestamp,
       i_comentario);
  
    -- Verificar si hay múltiples aprobadores y si todos los múltiples aprobadores, aprobaron
    select sum(nvl(pendientes, 0))
      into l_pendientes
      from v_roles_responsables_en_progreso
     where id_paso_instancia = l_id_paso_instancia;
  
    if l_aprobado = 'N' then
      -- Actualizar estado en caso de rechazo, condicionado u otros.
      avanzar_flujo(i_id_instancia, i_accion, i_usuario, i_comentario);
    else
      if l_aprobadores_requeridos > 0 and l_pendientes > 0 then
        null;
      else
        -- Actualizar estado en caso de aprobaciones completadas
        avanzar_flujo(i_id_instancia,
                      i_accion,
                      i_usuario,
                      'Completadas las aprobaciones múltiples');
      end if;
    end if;
  
  end;

end k_flujo;
/
