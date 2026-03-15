CREATE OR REPLACE PACKAGE BODY T_PERMISOS_API IS
  /*
  This is the API for the table T_PERMISOS.
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
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_PERMISOS
      WHERE
        ID_PERMISO = p_id_permiso;
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
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_permiso => p_id_permiso )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE             DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE            DEFAULT NULL,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE                DEFAULT NULL )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
    v_return T_PERMISOS.ID_PERMISO%TYPE; 
  BEGIN
    INSERT INTO T_PERMISOS (
      ID_PERMISO /*PK*/,
      DESCRIPCION,
      DETALLE,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_permiso,
      p_descripcion,
      p_detalle,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_PERMISO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE             DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE            DEFAULT NULL,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE                DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_PERMISOS (
      ID_PERMISO /*PK*/,
      DESCRIPCION,
      DETALLE,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_permiso,
      p_descripcion,
      p_detalle,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_PERMISOS%ROWTYPE )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_permiso  => p_row.ID_PERMISO /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_detalle     => p_row.DETALLE );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_PERMISOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_permiso  => p_row.ID_PERMISO /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_detalle     => p_row.DETALLE );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_PERMISOS (
      ID_PERMISO /*PK*/,
      DESCRIPCION,
      DETALLE,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_PERMISO,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).DETALLE,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_PERMISO /*PK*/,
      DESCRIPCION,
      DETALLE,
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
    INSERT INTO T_PERMISOS (
      ID_PERMISO /*PK*/,
      DESCRIPCION,
      DETALLE,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_PERMISO,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).DETALLE,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS%ROWTYPE
  IS
    v_row T_PERMISOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_PERMISOS
      WHERE
        ID_PERMISO = p_id_permiso;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_permiso           IN            T_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_descripcion             OUT NOCOPY T_PERMISOS.DESCRIPCION%TYPE,
    p_detalle                 OUT NOCOPY T_PERMISOS.DETALLE%TYPE,
    p_usuario_insercion       OUT NOCOPY T_PERMISOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_PERMISOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_PERMISOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_PERMISOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_PERMISOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_permiso => p_id_permiso );
    p_descripcion          := v_row.DESCRIPCION; 
    p_detalle              := v_row.DETALLE; 
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
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
    v_return T_PERMISOS.ID_PERMISO%TYPE; 
  BEGIN
    UPDATE
      T_PERMISOS
    SET
      DESCRIPCION          = p_descripcion,
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PERMISO = p_id_permiso
    RETURN 
      ID_PERMISO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_PERMISOS
    SET
      DESCRIPCION          = p_descripcion,
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PERMISO = p_id_permiso;
  END update_row;

  FUNCTION update_row (
    p_row IN T_PERMISOS%ROWTYPE )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_permiso  => p_row.ID_PERMISO /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_detalle     => p_row.DETALLE );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_PERMISOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_permiso  => p_row.ID_PERMISO /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_detalle     => p_row.DETALLE );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_PERMISOS
      SET
        DESCRIPCION          = p_rows_tab(i).DESCRIPCION,
        DETALLE              = p_rows_tab(i).DETALLE,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_PERMISO = p_rows_tab(i).ID_PERMISO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_PERMISOS
    WHERE
      ID_PERMISO = p_id_permiso;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_PERMISOS
       WHERE ID_PERMISO = p_rows_tab(i).ID_PERMISO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_permiso => p_id_permiso
    )
    THEN
      RETURN update_row (
        p_id_permiso  => p_id_permiso /*PK*/,
        p_descripcion => p_descripcion,
        p_detalle     => p_detalle );
    ELSE
      RETURN create_row (
        p_id_permiso  => p_id_permiso /*PK*/,
        p_descripcion => p_descripcion,
        p_detalle     => p_detalle );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE,
    p_detalle     IN T_PERMISOS.DETALLE%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_permiso => p_id_permiso
    )
    THEN
      update_row (
        p_id_permiso  => p_id_permiso /*PK*/,
        p_descripcion => p_descripcion,
        p_detalle     => p_detalle );
    ELSE
      create_row (
        p_id_permiso  => p_id_permiso /*PK*/,
        p_descripcion => p_descripcion,
        p_detalle     => p_detalle );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_PERMISOS%ROWTYPE )
  RETURN T_PERMISOS.ID_PERMISO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_permiso => p_row.ID_PERMISO
    )
    THEN
      RETURN update_row (
        p_id_permiso  => p_row.ID_PERMISO /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_detalle     => p_row.DETALLE );
    ELSE
      RETURN create_row (
        p_id_permiso  => p_row.ID_PERMISO /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_detalle     => p_row.DETALLE );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_PERMISOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_permiso => p_row.ID_PERMISO
    )
    THEN
      update_row (
        p_id_permiso  => p_row.ID_PERMISO /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_detalle     => p_row.DETALLE );
    ELSE
      create_row (
        p_id_permiso  => p_row.ID_PERMISO /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_detalle     => p_row.DETALLE );
    END IF;
  END create_or_update_row;

  FUNCTION get_descripcion (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.DESCRIPCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).DESCRIPCION;
  END get_descripcion;

  FUNCTION get_detalle (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).DETALLE;
  END get_detalle;

  FUNCTION get_usuario_insercion (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_PERMISOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_permiso => p_id_permiso ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_descripcion (
    p_id_permiso  IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_descripcion IN T_PERMISOS.DESCRIPCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_PERMISOS
    SET
      DESCRIPCION          = p_descripcion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PERMISO = p_id_permiso;
  END set_descripcion;

  PROCEDURE set_detalle (
    p_id_permiso IN T_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_detalle    IN T_PERMISOS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_PERMISOS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PERMISO = p_id_permiso;
  END set_detalle;

  FUNCTION get_default_row
  RETURN T_PERMISOS%ROWTYPE
  IS
    v_row T_PERMISOS%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_PERMISOS_API;
/

