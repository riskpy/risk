CREATE OR REPLACE PACKAGE BODY T_AUTENTICACION_ORIGENES_API IS
  /*
  This is the API for the table T_AUTENTICACION_ORIGENES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:56
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
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_AUTENTICACION_ORIGENES
      WHERE
        ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
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
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_autenticacion_origen => p_id_autenticacion_origen )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE              DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE                               ,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE                              DEFAULT NULL,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE                               DEFAULT 'N' ,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE                      DEFAULT NULL,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE       DEFAULT NULL,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE   DEFAULT NULL )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
    v_return T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE; 
  BEGIN
    INSERT INTO T_AUTENTICACION_ORIGENES (
      ID_AUTENTICACION_ORIGEN /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      PREFIJO_DOMINIO,
      METODO_VALIDACION_CREDENCIALES,
      PARAMETROS_VALIDACION_CREDENCIALES,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_autenticacion_origen,
      p_nombre,
      p_detalle,
      p_activo,
      p_prefijo_dominio,
      p_metodo_validacion_credenciales,
      p_parametros_validacion_credenciales,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_AUTENTICACION_ORIGEN
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE              DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE                               ,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE                              DEFAULT NULL,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE                               DEFAULT 'N' ,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE                      DEFAULT NULL,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE       DEFAULT NULL,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE   DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_AUTENTICACION_ORIGENES (
      ID_AUTENTICACION_ORIGEN /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      PREFIJO_DOMINIO,
      METODO_VALIDACION_CREDENCIALES,
      PARAMETROS_VALIDACION_CREDENCIALES,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_autenticacion_origen,
      p_nombre,
      p_detalle,
      p_activo,
      p_prefijo_dominio,
      p_metodo_validacion_credenciales,
      p_parametros_validacion_credenciales,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
      p_nombre                             => p_row.NOMBRE,
      p_detalle                            => p_row.DETALLE,
      p_activo                             => p_row.ACTIVO,
      p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
      p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
      p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
      p_nombre                             => p_row.NOMBRE,
      p_detalle                            => p_row.DETALLE,
      p_activo                             => p_row.ACTIVO,
      p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
      p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
      p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_AUTENTICACION_ORIGENES (
      ID_AUTENTICACION_ORIGEN /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      PREFIJO_DOMINIO,
      METODO_VALIDACION_CREDENCIALES,
      PARAMETROS_VALIDACION_CREDENCIALES,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_AUTENTICACION_ORIGEN,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).PREFIJO_DOMINIO,
      p_rows_tab(i).METODO_VALIDACION_CREDENCIALES,
      p_rows_tab(i).PARAMETROS_VALIDACION_CREDENCIALES,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_AUTENTICACION_ORIGEN /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      PREFIJO_DOMINIO,
      METODO_VALIDACION_CREDENCIALES,
      PARAMETROS_VALIDACION_CREDENCIALES,
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
    INSERT INTO T_AUTENTICACION_ORIGENES (
      ID_AUTENTICACION_ORIGEN /*PK*/,
      NOMBRE,
      DETALLE,
      ACTIVO,
      PREFIJO_DOMINIO,
      METODO_VALIDACION_CREDENCIALES,
      PARAMETROS_VALIDACION_CREDENCIALES,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_AUTENTICACION_ORIGEN,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).PREFIJO_DOMINIO,
      p_rows_tab(i).METODO_VALIDACION_CREDENCIALES,
      p_rows_tab(i).PARAMETROS_VALIDACION_CREDENCIALES,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES%ROWTYPE
  IS
    v_row T_AUTENTICACION_ORIGENES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_AUTENTICACION_ORIGENES
      WHERE
        ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_autenticacion_origen            IN            T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_nombre                                OUT NOCOPY T_AUTENTICACION_ORIGENES.NOMBRE%TYPE,
    p_detalle                               OUT NOCOPY T_AUTENTICACION_ORIGENES.DETALLE%TYPE,
    p_activo                                OUT NOCOPY T_AUTENTICACION_ORIGENES.ACTIVO%TYPE,
    p_prefijo_dominio                       OUT NOCOPY T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE,
    p_metodo_validacion_credenciales        OUT NOCOPY T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE,
    p_parametros_validacion_credenciales    OUT NOCOPY T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE,
    p_usuario_insercion                     OUT NOCOPY T_AUTENTICACION_ORIGENES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion                       OUT NOCOPY T_AUTENTICACION_ORIGENES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion                  OUT NOCOPY T_AUTENTICACION_ORIGENES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion                    OUT NOCOPY T_AUTENTICACION_ORIGENES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_AUTENTICACION_ORIGENES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen );
    p_nombre                             := v_row.NOMBRE; 
    p_detalle                            := v_row.DETALLE; 
    p_activo                             := v_row.ACTIVO; 
    p_prefijo_dominio                    := v_row.PREFIJO_DOMINIO; 
    p_metodo_validacion_credenciales     := v_row.METODO_VALIDACION_CREDENCIALES; 
    p_parametros_validacion_credenciales := v_row.PARAMETROS_VALIDACION_CREDENCIALES; 
    p_usuario_insercion                  := v_row.USUARIO_INSERCION; 
    p_fecha_insercion                    := v_row.FECHA_INSERCION; 
    p_usuario_modificacion               := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion                 := v_row.FECHA_MODIFICACION; 
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
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
    v_return T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE; 
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      NOMBRE                             = p_nombre,
      DETALLE                            = p_detalle,
      ACTIVO                             = p_activo,
      PREFIJO_DOMINIO                    = p_prefijo_dominio,
      METODO_VALIDACION_CREDENCIALES     = p_metodo_validacion_credenciales,
      PARAMETROS_VALIDACION_CREDENCIALES = p_parametros_validacion_credenciales,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen
    RETURN 
      ID_AUTENTICACION_ORIGEN
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      NOMBRE                             = p_nombre,
      DETALLE                            = p_detalle,
      ACTIVO                             = p_activo,
      PREFIJO_DOMINIO                    = p_prefijo_dominio,
      METODO_VALIDACION_CREDENCIALES     = p_metodo_validacion_credenciales,
      PARAMETROS_VALIDACION_CREDENCIALES = p_parametros_validacion_credenciales,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END update_row;

  FUNCTION update_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
      p_nombre                             => p_row.NOMBRE,
      p_detalle                            => p_row.DETALLE,
      p_activo                             => p_row.ACTIVO,
      p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
      p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
      p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
      p_nombre                             => p_row.NOMBRE,
      p_detalle                            => p_row.DETALLE,
      p_activo                             => p_row.ACTIVO,
      p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
      p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
      p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_AUTENTICACION_ORIGENES
      SET
        NOMBRE                             = p_rows_tab(i).NOMBRE,
        DETALLE                            = p_rows_tab(i).DETALLE,
        ACTIVO                             = p_rows_tab(i).ACTIVO,
        PREFIJO_DOMINIO                    = p_rows_tab(i).PREFIJO_DOMINIO,
        METODO_VALIDACION_CREDENCIALES     = p_rows_tab(i).METODO_VALIDACION_CREDENCIALES,
        PARAMETROS_VALIDACION_CREDENCIALES = p_rows_tab(i).PARAMETROS_VALIDACION_CREDENCIALES,
        USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION                 = systimestamp
      WHERE
        ID_AUTENTICACION_ORIGEN = p_rows_tab(i).ID_AUTENTICACION_ORIGEN;
  END update_rows;

  PROCEDURE delete_row (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_AUTENTICACION_ORIGENES
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_AUTENTICACION_ORIGENES
       WHERE ID_AUTENTICACION_ORIGEN = p_rows_tab(i).ID_AUTENTICACION_ORIGEN;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_autenticacion_origen => p_id_autenticacion_origen
    )
    THEN
      RETURN update_row (
        p_id_autenticacion_origen            => p_id_autenticacion_origen /*PK*/,
        p_nombre                             => p_nombre,
        p_detalle                            => p_detalle,
        p_activo                             => p_activo,
        p_prefijo_dominio                    => p_prefijo_dominio,
        p_metodo_validacion_credenciales     => p_metodo_validacion_credenciales,
        p_parametros_validacion_credenciales => p_parametros_validacion_credenciales );
    ELSE
      RETURN create_row (
        p_id_autenticacion_origen            => p_id_autenticacion_origen /*PK*/,
        p_nombre                             => p_nombre,
        p_detalle                            => p_detalle,
        p_activo                             => p_activo,
        p_prefijo_dominio                    => p_prefijo_dominio,
        p_metodo_validacion_credenciales     => p_metodo_validacion_credenciales,
        p_parametros_validacion_credenciales => p_parametros_validacion_credenciales );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE DEFAULT NULL /*PK*/,
    p_nombre                             IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE,
    p_detalle                            IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE,
    p_activo                             IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE,
    p_prefijo_dominio                    IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE,
    p_metodo_validacion_credenciales     IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_autenticacion_origen => p_id_autenticacion_origen
    )
    THEN
      update_row (
        p_id_autenticacion_origen            => p_id_autenticacion_origen /*PK*/,
        p_nombre                             => p_nombre,
        p_detalle                            => p_detalle,
        p_activo                             => p_activo,
        p_prefijo_dominio                    => p_prefijo_dominio,
        p_metodo_validacion_credenciales     => p_metodo_validacion_credenciales,
        p_parametros_validacion_credenciales => p_parametros_validacion_credenciales );
    ELSE
      create_row (
        p_id_autenticacion_origen            => p_id_autenticacion_origen /*PK*/,
        p_nombre                             => p_nombre,
        p_detalle                            => p_detalle,
        p_activo                             => p_activo,
        p_prefijo_dominio                    => p_prefijo_dominio,
        p_metodo_validacion_credenciales     => p_metodo_validacion_credenciales,
        p_parametros_validacion_credenciales => p_parametros_validacion_credenciales );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  RETURN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_autenticacion_origen => p_row.ID_AUTENTICACION_ORIGEN
    )
    THEN
      RETURN update_row (
        p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
        p_nombre                             => p_row.NOMBRE,
        p_detalle                            => p_row.DETALLE,
        p_activo                             => p_row.ACTIVO,
        p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
        p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
        p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
    ELSE
      RETURN create_row (
        p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
        p_nombre                             => p_row.NOMBRE,
        p_detalle                            => p_row.DETALLE,
        p_activo                             => p_row.ACTIVO,
        p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
        p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
        p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_AUTENTICACION_ORIGENES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_autenticacion_origen => p_row.ID_AUTENTICACION_ORIGEN
    )
    THEN
      update_row (
        p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
        p_nombre                             => p_row.NOMBRE,
        p_detalle                            => p_row.DETALLE,
        p_activo                             => p_row.ACTIVO,
        p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
        p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
        p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
    ELSE
      create_row (
        p_id_autenticacion_origen            => p_row.ID_AUTENTICACION_ORIGEN /*PK*/,
        p_nombre                             => p_row.NOMBRE,
        p_detalle                            => p_row.DETALLE,
        p_activo                             => p_row.ACTIVO,
        p_prefijo_dominio                    => p_row.PREFIJO_DOMINIO,
        p_metodo_validacion_credenciales     => p_row.METODO_VALIDACION_CREDENCIALES,
        p_parametros_validacion_credenciales => p_row.PARAMETROS_VALIDACION_CREDENCIALES );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).NOMBRE;
  END get_nombre;

  FUNCTION get_detalle (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).DETALLE;
  END get_detalle;

  FUNCTION get_activo (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).ACTIVO;
  END get_activo;

  FUNCTION get_prefijo_dominio (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).PREFIJO_DOMINIO;
  END get_prefijo_dominio;

  FUNCTION get_metodo_validacion_credenciales (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).METODO_VALIDACION_CREDENCIALES;
  END get_metodo_validacion_credenciales;

  FUNCTION get_parametros_validacion_credenciales (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).PARAMETROS_VALIDACION_CREDENCIALES;
  END get_parametros_validacion_credenciales;

  FUNCTION get_usuario_insercion (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/ )
  RETURN T_AUTENTICACION_ORIGENES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_autenticacion_origen => p_id_autenticacion_origen ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_nombre                  IN T_AUTENTICACION_ORIGENES.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_nombre;

  PROCEDURE set_detalle (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_detalle                 IN T_AUTENTICACION_ORIGENES.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_detalle;

  PROCEDURE set_activo (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_activo                  IN T_AUTENTICACION_ORIGENES.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_activo;

  PROCEDURE set_prefijo_dominio (
    p_id_autenticacion_origen IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_prefijo_dominio         IN T_AUTENTICACION_ORIGENES.PREFIJO_DOMINIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      PREFIJO_DOMINIO      = p_prefijo_dominio,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_prefijo_dominio;

  PROCEDURE set_metodo_validacion_credenciales (
    p_id_autenticacion_origen        IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_metodo_validacion_credenciales IN T_AUTENTICACION_ORIGENES.METODO_VALIDACION_CREDENCIALES%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      METODO_VALIDACION_CREDENCIALES = p_metodo_validacion_credenciales,
      USUARIO_MODIFICACION           = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION             = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_metodo_validacion_credenciales;

  PROCEDURE set_parametros_validacion_credenciales (
    p_id_autenticacion_origen            IN T_AUTENTICACION_ORIGENES.ID_AUTENTICACION_ORIGEN%TYPE /*PK*/,
    p_parametros_validacion_credenciales IN T_AUTENTICACION_ORIGENES.PARAMETROS_VALIDACION_CREDENCIALES%TYPE )
  IS
  BEGIN
    UPDATE
      T_AUTENTICACION_ORIGENES
    SET
      PARAMETROS_VALIDACION_CREDENCIALES = p_parametros_validacion_credenciales,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_AUTENTICACION_ORIGEN = p_id_autenticacion_origen;
  END set_parametros_validacion_credenciales;

  FUNCTION get_default_row
  RETURN T_AUTENTICACION_ORIGENES%ROWTYPE
  IS
    v_row T_AUTENTICACION_ORIGENES%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_AUTENTICACION_ORIGENES_API;
/

