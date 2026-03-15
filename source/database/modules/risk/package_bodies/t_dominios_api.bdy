CREATE OR REPLACE PACKAGE BODY T_DOMINIOS_API IS
  /*
  This is the API for the table T_DOMINIOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:55
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
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_DOMINIOS
      WHERE
        ID_DOMINIO = p_id_dominio;
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
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_dominio => p_id_dominio )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE             DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE                 ,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE               /*FK*/ )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
    v_return T_DOMINIOS.ID_DOMINIO%TYPE; 
  BEGIN
    INSERT INTO T_DOMINIOS (
      ID_DOMINIO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      ID_MODULO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_dominio,
      p_nombre,
      p_detalle,
      p_activo,
      p_id_modulo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DOMINIO
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE             DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE                 ,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE                DEFAULT NULL,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE               /*FK*/ )
  IS
  BEGIN
    INSERT INTO T_DOMINIOS (
      ID_DOMINIO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      ID_MODULO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_dominio,
      p_nombre,
      p_detalle,
      p_activo,
      p_id_modulo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_dominio => p_row.ID_DOMINIO /*PK*/,
      p_nombre     => p_row.NOMBRE,
      p_detalle    => p_row.DETALLE,
      p_activo     => p_row.ACTIVO,
      p_id_modulo  => p_row.ID_MODULO /*FK*/ );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_dominio => p_row.ID_DOMINIO /*PK*/,
      p_nombre     => p_row.NOMBRE,
      p_detalle    => p_row.DETALLE,
      p_activo     => p_row.ACTIVO,
      p_id_modulo  => p_row.ID_MODULO /*FK*/ );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_DOMINIOS (
      ID_DOMINIO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      ID_MODULO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DOMINIO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).ID_MODULO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DOMINIO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      ID_MODULO /*FK*/,
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
    INSERT INTO T_DOMINIOS (
      ID_DOMINIO /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      ID_MODULO /*FK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DOMINIO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).ID_MODULO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS%ROWTYPE
  IS
    v_row T_DOMINIOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_DOMINIOS
      WHERE
        ID_DOMINIO = p_id_dominio;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_dominio           IN            T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_DOMINIOS.NOMBRE%TYPE,
    p_detalle                 OUT NOCOPY T_DOMINIOS.DETALLE%TYPE,
    p_activo                  OUT NOCOPY T_DOMINIOS.ACTIVO%TYPE,
    p_id_modulo               OUT NOCOPY T_DOMINIOS.ID_MODULO%TYPE /*FK*/,
    p_usuario_insercion       OUT NOCOPY T_DOMINIOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DOMINIOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DOMINIOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DOMINIOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_DOMINIOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_dominio => p_id_dominio );
    p_nombre               := v_row.NOMBRE; 
    p_detalle              := v_row.DETALLE; 
    p_activo               := v_row.ACTIVO; 
    p_id_modulo            := v_row.ID_MODULO; 
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
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE /*FK*/ )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
    v_return T_DOMINIOS.ID_DOMINIO%TYPE; 
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      ID_MODULO            = p_id_modulo /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio
    RETURN 
      ID_DOMINIO
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE /*FK*/ )
  IS
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      NOMBRE               = p_nombre,
      DETALLE              = p_detalle,
      ACTIVO               = p_activo,
      ID_MODULO            = p_id_modulo /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio;
  END update_row;

  FUNCTION update_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_dominio => p_row.ID_DOMINIO /*PK*/,
      p_nombre     => p_row.NOMBRE,
      p_detalle    => p_row.DETALLE,
      p_activo     => p_row.ACTIVO,
      p_id_modulo  => p_row.ID_MODULO /*FK*/ );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_dominio => p_row.ID_DOMINIO /*PK*/,
      p_nombre     => p_row.NOMBRE,
      p_detalle    => p_row.DETALLE,
      p_activo     => p_row.ACTIVO,
      p_id_modulo  => p_row.ID_MODULO /*FK*/ );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_DOMINIOS
      SET
        NOMBRE               = p_rows_tab(i).NOMBRE,
        DETALLE              = p_rows_tab(i).DETALLE,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        ID_MODULO            = p_rows_tab(i).ID_MODULO /*FK*/,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_DOMINIO = p_rows_tab(i).ID_DOMINIO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_DOMINIOS
    WHERE
      ID_DOMINIO = p_id_dominio;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_DOMINIOS
       WHERE ID_DOMINIO = p_rows_tab(i).ID_DOMINIO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE /*FK*/ )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_dominio => p_id_dominio
    )
    THEN
      RETURN update_row (
        p_id_dominio => p_id_dominio /*PK*/,
        p_nombre     => p_nombre,
        p_detalle    => p_detalle,
        p_activo     => p_activo,
        p_id_modulo  => p_id_modulo /*FK*/ );
    ELSE
      RETURN create_row (
        p_id_dominio => p_id_dominio /*PK*/,
        p_nombre     => p_nombre,
        p_detalle    => p_detalle,
        p_activo     => p_activo,
        p_id_modulo  => p_id_modulo /*FK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE DEFAULT NULL /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE /*FK*/ )
  IS
  BEGIN
    IF row_exists(
      p_id_dominio => p_id_dominio
    )
    THEN
      update_row (
        p_id_dominio => p_id_dominio /*PK*/,
        p_nombre     => p_nombre,
        p_detalle    => p_detalle,
        p_activo     => p_activo,
        p_id_modulo  => p_id_modulo /*FK*/ );
    ELSE
      create_row (
        p_id_dominio => p_id_dominio /*PK*/,
        p_nombre     => p_nombre,
        p_detalle    => p_detalle,
        p_activo     => p_activo,
        p_id_modulo  => p_id_modulo /*FK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  RETURN T_DOMINIOS.ID_DOMINIO%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_dominio => p_row.ID_DOMINIO
    )
    THEN
      RETURN update_row (
        p_id_dominio => p_row.ID_DOMINIO /*PK*/,
        p_nombre     => p_row.NOMBRE,
        p_detalle    => p_row.DETALLE,
        p_activo     => p_row.ACTIVO,
        p_id_modulo  => p_row.ID_MODULO /*FK*/ );
    ELSE
      RETURN create_row (
        p_id_dominio => p_row.ID_DOMINIO /*PK*/,
        p_nombre     => p_row.NOMBRE,
        p_detalle    => p_row.DETALLE,
        p_activo     => p_row.ACTIVO,
        p_id_modulo  => p_row.ID_MODULO /*FK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_DOMINIOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_dominio => p_row.ID_DOMINIO
    )
    THEN
      update_row (
        p_id_dominio => p_row.ID_DOMINIO /*PK*/,
        p_nombre     => p_row.NOMBRE,
        p_detalle    => p_row.DETALLE,
        p_activo     => p_row.ACTIVO,
        p_id_modulo  => p_row.ID_MODULO /*FK*/ );
    ELSE
      create_row (
        p_id_dominio => p_row.ID_DOMINIO /*PK*/,
        p_nombre     => p_row.NOMBRE,
        p_detalle    => p_row.DETALLE,
        p_activo     => p_row.ACTIVO,
        p_id_modulo  => p_row.ID_MODULO /*FK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).NOMBRE;
  END get_nombre;

  FUNCTION get_detalle (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).DETALLE;
  END get_detalle;

  FUNCTION get_activo (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).ACTIVO;
  END get_activo;

  FUNCTION get_id_modulo (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.ID_MODULO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).ID_MODULO;
  END get_id_modulo;

  FUNCTION get_usuario_insercion (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/ )
  RETURN T_DOMINIOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dominio => p_id_dominio ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/,
    p_nombre     IN T_DOMINIOS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio;
  END set_nombre;

  PROCEDURE set_detalle (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/,
    p_detalle    IN T_DOMINIOS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio;
  END set_detalle;

  PROCEDURE set_activo (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/,
    p_activo     IN T_DOMINIOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio;
  END set_activo;

  PROCEDURE set_id_modulo (
    p_id_dominio IN T_DOMINIOS.ID_DOMINIO%TYPE /*PK*/,
    p_id_modulo  IN T_DOMINIOS.ID_MODULO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DOMINIOS
    SET
      ID_MODULO            = p_id_modulo /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DOMINIO = p_id_dominio;
  END set_id_modulo;

  FUNCTION get_default_row
  RETURN T_DOMINIOS%ROWTYPE
  IS
    v_row T_DOMINIOS%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_DOMINIOS_API;
/

