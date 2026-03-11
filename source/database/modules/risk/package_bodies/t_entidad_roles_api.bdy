CREATE OR REPLACE PACKAGE BODY T_ENTIDAD_ROLES_API IS
  /*
  This is the API for the table T_ENTIDAD_ROLES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:55
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
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_ENTIDAD_ROLES
      WHERE
        ID_ENTIDAD = p_id_entidad
        AND ID_ROL = p_id_rol;
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
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_entidad => p_id_entidad,
          p_id_rol     => p_id_rol )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
    v_return T_ENTIDAD_ROLES%ROWTYPE; 
  BEGIN
    INSERT INTO T_ENTIDAD_ROLES (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_entidad,
      p_id_rol,
      p_estado,
      p_cantidad_autorizaciones_requeridas,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  IS
  BEGIN
    INSERT INTO T_ENTIDAD_ROLES (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_entidad,
      p_id_rol,
      p_estado,
      p_cantidad_autorizaciones_requeridas,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
      p_estado                             => p_row.ESTADO,
      p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
      p_estado                             => p_row.ESTADO,
      p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_ENTIDAD_ROLES (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ENTIDAD,
      p_rows_tab(i).ID_ROL,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
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
    INSERT INTO T_ENTIDAD_ROLES (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ENTIDAD,
      p_rows_tab(i).ID_ROL,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
    v_row T_ENTIDAD_ROLES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_ENTIDAD_ROLES
      WHERE
        ID_ENTIDAD = p_id_entidad
        AND ID_ROL = p_id_rol;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_entidad                         IN            T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN            T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                                OUT NOCOPY T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas    OUT NOCOPY T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE,
    p_usuario_insercion                     OUT NOCOPY T_ENTIDAD_ROLES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion                       OUT NOCOPY T_ENTIDAD_ROLES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion                  OUT NOCOPY T_ENTIDAD_ROLES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion                    OUT NOCOPY T_ENTIDAD_ROLES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_ENTIDAD_ROLES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol );
    p_estado                             := v_row.ESTADO; 
    p_cantidad_autorizaciones_requeridas := v_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS; 
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
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
    v_return T_ENTIDAD_ROLES%ROWTYPE; 
  BEGIN
    UPDATE
      T_ENTIDAD_ROLES
    SET
      ESTADO                             = p_estado,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS = p_cantidad_autorizaciones_requeridas,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_ROL = p_id_rol
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_ROL /*PK*/ /*FK*/,
      ESTADO,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_ROLES
    SET
      ESTADO                             = p_estado,
      CANTIDAD_AUTORIZACIONES_REQUERIDAS = p_cantidad_autorizaciones_requeridas,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_ROL = p_id_rol;
  END update_row;

  FUNCTION update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
      p_estado                             => p_row.ESTADO,
      p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
      p_estado                             => p_row.ESTADO,
      p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_ENTIDAD_ROLES
      SET
        ESTADO                             = p_rows_tab(i).ESTADO,
        CANTIDAD_AUTORIZACIONES_REQUERIDAS = p_rows_tab(i).CANTIDAD_AUTORIZACIONES_REQUERIDAS,
        USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION                 = systimestamp
      WHERE
        ID_ENTIDAD = p_rows_tab(i).ID_ENTIDAD
        AND ID_ROL = p_rows_tab(i).ID_ROL;
  END update_rows;

  PROCEDURE delete_row (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_ENTIDAD_ROLES
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_ROL = p_id_rol;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_ENTIDAD_ROLES
       WHERE ID_ENTIDAD = p_rows_tab(i).ID_ENTIDAD
        AND ID_ROL = p_rows_tab(i).ID_ROL;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol
    )
    THEN
      RETURN update_row (
        p_id_entidad                         => p_id_entidad /*PK*/ /*FK*/,
        p_id_rol                             => p_id_rol /*PK*/ /*FK*/,
        p_estado                             => p_estado,
        p_cantidad_autorizaciones_requeridas => p_cantidad_autorizaciones_requeridas );
    ELSE
      RETURN create_row (
        p_id_entidad                         => p_id_entidad /*PK*/ /*FK*/,
        p_id_rol                             => p_id_rol /*PK*/ /*FK*/,
        p_estado                             => p_estado,
        p_cantidad_autorizaciones_requeridas => p_cantidad_autorizaciones_requeridas );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol
    )
    THEN
      update_row (
        p_id_entidad                         => p_id_entidad /*PK*/ /*FK*/,
        p_id_rol                             => p_id_rol /*PK*/ /*FK*/,
        p_estado                             => p_estado,
        p_cantidad_autorizaciones_requeridas => p_cantidad_autorizaciones_requeridas );
    ELSE
      create_row (
        p_id_entidad                         => p_id_entidad /*PK*/ /*FK*/,
        p_id_rol                             => p_id_rol /*PK*/ /*FK*/,
        p_estado                             => p_estado,
        p_cantidad_autorizaciones_requeridas => p_cantidad_autorizaciones_requeridas );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_row.ID_ENTIDAD,
      p_id_rol     => p_row.ID_ROL
    )
    THEN
      RETURN update_row (
        p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
        p_estado                             => p_row.ESTADO,
        p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
    ELSE
      RETURN create_row (
        p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
        p_estado                             => p_row.ESTADO,
        p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_row.ID_ENTIDAD,
      p_id_rol     => p_row.ID_ROL
    )
    THEN
      update_row (
        p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
        p_estado                             => p_row.ESTADO,
        p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
    ELSE
      create_row (
        p_id_entidad                         => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_rol                             => p_row.ID_ROL /*PK*/ /*FK*/,
        p_estado                             => p_row.ESTADO,
        p_cantidad_autorizaciones_requeridas => p_row.CANTIDAD_AUTORIZACIONES_REQUERIDAS );
    END IF;
  END create_or_update_row;

  FUNCTION get_estado (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.ESTADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).ESTADO;
  END get_estado;

  FUNCTION get_cantidad_autorizaciones_requeridas (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).CANTIDAD_AUTORIZACIONES_REQUERIDAS;
  END get_cantidad_autorizaciones_requeridas;

  FUNCTION get_usuario_insercion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_rol     => p_id_rol ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_estado (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/,
    p_estado     IN T_ENTIDAD_ROLES.ESTADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_ROLES
    SET
      ESTADO               = p_estado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_ROL = p_id_rol;
  END set_estado;

  PROCEDURE set_cantidad_autorizaciones_requeridas (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_ROLES
    SET
      CANTIDAD_AUTORIZACIONES_REQUERIDAS = p_cantidad_autorizaciones_requeridas,
      USUARIO_MODIFICACION               = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION                 = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_ROL = p_id_rol;
  END set_cantidad_autorizaciones_requeridas;

END T_ENTIDAD_ROLES_API;
/

