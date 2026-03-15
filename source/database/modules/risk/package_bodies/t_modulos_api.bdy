CREATE OR REPLACE PACKAGE BODY T_MODULOS_API IS
  /*
  This is the API for the table T_MODULOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:54
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
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_MODULOS
      WHERE
        ID_MODULO = p_id_modulo;
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
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_modulo => p_id_modulo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE              DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE                 ,
    p_detalle        IN T_MODULOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo         IN T_MODULOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE           DEFAULT NULL,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE         DEFAULT NULL )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
    v_return T_MODULOS.ID_MODULO%TYPE; 
  BEGIN
    INSERT INTO T_MODULOS (
      ID_MODULO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      FECHA_ACTUAL,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_modulo,
      p_nombre,
      p_detalle,
      p_activo,
      p_fecha_actual,
      p_version_actual,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MODULO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE              DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE                 ,
    p_detalle        IN T_MODULOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo         IN T_MODULOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE           DEFAULT NULL,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE         DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_MODULOS (
      ID_MODULO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      FECHA_ACTUAL,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_modulo,
      p_nombre,
      p_detalle,
      p_activo,
      p_fecha_actual,
      p_version_actual,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_MODULOS%ROWTYPE )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_modulo      => p_row.ID_MODULO /*PK*/,
      p_nombre         => p_row.NOMBRE,
      p_detalle        => p_row.DETALLE,
      p_activo         => p_row.ACTIVO,
      p_fecha_actual   => p_row.FECHA_ACTUAL,
      p_version_actual => p_row.VERSION_ACTUAL );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_MODULOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_modulo      => p_row.ID_MODULO /*PK*/,
      p_nombre         => p_row.NOMBRE,
      p_detalle        => p_row.DETALLE,
      p_activo         => p_row.ACTIVO,
      p_fecha_actual   => p_row.FECHA_ACTUAL,
      p_version_actual => p_row.VERSION_ACTUAL );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MODULOS (
      ID_MODULO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      FECHA_ACTUAL,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MODULO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).FECHA_ACTUAL,
      p_rows_tab(i).VERSION_ACTUAL,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_MODULO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      FECHA_ACTUAL,
      VERSION_ACTUAL,
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
    INSERT INTO T_MODULOS (
      ID_MODULO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      FECHA_ACTUAL,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_MODULO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).FECHA_ACTUAL,
      p_rows_tab(i).VERSION_ACTUAL,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS%ROWTYPE
  IS
    v_row T_MODULOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_MODULOS
      WHERE
        ID_MODULO = p_id_modulo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_modulo            IN            T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_MODULOS.NOMBRE%TYPE,
    p_detalle                 OUT NOCOPY T_MODULOS.DETALLE%TYPE,
    p_activo                  OUT NOCOPY T_MODULOS.ACTIVO%TYPE,
    p_fecha_actual            OUT NOCOPY T_MODULOS.FECHA_ACTUAL%TYPE,
    p_version_actual          OUT NOCOPY T_MODULOS.VERSION_ACTUAL%TYPE,
    p_usuario_insercion       OUT NOCOPY T_MODULOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_MODULOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_MODULOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_MODULOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_MODULOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_modulo => p_id_modulo );
    p_nombre               := v_row.NOMBRE; 
    p_detalle              := v_row.DETALLE; 
    p_activo               := v_row.ACTIVO; 
    p_fecha_actual         := v_row.FECHA_ACTUAL; 
    p_version_actual       := v_row.VERSION_ACTUAL; 
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
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE,
    p_detalle        IN T_MODULOS.DETALLE%TYPE,
    p_activo         IN T_MODULOS.ACTIVO%TYPE,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
    v_return T_MODULOS.ID_MODULO%TYPE; 
  BEGIN
    UPDATE
      T_MODULOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      FECHA_ACTUAL         = p_fecha_actual,
      VERSION_ACTUAL       = p_version_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo
    RETURN 
      ID_MODULO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE,
    p_detalle        IN T_MODULOS.DETALLE%TYPE,
    p_activo         IN T_MODULOS.ACTIVO%TYPE,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      FECHA_ACTUAL         = p_fecha_actual,
      VERSION_ACTUAL       = p_version_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_MODULOS%ROWTYPE )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_modulo      => p_row.ID_MODULO /*PK*/,
      p_nombre         => p_row.NOMBRE,
      p_detalle        => p_row.DETALLE,
      p_activo         => p_row.ACTIVO,
      p_fecha_actual   => p_row.FECHA_ACTUAL,
      p_version_actual => p_row.VERSION_ACTUAL );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_MODULOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_modulo      => p_row.ID_MODULO /*PK*/,
      p_nombre         => p_row.NOMBRE,
      p_detalle        => p_row.DETALLE,
      p_activo         => p_row.ACTIVO,
      p_fecha_actual   => p_row.FECHA_ACTUAL,
      p_version_actual => p_row.VERSION_ACTUAL );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_MODULOS
      SET
        NOMBRE               = p_rows_tab(i).NOMBRE,
        DETALLE              = p_rows_tab(i).DETALLE,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        FECHA_ACTUAL         = p_rows_tab(i).FECHA_ACTUAL,
        VERSION_ACTUAL       = p_rows_tab(i).VERSION_ACTUAL,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_MODULO = p_rows_tab(i).ID_MODULO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_MODULOS
    WHERE
      ID_MODULO = p_id_modulo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_MODULOS
       WHERE ID_MODULO = p_rows_tab(i).ID_MODULO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE,
    p_detalle        IN T_MODULOS.DETALLE%TYPE,
    p_activo         IN T_MODULOS.ACTIVO%TYPE,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_modulo => p_id_modulo
    )
    THEN
      RETURN update_row (
        p_id_modulo      => p_id_modulo /*PK*/,
        p_nombre         => p_nombre,
        p_detalle        => p_detalle,
        p_activo         => p_activo,
        p_fecha_actual   => p_fecha_actual,
        p_version_actual => p_version_actual );
    ELSE
      RETURN create_row (
        p_id_modulo      => p_id_modulo /*PK*/,
        p_nombre         => p_nombre,
        p_detalle        => p_detalle,
        p_activo         => p_activo,
        p_fecha_actual   => p_fecha_actual,
        p_version_actual => p_version_actual );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE DEFAULT NULL /*PK*/,
    p_nombre         IN T_MODULOS.NOMBRE%TYPE,
    p_detalle        IN T_MODULOS.DETALLE%TYPE,
    p_activo         IN T_MODULOS.ACTIVO%TYPE,
    p_fecha_actual   IN T_MODULOS.FECHA_ACTUAL%TYPE,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_modulo => p_id_modulo
    )
    THEN
      update_row (
        p_id_modulo      => p_id_modulo /*PK*/,
        p_nombre         => p_nombre,
        p_detalle        => p_detalle,
        p_activo         => p_activo,
        p_fecha_actual   => p_fecha_actual,
        p_version_actual => p_version_actual );
    ELSE
      create_row (
        p_id_modulo      => p_id_modulo /*PK*/,
        p_nombre         => p_nombre,
        p_detalle        => p_detalle,
        p_activo         => p_activo,
        p_fecha_actual   => p_fecha_actual,
        p_version_actual => p_version_actual );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_MODULOS%ROWTYPE )
  RETURN T_MODULOS.ID_MODULO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_modulo => p_row.ID_MODULO
    )
    THEN
      RETURN update_row (
        p_id_modulo      => p_row.ID_MODULO /*PK*/,
        p_nombre         => p_row.NOMBRE,
        p_detalle        => p_row.DETALLE,
        p_activo         => p_row.ACTIVO,
        p_fecha_actual   => p_row.FECHA_ACTUAL,
        p_version_actual => p_row.VERSION_ACTUAL );
    ELSE
      RETURN create_row (
        p_id_modulo      => p_row.ID_MODULO /*PK*/,
        p_nombre         => p_row.NOMBRE,
        p_detalle        => p_row.DETALLE,
        p_activo         => p_row.ACTIVO,
        p_fecha_actual   => p_row.FECHA_ACTUAL,
        p_version_actual => p_row.VERSION_ACTUAL );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_MODULOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_modulo => p_row.ID_MODULO
    )
    THEN
      update_row (
        p_id_modulo      => p_row.ID_MODULO /*PK*/,
        p_nombre         => p_row.NOMBRE,
        p_detalle        => p_row.DETALLE,
        p_activo         => p_row.ACTIVO,
        p_fecha_actual   => p_row.FECHA_ACTUAL,
        p_version_actual => p_row.VERSION_ACTUAL );
    ELSE
      create_row (
        p_id_modulo      => p_row.ID_MODULO /*PK*/,
        p_nombre         => p_row.NOMBRE,
        p_detalle        => p_row.DETALLE,
        p_activo         => p_row.ACTIVO,
        p_fecha_actual   => p_row.FECHA_ACTUAL,
        p_version_actual => p_row.VERSION_ACTUAL );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).NOMBRE;
  END get_nombre;

  FUNCTION get_detalle (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).DETALLE;
  END get_detalle;

  FUNCTION get_activo (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).ACTIVO;
  END get_activo;

  FUNCTION get_fecha_actual (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.FECHA_ACTUAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).FECHA_ACTUAL;
  END get_fecha_actual;

  FUNCTION get_version_actual (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.VERSION_ACTUAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).VERSION_ACTUAL;
  END get_version_actual;

  FUNCTION get_usuario_insercion (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/ )
  RETURN T_MODULOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_modulo => p_id_modulo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_nombre    IN T_MODULOS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END set_nombre;

  PROCEDURE set_detalle (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_detalle   IN T_MODULOS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END set_detalle;

  PROCEDURE set_activo (
    p_id_modulo IN T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_activo    IN T_MODULOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END set_activo;

  PROCEDURE set_fecha_actual (
    p_id_modulo    IN T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_fecha_actual IN T_MODULOS.FECHA_ACTUAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      FECHA_ACTUAL         = p_fecha_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END set_fecha_actual;

  PROCEDURE set_version_actual (
    p_id_modulo      IN T_MODULOS.ID_MODULO%TYPE /*PK*/,
    p_version_actual IN T_MODULOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_MODULOS
    SET
      VERSION_ACTUAL       = p_version_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MODULO = p_id_modulo;
  END set_version_actual;

  FUNCTION get_default_row
  RETURN T_MODULOS%ROWTYPE
  IS
    v_row T_MODULOS%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_MODULOS_API;
/

