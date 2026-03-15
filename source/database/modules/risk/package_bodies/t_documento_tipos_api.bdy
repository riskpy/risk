CREATE OR REPLACE PACKAGE BODY T_DOCUMENTO_TIPOS_API IS
  /*
  This is the API for the table T_DOCUMENTO_TIPOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:14:03
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
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_DOCUMENTO_TIPOS
      WHERE
        ID_DOCUMENTO_TIPO = p_id_documento_tipo;
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
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_documento_tipo => p_id_documento_tipo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE      DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE                 ,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE                 DEFAULT 'N'  )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
    v_return T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE; 
  BEGIN
    INSERT INTO T_DOCUMENTO_TIPOS (
      ID_DOCUMENTO_TIPO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_documento_tipo,
      p_nombre,
      p_detalle,
      p_activo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DOCUMENTO_TIPO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE      DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE                 ,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE                 DEFAULT 'N'  )
  IS
  BEGIN
    INSERT INTO T_DOCUMENTO_TIPOS (
      ID_DOCUMENTO_TIPO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_documento_tipo,
      p_nombre,
      p_detalle,
      p_activo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
      p_nombre            => p_row.NOMBRE,
      p_detalle           => p_row.DETALLE,
      p_activo            => p_row.ACTIVO );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
      p_nombre            => p_row.NOMBRE,
      p_detalle           => p_row.DETALLE,
      p_activo            => p_row.ACTIVO );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_DOCUMENTO_TIPOS (
      ID_DOCUMENTO_TIPO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DOCUMENTO_TIPO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DOCUMENTO_TIPO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
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
    INSERT INTO T_DOCUMENTO_TIPOS (
      ID_DOCUMENTO_TIPO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DOCUMENTO_TIPO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS%ROWTYPE
  IS
    v_row T_DOCUMENTO_TIPOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_DOCUMENTO_TIPOS
      WHERE
        ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_documento_tipo    IN            T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_DOCUMENTO_TIPOS.NOMBRE%TYPE,
    p_detalle                 OUT NOCOPY T_DOCUMENTO_TIPOS.DETALLE%TYPE,
    p_activo                  OUT NOCOPY T_DOCUMENTO_TIPOS.ACTIVO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_DOCUMENTO_TIPOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DOCUMENTO_TIPOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DOCUMENTO_TIPOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DOCUMENTO_TIPOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_DOCUMENTO_TIPOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_documento_tipo => p_id_documento_tipo );
    p_nombre               := v_row.NOMBRE; 
    p_detalle              := v_row.DETALLE; 
    p_activo               := v_row.ACTIVO; 
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
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
    v_return T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE; 
  BEGIN
    UPDATE
      T_DOCUMENTO_TIPOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo
    RETURN 
      ID_DOCUMENTO_TIPO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOCUMENTO_TIPOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
      p_nombre            => p_row.NOMBRE,
      p_detalle           => p_row.DETALLE,
      p_activo            => p_row.ACTIVO );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
      p_nombre            => p_row.NOMBRE,
      p_detalle           => p_row.DETALLE,
      p_activo            => p_row.ACTIVO );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_DOCUMENTO_TIPOS
      SET
        NOMBRE               = p_rows_tab(i).NOMBRE,
        DETALLE              = p_rows_tab(i).DETALLE,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_DOCUMENTO_TIPO = p_rows_tab(i).ID_DOCUMENTO_TIPO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_DOCUMENTO_TIPOS
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_DOCUMENTO_TIPOS
       WHERE ID_DOCUMENTO_TIPO = p_rows_tab(i).ID_DOCUMENTO_TIPO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_documento_tipo => p_id_documento_tipo
    )
    THEN
      RETURN update_row (
        p_id_documento_tipo => p_id_documento_tipo /*PK*/,
        p_nombre            => p_nombre,
        p_detalle           => p_detalle,
        p_activo            => p_activo );
    ELSE
      RETURN create_row (
        p_id_documento_tipo => p_id_documento_tipo /*PK*/,
        p_nombre            => p_nombre,
        p_detalle           => p_detalle,
        p_activo            => p_activo );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE DEFAULT NULL /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_documento_tipo => p_id_documento_tipo
    )
    THEN
      update_row (
        p_id_documento_tipo => p_id_documento_tipo /*PK*/,
        p_nombre            => p_nombre,
        p_detalle           => p_detalle,
        p_activo            => p_activo );
    ELSE
      create_row (
        p_id_documento_tipo => p_id_documento_tipo /*PK*/,
        p_nombre            => p_nombre,
        p_detalle           => p_detalle,
        p_activo            => p_activo );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  RETURN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO
    )
    THEN
      RETURN update_row (
        p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
        p_nombre            => p_row.NOMBRE,
        p_detalle           => p_row.DETALLE,
        p_activo            => p_row.ACTIVO );
    ELSE
      RETURN create_row (
        p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
        p_nombre            => p_row.NOMBRE,
        p_detalle           => p_row.DETALLE,
        p_activo            => p_row.ACTIVO );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_DOCUMENTO_TIPOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO
    )
    THEN
      update_row (
        p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
        p_nombre            => p_row.NOMBRE,
        p_detalle           => p_row.DETALLE,
        p_activo            => p_row.ACTIVO );
    ELSE
      create_row (
        p_id_documento_tipo => p_row.ID_DOCUMENTO_TIPO /*PK*/,
        p_nombre            => p_row.NOMBRE,
        p_detalle           => p_row.DETALLE,
        p_activo            => p_row.ACTIVO );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).NOMBRE;
  END get_nombre;

  FUNCTION get_detalle (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).DETALLE;
  END get_detalle;

  FUNCTION get_activo (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).ACTIVO;
  END get_activo;

  FUNCTION get_usuario_insercion (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/ )
  RETURN T_DOCUMENTO_TIPOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_documento_tipo => p_id_documento_tipo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/,
    p_nombre            IN T_DOCUMENTO_TIPOS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOCUMENTO_TIPOS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  END set_nombre;

  PROCEDURE set_detalle (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/,
    p_detalle           IN T_DOCUMENTO_TIPOS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOCUMENTO_TIPOS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  END set_detalle;

  PROCEDURE set_activo (
    p_id_documento_tipo IN T_DOCUMENTO_TIPOS.ID_DOCUMENTO_TIPO%TYPE /*PK*/,
    p_activo            IN T_DOCUMENTO_TIPOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOCUMENTO_TIPOS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOCUMENTO_TIPO = p_id_documento_tipo;
  END set_activo;

  FUNCTION get_default_row
  RETURN T_DOCUMENTO_TIPOS%ROWTYPE
  IS
    v_row T_DOCUMENTO_TIPOS%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_DOCUMENTO_TIPOS_API;
/

