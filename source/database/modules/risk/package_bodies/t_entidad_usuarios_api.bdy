CREATE OR REPLACE PACKAGE BODY T_ENTIDAD_USUARIOS_API IS
  /*
  This is the API for the table T_ENTIDAD_USUARIOS.
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
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_ENTIDAD_USUARIOS
      WHERE
        ID_ENTIDAD = p_id_entidad
        AND ID_USUARIO = p_id_usuario
        AND GRUPO = p_grupo;
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
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_entidad => p_id_entidad,
          p_id_usuario => p_id_usuario,
          p_grupo      => p_grupo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
    v_return T_ENTIDAD_USUARIOS%ROWTYPE; 
  BEGIN
    INSERT INTO T_ENTIDAD_USUARIOS (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_entidad,
      p_id_usuario,
      p_grupo,
      p_estado,
      p_fecha_expiracion,
      p_direccion_correo,
      p_numero_telefono,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  IS
  BEGIN
    INSERT INTO T_ENTIDAD_USUARIOS (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_entidad,
      p_id_usuario,
      p_grupo,
      p_estado,
      p_fecha_expiracion,
      p_direccion_correo,
      p_numero_telefono,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_grupo            => p_row.GRUPO /*PK*/,
      p_estado           => p_row.ESTADO,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION,
      p_direccion_correo => p_row.DIRECCION_CORREO,
      p_numero_telefono  => p_row.NUMERO_TELEFONO );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_grupo            => p_row.GRUPO /*PK*/,
      p_estado           => p_row.ESTADO,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION,
      p_direccion_correo => p_row.DIRECCION_CORREO,
      p_numero_telefono  => p_row.NUMERO_TELEFONO );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_ENTIDAD_USUARIOS (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ENTIDAD,
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).GRUPO,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).FECHA_EXPIRACION,
      p_rows_tab(i).DIRECCION_CORREO,
      p_rows_tab(i).NUMERO_TELEFONO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
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
    INSERT INTO T_ENTIDAD_USUARIOS (
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_ENTIDAD,
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).GRUPO,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).FECHA_EXPIRACION,
      p_rows_tab(i).DIRECCION_CORREO,
      p_rows_tab(i).NUMERO_TELEFONO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
    v_row T_ENTIDAD_USUARIOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_ENTIDAD_USUARIOS
      WHERE
        ID_ENTIDAD = p_id_entidad
        AND ID_USUARIO = p_id_usuario
        AND GRUPO = p_grupo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_entidad           IN            T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario           IN            T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo                IN            T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado                  OUT NOCOPY T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion        OUT NOCOPY T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo        OUT NOCOPY T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono         OUT NOCOPY T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_ENTIDAD_USUARIOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_ENTIDAD_USUARIOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_ENTIDAD_USUARIOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_ENTIDAD_USUARIOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_ENTIDAD_USUARIOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo );
    p_estado               := v_row.ESTADO; 
    p_fecha_expiracion     := v_row.FECHA_EXPIRACION; 
    p_direccion_correo     := v_row.DIRECCION_CORREO; 
    p_numero_telefono      := v_row.NUMERO_TELEFONO; 
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
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
    v_return T_ENTIDAD_USUARIOS%ROWTYPE; 
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      ESTADO               = p_estado,
      FECHA_EXPIRACION     = p_fecha_expiracion,
      DIRECCION_CORREO     = p_direccion_correo,
      NUMERO_TELEFONO      = p_numero_telefono,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo
    RETURN 
      ID_ENTIDAD /*PK*/ /*FK*/,
      ID_USUARIO /*PK*/ /*FK*/,
      GRUPO /*PK*/,
      ESTADO,
      FECHA_EXPIRACION,
      DIRECCION_CORREO,
      NUMERO_TELEFONO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      ESTADO               = p_estado,
      FECHA_EXPIRACION     = p_fecha_expiracion,
      DIRECCION_CORREO     = p_direccion_correo,
      NUMERO_TELEFONO      = p_numero_telefono,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_grupo            => p_row.GRUPO /*PK*/,
      p_estado           => p_row.ESTADO,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION,
      p_direccion_correo => p_row.DIRECCION_CORREO,
      p_numero_telefono  => p_row.NUMERO_TELEFONO );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
      p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_grupo            => p_row.GRUPO /*PK*/,
      p_estado           => p_row.ESTADO,
      p_fecha_expiracion => p_row.FECHA_EXPIRACION,
      p_direccion_correo => p_row.DIRECCION_CORREO,
      p_numero_telefono  => p_row.NUMERO_TELEFONO );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_ENTIDAD_USUARIOS
      SET
        ESTADO               = p_rows_tab(i).ESTADO,
        FECHA_EXPIRACION     = p_rows_tab(i).FECHA_EXPIRACION,
        DIRECCION_CORREO     = p_rows_tab(i).DIRECCION_CORREO,
        NUMERO_TELEFONO      = p_rows_tab(i).NUMERO_TELEFONO,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_ENTIDAD = p_rows_tab(i).ID_ENTIDAD
        AND ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND GRUPO = p_rows_tab(i).GRUPO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_ENTIDAD_USUARIOS
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_ENTIDAD_USUARIOS
       WHERE ID_ENTIDAD = p_rows_tab(i).ID_ENTIDAD
        AND ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND GRUPO = p_rows_tab(i).GRUPO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo
    )
    THEN
      RETURN update_row (
        p_id_entidad       => p_id_entidad /*PK*/ /*FK*/,
        p_id_usuario       => p_id_usuario /*PK*/ /*FK*/,
        p_grupo            => p_grupo /*PK*/,
        p_estado           => p_estado,
        p_fecha_expiracion => p_fecha_expiracion,
        p_direccion_correo => p_direccion_correo,
        p_numero_telefono  => p_numero_telefono );
    ELSE
      RETURN create_row (
        p_id_entidad       => p_id_entidad /*PK*/ /*FK*/,
        p_id_usuario       => p_id_usuario /*PK*/ /*FK*/,
        p_grupo            => p_grupo /*PK*/,
        p_estado           => p_estado,
        p_fecha_expiracion => p_fecha_expiracion,
        p_direccion_correo => p_direccion_correo,
        p_numero_telefono  => p_numero_telefono );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado           IN T_ENTIDAD_USUARIOS.ESTADO%TYPE,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE,
    p_numero_telefono  IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo
    )
    THEN
      update_row (
        p_id_entidad       => p_id_entidad /*PK*/ /*FK*/,
        p_id_usuario       => p_id_usuario /*PK*/ /*FK*/,
        p_grupo            => p_grupo /*PK*/,
        p_estado           => p_estado,
        p_fecha_expiracion => p_fecha_expiracion,
        p_direccion_correo => p_direccion_correo,
        p_numero_telefono  => p_numero_telefono );
    ELSE
      create_row (
        p_id_entidad       => p_id_entidad /*PK*/ /*FK*/,
        p_id_usuario       => p_id_usuario /*PK*/ /*FK*/,
        p_grupo            => p_grupo /*PK*/,
        p_estado           => p_estado,
        p_fecha_expiracion => p_fecha_expiracion,
        p_direccion_correo => p_direccion_correo,
        p_numero_telefono  => p_numero_telefono );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  RETURN T_ENTIDAD_USUARIOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_row.ID_ENTIDAD,
      p_id_usuario => p_row.ID_USUARIO,
      p_grupo      => p_row.GRUPO
    )
    THEN
      RETURN update_row (
        p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_grupo            => p_row.GRUPO /*PK*/,
        p_estado           => p_row.ESTADO,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION,
        p_direccion_correo => p_row.DIRECCION_CORREO,
        p_numero_telefono  => p_row.NUMERO_TELEFONO );
    ELSE
      RETURN create_row (
        p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_grupo            => p_row.GRUPO /*PK*/,
        p_estado           => p_row.ESTADO,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION,
        p_direccion_correo => p_row.DIRECCION_CORREO,
        p_numero_telefono  => p_row.NUMERO_TELEFONO );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_ENTIDAD_USUARIOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_entidad => p_row.ID_ENTIDAD,
      p_id_usuario => p_row.ID_USUARIO,
      p_grupo      => p_row.GRUPO
    )
    THEN
      update_row (
        p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_grupo            => p_row.GRUPO /*PK*/,
        p_estado           => p_row.ESTADO,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION,
        p_direccion_correo => p_row.DIRECCION_CORREO,
        p_numero_telefono  => p_row.NUMERO_TELEFONO );
    ELSE
      create_row (
        p_id_entidad       => p_row.ID_ENTIDAD /*PK*/ /*FK*/,
        p_id_usuario       => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_grupo            => p_row.GRUPO /*PK*/,
        p_estado           => p_row.ESTADO,
        p_fecha_expiracion => p_row.FECHA_EXPIRACION,
        p_direccion_correo => p_row.DIRECCION_CORREO,
        p_numero_telefono  => p_row.NUMERO_TELEFONO );
    END IF;
  END create_or_update_row;

  FUNCTION get_estado (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.ESTADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).ESTADO;
  END get_estado;

  FUNCTION get_fecha_expiracion (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).FECHA_EXPIRACION;
  END get_fecha_expiracion;

  FUNCTION get_direccion_correo (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).DIRECCION_CORREO;
  END get_direccion_correo;

  FUNCTION get_numero_telefono (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).NUMERO_TELEFONO;
  END get_numero_telefono;

  FUNCTION get_usuario_insercion (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/ )
  RETURN T_ENTIDAD_USUARIOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_entidad => p_id_entidad,
      p_id_usuario => p_id_usuario,
      p_grupo      => p_grupo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_estado (
    p_id_entidad IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo      IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_estado     IN T_ENTIDAD_USUARIOS.ESTADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      ESTADO               = p_estado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END set_estado;

  PROCEDURE set_fecha_expiracion (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_fecha_expiracion IN T_ENTIDAD_USUARIOS.FECHA_EXPIRACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      FECHA_EXPIRACION     = p_fecha_expiracion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END set_fecha_expiracion;

  PROCEDURE set_direccion_correo (
    p_id_entidad       IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario       IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo            IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_direccion_correo IN T_ENTIDAD_USUARIOS.DIRECCION_CORREO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      DIRECCION_CORREO     = p_direccion_correo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END set_direccion_correo;

  PROCEDURE set_numero_telefono (
    p_id_entidad      IN T_ENTIDAD_USUARIOS.ID_ENTIDAD%TYPE /*PK*/,
    p_id_usuario      IN T_ENTIDAD_USUARIOS.ID_USUARIO%TYPE /*PK*/,
    p_grupo           IN T_ENTIDAD_USUARIOS.GRUPO%TYPE /*PK*/,
    p_numero_telefono IN T_ENTIDAD_USUARIOS.NUMERO_TELEFONO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ENTIDAD_USUARIOS
    SET
      NUMERO_TELEFONO      = p_numero_telefono,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_ENTIDAD = p_id_entidad
      AND ID_USUARIO = p_id_usuario
      AND GRUPO = p_grupo;
  END set_numero_telefono;

END T_ENTIDAD_USUARIOS_API;
/

