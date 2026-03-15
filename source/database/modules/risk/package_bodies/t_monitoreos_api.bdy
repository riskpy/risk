CREATE OR REPLACE PACKAGE BODY T_MONITOREOS_API IS
  /*
  This is the API for the table T_MONITOREOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:58
  - generated_by: JAVIER
  */

  g_bulk_limit     PLS_INTEGER := 1000;
  g_bulk_completed BOOLEAN     := FALSE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN
  IS
  BEGIN
    RETURN g_bulk_completed;
  END bulk_is_complete;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER )
  IS
  BEGIN
    g_bulk_limit := p_bulk_limit;
  END set_bulk_limit;

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER
  IS
  BEGIN
    RETURN g_bulk_limit;
  END get_bulk_limit;

  FUNCTION row_exists (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_MONITOREOS
      WHERE
        ID_MONITOREO = p_id_monitoreo;
  BEGIN
    OPEN cur_bool;
    FETCH cur_bool INTO v_dummy;
    IF cur_bool%FOUND THEN
      v_return := TRUE;
    END IF;
    CLOSE cur_bool;
    RETURN v_return;
  END;

  FUNCTION row_exists_yn (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_monitoreo => p_id_monitoreo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE                       DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE                              DEFAULT NULL,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE                        DEFAULT NULL,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE                             DEFAULT 'N' ,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE                       DEFAULT NULL,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE                       DEFAULT NULL,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE                          DEFAULT 3 ,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE               DEFAULT NULL,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE             DEFAULT NULL,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE   DEFAULT NULL,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE                 DEFAULT NULL,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE              DEFAULT NULL,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE                 DEFAULT 1 ,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE                 DEFAULT 'N' ,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE                      DEFAULT 'N' ,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE                         DEFAULT 'D' ,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE              DEFAULT 'N' ,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE                 DEFAULT 'N' ,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE                        DEFAULT NULL,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE                        DEFAULT NULL,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE                        DEFAULT NULL )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
    v_return T_MONITOREOS.ID_MONITOREO%TYPE; 
  BEGIN
    INSERT INTO T_MONITOREOS (
      ID_MONITOREO /*PK*/ /*FK*/,
      CAUSA,
      PLAN_ACCION,
      ACTIVO,
      CONSULTA_SQL,
      BLOQUE_PLSQL,
      PRIORIDAD,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CANTIDAD_EJECUCIONES_CONFLICTO,
      FECHA_ULTIMA_EJECUCION_CONFLICTO,
      ROLES_RESPONSABLES,
      USUARIOS_RESPONSABLES,
      NIVEL_AVISO_CORREO,
      AVISO_NOTIFICACION,
      AVISO_MENSAJE,
      FRECUENCIA,
      OPERA_SISTEMA_CERRADO,
      OPERA_DIA_NO_HABIL,
      HORA_MINIMA,
      HORA_MAXIMA,
      COMENTARIOS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_monitoreo,
      p_causa,
      p_plan_accion,
      p_activo,
      p_consulta_sql,
      p_bloque_plsql,
      p_prioridad,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_cantidad_ejecuciones_conflicto,
      p_fecha_ultima_ejecucion_conflicto,
      p_roles_responsables,
      p_usuarios_responsables,
      p_nivel_aviso_correo,
      p_aviso_notificacion,
      p_aviso_mensaje,
      p_frecuencia,
      p_opera_sistema_cerrado,
      p_opera_dia_no_habil,
      p_hora_minima,
      p_hora_maxima,
      p_comentarios,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MONITOREO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE                       DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE                              DEFAULT NULL,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE                        DEFAULT NULL,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE                             DEFAULT 'N' ,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE                       DEFAULT NULL,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE                       DEFAULT NULL,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE                          DEFAULT 3 ,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE               DEFAULT NULL,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE             DEFAULT NULL,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE   DEFAULT NULL,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE                 DEFAULT NULL,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE              DEFAULT NULL,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE                 DEFAULT 1 ,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE                 DEFAULT 'N' ,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE                      DEFAULT 'N' ,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE                         DEFAULT 'D' ,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE              DEFAULT 'N' ,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE                 DEFAULT 'N' ,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE                        DEFAULT NULL,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE                        DEFAULT NULL,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE                        DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_MONITOREOS (
      ID_MONITOREO /*PK*/ /*FK*/,
      CAUSA,
      PLAN_ACCION,
      ACTIVO,
      CONSULTA_SQL,
      BLOQUE_PLSQL,
      PRIORIDAD,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CANTIDAD_EJECUCIONES_CONFLICTO,
      FECHA_ULTIMA_EJECUCION_CONFLICTO,
      ROLES_RESPONSABLES,
      USUARIOS_RESPONSABLES,
      NIVEL_AVISO_CORREO,
      AVISO_NOTIFICACION,
      AVISO_MENSAJE,
      FRECUENCIA,
      OPERA_SISTEMA_CERRADO,
      OPERA_DIA_NO_HABIL,
      HORA_MINIMA,
      HORA_MAXIMA,
      COMENTARIOS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_monitoreo,
      p_causa,
      p_plan_accion,
      p_activo,
      p_consulta_sql,
      p_bloque_plsql,
      p_prioridad,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_cantidad_ejecuciones_conflicto,
      p_fecha_ultima_ejecucion_conflicto,
      p_roles_responsables,
      p_usuarios_responsables,
      p_nivel_aviso_correo,
      p_aviso_notificacion,
      p_aviso_mensaje,
      p_frecuencia,
      p_opera_sistema_cerrado,
      p_opera_dia_no_habil,
      p_hora_minima,
      p_hora_maxima,
      p_comentarios,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
      p_causa                            => p_row.CAUSA,
      p_plan_accion                      => p_row.PLAN_ACCION,
      p_activo                           => p_row.ACTIVO,
      p_consulta_sql                     => p_row.CONSULTA_SQL,
      p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
      p_prioridad                        => p_row.PRIORIDAD,
      p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
      p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
      p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_roles_responsables               => p_row.ROLES_RESPONSABLES,
      p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
      p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
      p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
      p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
      p_frecuencia                       => p_row.FRECUENCIA,
      p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
      p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
      p_hora_minima                      => p_row.HORA_MINIMA,
      p_hora_maxima                      => p_row.HORA_MAXIMA,
      p_comentarios                      => p_row.COMENTARIOS );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
      p_causa                            => p_row.CAUSA,
      p_plan_accion                      => p_row.PLAN_ACCION,
      p_activo                           => p_row.ACTIVO,
      p_consulta_sql                     => p_row.CONSULTA_SQL,
      p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
      p_prioridad                        => p_row.PRIORIDAD,
      p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
      p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
      p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_roles_responsables               => p_row.ROLES_RESPONSABLES,
      p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
      p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
      p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
      p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
      p_frecuencia                       => p_row.FRECUENCIA,
      p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
      p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
      p_hora_minima                      => p_row.HORA_MINIMA,
      p_hora_maxima                      => p_row.HORA_MAXIMA,
      p_comentarios                      => p_row.COMENTARIOS );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MONITOREOS (
      ID_MONITOREO /*PK*/ /*FK*/,
      CAUSA,
      PLAN_ACCION,
      ACTIVO,
      CONSULTA_SQL,
      BLOQUE_PLSQL,
      PRIORIDAD,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CANTIDAD_EJECUCIONES_CONFLICTO,
      FECHA_ULTIMA_EJECUCION_CONFLICTO,
      ROLES_RESPONSABLES,
      USUARIOS_RESPONSABLES,
      NIVEL_AVISO_CORREO,
      AVISO_NOTIFICACION,
      AVISO_MENSAJE,
      FRECUENCIA,
      OPERA_SISTEMA_CERRADO,
      OPERA_DIA_NO_HABIL,
      HORA_MINIMA,
      HORA_MAXIMA,
      COMENTARIOS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MONITOREO,
      p_rows_tab(i).CAUSA,
      p_rows_tab(i).PLAN_ACCION,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).CONSULTA_SQL,
      p_rows_tab(i).BLOQUE_PLSQL,
      p_rows_tab(i).PRIORIDAD,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).CANTIDAD_EJECUCIONES_CONFLICTO,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_rows_tab(i).ROLES_RESPONSABLES,
      p_rows_tab(i).USUARIOS_RESPONSABLES,
      p_rows_tab(i).NIVEL_AVISO_CORREO,
      p_rows_tab(i).AVISO_NOTIFICACION,
      p_rows_tab(i).AVISO_MENSAJE,
      p_rows_tab(i).FRECUENCIA,
      p_rows_tab(i).OPERA_SISTEMA_CERRADO,
      p_rows_tab(i).OPERA_DIA_NO_HABIL,
      p_rows_tab(i).HORA_MINIMA,
      p_rows_tab(i).HORA_MAXIMA,
      p_rows_tab(i).COMENTARIOS,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MONITOREO /*PK*/ /*FK*/,
      CAUSA,
      PLAN_ACCION,
      ACTIVO,
      CONSULTA_SQL,
      BLOQUE_PLSQL,
      PRIORIDAD,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CANTIDAD_EJECUCIONES_CONFLICTO,
      FECHA_ULTIMA_EJECUCION_CONFLICTO,
      ROLES_RESPONSABLES,
      USUARIOS_RESPONSABLES,
      NIVEL_AVISO_CORREO,
      AVISO_NOTIFICACION,
      AVISO_MENSAJE,
      FRECUENCIA,
      OPERA_SISTEMA_CERRADO,
      OPERA_DIA_NO_HABIL,
      HORA_MINIMA,
      HORA_MAXIMA,
      COMENTARIOS,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    BULK COLLECT INTO v_return;
    RETURN v_return;
  END create_rows;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MONITOREOS (
      ID_MONITOREO /*PK*/ /*FK*/,
      CAUSA,
      PLAN_ACCION,
      ACTIVO,
      CONSULTA_SQL,
      BLOQUE_PLSQL,
      PRIORIDAD,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CANTIDAD_EJECUCIONES_CONFLICTO,
      FECHA_ULTIMA_EJECUCION_CONFLICTO,
      ROLES_RESPONSABLES,
      USUARIOS_RESPONSABLES,
      NIVEL_AVISO_CORREO,
      AVISO_NOTIFICACION,
      AVISO_MENSAJE,
      FRECUENCIA,
      OPERA_SISTEMA_CERRADO,
      OPERA_DIA_NO_HABIL,
      HORA_MINIMA,
      HORA_MAXIMA,
      COMENTARIOS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MONITOREO,
      p_rows_tab(i).CAUSA,
      p_rows_tab(i).PLAN_ACCION,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).CONSULTA_SQL,
      p_rows_tab(i).BLOQUE_PLSQL,
      p_rows_tab(i).PRIORIDAD,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).CANTIDAD_EJECUCIONES_CONFLICTO,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_rows_tab(i).ROLES_RESPONSABLES,
      p_rows_tab(i).USUARIOS_RESPONSABLES,
      p_rows_tab(i).NIVEL_AVISO_CORREO,
      p_rows_tab(i).AVISO_NOTIFICACION,
      p_rows_tab(i).AVISO_MENSAJE,
      p_rows_tab(i).FRECUENCIA,
      p_rows_tab(i).OPERA_SISTEMA_CERRADO,
      p_rows_tab(i).OPERA_DIA_NO_HABIL,
      p_rows_tab(i).HORA_MINIMA,
      p_rows_tab(i).HORA_MAXIMA,
      p_rows_tab(i).COMENTARIOS,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS%ROWTYPE
  IS
    v_row T_MONITOREOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_MONITOREOS
      WHERE
        ID_MONITOREO = p_id_monitoreo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_monitoreo                     IN            T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ /*FK*/,
    p_causa                               OUT NOCOPY T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                         OUT NOCOPY T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                              OUT NOCOPY T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                        OUT NOCOPY T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                        OUT NOCOPY T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                           OUT NOCOPY T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones                OUT NOCOPY T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion              OUT NOCOPY T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto      OUT NOCOPY T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto    OUT NOCOPY T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables                  OUT NOCOPY T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables               OUT NOCOPY T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo                  OUT NOCOPY T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion                  OUT NOCOPY T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                       OUT NOCOPY T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                          OUT NOCOPY T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado               OUT NOCOPY T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil                  OUT NOCOPY T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                         OUT NOCOPY T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                         OUT NOCOPY T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                         OUT NOCOPY T_MONITOREOS.COMENTARIOS%TYPE,
    p_usuario_insercion                   OUT NOCOPY T_MONITOREOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion                     OUT NOCOPY T_MONITOREOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion                OUT NOCOPY T_MONITOREOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion                  OUT NOCOPY T_MONITOREOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_MONITOREOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_monitoreo => p_id_monitoreo );
    p_causa                            := v_row.CAUSA; 
    p_plan_accion                      := v_row.PLAN_ACCION; 
    p_activo                           := v_row.ACTIVO; 
    p_consulta_sql                     := v_row.CONSULTA_SQL; 
    p_bloque_plsql                     := v_row.BLOQUE_PLSQL; 
    p_prioridad                        := v_row.PRIORIDAD; 
    p_cantidad_ejecuciones             := v_row.CANTIDAD_EJECUCIONES; 
    p_fecha_ultima_ejecucion           := v_row.FECHA_ULTIMA_EJECUCION; 
    p_cantidad_ejecuciones_conflicto   := v_row.CANTIDAD_EJECUCIONES_CONFLICTO; 
    p_fecha_ultima_ejecucion_conflicto := v_row.FECHA_ULTIMA_EJECUCION_CONFLICTO; 
    p_roles_responsables               := v_row.ROLES_RESPONSABLES; 
    p_usuarios_responsables            := v_row.USUARIOS_RESPONSABLES; 
    p_nivel_aviso_correo               := v_row.NIVEL_AVISO_CORREO; 
    p_aviso_notificacion               := v_row.AVISO_NOTIFICACION; 
    p_aviso_mensaje                    := v_row.AVISO_MENSAJE; 
    p_frecuencia                       := v_row.FRECUENCIA; 
    p_opera_sistema_cerrado            := v_row.OPERA_SISTEMA_CERRADO; 
    p_opera_dia_no_habil               := v_row.OPERA_DIA_NO_HABIL; 
    p_hora_minima                      := v_row.HORA_MINIMA; 
    p_hora_maxima                      := v_row.HORA_MAXIMA; 
    p_comentarios                      := v_row.COMENTARIOS; 
    p_usuario_insercion                := v_row.USUARIO_INSERCION; 
    p_fecha_insercion                  := v_row.FECHA_INSERCION; 
    p_usuario_modificacion             := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion               := v_row.FECHA_MODIFICACION; 
  END read_row;

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    IF (p_ref_cursor%ISOPEN) THEN
      g_bulk_completed := FALSE;
      FETCH p_ref_cursor BULK COLLECT INTO v_return LIMIT g_bulk_limit;
      IF (v_return.COUNT < g_bulk_limit) THEN
        g_bulk_completed := TRUE;
      END IF;
    END IF;
    RETURN v_return;
  END read_rows;

  FUNCTION update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
    v_return T_MONITOREOS.ID_MONITOREO%TYPE; 
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CAUSA                            = p_causa,
      PLAN_ACCION                      = p_plan_accion,
      ACTIVO                           = p_activo,
      CONSULTA_SQL                     = p_consulta_sql,
      BLOQUE_PLSQL                     = p_bloque_plsql,
      PRIORIDAD                        = p_prioridad,
      CANTIDAD_EJECUCIONES             = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION           = p_fecha_ultima_ejecucion,
      CANTIDAD_EJECUCIONES_CONFLICTO   = p_cantidad_ejecuciones_conflicto,
      FECHA_ULTIMA_EJECUCION_CONFLICTO = p_fecha_ultima_ejecucion_conflicto,
      ROLES_RESPONSABLES               = p_roles_responsables,
      USUARIOS_RESPONSABLES            = p_usuarios_responsables,
      NIVEL_AVISO_CORREO               = p_nivel_aviso_correo,
      AVISO_NOTIFICACION               = p_aviso_notificacion,
      AVISO_MENSAJE                    = p_aviso_mensaje,
      FRECUENCIA                       = p_frecuencia,
      OPERA_SISTEMA_CERRADO            = p_opera_sistema_cerrado,
      OPERA_DIA_NO_HABIL               = p_opera_dia_no_habil,
      HORA_MINIMA                      = p_hora_minima,
      HORA_MAXIMA                      = p_hora_maxima,
      COMENTARIOS                      = p_comentarios,
      USUARIO_MODIFICACION             = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION               = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo
    RETURN 
      ID_MONITOREO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CAUSA                            = p_causa,
      PLAN_ACCION                      = p_plan_accion,
      ACTIVO                           = p_activo,
      CONSULTA_SQL                     = p_consulta_sql,
      BLOQUE_PLSQL                     = p_bloque_plsql,
      PRIORIDAD                        = p_prioridad,
      CANTIDAD_EJECUCIONES             = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION           = p_fecha_ultima_ejecucion,
      CANTIDAD_EJECUCIONES_CONFLICTO   = p_cantidad_ejecuciones_conflicto,
      FECHA_ULTIMA_EJECUCION_CONFLICTO = p_fecha_ultima_ejecucion_conflicto,
      ROLES_RESPONSABLES               = p_roles_responsables,
      USUARIOS_RESPONSABLES            = p_usuarios_responsables,
      NIVEL_AVISO_CORREO               = p_nivel_aviso_correo,
      AVISO_NOTIFICACION               = p_aviso_notificacion,
      AVISO_MENSAJE                    = p_aviso_mensaje,
      FRECUENCIA                       = p_frecuencia,
      OPERA_SISTEMA_CERRADO            = p_opera_sistema_cerrado,
      OPERA_DIA_NO_HABIL               = p_opera_dia_no_habil,
      HORA_MINIMA                      = p_hora_minima,
      HORA_MAXIMA                      = p_hora_maxima,
      COMENTARIOS                      = p_comentarios,
      USUARIO_MODIFICACION             = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION               = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
      p_causa                            => p_row.CAUSA,
      p_plan_accion                      => p_row.PLAN_ACCION,
      p_activo                           => p_row.ACTIVO,
      p_consulta_sql                     => p_row.CONSULTA_SQL,
      p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
      p_prioridad                        => p_row.PRIORIDAD,
      p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
      p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
      p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_roles_responsables               => p_row.ROLES_RESPONSABLES,
      p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
      p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
      p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
      p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
      p_frecuencia                       => p_row.FRECUENCIA,
      p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
      p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
      p_hora_minima                      => p_row.HORA_MINIMA,
      p_hora_maxima                      => p_row.HORA_MAXIMA,
      p_comentarios                      => p_row.COMENTARIOS );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
      p_causa                            => p_row.CAUSA,
      p_plan_accion                      => p_row.PLAN_ACCION,
      p_activo                           => p_row.ACTIVO,
      p_consulta_sql                     => p_row.CONSULTA_SQL,
      p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
      p_prioridad                        => p_row.PRIORIDAD,
      p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
      p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
      p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
      p_roles_responsables               => p_row.ROLES_RESPONSABLES,
      p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
      p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
      p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
      p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
      p_frecuencia                       => p_row.FRECUENCIA,
      p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
      p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
      p_hora_minima                      => p_row.HORA_MINIMA,
      p_hora_maxima                      => p_row.HORA_MAXIMA,
      p_comentarios                      => p_row.COMENTARIOS );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_MONITOREOS
      SET
        CAUSA                            = p_rows_tab(i).CAUSA,
        PLAN_ACCION                      = p_rows_tab(i).PLAN_ACCION,
        ACTIVO                           = p_rows_tab(i).ACTIVO,
        CONSULTA_SQL                     = p_rows_tab(i).CONSULTA_SQL,
        BLOQUE_PLSQL                     = p_rows_tab(i).BLOQUE_PLSQL,
        PRIORIDAD                        = p_rows_tab(i).PRIORIDAD,
        CANTIDAD_EJECUCIONES             = p_rows_tab(i).CANTIDAD_EJECUCIONES,
        FECHA_ULTIMA_EJECUCION           = p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
        CANTIDAD_EJECUCIONES_CONFLICTO   = p_rows_tab(i).CANTIDAD_EJECUCIONES_CONFLICTO,
        FECHA_ULTIMA_EJECUCION_CONFLICTO = p_rows_tab(i).FECHA_ULTIMA_EJECUCION_CONFLICTO,
        ROLES_RESPONSABLES               = p_rows_tab(i).ROLES_RESPONSABLES,
        USUARIOS_RESPONSABLES            = p_rows_tab(i).USUARIOS_RESPONSABLES,
        NIVEL_AVISO_CORREO               = p_rows_tab(i).NIVEL_AVISO_CORREO,
        AVISO_NOTIFICACION               = p_rows_tab(i).AVISO_NOTIFICACION,
        AVISO_MENSAJE                    = p_rows_tab(i).AVISO_MENSAJE,
        FRECUENCIA                       = p_rows_tab(i).FRECUENCIA,
        OPERA_SISTEMA_CERRADO            = p_rows_tab(i).OPERA_SISTEMA_CERRADO,
        OPERA_DIA_NO_HABIL               = p_rows_tab(i).OPERA_DIA_NO_HABIL,
        HORA_MINIMA                      = p_rows_tab(i).HORA_MINIMA,
        HORA_MAXIMA                      = p_rows_tab(i).HORA_MAXIMA,
        COMENTARIOS                      = p_rows_tab(i).COMENTARIOS,
        USUARIO_MODIFICACION             = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION               = systimestamp
      WHERE
        ID_MONITOREO = p_rows_tab(i).ID_MONITOREO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_MONITOREOS
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_MONITOREOS
       WHERE ID_MONITOREO = p_rows_tab(i).ID_MONITOREO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_monitoreo => p_id_monitoreo
    )
    THEN
      RETURN update_row (
        p_id_monitoreo                     => p_id_monitoreo /*PK*/ /*FK*/,
        p_causa                            => p_causa,
        p_plan_accion                      => p_plan_accion,
        p_activo                           => p_activo,
        p_consulta_sql                     => p_consulta_sql,
        p_bloque_plsql                     => p_bloque_plsql,
        p_prioridad                        => p_prioridad,
        p_cantidad_ejecuciones             => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion           => p_fecha_ultima_ejecucion,
        p_cantidad_ejecuciones_conflicto   => p_cantidad_ejecuciones_conflicto,
        p_fecha_ultima_ejecucion_conflicto => p_fecha_ultima_ejecucion_conflicto,
        p_roles_responsables               => p_roles_responsables,
        p_usuarios_responsables            => p_usuarios_responsables,
        p_nivel_aviso_correo               => p_nivel_aviso_correo,
        p_aviso_notificacion               => p_aviso_notificacion,
        p_aviso_mensaje                    => p_aviso_mensaje,
        p_frecuencia                       => p_frecuencia,
        p_opera_sistema_cerrado            => p_opera_sistema_cerrado,
        p_opera_dia_no_habil               => p_opera_dia_no_habil,
        p_hora_minima                      => p_hora_minima,
        p_hora_maxima                      => p_hora_maxima,
        p_comentarios                      => p_comentarios );
    ELSE
      RETURN create_row (
        p_id_monitoreo                     => p_id_monitoreo /*PK*/ /*FK*/,
        p_causa                            => p_causa,
        p_plan_accion                      => p_plan_accion,
        p_activo                           => p_activo,
        p_consulta_sql                     => p_consulta_sql,
        p_bloque_plsql                     => p_bloque_plsql,
        p_prioridad                        => p_prioridad,
        p_cantidad_ejecuciones             => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion           => p_fecha_ultima_ejecucion,
        p_cantidad_ejecuciones_conflicto   => p_cantidad_ejecuciones_conflicto,
        p_fecha_ultima_ejecucion_conflicto => p_fecha_ultima_ejecucion_conflicto,
        p_roles_responsables               => p_roles_responsables,
        p_usuarios_responsables            => p_usuarios_responsables,
        p_nivel_aviso_correo               => p_nivel_aviso_correo,
        p_aviso_notificacion               => p_aviso_notificacion,
        p_aviso_mensaje                    => p_aviso_mensaje,
        p_frecuencia                       => p_frecuencia,
        p_opera_sistema_cerrado            => p_opera_sistema_cerrado,
        p_opera_dia_no_habil               => p_opera_dia_no_habil,
        p_hora_minima                      => p_hora_minima,
        p_hora_maxima                      => p_hora_maxima,
        p_comentarios                      => p_comentarios );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_monitoreo => p_id_monitoreo
    )
    THEN
      update_row (
        p_id_monitoreo                     => p_id_monitoreo /*PK*/ /*FK*/,
        p_causa                            => p_causa,
        p_plan_accion                      => p_plan_accion,
        p_activo                           => p_activo,
        p_consulta_sql                     => p_consulta_sql,
        p_bloque_plsql                     => p_bloque_plsql,
        p_prioridad                        => p_prioridad,
        p_cantidad_ejecuciones             => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion           => p_fecha_ultima_ejecucion,
        p_cantidad_ejecuciones_conflicto   => p_cantidad_ejecuciones_conflicto,
        p_fecha_ultima_ejecucion_conflicto => p_fecha_ultima_ejecucion_conflicto,
        p_roles_responsables               => p_roles_responsables,
        p_usuarios_responsables            => p_usuarios_responsables,
        p_nivel_aviso_correo               => p_nivel_aviso_correo,
        p_aviso_notificacion               => p_aviso_notificacion,
        p_aviso_mensaje                    => p_aviso_mensaje,
        p_frecuencia                       => p_frecuencia,
        p_opera_sistema_cerrado            => p_opera_sistema_cerrado,
        p_opera_dia_no_habil               => p_opera_dia_no_habil,
        p_hora_minima                      => p_hora_minima,
        p_hora_maxima                      => p_hora_maxima,
        p_comentarios                      => p_comentarios );
    ELSE
      create_row (
        p_id_monitoreo                     => p_id_monitoreo /*PK*/ /*FK*/,
        p_causa                            => p_causa,
        p_plan_accion                      => p_plan_accion,
        p_activo                           => p_activo,
        p_consulta_sql                     => p_consulta_sql,
        p_bloque_plsql                     => p_bloque_plsql,
        p_prioridad                        => p_prioridad,
        p_cantidad_ejecuciones             => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion           => p_fecha_ultima_ejecucion,
        p_cantidad_ejecuciones_conflicto   => p_cantidad_ejecuciones_conflicto,
        p_fecha_ultima_ejecucion_conflicto => p_fecha_ultima_ejecucion_conflicto,
        p_roles_responsables               => p_roles_responsables,
        p_usuarios_responsables            => p_usuarios_responsables,
        p_nivel_aviso_correo               => p_nivel_aviso_correo,
        p_aviso_notificacion               => p_aviso_notificacion,
        p_aviso_mensaje                    => p_aviso_mensaje,
        p_frecuencia                       => p_frecuencia,
        p_opera_sistema_cerrado            => p_opera_sistema_cerrado,
        p_opera_dia_no_habil               => p_opera_dia_no_habil,
        p_hora_minima                      => p_hora_minima,
        p_hora_maxima                      => p_hora_maxima,
        p_comentarios                      => p_comentarios );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_monitoreo => p_row.ID_MONITOREO
    )
    THEN
      RETURN update_row (
        p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
        p_causa                            => p_row.CAUSA,
        p_plan_accion                      => p_row.PLAN_ACCION,
        p_activo                           => p_row.ACTIVO,
        p_consulta_sql                     => p_row.CONSULTA_SQL,
        p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
        p_prioridad                        => p_row.PRIORIDAD,
        p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
        p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
        p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
        p_roles_responsables               => p_row.ROLES_RESPONSABLES,
        p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
        p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
        p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
        p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
        p_frecuencia                       => p_row.FRECUENCIA,
        p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
        p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
        p_hora_minima                      => p_row.HORA_MINIMA,
        p_hora_maxima                      => p_row.HORA_MAXIMA,
        p_comentarios                      => p_row.COMENTARIOS );
    ELSE
      RETURN create_row (
        p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
        p_causa                            => p_row.CAUSA,
        p_plan_accion                      => p_row.PLAN_ACCION,
        p_activo                           => p_row.ACTIVO,
        p_consulta_sql                     => p_row.CONSULTA_SQL,
        p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
        p_prioridad                        => p_row.PRIORIDAD,
        p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
        p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
        p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
        p_roles_responsables               => p_row.ROLES_RESPONSABLES,
        p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
        p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
        p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
        p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
        p_frecuencia                       => p_row.FRECUENCIA,
        p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
        p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
        p_hora_minima                      => p_row.HORA_MINIMA,
        p_hora_maxima                      => p_row.HORA_MAXIMA,
        p_comentarios                      => p_row.COMENTARIOS );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_monitoreo => p_row.ID_MONITOREO
    )
    THEN
      update_row (
        p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
        p_causa                            => p_row.CAUSA,
        p_plan_accion                      => p_row.PLAN_ACCION,
        p_activo                           => p_row.ACTIVO,
        p_consulta_sql                     => p_row.CONSULTA_SQL,
        p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
        p_prioridad                        => p_row.PRIORIDAD,
        p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
        p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
        p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
        p_roles_responsables               => p_row.ROLES_RESPONSABLES,
        p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
        p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
        p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
        p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
        p_frecuencia                       => p_row.FRECUENCIA,
        p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
        p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
        p_hora_minima                      => p_row.HORA_MINIMA,
        p_hora_maxima                      => p_row.HORA_MAXIMA,
        p_comentarios                      => p_row.COMENTARIOS );
    ELSE
      create_row (
        p_id_monitoreo                     => p_row.ID_MONITOREO /*PK*/ /*FK*/,
        p_causa                            => p_row.CAUSA,
        p_plan_accion                      => p_row.PLAN_ACCION,
        p_activo                           => p_row.ACTIVO,
        p_consulta_sql                     => p_row.CONSULTA_SQL,
        p_bloque_plsql                     => p_row.BLOQUE_PLSQL,
        p_prioridad                        => p_row.PRIORIDAD,
        p_cantidad_ejecuciones             => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion           => p_row.FECHA_ULTIMA_EJECUCION,
        p_cantidad_ejecuciones_conflicto   => p_row.CANTIDAD_EJECUCIONES_CONFLICTO,
        p_fecha_ultima_ejecucion_conflicto => p_row.FECHA_ULTIMA_EJECUCION_CONFLICTO,
        p_roles_responsables               => p_row.ROLES_RESPONSABLES,
        p_usuarios_responsables            => p_row.USUARIOS_RESPONSABLES,
        p_nivel_aviso_correo               => p_row.NIVEL_AVISO_CORREO,
        p_aviso_notificacion               => p_row.AVISO_NOTIFICACION,
        p_aviso_mensaje                    => p_row.AVISO_MENSAJE,
        p_frecuencia                       => p_row.FRECUENCIA,
        p_opera_sistema_cerrado            => p_row.OPERA_SISTEMA_CERRADO,
        p_opera_dia_no_habil               => p_row.OPERA_DIA_NO_HABIL,
        p_hora_minima                      => p_row.HORA_MINIMA,
        p_hora_maxima                      => p_row.HORA_MAXIMA,
        p_comentarios                      => p_row.COMENTARIOS );
    END IF;
  END create_or_update_row;

  FUNCTION get_causa (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CAUSA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).CAUSA;
  END get_causa;

  FUNCTION get_plan_accion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.PLAN_ACCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).PLAN_ACCION;
  END get_plan_accion;

  FUNCTION get_activo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).ACTIVO;
  END get_activo;

  FUNCTION get_consulta_sql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CONSULTA_SQL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).CONSULTA_SQL;
  END get_consulta_sql;

  FUNCTION get_bloque_plsql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.BLOQUE_PLSQL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).BLOQUE_PLSQL;
  END get_bloque_plsql;

  FUNCTION get_prioridad (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.PRIORIDAD%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).PRIORIDAD;
  END get_prioridad;

  FUNCTION get_cantidad_ejecuciones (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).CANTIDAD_EJECUCIONES;
  END get_cantidad_ejecuciones;

  FUNCTION get_fecha_ultima_ejecucion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).FECHA_ULTIMA_EJECUCION;
  END get_fecha_ultima_ejecucion;

  FUNCTION get_cantidad_ejecuciones_conflicto (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).CANTIDAD_EJECUCIONES_CONFLICTO;
  END get_cantidad_ejecuciones_conflicto;

  FUNCTION get_fecha_ultima_ejecucion_conflicto (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).FECHA_ULTIMA_EJECUCION_CONFLICTO;
  END get_fecha_ultima_ejecucion_conflicto;

  FUNCTION get_roles_responsables (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.ROLES_RESPONSABLES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).ROLES_RESPONSABLES;
  END get_roles_responsables;

  FUNCTION get_usuarios_responsables (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).USUARIOS_RESPONSABLES;
  END get_usuarios_responsables;

  FUNCTION get_nivel_aviso_correo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).NIVEL_AVISO_CORREO;
  END get_nivel_aviso_correo;

  FUNCTION get_aviso_notificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.AVISO_NOTIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).AVISO_NOTIFICACION;
  END get_aviso_notificacion;

  FUNCTION get_aviso_mensaje (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.AVISO_MENSAJE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).AVISO_MENSAJE;
  END get_aviso_mensaje;

  FUNCTION get_frecuencia (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FRECUENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).FRECUENCIA;
  END get_frecuencia;

  FUNCTION get_opera_sistema_cerrado (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).OPERA_SISTEMA_CERRADO;
  END get_opera_sistema_cerrado;

  FUNCTION get_opera_dia_no_habil (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).OPERA_DIA_NO_HABIL;
  END get_opera_dia_no_habil;

  FUNCTION get_hora_minima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.HORA_MINIMA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).HORA_MINIMA;
  END get_hora_minima;

  FUNCTION get_hora_maxima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.HORA_MAXIMA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).HORA_MAXIMA;
  END get_hora_maxima;

  FUNCTION get_comentarios (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.COMENTARIOS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).COMENTARIOS;
  END get_comentarios;

  FUNCTION get_usuario_insercion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_monitoreo => p_id_monitoreo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_causa (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_causa        IN T_MONITOREOS.CAUSA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CAUSA                = p_causa,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_causa;

  PROCEDURE set_plan_accion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_plan_accion  IN T_MONITOREOS.PLAN_ACCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      PLAN_ACCION          = p_plan_accion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_plan_accion;

  PROCEDURE set_activo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_activo       IN T_MONITOREOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_activo;

  PROCEDURE set_consulta_sql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_consulta_sql IN T_MONITOREOS.CONSULTA_SQL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CONSULTA_SQL         = p_consulta_sql,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_consulta_sql;

  PROCEDURE set_bloque_plsql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_bloque_plsql IN T_MONITOREOS.BLOQUE_PLSQL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      BLOQUE_PLSQL         = p_bloque_plsql,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_bloque_plsql;

  PROCEDURE set_prioridad (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_prioridad    IN T_MONITOREOS.PRIORIDAD%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      PRIORIDAD            = p_prioridad,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_prioridad;

  PROCEDURE set_cantidad_ejecuciones (
    p_id_monitoreo         IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_cantidad_ejecuciones IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CANTIDAD_EJECUCIONES = p_cantidad_ejecuciones,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_cantidad_ejecuciones;

  PROCEDURE set_fecha_ultima_ejecucion (
    p_id_monitoreo           IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_fecha_ultima_ejecucion;

  PROCEDURE set_cantidad_ejecuciones_conflicto (
    p_id_monitoreo                   IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_cantidad_ejecuciones_conflicto IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      CANTIDAD_EJECUCIONES_CONFLICTO = p_cantidad_ejecuciones_conflicto,
      USUARIO_MODIFICACION           = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION             = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_cantidad_ejecuciones_conflicto;

  PROCEDURE set_fecha_ultima_ejecucion_conflicto (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      FECHA_ULTIMA_EJECUCION_CONFLICTO = p_fecha_ultima_ejecucion_conflicto,
      USUARIO_MODIFICACION             = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION               = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_fecha_ultima_ejecucion_conflicto;

  PROCEDURE set_roles_responsables (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_roles_responsables IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      ROLES_RESPONSABLES   = p_roles_responsables,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_roles_responsables;

  PROCEDURE set_usuarios_responsables (
    p_id_monitoreo          IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_usuarios_responsables IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      USUARIOS_RESPONSABLES = p_usuarios_responsables,
      USUARIO_MODIFICACION  = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION    = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_usuarios_responsables;

  PROCEDURE set_nivel_aviso_correo (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_nivel_aviso_correo IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      NIVEL_AVISO_CORREO   = p_nivel_aviso_correo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_nivel_aviso_correo;

  PROCEDURE set_aviso_notificacion (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_aviso_notificacion IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      AVISO_NOTIFICACION   = p_aviso_notificacion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_aviso_notificacion;

  PROCEDURE set_aviso_mensaje (
    p_id_monitoreo  IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_aviso_mensaje IN T_MONITOREOS.AVISO_MENSAJE%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      AVISO_MENSAJE        = p_aviso_mensaje,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_aviso_mensaje;

  PROCEDURE set_frecuencia (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_frecuencia   IN T_MONITOREOS.FRECUENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      FRECUENCIA           = p_frecuencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_frecuencia;

  PROCEDURE set_opera_sistema_cerrado (
    p_id_monitoreo          IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_opera_sistema_cerrado IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      OPERA_SISTEMA_CERRADO = p_opera_sistema_cerrado,
      USUARIO_MODIFICACION  = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION    = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_opera_sistema_cerrado;

  PROCEDURE set_opera_dia_no_habil (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_opera_dia_no_habil IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      OPERA_DIA_NO_HABIL   = p_opera_dia_no_habil,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_opera_dia_no_habil;

  PROCEDURE set_hora_minima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_hora_minima  IN T_MONITOREOS.HORA_MINIMA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      HORA_MINIMA          = p_hora_minima,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_hora_minima;

  PROCEDURE set_hora_maxima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_hora_maxima  IN T_MONITOREOS.HORA_MAXIMA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      HORA_MAXIMA          = p_hora_maxima,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_hora_maxima;

  PROCEDURE set_comentarios (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_comentarios  IN T_MONITOREOS.COMENTARIOS%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONITOREOS
    SET
      COMENTARIOS          = p_comentarios,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONITOREO = p_id_monitoreo;
  END set_comentarios;

  FUNCTION get_default_row
  RETURN T_MONITOREOS%ROWTYPE
  IS
    v_row T_MONITOREOS%ROWTYPE;
  BEGIN
    v_row.ACTIVO                := 'N' ;
    v_row.PRIORIDAD             := 3 ;
    v_row.NIVEL_AVISO_CORREO    := 1 ;
    v_row.AVISO_NOTIFICACION    := 'N' ;
    v_row.AVISO_MENSAJE         := 'N' ;
    v_row.FRECUENCIA            := 'D' ;
    v_row.OPERA_SISTEMA_CERRADO := 'N' ;
    v_row.OPERA_DIA_NO_HABIL    := 'N' ;
    v_row.USUARIO_INSERCION     := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION       := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_MONITOREOS_API;
/

