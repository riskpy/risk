CREATE OR REPLACE PACKAGE BODY T_ROL_PERMISOS_API IS
  /*
  This is the API for the table T_ROL_PERMISOS.
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
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_ROL_PERMISOS
      WHERE
        ID_ROL = p_id_rol
        AND ID_PERMISO = p_id_permiso;
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
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_rol     => p_id_rol,
          p_id_permiso => p_id_permiso )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE                  /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE              /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE              DEFAULT 'N' ,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE               DEFAULT 'N' ,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE             DEFAULT 'N' ,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE               DEFAULT 'N' ,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE              DEFAULT 'N' ,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE              DEFAULT 'N'  )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
    v_return T_ROL_PERMISOS%ROWTYPE; 
  BEGIN
    INSERT INTO T_ROL_PERMISOS (
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_rol,
      p_id_permiso,
      p_consultar,
      p_insertar,
      p_actualizar,
      p_eliminar,
      p_verificar,
      p_autorizar,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE                  /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE              /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE              DEFAULT 'N' ,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE               DEFAULT 'N' ,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE             DEFAULT 'N' ,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE               DEFAULT 'N' ,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE              DEFAULT 'N' ,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE              DEFAULT 'N'  )
  IS
  BEGIN
    INSERT INTO T_ROL_PERMISOS (
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_rol,
      p_id_permiso,
      p_consultar,
      p_insertar,
      p_actualizar,
      p_eliminar,
      p_verificar,
      p_autorizar,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
      p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
      p_consultar  => p_row.CONSULTAR,
      p_insertar   => p_row.INSERTAR,
      p_actualizar => p_row.ACTUALIZAR,
      p_eliminar   => p_row.ELIMINAR,
      p_verificar  => p_row.VERIFICAR,
      p_autorizar  => p_row.AUTORIZAR );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
      p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
      p_consultar  => p_row.CONSULTAR,
      p_insertar   => p_row.INSERTAR,
      p_actualizar => p_row.ACTUALIZAR,
      p_eliminar   => p_row.ELIMINAR,
      p_verificar  => p_row.VERIFICAR,
      p_autorizar  => p_row.AUTORIZAR );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_ROL_PERMISOS (
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ROL,
      p_rows_tab(i).ID_PERMISO,
      p_rows_tab(i).CONSULTAR,
      p_rows_tab(i).INSERTAR,
      p_rows_tab(i).ACTUALIZAR,
      p_rows_tab(i).ELIMINAR,
      p_rows_tab(i).VERIFICAR,
      p_rows_tab(i).AUTORIZAR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
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
    INSERT INTO T_ROL_PERMISOS (
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ROL,
      p_rows_tab(i).ID_PERMISO,
      p_rows_tab(i).CONSULTAR,
      p_rows_tab(i).INSERTAR,
      p_rows_tab(i).ACTUALIZAR,
      p_rows_tab(i).ELIMINAR,
      p_rows_tab(i).VERIFICAR,
      p_rows_tab(i).AUTORIZAR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
    v_row T_ROL_PERMISOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_ROL_PERMISOS
      WHERE
        ID_ROL = p_id_rol
        AND ID_PERMISO = p_id_permiso;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_rol               IN            T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_id_permiso           IN            T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ /*FK*/,
    p_consultar               OUT NOCOPY T_ROL_PERMISOS.CONSULTAR%TYPE,
    p_insertar                OUT NOCOPY T_ROL_PERMISOS.INSERTAR%TYPE,
    p_actualizar              OUT NOCOPY T_ROL_PERMISOS.ACTUALIZAR%TYPE,
    p_eliminar                OUT NOCOPY T_ROL_PERMISOS.ELIMINAR%TYPE,
    p_verificar               OUT NOCOPY T_ROL_PERMISOS.VERIFICAR%TYPE,
    p_autorizar               OUT NOCOPY T_ROL_PERMISOS.AUTORIZAR%TYPE,
    p_usuario_insercion       OUT NOCOPY T_ROL_PERMISOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_ROL_PERMISOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_ROL_PERMISOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_ROL_PERMISOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_ROL_PERMISOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso );
    p_consultar            := v_row.CONSULTAR; 
    p_insertar             := v_row.INSERTAR; 
    p_actualizar           := v_row.ACTUALIZAR; 
    p_eliminar             := v_row.ELIMINAR; 
    p_verificar            := v_row.VERIFICAR; 
    p_autorizar            := v_row.AUTORIZAR; 
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
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
    v_return T_ROL_PERMISOS%ROWTYPE; 
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      CONSULTAR            = p_consultar,
      INSERTAR             = p_insertar,
      ACTUALIZAR           = p_actualizar,
      ELIMINAR             = p_eliminar,
      VERIFICAR            = p_verificar,
      AUTORIZAR            = p_autorizar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso
    RETURN 
      ID_ROL /*PK*/ /*FK*/,
      ID_PERMISO /*PK*/ /*FK*/,
      CONSULTAR,
      INSERTAR,
      ACTUALIZAR,
      ELIMINAR,
      VERIFICAR,
      AUTORIZAR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      CONSULTAR            = p_consultar,
      INSERTAR             = p_insertar,
      ACTUALIZAR           = p_actualizar,
      ELIMINAR             = p_eliminar,
      VERIFICAR            = p_verificar,
      AUTORIZAR            = p_autorizar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END update_row;

  FUNCTION update_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
      p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
      p_consultar  => p_row.CONSULTAR,
      p_insertar   => p_row.INSERTAR,
      p_actualizar => p_row.ACTUALIZAR,
      p_eliminar   => p_row.ELIMINAR,
      p_verificar  => p_row.VERIFICAR,
      p_autorizar  => p_row.AUTORIZAR );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
      p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
      p_consultar  => p_row.CONSULTAR,
      p_insertar   => p_row.INSERTAR,
      p_actualizar => p_row.ACTUALIZAR,
      p_eliminar   => p_row.ELIMINAR,
      p_verificar  => p_row.VERIFICAR,
      p_autorizar  => p_row.AUTORIZAR );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_ROL_PERMISOS
      SET
        CONSULTAR            = p_rows_tab(i).CONSULTAR,
        INSERTAR             = p_rows_tab(i).INSERTAR,
        ACTUALIZAR           = p_rows_tab(i).ACTUALIZAR,
        ELIMINAR             = p_rows_tab(i).ELIMINAR,
        VERIFICAR            = p_rows_tab(i).VERIFICAR,
        AUTORIZAR            = p_rows_tab(i).AUTORIZAR,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_ROL = p_rows_tab(i).ID_ROL
        AND ID_PERMISO = p_rows_tab(i).ID_PERMISO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_ROL_PERMISOS
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_ROL_PERMISOS
       WHERE ID_ROL = p_rows_tab(i).ID_ROL
        AND ID_PERMISO = p_rows_tab(i).ID_PERMISO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso
    )
    THEN
      RETURN update_row (
        p_id_rol     => p_id_rol /*PK*/ /*FK*/,
        p_id_permiso => p_id_permiso /*PK*/ /*FK*/,
        p_consultar  => p_consultar,
        p_insertar   => p_insertar,
        p_actualizar => p_actualizar,
        p_eliminar   => p_eliminar,
        p_verificar  => p_verificar,
        p_autorizar  => p_autorizar );
    ELSE
      RETURN create_row (
        p_id_rol     => p_id_rol /*PK*/ /*FK*/,
        p_id_permiso => p_id_permiso /*PK*/ /*FK*/,
        p_consultar  => p_consultar,
        p_insertar   => p_insertar,
        p_actualizar => p_actualizar,
        p_eliminar   => p_eliminar,
        p_verificar  => p_verificar,
        p_autorizar  => p_autorizar );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ /*FK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso
    )
    THEN
      update_row (
        p_id_rol     => p_id_rol /*PK*/ /*FK*/,
        p_id_permiso => p_id_permiso /*PK*/ /*FK*/,
        p_consultar  => p_consultar,
        p_insertar   => p_insertar,
        p_actualizar => p_actualizar,
        p_eliminar   => p_eliminar,
        p_verificar  => p_verificar,
        p_autorizar  => p_autorizar );
    ELSE
      create_row (
        p_id_rol     => p_id_rol /*PK*/ /*FK*/,
        p_id_permiso => p_id_permiso /*PK*/ /*FK*/,
        p_consultar  => p_consultar,
        p_insertar   => p_insertar,
        p_actualizar => p_actualizar,
        p_eliminar   => p_eliminar,
        p_verificar  => p_verificar,
        p_autorizar  => p_autorizar );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_rol     => p_row.ID_ROL,
      p_id_permiso => p_row.ID_PERMISO
    )
    THEN
      RETURN update_row (
        p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
        p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
        p_consultar  => p_row.CONSULTAR,
        p_insertar   => p_row.INSERTAR,
        p_actualizar => p_row.ACTUALIZAR,
        p_eliminar   => p_row.ELIMINAR,
        p_verificar  => p_row.VERIFICAR,
        p_autorizar  => p_row.AUTORIZAR );
    ELSE
      RETURN create_row (
        p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
        p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
        p_consultar  => p_row.CONSULTAR,
        p_insertar   => p_row.INSERTAR,
        p_actualizar => p_row.ACTUALIZAR,
        p_eliminar   => p_row.ELIMINAR,
        p_verificar  => p_row.VERIFICAR,
        p_autorizar  => p_row.AUTORIZAR );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_ROL_PERMISOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_rol     => p_row.ID_ROL,
      p_id_permiso => p_row.ID_PERMISO
    )
    THEN
      update_row (
        p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
        p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
        p_consultar  => p_row.CONSULTAR,
        p_insertar   => p_row.INSERTAR,
        p_actualizar => p_row.ACTUALIZAR,
        p_eliminar   => p_row.ELIMINAR,
        p_verificar  => p_row.VERIFICAR,
        p_autorizar  => p_row.AUTORIZAR );
    ELSE
      create_row (
        p_id_rol     => p_row.ID_ROL /*PK*/ /*FK*/,
        p_id_permiso => p_row.ID_PERMISO /*PK*/ /*FK*/,
        p_consultar  => p_row.CONSULTAR,
        p_insertar   => p_row.INSERTAR,
        p_actualizar => p_row.ACTUALIZAR,
        p_eliminar   => p_row.ELIMINAR,
        p_verificar  => p_row.VERIFICAR,
        p_autorizar  => p_row.AUTORIZAR );
    END IF;
  END create_or_update_row;

  FUNCTION get_consultar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.CONSULTAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).CONSULTAR;
  END get_consultar;

  FUNCTION get_insertar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.INSERTAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).INSERTAR;
  END get_insertar;

  FUNCTION get_actualizar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.ACTUALIZAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).ACTUALIZAR;
  END get_actualizar;

  FUNCTION get_eliminar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.ELIMINAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).ELIMINAR;
  END get_eliminar;

  FUNCTION get_verificar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.VERIFICAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).VERIFICAR;
  END get_verificar;

  FUNCTION get_autorizar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.AUTORIZAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).AUTORIZAR;
  END get_autorizar;

  FUNCTION get_usuario_insercion (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/ )
  RETURN T_ROL_PERMISOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_rol     => p_id_rol,
      p_id_permiso => p_id_permiso ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_consultar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_consultar  IN T_ROL_PERMISOS.CONSULTAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      CONSULTAR            = p_consultar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_consultar;

  PROCEDURE set_insertar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_insertar   IN T_ROL_PERMISOS.INSERTAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      INSERTAR             = p_insertar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_insertar;

  PROCEDURE set_actualizar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_actualizar IN T_ROL_PERMISOS.ACTUALIZAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      ACTUALIZAR           = p_actualizar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_actualizar;

  PROCEDURE set_eliminar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_eliminar   IN T_ROL_PERMISOS.ELIMINAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      ELIMINAR             = p_eliminar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_eliminar;

  PROCEDURE set_verificar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_verificar  IN T_ROL_PERMISOS.VERIFICAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      VERIFICAR            = p_verificar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_verificar;

  PROCEDURE set_autorizar (
    p_id_rol     IN T_ROL_PERMISOS.ID_ROL%TYPE /*PK*/,
    p_id_permiso IN T_ROL_PERMISOS.ID_PERMISO%TYPE /*PK*/,
    p_autorizar  IN T_ROL_PERMISOS.AUTORIZAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_ROL_PERMISOS
    SET
      AUTORIZAR            = p_autorizar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ROL = p_id_rol
      AND ID_PERMISO = p_id_permiso;
  END set_autorizar;

  FUNCTION get_default_row
  RETURN T_ROL_PERMISOS%ROWTYPE
  IS
    v_row T_ROL_PERMISOS%ROWTYPE;
  BEGIN
    v_row.CONSULTAR         := 'N' ;
    v_row.INSERTAR          := 'N' ;
    v_row.ACTUALIZAR        := 'N' ;
    v_row.ELIMINAR          := 'N' ;
    v_row.VERIFICAR         := 'N' ;
    v_row.AUTORIZAR         := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_ROL_PERMISOS_API;
/

