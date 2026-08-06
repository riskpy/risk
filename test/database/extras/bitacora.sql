select a.id_operacion_log as "Id. Log",
       coalesce(a.ctx_id_aplicacion, a.ctx_clave_aplicacion) as "Aplicación",
       coalesce(to_char(a.id_usuario), to_char(a.ctx_id_usuario), a.ctx_dato_usuario, a.ctx_usuario) as "Usuario",
       coalesce(to_char(a.id_entidad), to_char(a.ctx_id_entidad), a.ctx_entidad) as "Entidad",
       a.id_operacion as "Id. Operación",
       a.tipo as "Tipo",
       a.nombre_operacion as "Operación",
       a.dominio_operacion as "Dominio",
       a.prms as "Parámetros Entrada",
       a.parametros as "Parámetros Entrada Completo",
       a.contexto as "Contexto",
       a.rsp_codigo as "Código Respuesta",
       a.rsp_mensaje as "Mensaje",
       a.rsp_mensaje_bd as "Mensaje BD",
       a.rsp_tipo_error as "Tipo Error",
       a.rsp_lugar as "Lugar",
       a.respuesta as "Respuesta Completo",
       a.fecha_hora_inicio as "Fecha Inicio",
       a.fecha_hora_fin as "Fecha Fin",
       a.duracion as "Duración",
       s.id_sesion as "Id. Sesión",
       s.access_token as "Sesión",
       a.ctx_access_token as "Access Token",
       s.id_dispositivo as "Dispositivo",
       a.ctx_direccion_ip as "IP Origen",
       a.ctx_id_ejecucion as "Id. Ejecución",
       a.ctx_id_tracking as "Id. Tracking",
       a.nombre_programa_implementacion as "Programa",
       to_clob('-- ') ||
        to_char(a.fecha_hora_inicio, 'DD/MM/YYYY HH24:MI:SS') || ' - ' ||
        to_char(a.id_operacion) || ' - ' || a.nombre_operacion ||
        chr(10) || 'DECLARE
  v_resultado CLOB;
BEGIN
  v_resultado := f_procesar_' || decode(a.tipo, 'R', 'reporte', 'servicio') || '(
    i_nombre     => ''' || a.nombre_operacion || ''',
    i_dominio    => ''' || a.dominio_operacion || ''',
    i_parametros => q''[' || a.parametros || ']'',
    i_contexto   => q''[' || a.contexto || ']'',
    i_version    => ''' || a.version || '''
  );

  dbms_output.put_line(''Respuesta:'');
  dbms_output.put_line(v_resultado);
END;' as "Script PLSQL"
  from v_operacion_logs a, t_sesiones s
 where s.id_sesion(+) = a.id_sesion
   and ('&p_aplicacion' is null or coalesce(a.ctx_id_aplicacion, a.ctx_clave_aplicacion) = '&p_aplicacion')
   and ('&p_usuario' is null or coalesce(to_char(a.id_usuario), to_char(a.ctx_id_usuario), a.ctx_dato_usuario, a.ctx_usuario) = '&p_usuario')
   and ('&p_entidad' is null or coalesce(to_char(a.id_entidad), to_char(a.ctx_id_entidad), a.ctx_entidad) = '&p_entidad')
   and ('&p_operacion' is null or '&p_operacion' in (a.nombre_operacion, to_char(a.id_operacion)))
   and ('&p_dominio' is null or a.dominio_operacion = '&p_dominio')
   and ('&p_sesion' is null or s.access_token = '&p_sesion')
   and ('&p_ip' is null or a.ctx_direccion_ip = '&p_ip')
   and (a.fecha_hora_inicio >= to_timestamp(nvl('&p_fecha_ini', to_char(sysdate, 'DD/MM/YYYY') || ' 00:00:00'), 'DD/MM/YYYY HH24:MI:SS'))
   and (a.fecha_hora_inicio <= to_timestamp(nvl('&p_fecha_fin', to_char(sysdate, 'DD/MM/YYYY') || ' 23:59:59'), 'DD/MM/YYYY HH24:MI:SS'))
   and ('&p_id_log' is null or a.id_operacion_log = '&p_id_log')
   and ('&p_id_ejecucion' is null or a.ctx_id_ejecucion = '&p_id_ejecucion')
   and ('&p_id_tracking' is null or a.ctx_id_tracking = '&p_id_tracking')
   and ('&p_codigo_respuesta' is null or a.rsp_codigo = '&p_codigo_respuesta')
   and ('&p_tipo_error' is null or a.rsp_tipo_error = '&p_tipo_error')
   and (nvl('&p_solo_errores', 'N') <> 'S' or (nvl('&p_solo_errores', 'N') = 'S' and (a.rsp_codigo <> '0')))
 order by a.fecha_hora_inicio desc;
