create or replace force view v_operacion_logs as
select l.id_operacion_log,
       l.id_operacion,
       s.nombre nombre_operacion,
       s.dominio dominio_operacion,
       s.nombre_programa_implementacion,
       l.version,
       l.fecha_hora_inicio,
       l.fecha_hora_fin,
       l.duracion,
       l.sql_ejecucion,
       l.id_usuario,
       l.id_entidad,
       l.id_sesion,
       l.id_dispositivo,
       -- parametros
       l.parametros,
       json_query(l.parametros, '$' returning varchar2(4000) truncate) prms,
       -- respuesta
       l.respuesta,
       json_value(l.respuesta, '$.codigo') rsp_codigo,
       json_value(l.respuesta, '$.mensaje') rsp_mensaje,
       json_value(l.respuesta, '$.mensaje_bd') rsp_mensaje_bd,
       json_value(l.respuesta, '$.tipo_error') rsp_tipo_error,
       json_value(l.respuesta, '$.lugar') rsp_lugar,
       json_query(l.respuesta, '$.datos' returning varchar2(4000) truncate) rsp_datos,
       -- contexto
       l.contexto,
       json_value(l.contexto, '$.direccion_ip') ctx_direccion_ip,
       json_value(l.contexto, '$.clave_aplicacion') ctx_clave_aplicacion,
       json_value(l.contexto, '$.access_token') ctx_access_token,
       json_value(l.contexto, '$.usuario') ctx_usuario,
       json_value(l.contexto, '$.token_dispositivo') ctx_token_dispositivo,
       json_value(l.contexto, '$.id_ejecucion') ctx_id_ejecucion,
       --
       json_value(l.contexto, '$.id_tracking') ctx_id_tracking,
       json_value(l.contexto, '$.dispositivo_origen') ctx_dispositivo_origen,
       json_value(l.contexto, '$.timestamp') ctx_timestamp,
       json_value(l.contexto, '$.tipo_persona') ctx_tipo_persona,
       json_value(l.contexto, '$.id_usuario') ctx_id_usuario,
       json_value(l.contexto, '$.id_entidad') ctx_id_entidad,
       json_value(l.contexto, '$.dato_usuario') ctx_dato_usuario,
       json_value(l.contexto, '$.entidad') ctx_entidad,
       json_value(l.contexto, '$.id_aplicacion') ctx_id_aplicacion
  from t_operacion_logs l, t_operaciones s
 where s.id_operacion(+) = l.id_operacion
;
comment on table V_OPERACION_LOGS is 'Logs de Operaciones';
comment on column V_OPERACION_LOGS.ID_OPERACION_LOG is 'Identificador del log';
comment on column V_OPERACION_LOGS.ID_OPERACION is 'Identificador de la operación';
comment on column V_OPERACION_LOGS.NOMBRE_OPERACION is 'Nombre de la operación';
comment on column V_OPERACION_LOGS.DOMINIO_OPERACION is 'Dominio de la operación';
comment on column V_OPERACION_LOGS.NOMBRE_PROGRAMA_IMPLEMENTACION is 'Nombre del programa de implementación de la operación';
comment on column V_OPERACION_LOGS.VERSION is 'Versión de la operación';
comment on column V_OPERACION_LOGS.FECHA_HORA_INICIO is 'Fecha/hora de inicio de la ejecución de la operación';
comment on column V_OPERACION_LOGS.FECHA_HORA_FIN is 'Fecha/hora de fin de la ejecución de la operación';
comment on column V_OPERACION_LOGS.DURACION is 'Duración de la ejecución de la operación';
comment on column V_OPERACION_LOGS.SQL_EJECUCION is 'SQL de la ejecución de la operación';
comment on column V_OPERACION_LOGS.ID_USUARIO is 'Identificador del usuario';
comment on column V_OPERACION_LOGS.ID_ENTIDAD is 'Identificador de la entidad';
comment on column V_OPERACION_LOGS.ID_SESION is 'Identificador de la sesión';
comment on column V_OPERACION_LOGS.ID_DISPOSITIVO is 'Identificador del dispositivo';
comment on column V_OPERACION_LOGS.PARAMETROS is 'Parámetros recibidos';
comment on column V_OPERACION_LOGS.PRMS is 'Parámetros recibidos: *';
comment on column V_OPERACION_LOGS.RESPUESTA is 'Respuesta enviada';
comment on column V_OPERACION_LOGS.RSP_CODIGO is 'Respuesta enviada: codigo';
comment on column V_OPERACION_LOGS.RSP_MENSAJE is 'Respuesta enviada: mensaje';
comment on column V_OPERACION_LOGS.RSP_MENSAJE_BD is 'Respuesta enviada: mensaje_bd';
comment on column V_OPERACION_LOGS.RSP_TIPO_ERROR is 'Respuesta enviada: tipo_error';
comment on column V_OPERACION_LOGS.RSP_LUGAR is 'Respuesta enviada: lugar';
comment on column V_OPERACION_LOGS.RSP_DATOS is 'Respuesta enviada: datos';
comment on column V_OPERACION_LOGS.CONTEXTO is 'Contexto de la operación';
comment on column V_OPERACION_LOGS.CTX_DIRECCION_IP is 'Contexto de la operación: direccion_ip';
comment on column V_OPERACION_LOGS.CTX_CLAVE_APLICACION is 'Contexto de la operación: clave_aplicacion';
comment on column V_OPERACION_LOGS.CTX_ACCESS_TOKEN is 'Contexto de la operación: access_token';
comment on column V_OPERACION_LOGS.CTX_USUARIO is 'Contexto de la operación: usuario';
comment on column V_OPERACION_LOGS.CTX_TOKEN_DISPOSITIVO is 'Contexto de la operación: token_dispositivo';
comment on column V_OPERACION_LOGS.CTX_ID_EJECUCION is 'Contexto de la operación: id_ejecucion';
comment on column V_OPERACION_LOGS.CTX_ID_TRACKING is 'Contexto de la operación: id_tracking';
comment on column V_OPERACION_LOGS.CTX_DISPOSITIVO_ORIGEN is 'Contexto de la operación: dispositivo_origen';
comment on column V_OPERACION_LOGS.CTX_TIMESTAMP is 'Contexto de la operación: timestamp';
comment on column V_OPERACION_LOGS.CTX_TIPO_PERSONA is 'Contexto de la operación: tipo_persona';
comment on column V_OPERACION_LOGS.CTX_ID_USUARIO is 'Contexto de la operación: id_usuario';
comment on column V_OPERACION_LOGS.CTX_ID_ENTIDAD is 'Contexto de la operación: id_entidad';
comment on column V_OPERACION_LOGS.CTX_DATO_USUARIO is 'Contexto de la operación: dato_usuario';
comment on column V_OPERACION_LOGS.CTX_ENTIDAD is 'Contexto de la operación: entidad';
comment on column V_OPERACION_LOGS.CTX_ID_APLICACION is 'Contexto de la operación: id_aplicacion';

