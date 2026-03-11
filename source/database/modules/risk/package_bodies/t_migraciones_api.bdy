CREATE OR REPLACE PACKAGE BODY T_MIGRACIONES_API IS
  /*
  This is the API for the table T_MIGRACIONES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:53
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
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_MIGRACIONES
      WHERE
        ID_MIGRACION = p_id_migracion;
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
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_migracion => p_id_migracion )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
    v_return T_MIGRACIONES.ID_MIGRACION%TYPE; 
  BEGIN
    INSERT INTO T_MIGRACIONES (
      ID_MIGRACION /*PK*/,
      DESCRIPCION,
      FECHA_EJECUCION,
      REFERENCIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_migracion,
      p_descripcion,
      p_fecha_ejecucion,
      p_referencia,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MIGRACION
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  IS
  BEGIN
    INSERT INTO T_MIGRACIONES (
      ID_MIGRACION /*PK*/,
      DESCRIPCION,
      FECHA_EJECUCION,
      REFERENCIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_migracion,
      p_descripcion,
      p_fecha_ejecucion,
      p_referencia,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
      p_descripcion     => p_row.DESCRIPCION,
      p_fecha_ejecucion => p_row.FECHA_EJECUCION,
      p_referencia      => p_row.REFERENCIA );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
      p_descripcion     => p_row.DESCRIPCION,
      p_fecha_ejecucion => p_row.FECHA_EJECUCION,
      p_referencia      => p_row.REFERENCIA );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MIGRACIONES (
      ID_MIGRACION /*PK*/,
      DESCRIPCION,
      FECHA_EJECUCION,
      REFERENCIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MIGRACION,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).FECHA_EJECUCION,
      p_rows_tab(i).REFERENCIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MIGRACION /*PK*/,
      DESCRIPCION,
      FECHA_EJECUCION,
      REFERENCIA,
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
    INSERT INTO T_MIGRACIONES (
      ID_MIGRACION /*PK*/,
      DESCRIPCION,
      FECHA_EJECUCION,
      REFERENCIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MIGRACION,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).FECHA_EJECUCION,
      p_rows_tab(i).REFERENCIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES%ROWTYPE
  IS
    v_row T_MIGRACIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_MIGRACIONES
      WHERE
        ID_MIGRACION = p_id_migracion;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_migracion         IN            T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/,
    p_descripcion             OUT NOCOPY T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion         OUT NOCOPY T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia              OUT NOCOPY T_MIGRACIONES.REFERENCIA%TYPE,
    p_usuario_insercion       OUT NOCOPY T_MIGRACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_MIGRACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_MIGRACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_MIGRACIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_MIGRACIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_migracion => p_id_migracion );
    p_descripcion          := v_row.DESCRIPCION; 
    p_fecha_ejecucion      := v_row.FECHA_EJECUCION; 
    p_referencia           := v_row.REFERENCIA; 
    p_usuario_insercion    := v_row.USUARIO_INSERCION; 
    p_fecha_insercion      := v_row.FECHA_INSERCION; 
    p_usuario_modificacion := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion   := v_row.FECHA_MODIFICACION; 
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
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
    v_return T_MIGRACIONES.ID_MIGRACION%TYPE; 
  BEGIN
    UPDATE
      T_MIGRACIONES
    SET
      DESCRIPCION          = p_descripcion,
      FECHA_EJECUCION      = p_fecha_ejecucion,
      REFERENCIA           = p_referencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MIGRACION = p_id_migracion
    RETURN 
      ID_MIGRACION
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MIGRACIONES
    SET
      DESCRIPCION          = p_descripcion,
      FECHA_EJECUCION      = p_fecha_ejecucion,
      REFERENCIA           = p_referencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MIGRACION = p_id_migracion;
  END update_row;

  FUNCTION update_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
      p_descripcion     => p_row.DESCRIPCION,
      p_fecha_ejecucion => p_row.FECHA_EJECUCION,
      p_referencia      => p_row.REFERENCIA );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
      p_descripcion     => p_row.DESCRIPCION,
      p_fecha_ejecucion => p_row.FECHA_EJECUCION,
      p_referencia      => p_row.REFERENCIA );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_MIGRACIONES
      SET
        DESCRIPCION          = p_rows_tab(i).DESCRIPCION,
        FECHA_EJECUCION      = p_rows_tab(i).FECHA_EJECUCION,
        REFERENCIA           = p_rows_tab(i).REFERENCIA,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_MIGRACION = p_rows_tab(i).ID_MIGRACION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_MIGRACIONES
    WHERE
      ID_MIGRACION = p_id_migracion;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_MIGRACIONES
       WHERE ID_MIGRACION = p_rows_tab(i).ID_MIGRACION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_migracion => p_id_migracion
    )
    THEN
      RETURN update_row (
        p_id_migracion    => p_id_migracion /*PK*/,
        p_descripcion     => p_descripcion,
        p_fecha_ejecucion => p_fecha_ejecucion,
        p_referencia      => p_referencia );
    ELSE
      RETURN create_row (
        p_id_migracion    => p_id_migracion /*PK*/,
        p_descripcion     => p_descripcion,
        p_fecha_ejecucion => p_fecha_ejecucion,
        p_referencia      => p_referencia );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE DEFAULT NULL /*PK*/,
    p_descripcion     IN T_MIGRACIONES.DESCRIPCION%TYPE,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE,
    p_referencia      IN T_MIGRACIONES.REFERENCIA%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_migracion => p_id_migracion
    )
    THEN
      update_row (
        p_id_migracion    => p_id_migracion /*PK*/,
        p_descripcion     => p_descripcion,
        p_fecha_ejecucion => p_fecha_ejecucion,
        p_referencia      => p_referencia );
    ELSE
      create_row (
        p_id_migracion    => p_id_migracion /*PK*/,
        p_descripcion     => p_descripcion,
        p_fecha_ejecucion => p_fecha_ejecucion,
        p_referencia      => p_referencia );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  RETURN T_MIGRACIONES.ID_MIGRACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_migracion => p_row.ID_MIGRACION
    )
    THEN
      RETURN update_row (
        p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
        p_descripcion     => p_row.DESCRIPCION,
        p_fecha_ejecucion => p_row.FECHA_EJECUCION,
        p_referencia      => p_row.REFERENCIA );
    ELSE
      RETURN create_row (
        p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
        p_descripcion     => p_row.DESCRIPCION,
        p_fecha_ejecucion => p_row.FECHA_EJECUCION,
        p_referencia      => p_row.REFERENCIA );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_MIGRACIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_migracion => p_row.ID_MIGRACION
    )
    THEN
      update_row (
        p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
        p_descripcion     => p_row.DESCRIPCION,
        p_fecha_ejecucion => p_row.FECHA_EJECUCION,
        p_referencia      => p_row.REFERENCIA );
    ELSE
      create_row (
        p_id_migracion    => p_row.ID_MIGRACION /*PK*/,
        p_descripcion     => p_row.DESCRIPCION,
        p_fecha_ejecucion => p_row.FECHA_EJECUCION,
        p_referencia      => p_row.REFERENCIA );
    END IF;
  END create_or_update_row;

  FUNCTION get_descripcion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.DESCRIPCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).DESCRIPCION;
  END get_descripcion;

  FUNCTION get_fecha_ejecucion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.FECHA_EJECUCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).FECHA_EJECUCION;
  END get_fecha_ejecucion;

  FUNCTION get_referencia (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.REFERENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).REFERENCIA;
  END get_referencia;

  FUNCTION get_usuario_insercion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/ )
  RETURN T_MIGRACIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_migracion => p_id_migracion ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_descripcion (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/,
    p_descripcion  IN T_MIGRACIONES.DESCRIPCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MIGRACIONES
    SET
      DESCRIPCION          = p_descripcion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MIGRACION = p_id_migracion;
  END set_descripcion;

  PROCEDURE set_fecha_ejecucion (
    p_id_migracion    IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/,
    p_fecha_ejecucion IN T_MIGRACIONES.FECHA_EJECUCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MIGRACIONES
    SET
      FECHA_EJECUCION      = p_fecha_ejecucion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MIGRACION = p_id_migracion;
  END set_fecha_ejecucion;

  PROCEDURE set_referencia (
    p_id_migracion IN T_MIGRACIONES.ID_MIGRACION%TYPE /*PK*/,
    p_referencia   IN T_MIGRACIONES.REFERENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MIGRACIONES
    SET
      REFERENCIA           = p_referencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MIGRACION = p_id_migracion;
  END set_referencia;

END T_MIGRACIONES_API;
/

