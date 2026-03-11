CREATE OR REPLACE PACKAGE BODY T_APLICACIONES_API IS
  /*
  This is the API for the table T_APLICACIONES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:50
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
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_APLICACIONES
      WHERE
        ID_APLICACION = p_id_aplicacion;
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
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_aplicacion => p_id_aplicacion )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
    v_return T_APLICACIONES.ID_APLICACION%TYPE; 
  BEGIN
    INSERT INTO T_APLICACIONES (
      ID_APLICACION /*PK*/,
      NOMBRE,
      TIPO,
      ACTIVO,
      DETALLE,
      ID_DOMINIO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_nombre,
      p_tipo,
      p_activo,
      p_detalle,
      p_id_dominio,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  IS
  BEGIN
    INSERT INTO T_APLICACIONES (
      ID_APLICACION /*PK*/,
      NOMBRE,
      TIPO,
      ACTIVO,
      DETALLE,
      ID_DOMINIO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_nombre,
      p_tipo,
      p_activo,
      p_detalle,
      p_id_dominio,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
      p_nombre        => p_row.NOMBRE,
      p_tipo          => p_row.TIPO,
      p_activo        => p_row.ACTIVO,
      p_detalle       => p_row.DETALLE,
      p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
      p_nombre        => p_row.NOMBRE,
      p_tipo          => p_row.TIPO,
      p_activo        => p_row.ACTIVO,
      p_detalle       => p_row.DETALLE,
      p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_APLICACIONES (
      ID_APLICACION /*PK*/,
      NOMBRE,
      TIPO,
      ACTIVO,
      DETALLE,
      ID_DOMINIO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ID_DOMINIO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION /*PK*/,
      NOMBRE,
      TIPO,
      ACTIVO,
      DETALLE,
      ID_DOMINIO /*FK*/,
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
    INSERT INTO T_APLICACIONES (
      ID_APLICACION /*PK*/,
      NOMBRE,
      TIPO,
      ACTIVO,
      DETALLE,
      ID_DOMINIO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ID_DOMINIO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES%ROWTYPE
  IS
    v_row T_APLICACIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_APLICACIONES
      WHERE
        ID_APLICACION = p_id_aplicacion;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_aplicacion        IN            T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_APLICACIONES.NOMBRE%TYPE,
    p_tipo                    OUT NOCOPY T_APLICACIONES.TIPO%TYPE,
    p_activo                  OUT NOCOPY T_APLICACIONES.ACTIVO%TYPE,
    p_detalle                 OUT NOCOPY T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio              OUT NOCOPY T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/,
    p_usuario_insercion       OUT NOCOPY T_APLICACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_APLICACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_APLICACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_APLICACIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_APLICACIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_aplicacion => p_id_aplicacion );
    p_nombre               := v_row.NOMBRE; 
    p_tipo                 := v_row.TIPO; 
    p_activo               := v_row.ACTIVO; 
    p_detalle              := v_row.DETALLE; 
    p_id_dominio           := v_row.ID_DOMINIO; 
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
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
    v_return T_APLICACIONES.ID_APLICACION%TYPE; 
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      NOMBRE               = p_nombre,
      TIPO                 = p_tipo,
      ACTIVO               = p_activo,
      DETALLE              = p_detalle,
      ID_DOMINIO           = p_id_dominio /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
    RETURN 
      ID_APLICACION
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      NOMBRE               = p_nombre,
      TIPO                 = p_tipo,
      ACTIVO               = p_activo,
      DETALLE              = p_detalle,
      ID_DOMINIO           = p_id_dominio /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END update_row;

  FUNCTION update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
      p_nombre        => p_row.NOMBRE,
      p_tipo          => p_row.TIPO,
      p_activo        => p_row.ACTIVO,
      p_detalle       => p_row.DETALLE,
      p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
      p_nombre        => p_row.NOMBRE,
      p_tipo          => p_row.TIPO,
      p_activo        => p_row.ACTIVO,
      p_detalle       => p_row.DETALLE,
      p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_APLICACIONES
      SET
        NOMBRE               = p_rows_tab(i).NOMBRE,
        TIPO                 = p_rows_tab(i).TIPO,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        DETALLE              = p_rows_tab(i).DETALLE,
        ID_DOMINIO           = p_rows_tab(i).ID_DOMINIO /*FK*/,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_APLICACION = p_rows_tab(i).ID_APLICACION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_APLICACIONES
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_APLICACIONES
       WHERE ID_APLICACION = p_rows_tab(i).ID_APLICACION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion
    )
    THEN
      RETURN update_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/,
        p_nombre        => p_nombre,
        p_tipo          => p_tipo,
        p_activo        => p_activo,
        p_detalle       => p_detalle,
        p_id_dominio    => p_id_dominio /*FK*/ );
    ELSE
      RETURN create_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/,
        p_nombre        => p_nombre,
        p_tipo          => p_tipo,
        p_activo        => p_activo,
        p_detalle       => p_detalle,
        p_id_dominio    => p_id_dominio /*FK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion
    )
    THEN
      update_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/,
        p_nombre        => p_nombre,
        p_tipo          => p_tipo,
        p_activo        => p_activo,
        p_detalle       => p_detalle,
        p_id_dominio    => p_id_dominio /*FK*/ );
    ELSE
      create_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/,
        p_nombre        => p_nombre,
        p_tipo          => p_tipo,
        p_activo        => p_activo,
        p_detalle       => p_detalle,
        p_id_dominio    => p_id_dominio /*FK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION
    )
    THEN
      RETURN update_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
        p_nombre        => p_row.NOMBRE,
        p_tipo          => p_row.TIPO,
        p_activo        => p_row.ACTIVO,
        p_detalle       => p_row.DETALLE,
        p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
    ELSE
      RETURN create_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
        p_nombre        => p_row.NOMBRE,
        p_tipo          => p_row.TIPO,
        p_activo        => p_row.ACTIVO,
        p_detalle       => p_row.DETALLE,
        p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION
    )
    THEN
      update_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
        p_nombre        => p_row.NOMBRE,
        p_tipo          => p_row.TIPO,
        p_activo        => p_row.ACTIVO,
        p_detalle       => p_row.DETALLE,
        p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
    ELSE
      create_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/,
        p_nombre        => p_row.NOMBRE,
        p_tipo          => p_row.TIPO,
        p_activo        => p_row.ACTIVO,
        p_detalle       => p_row.DETALLE,
        p_id_dominio    => p_row.ID_DOMINIO /*FK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).NOMBRE;
  END get_nombre;

  FUNCTION get_tipo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.TIPO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).TIPO;
  END get_tipo;

  FUNCTION get_activo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).ACTIVO;
  END get_activo;

  FUNCTION get_detalle (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).DETALLE;
  END get_detalle;

  FUNCTION get_id_dominio (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.ID_DOMINIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).ID_DOMINIO;
  END get_id_dominio;

  FUNCTION get_usuario_insercion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END set_nombre;

  PROCEDURE set_tipo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      TIPO                 = p_tipo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END set_tipo;

  PROCEDURE set_activo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END set_activo;

  PROCEDURE set_detalle (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END set_detalle;

  PROCEDURE set_id_dominio (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACIONES
    SET
      ID_DOMINIO           = p_id_dominio /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion;
  END set_id_dominio;

END T_APLICACIONES_API;
/

