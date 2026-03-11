CREATE OR REPLACE PACKAGE BODY T_USUARIO_SUSCRIPCIONES_API IS
  /*
  This is the API for the table T_USUARIO_SUSCRIPCIONES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:56
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
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_USUARIO_SUSCRIPCIONES
      WHERE
        ID_USUARIO = p_id_usuario
        AND SUSCRIPCION = p_suscripcion;
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
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_usuario  => p_id_usuario,
          p_suscripcion => p_suscripcion )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
    v_return T_USUARIO_SUSCRIPCIONES%ROWTYPE; 
  BEGIN
    INSERT INTO T_USUARIO_SUSCRIPCIONES (
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_usuario,
      p_suscripcion,
      p_fecha_expiracion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  IS
  BEGIN
    INSERT INTO T_USUARIO_SUSCRIPCIONES (
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_usuario,
      p_suscripcion,
      p_fecha_expiracion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_usuario       => p_row.ID_USUARIO /*PK*/,
      p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_usuario       => p_row.ID_USUARIO /*PK*/,
      p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_USUARIO_SUSCRIPCIONES (
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).SUSCRIPCION,
      p_rows_tab(i).FECHA_EXPIRACION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
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
    INSERT INTO T_USUARIO_SUSCRIPCIONES (
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).SUSCRIPCION,
      p_rows_tab(i).FECHA_EXPIRACION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
    v_row T_USUARIO_SUSCRIPCIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_USUARIO_SUSCRIPCIONES
      WHERE
        ID_USUARIO = p_id_usuario
        AND SUSCRIPCION = p_suscripcion;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_usuario           IN            T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion          IN            T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion        OUT NOCOPY T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE,
    p_usuario_insercion       OUT NOCOPY T_USUARIO_SUSCRIPCIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_USUARIO_SUSCRIPCIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_USUARIO_SUSCRIPCIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_USUARIO_SUSCRIPCIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_USUARIO_SUSCRIPCIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion );
    p_fecha_expiracion     := v_row.FECHA_EXPIRACION; 
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
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
    v_return T_USUARIO_SUSCRIPCIONES%ROWTYPE; 
  BEGIN
    UPDATE
      T_USUARIO_SUSCRIPCIONES
    SET
      FECHA_EXPIRACION     = p_fecha_expiracion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND SUSCRIPCION = p_suscripcion
    RETURN 
      ID_USUARIO /*PK*/,
      SUSCRIPCION /*PK*/,
      FECHA_EXPIRACION,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_SUSCRIPCIONES
    SET
      FECHA_EXPIRACION     = p_fecha_expiracion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND SUSCRIPCION = p_suscripcion;
  END update_row;

  FUNCTION update_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_usuario       => p_row.ID_USUARIO /*PK*/,
      p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_usuario       => p_row.ID_USUARIO /*PK*/,
      p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_USUARIO_SUSCRIPCIONES
      SET
        FECHA_EXPIRACION     = p_rows_tab(i).FECHA_EXPIRACION,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND SUSCRIPCION = p_rows_tab(i).SUSCRIPCION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_USUARIO_SUSCRIPCIONES
    WHERE
      ID_USUARIO = p_id_usuario
      AND SUSCRIPCION = p_suscripcion;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_USUARIO_SUSCRIPCIONES
       WHERE ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND SUSCRIPCION = p_rows_tab(i).SUSCRIPCION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion
    )
    THEN
      RETURN update_row (
        p_id_usuario       => p_id_usuario /*PK*/,
        p_suscripcion      => p_suscripcion /*PK*/,
        p_fecha_expiracion => p_fecha_expiracion );
    ELSE
      RETURN create_row (
        p_id_usuario       => p_id_usuario /*PK*/,
        p_suscripcion      => p_suscripcion /*PK*/,
        p_fecha_expiracion => p_fecha_expiracion );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion
    )
    THEN
      update_row (
        p_id_usuario       => p_id_usuario /*PK*/,
        p_suscripcion      => p_suscripcion /*PK*/,
        p_fecha_expiracion => p_fecha_expiracion );
    ELSE
      create_row (
        p_id_usuario       => p_id_usuario /*PK*/,
        p_suscripcion      => p_suscripcion /*PK*/,
        p_fecha_expiracion => p_fecha_expiracion );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  RETURN T_USUARIO_SUSCRIPCIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_usuario  => p_row.ID_USUARIO,
      p_suscripcion => p_row.SUSCRIPCION
    )
    THEN
      RETURN update_row (
        p_id_usuario       => p_row.ID_USUARIO /*PK*/,
        p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION );
    ELSE
      RETURN create_row (
        p_id_usuario       => p_row.ID_USUARIO /*PK*/,
        p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_USUARIO_SUSCRIPCIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_usuario  => p_row.ID_USUARIO,
      p_suscripcion => p_row.SUSCRIPCION
    )
    THEN
      update_row (
        p_id_usuario       => p_row.ID_USUARIO /*PK*/,
        p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION );
    ELSE
      create_row (
        p_id_usuario       => p_row.ID_USUARIO /*PK*/,
        p_suscripcion      => p_row.SUSCRIPCION /*PK*/,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION );
    END IF;
  END create_or_update_row;

  FUNCTION get_fecha_expiracion (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion ).FECHA_EXPIRACION;
  END get_fecha_expiracion;

  FUNCTION get_usuario_insercion (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_usuario  IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/ )
  RETURN T_USUARIO_SUSCRIPCIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario  => p_id_usuario,
      p_suscripcion => p_suscripcion ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_fecha_expiracion (
    p_id_usuario       IN T_USUARIO_SUSCRIPCIONES.ID_USUARIO%TYPE /*PK*/,
    p_suscripcion      IN T_USUARIO_SUSCRIPCIONES.SUSCRIPCION%TYPE /*PK*/,
    p_fecha_expiracion IN T_USUARIO_SUSCRIPCIONES.FECHA_EXPIRACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_SUSCRIPCIONES
    SET
      FECHA_EXPIRACION     = p_fecha_expiracion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND SUSCRIPCION = p_suscripcion;
  END set_fecha_expiracion;

END T_USUARIO_SUSCRIPCIONES_API;
/

