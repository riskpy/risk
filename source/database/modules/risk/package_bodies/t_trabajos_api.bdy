CREATE OR REPLACE PACKAGE BODY T_TRABAJOS_API IS
  /*
  This is the API for the table T_TRABAJOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:59
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
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_TRABAJOS
      WHERE
        ID_TRABAJO = p_id_trabajo;
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
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_trabajo => p_id_trabajo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE               DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE                     DEFAULT NULL,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE                   DEFAULT NULL,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE             DEFAULT NULL,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE            DEFAULT NULL,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE     DEFAULT NULL,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE                DEFAULT NULL,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE              DEFAULT NULL,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE   DEFAULT NULL,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE                 DEFAULT NULL )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
    v_return T_TRABAJOS.ID_TRABAJO%TYPE; 
  BEGIN
    INSERT INTO T_TRABAJOS (
      ID_TRABAJO /*PK*/ /*FK*/,
      TIPO,
      ACCION,
      FECHA_INICIO,
      TIEMPO_INICIO,
      INTERVALO_REPETICION,
      FECHA_FIN,
      COMENTARIOS,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      PROGRAMA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_trabajo,
      p_tipo,
      p_accion,
      p_fecha_inicio,
      p_tiempo_inicio,
      p_intervalo_repeticion,
      p_fecha_fin,
      p_comentarios,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_programa,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_TRABAJO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE               DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE                     DEFAULT NULL,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE                   DEFAULT NULL,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE             DEFAULT NULL,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE            DEFAULT NULL,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE     DEFAULT NULL,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE                DEFAULT NULL,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE              DEFAULT NULL,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE   DEFAULT NULL,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE                 DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_TRABAJOS (
      ID_TRABAJO /*PK*/ /*FK*/,
      TIPO,
      ACCION,
      FECHA_INICIO,
      TIEMPO_INICIO,
      INTERVALO_REPETICION,
      FECHA_FIN,
      COMENTARIOS,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      PROGRAMA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_trabajo,
      p_tipo,
      p_accion,
      p_fecha_inicio,
      p_tiempo_inicio,
      p_intervalo_repeticion,
      p_fecha_fin,
      p_comentarios,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_programa,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_accion                 => p_row.ACCION,
      p_fecha_inicio           => p_row.FECHA_INICIO,
      p_tiempo_inicio          => p_row.TIEMPO_INICIO,
      p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
      p_fecha_fin              => p_row.FECHA_FIN,
      p_comentarios            => p_row.COMENTARIOS,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_programa               => p_row.PROGRAMA );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_accion                 => p_row.ACCION,
      p_fecha_inicio           => p_row.FECHA_INICIO,
      p_tiempo_inicio          => p_row.TIEMPO_INICIO,
      p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
      p_fecha_fin              => p_row.FECHA_FIN,
      p_comentarios            => p_row.COMENTARIOS,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_programa               => p_row.PROGRAMA );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_TRABAJOS (
      ID_TRABAJO /*PK*/ /*FK*/,
      TIPO,
      ACCION,
      FECHA_INICIO,
      TIEMPO_INICIO,
      INTERVALO_REPETICION,
      FECHA_FIN,
      COMENTARIOS,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      PROGRAMA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_TRABAJO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ACCION,
      p_rows_tab(i).FECHA_INICIO,
      p_rows_tab(i).TIEMPO_INICIO,
      p_rows_tab(i).INTERVALO_REPETICION,
      p_rows_tab(i).FECHA_FIN,
      p_rows_tab(i).COMENTARIOS,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).PROGRAMA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_TRABAJO /*PK*/ /*FK*/,
      TIPO,
      ACCION,
      FECHA_INICIO,
      TIEMPO_INICIO,
      INTERVALO_REPETICION,
      FECHA_FIN,
      COMENTARIOS,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      PROGRAMA,
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
    INSERT INTO T_TRABAJOS (
      ID_TRABAJO /*PK*/ /*FK*/,
      TIPO,
      ACCION,
      FECHA_INICIO,
      TIEMPO_INICIO,
      INTERVALO_REPETICION,
      FECHA_FIN,
      COMENTARIOS,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      PROGRAMA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_TRABAJO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ACCION,
      p_rows_tab(i).FECHA_INICIO,
      p_rows_tab(i).TIEMPO_INICIO,
      p_rows_tab(i).INTERVALO_REPETICION,
      p_rows_tab(i).FECHA_FIN,
      p_rows_tab(i).COMENTARIOS,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).PROGRAMA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS%ROWTYPE
  IS
    v_row T_TRABAJOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_TRABAJOS
      WHERE
        ID_TRABAJO = p_id_trabajo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_trabajo             IN            T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ /*FK*/,
    p_tipo                      OUT NOCOPY T_TRABAJOS.TIPO%TYPE,
    p_accion                    OUT NOCOPY T_TRABAJOS.ACCION%TYPE,
    p_fecha_inicio              OUT NOCOPY T_TRABAJOS.FECHA_INICIO%TYPE,
    p_tiempo_inicio             OUT NOCOPY T_TRABAJOS.TIEMPO_INICIO%TYPE,
    p_intervalo_repeticion      OUT NOCOPY T_TRABAJOS.INTERVALO_REPETICION%TYPE,
    p_fecha_fin                 OUT NOCOPY T_TRABAJOS.FECHA_FIN%TYPE,
    p_comentarios               OUT NOCOPY T_TRABAJOS.COMENTARIOS%TYPE,
    p_cantidad_ejecuciones      OUT NOCOPY T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion    OUT NOCOPY T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_programa                  OUT NOCOPY T_TRABAJOS.PROGRAMA%TYPE,
    p_usuario_insercion         OUT NOCOPY T_TRABAJOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion           OUT NOCOPY T_TRABAJOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion      OUT NOCOPY T_TRABAJOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion        OUT NOCOPY T_TRABAJOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_TRABAJOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_trabajo => p_id_trabajo );
    p_tipo                   := v_row.TIPO; 
    p_accion                 := v_row.ACCION; 
    p_fecha_inicio           := v_row.FECHA_INICIO; 
    p_tiempo_inicio          := v_row.TIEMPO_INICIO; 
    p_intervalo_repeticion   := v_row.INTERVALO_REPETICION; 
    p_fecha_fin              := v_row.FECHA_FIN; 
    p_comentarios            := v_row.COMENTARIOS; 
    p_cantidad_ejecuciones   := v_row.CANTIDAD_EJECUCIONES; 
    p_fecha_ultima_ejecucion := v_row.FECHA_ULTIMA_EJECUCION; 
    p_programa               := v_row.PROGRAMA; 
    p_usuario_insercion      := v_row.USUARIO_INSERCION; 
    p_fecha_insercion        := v_row.FECHA_INSERCION; 
    p_usuario_modificacion   := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion     := v_row.FECHA_MODIFICACION; 
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
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
    v_return T_TRABAJOS.ID_TRABAJO%TYPE; 
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      TIPO                   = p_tipo,
      ACCION                 = p_accion,
      FECHA_INICIO           = p_fecha_inicio,
      TIEMPO_INICIO          = p_tiempo_inicio,
      INTERVALO_REPETICION   = p_intervalo_repeticion,
      FECHA_FIN              = p_fecha_fin,
      COMENTARIOS            = p_comentarios,
      CANTIDAD_EJECUCIONES   = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      PROGRAMA               = p_programa,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo
    RETURN 
      ID_TRABAJO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      TIPO                   = p_tipo,
      ACCION                 = p_accion,
      FECHA_INICIO           = p_fecha_inicio,
      TIEMPO_INICIO          = p_tiempo_inicio,
      INTERVALO_REPETICION   = p_intervalo_repeticion,
      FECHA_FIN              = p_fecha_fin,
      COMENTARIOS            = p_comentarios,
      CANTIDAD_EJECUCIONES   = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      PROGRAMA               = p_programa,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_accion                 => p_row.ACCION,
      p_fecha_inicio           => p_row.FECHA_INICIO,
      p_tiempo_inicio          => p_row.TIEMPO_INICIO,
      p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
      p_fecha_fin              => p_row.FECHA_FIN,
      p_comentarios            => p_row.COMENTARIOS,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_programa               => p_row.PROGRAMA );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_accion                 => p_row.ACCION,
      p_fecha_inicio           => p_row.FECHA_INICIO,
      p_tiempo_inicio          => p_row.TIEMPO_INICIO,
      p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
      p_fecha_fin              => p_row.FECHA_FIN,
      p_comentarios            => p_row.COMENTARIOS,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_programa               => p_row.PROGRAMA );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_TRABAJOS
      SET
        TIPO                   = p_rows_tab(i).TIPO,
        ACCION                 = p_rows_tab(i).ACCION,
        FECHA_INICIO           = p_rows_tab(i).FECHA_INICIO,
        TIEMPO_INICIO          = p_rows_tab(i).TIEMPO_INICIO,
        INTERVALO_REPETICION   = p_rows_tab(i).INTERVALO_REPETICION,
        FECHA_FIN              = p_rows_tab(i).FECHA_FIN,
        COMENTARIOS            = p_rows_tab(i).COMENTARIOS,
        CANTIDAD_EJECUCIONES   = p_rows_tab(i).CANTIDAD_EJECUCIONES,
        FECHA_ULTIMA_EJECUCION = p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
        PROGRAMA               = p_rows_tab(i).PROGRAMA,
        USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION     = systimestamp
      WHERE
        ID_TRABAJO = p_rows_tab(i).ID_TRABAJO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_TRABAJOS
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_TRABAJOS
       WHERE ID_TRABAJO = p_rows_tab(i).ID_TRABAJO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_trabajo => p_id_trabajo
    )
    THEN
      RETURN update_row (
        p_id_trabajo             => p_id_trabajo /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_accion                 => p_accion,
        p_fecha_inicio           => p_fecha_inicio,
        p_tiempo_inicio          => p_tiempo_inicio,
        p_intervalo_repeticion   => p_intervalo_repeticion,
        p_fecha_fin              => p_fecha_fin,
        p_comentarios            => p_comentarios,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_programa               => p_programa );
    ELSE
      RETURN create_row (
        p_id_trabajo             => p_id_trabajo /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_accion                 => p_accion,
        p_fecha_inicio           => p_fecha_inicio,
        p_tiempo_inicio          => p_tiempo_inicio,
        p_intervalo_repeticion   => p_intervalo_repeticion,
        p_fecha_fin              => p_fecha_fin,
        p_comentarios            => p_comentarios,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_programa               => p_programa );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_TRABAJOS.TIPO%TYPE,
    p_accion                 IN T_TRABAJOS.ACCION%TYPE,
    p_fecha_inicio           IN T_TRABAJOS.FECHA_INICIO%TYPE,
    p_tiempo_inicio          IN T_TRABAJOS.TIEMPO_INICIO%TYPE,
    p_intervalo_repeticion   IN T_TRABAJOS.INTERVALO_REPETICION%TYPE,
    p_fecha_fin              IN T_TRABAJOS.FECHA_FIN%TYPE,
    p_comentarios            IN T_TRABAJOS.COMENTARIOS%TYPE,
    p_cantidad_ejecuciones   IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_programa               IN T_TRABAJOS.PROGRAMA%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_trabajo => p_id_trabajo
    )
    THEN
      update_row (
        p_id_trabajo             => p_id_trabajo /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_accion                 => p_accion,
        p_fecha_inicio           => p_fecha_inicio,
        p_tiempo_inicio          => p_tiempo_inicio,
        p_intervalo_repeticion   => p_intervalo_repeticion,
        p_fecha_fin              => p_fecha_fin,
        p_comentarios            => p_comentarios,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_programa               => p_programa );
    ELSE
      create_row (
        p_id_trabajo             => p_id_trabajo /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_accion                 => p_accion,
        p_fecha_inicio           => p_fecha_inicio,
        p_tiempo_inicio          => p_tiempo_inicio,
        p_intervalo_repeticion   => p_intervalo_repeticion,
        p_fecha_fin              => p_fecha_fin,
        p_comentarios            => p_comentarios,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_programa               => p_programa );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  RETURN T_TRABAJOS.ID_TRABAJO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_trabajo => p_row.ID_TRABAJO
    )
    THEN
      RETURN update_row (
        p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_accion                 => p_row.ACCION,
        p_fecha_inicio           => p_row.FECHA_INICIO,
        p_tiempo_inicio          => p_row.TIEMPO_INICIO,
        p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
        p_fecha_fin              => p_row.FECHA_FIN,
        p_comentarios            => p_row.COMENTARIOS,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_programa               => p_row.PROGRAMA );
    ELSE
      RETURN create_row (
        p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_accion                 => p_row.ACCION,
        p_fecha_inicio           => p_row.FECHA_INICIO,
        p_tiempo_inicio          => p_row.TIEMPO_INICIO,
        p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
        p_fecha_fin              => p_row.FECHA_FIN,
        p_comentarios            => p_row.COMENTARIOS,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_programa               => p_row.PROGRAMA );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_TRABAJOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_trabajo => p_row.ID_TRABAJO
    )
    THEN
      update_row (
        p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_accion                 => p_row.ACCION,
        p_fecha_inicio           => p_row.FECHA_INICIO,
        p_tiempo_inicio          => p_row.TIEMPO_INICIO,
        p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
        p_fecha_fin              => p_row.FECHA_FIN,
        p_comentarios            => p_row.COMENTARIOS,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_programa               => p_row.PROGRAMA );
    ELSE
      create_row (
        p_id_trabajo             => p_row.ID_TRABAJO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_accion                 => p_row.ACCION,
        p_fecha_inicio           => p_row.FECHA_INICIO,
        p_tiempo_inicio          => p_row.TIEMPO_INICIO,
        p_intervalo_repeticion   => p_row.INTERVALO_REPETICION,
        p_fecha_fin              => p_row.FECHA_FIN,
        p_comentarios            => p_row.COMENTARIOS,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_programa               => p_row.PROGRAMA );
    END IF;
  END create_or_update_row;

  FUNCTION get_tipo (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.TIPO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).TIPO;
  END get_tipo;

  FUNCTION get_accion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.ACCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).ACCION;
  END get_accion;

  FUNCTION get_fecha_inicio (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.FECHA_INICIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).FECHA_INICIO;
  END get_fecha_inicio;

  FUNCTION get_tiempo_inicio (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.TIEMPO_INICIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).TIEMPO_INICIO;
  END get_tiempo_inicio;

  FUNCTION get_intervalo_repeticion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.INTERVALO_REPETICION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).INTERVALO_REPETICION;
  END get_intervalo_repeticion;

  FUNCTION get_fecha_fin (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.FECHA_FIN%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).FECHA_FIN;
  END get_fecha_fin;

  FUNCTION get_comentarios (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.COMENTARIOS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).COMENTARIOS;
  END get_comentarios;

  FUNCTION get_cantidad_ejecuciones (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).CANTIDAD_EJECUCIONES;
  END get_cantidad_ejecuciones;

  FUNCTION get_fecha_ultima_ejecucion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).FECHA_ULTIMA_EJECUCION;
  END get_fecha_ultima_ejecucion;

  FUNCTION get_programa (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.PROGRAMA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).PROGRAMA;
  END get_programa;

  FUNCTION get_usuario_insercion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/ )
  RETURN T_TRABAJOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_trabajo => p_id_trabajo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_tipo (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_tipo       IN T_TRABAJOS.TIPO%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      TIPO                 = p_tipo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_tipo;

  PROCEDURE set_accion (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_accion     IN T_TRABAJOS.ACCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      ACCION               = p_accion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_accion;

  PROCEDURE set_fecha_inicio (
    p_id_trabajo   IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_fecha_inicio IN T_TRABAJOS.FECHA_INICIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      FECHA_INICIO         = p_fecha_inicio,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_fecha_inicio;

  PROCEDURE set_tiempo_inicio (
    p_id_trabajo    IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_tiempo_inicio IN T_TRABAJOS.TIEMPO_INICIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      TIEMPO_INICIO        = p_tiempo_inicio,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_tiempo_inicio;

  PROCEDURE set_intervalo_repeticion (
    p_id_trabajo           IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_intervalo_repeticion IN T_TRABAJOS.INTERVALO_REPETICION%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      INTERVALO_REPETICION = p_intervalo_repeticion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_intervalo_repeticion;

  PROCEDURE set_fecha_fin (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_fecha_fin  IN T_TRABAJOS.FECHA_FIN%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      FECHA_FIN            = p_fecha_fin,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_fecha_fin;

  PROCEDURE set_comentarios (
    p_id_trabajo  IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_comentarios IN T_TRABAJOS.COMENTARIOS%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      COMENTARIOS          = p_comentarios,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_comentarios;

  PROCEDURE set_cantidad_ejecuciones (
    p_id_trabajo           IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_cantidad_ejecuciones IN T_TRABAJOS.CANTIDAD_EJECUCIONES%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      CANTIDAD_EJECUCIONES = p_cantidad_ejecuciones,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_cantidad_ejecuciones;

  PROCEDURE set_fecha_ultima_ejecucion (
    p_id_trabajo             IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion IN T_TRABAJOS.FECHA_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_fecha_ultima_ejecucion;

  PROCEDURE set_programa (
    p_id_trabajo IN T_TRABAJOS.ID_TRABAJO%TYPE /*PK*/,
    p_programa   IN T_TRABAJOS.PROGRAMA%TYPE )
  IS
  BEGIN
    UPDATE
      T_TRABAJOS
    SET
      PROGRAMA             = p_programa,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_TRABAJO = p_id_trabajo;
  END set_programa;

  FUNCTION get_default_row
  RETURN T_TRABAJOS%ROWTYPE
  IS
    v_row T_TRABAJOS%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_TRABAJOS_API;
/

