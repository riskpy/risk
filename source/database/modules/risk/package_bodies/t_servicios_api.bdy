CREATE OR REPLACE PACKAGE BODY T_SERVICIOS_API IS
  /*
  This is the API for the table T_SERVICIOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:52
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
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_SERVICIOS
      WHERE
        ID_SERVICIO = p_id_servicio;
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
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_servicio => p_id_servicio )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
    v_return T_SERVICIOS.ID_SERVICIO%TYPE; 
  BEGIN
    INSERT INTO T_SERVICIOS (
      ID_SERVICIO /*PK*/ /*FK*/,
      TIPO,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CONSULTA_SQL,
      SQL_ULTIMA_EJECUCION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_servicio,
      p_tipo,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_consulta_sql,
      p_sql_ultima_ejecucion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_SERVICIO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    INSERT INTO T_SERVICIOS (
      ID_SERVICIO /*PK*/ /*FK*/,
      TIPO,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CONSULTA_SQL,
      SQL_ULTIMA_EJECUCION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_servicio,
      p_tipo,
      p_cantidad_ejecuciones,
      p_fecha_ultima_ejecucion,
      p_consulta_sql,
      p_sql_ultima_ejecucion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_consulta_sql           => p_row.CONSULTA_SQL,
      p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_consulta_sql           => p_row.CONSULTA_SQL,
      p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_SERVICIOS (
      ID_SERVICIO /*PK*/ /*FK*/,
      TIPO,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CONSULTA_SQL,
      SQL_ULTIMA_EJECUCION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_SERVICIO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).CONSULTA_SQL,
      p_rows_tab(i).SQL_ULTIMA_EJECUCION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_SERVICIO /*PK*/ /*FK*/,
      TIPO,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CONSULTA_SQL,
      SQL_ULTIMA_EJECUCION,
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
    INSERT INTO T_SERVICIOS (
      ID_SERVICIO /*PK*/ /*FK*/,
      TIPO,
      CANTIDAD_EJECUCIONES,
      FECHA_ULTIMA_EJECUCION,
      CONSULTA_SQL,
      SQL_ULTIMA_EJECUCION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_SERVICIO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).CANTIDAD_EJECUCIONES,
      p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
      p_rows_tab(i).CONSULTA_SQL,
      p_rows_tab(i).SQL_ULTIMA_EJECUCION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS%ROWTYPE
  IS
    v_row T_SERVICIOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_SERVICIOS
      WHERE
        ID_SERVICIO = p_id_servicio;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_servicio            IN            T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ /*FK*/,
    p_tipo                      OUT NOCOPY T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones      OUT NOCOPY T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion    OUT NOCOPY T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql              OUT NOCOPY T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion      OUT NOCOPY T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE,
    p_usuario_insercion         OUT NOCOPY T_SERVICIOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion           OUT NOCOPY T_SERVICIOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion      OUT NOCOPY T_SERVICIOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion        OUT NOCOPY T_SERVICIOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_SERVICIOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_servicio => p_id_servicio );
    p_tipo                   := v_row.TIPO; 
    p_cantidad_ejecuciones   := v_row.CANTIDAD_EJECUCIONES; 
    p_fecha_ultima_ejecucion := v_row.FECHA_ULTIMA_EJECUCION; 
    p_consulta_sql           := v_row.CONSULTA_SQL; 
    p_sql_ultima_ejecucion   := v_row.SQL_ULTIMA_EJECUCION; 
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
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
    v_return T_SERVICIOS.ID_SERVICIO%TYPE; 
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      TIPO                   = p_tipo,
      CANTIDAD_EJECUCIONES   = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      CONSULTA_SQL           = p_consulta_sql,
      SQL_ULTIMA_EJECUCION   = p_sql_ultima_ejecucion,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio
    RETURN 
      ID_SERVICIO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      TIPO                   = p_tipo,
      CANTIDAD_EJECUCIONES   = p_cantidad_ejecuciones,
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      CONSULTA_SQL           = p_consulta_sql,
      SQL_ULTIMA_EJECUCION   = p_sql_ultima_ejecucion,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END update_row;

  FUNCTION update_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_consulta_sql           => p_row.CONSULTA_SQL,
      p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
      p_tipo                   => p_row.TIPO,
      p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
      p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
      p_consulta_sql           => p_row.CONSULTA_SQL,
      p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_SERVICIOS
      SET
        TIPO                   = p_rows_tab(i).TIPO,
        CANTIDAD_EJECUCIONES   = p_rows_tab(i).CANTIDAD_EJECUCIONES,
        FECHA_ULTIMA_EJECUCION = p_rows_tab(i).FECHA_ULTIMA_EJECUCION,
        CONSULTA_SQL           = p_rows_tab(i).CONSULTA_SQL,
        SQL_ULTIMA_EJECUCION   = p_rows_tab(i).SQL_ULTIMA_EJECUCION,
        USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION     = systimestamp
      WHERE
        ID_SERVICIO = p_rows_tab(i).ID_SERVICIO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_SERVICIOS
    WHERE
      ID_SERVICIO = p_id_servicio;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_SERVICIOS
       WHERE ID_SERVICIO = p_rows_tab(i).ID_SERVICIO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_servicio => p_id_servicio
    )
    THEN
      RETURN update_row (
        p_id_servicio            => p_id_servicio /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_consulta_sql           => p_consulta_sql,
        p_sql_ultima_ejecucion   => p_sql_ultima_ejecucion );
    ELSE
      RETURN create_row (
        p_id_servicio            => p_id_servicio /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_consulta_sql           => p_consulta_sql,
        p_sql_ultima_ejecucion   => p_sql_ultima_ejecucion );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_tipo                   IN T_SERVICIOS.TIPO%TYPE,
    p_cantidad_ejecuciones   IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_consulta_sql           IN T_SERVICIOS.CONSULTA_SQL%TYPE,
    p_sql_ultima_ejecucion   IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_servicio => p_id_servicio
    )
    THEN
      update_row (
        p_id_servicio            => p_id_servicio /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_consulta_sql           => p_consulta_sql,
        p_sql_ultima_ejecucion   => p_sql_ultima_ejecucion );
    ELSE
      create_row (
        p_id_servicio            => p_id_servicio /*PK*/ /*FK*/,
        p_tipo                   => p_tipo,
        p_cantidad_ejecuciones   => p_cantidad_ejecuciones,
        p_fecha_ultima_ejecucion => p_fecha_ultima_ejecucion,
        p_consulta_sql           => p_consulta_sql,
        p_sql_ultima_ejecucion   => p_sql_ultima_ejecucion );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  RETURN T_SERVICIOS.ID_SERVICIO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_servicio => p_row.ID_SERVICIO
    )
    THEN
      RETURN update_row (
        p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_consulta_sql           => p_row.CONSULTA_SQL,
        p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
    ELSE
      RETURN create_row (
        p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_consulta_sql           => p_row.CONSULTA_SQL,
        p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_SERVICIOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_servicio => p_row.ID_SERVICIO
    )
    THEN
      update_row (
        p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_consulta_sql           => p_row.CONSULTA_SQL,
        p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
    ELSE
      create_row (
        p_id_servicio            => p_row.ID_SERVICIO /*PK*/ /*FK*/,
        p_tipo                   => p_row.TIPO,
        p_cantidad_ejecuciones   => p_row.CANTIDAD_EJECUCIONES,
        p_fecha_ultima_ejecucion => p_row.FECHA_ULTIMA_EJECUCION,
        p_consulta_sql           => p_row.CONSULTA_SQL,
        p_sql_ultima_ejecucion   => p_row.SQL_ULTIMA_EJECUCION );
    END IF;
  END create_or_update_row;

  FUNCTION get_tipo (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.TIPO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).TIPO;
  END get_tipo;

  FUNCTION get_cantidad_ejecuciones (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).CANTIDAD_EJECUCIONES;
  END get_cantidad_ejecuciones;

  FUNCTION get_fecha_ultima_ejecucion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).FECHA_ULTIMA_EJECUCION;
  END get_fecha_ultima_ejecucion;

  FUNCTION get_consulta_sql (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.CONSULTA_SQL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).CONSULTA_SQL;
  END get_consulta_sql;

  FUNCTION get_sql_ultima_ejecucion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).SQL_ULTIMA_EJECUCION;
  END get_sql_ultima_ejecucion;

  FUNCTION get_usuario_insercion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/ )
  RETURN T_SERVICIOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_servicio => p_id_servicio ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_tipo (
    p_id_servicio IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/,
    p_tipo        IN T_SERVICIOS.TIPO%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      TIPO                 = p_tipo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END set_tipo;

  PROCEDURE set_cantidad_ejecuciones (
    p_id_servicio          IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/,
    p_cantidad_ejecuciones IN T_SERVICIOS.CANTIDAD_EJECUCIONES%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      CANTIDAD_EJECUCIONES = p_cantidad_ejecuciones,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END set_cantidad_ejecuciones;

  PROCEDURE set_fecha_ultima_ejecucion (
    p_id_servicio            IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion IN T_SERVICIOS.FECHA_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      FECHA_ULTIMA_EJECUCION = p_fecha_ultima_ejecucion,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END set_fecha_ultima_ejecucion;

  PROCEDURE set_consulta_sql (
    p_id_servicio  IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/,
    p_consulta_sql IN T_SERVICIOS.CONSULTA_SQL%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      CONSULTA_SQL         = p_consulta_sql,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END set_consulta_sql;

  PROCEDURE set_sql_ultima_ejecucion (
    p_id_servicio          IN T_SERVICIOS.ID_SERVICIO%TYPE /*PK*/,
    p_sql_ultima_ejecucion IN T_SERVICIOS.SQL_ULTIMA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_SERVICIOS
    SET
      SQL_ULTIMA_EJECUCION = p_sql_ultima_ejecucion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_SERVICIO = p_id_servicio;
  END set_sql_ultima_ejecucion;

END T_SERVICIOS_API;
/

