CREATE OR REPLACE PACKAGE BODY T_MENSAJE_PLANTILLAS_API IS
  /*
  This is the API for the table T_MENSAJE_PLANTILLAS.
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
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_MENSAJE_PLANTILLAS
      WHERE
        ID_PLANTILLA = p_id_plantilla;
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
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_plantilla => p_id_plantilla )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
    v_return T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE; 
  BEGIN
    INSERT INTO T_MENSAJE_PLANTILLAS (
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      ID_CATEGORIA /*FK*/,
      DETALLE,
      PLANTILLA,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      CANTIDAD_MAX_ENVIAR,
      CANTIDAD_ENVIO_POR_DIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_plantilla,
      p_nombre,
      p_activo,
      p_id_categoria,
      p_detalle,
      p_plantilla,
      p_fecha_ini_vigencia,
      p_fecha_fin_vigencia,
      p_cantidad_max_enviar,
      p_cantidad_envio_por_dia,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_PLANTILLA
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  IS
  BEGIN
    INSERT INTO T_MENSAJE_PLANTILLAS (
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      ID_CATEGORIA /*FK*/,
      DETALLE,
      PLANTILLA,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      CANTIDAD_MAX_ENVIAR,
      CANTIDAD_ENVIO_POR_DIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_plantilla,
      p_nombre,
      p_activo,
      p_id_categoria,
      p_detalle,
      p_plantilla,
      p_fecha_ini_vigencia,
      p_fecha_fin_vigencia,
      p_cantidad_max_enviar,
      p_cantidad_envio_por_dia,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
      p_detalle                => p_row.DETALLE,
      p_plantilla              => p_row.PLANTILLA,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
      p_detalle                => p_row.DETALLE,
      p_plantilla              => p_row.PLANTILLA,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MENSAJE_PLANTILLAS (
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      ID_CATEGORIA /*FK*/,
      DETALLE,
      PLANTILLA,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      CANTIDAD_MAX_ENVIAR,
      CANTIDAD_ENVIO_POR_DIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_PLANTILLA,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).ID_CATEGORIA,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).PLANTILLA,
      p_rows_tab(i).FECHA_INI_VIGENCIA,
      p_rows_tab(i).FECHA_FIN_VIGENCIA,
      p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
      p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      ID_CATEGORIA /*FK*/,
      DETALLE,
      PLANTILLA,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      CANTIDAD_MAX_ENVIAR,
      CANTIDAD_ENVIO_POR_DIA,
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
    INSERT INTO T_MENSAJE_PLANTILLAS (
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      ID_CATEGORIA /*FK*/,
      DETALLE,
      PLANTILLA,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      CANTIDAD_MAX_ENVIAR,
      CANTIDAD_ENVIO_POR_DIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_PLANTILLA,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).ID_CATEGORIA,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).PLANTILLA,
      p_rows_tab(i).FECHA_INI_VIGENCIA,
      p_rows_tab(i).FECHA_FIN_VIGENCIA,
      p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
      p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS%ROWTYPE
  IS
    v_row T_MENSAJE_PLANTILLAS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_MENSAJE_PLANTILLAS
      WHERE
        ID_PLANTILLA = p_id_plantilla;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_plantilla           IN            T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                    OUT NOCOPY T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                    OUT NOCOPY T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria              OUT NOCOPY T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                   OUT NOCOPY T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla                 OUT NOCOPY T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia        OUT NOCOPY T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia        OUT NOCOPY T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar       OUT NOCOPY T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia    OUT NOCOPY T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_usuario_insercion         OUT NOCOPY T_MENSAJE_PLANTILLAS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion           OUT NOCOPY T_MENSAJE_PLANTILLAS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion      OUT NOCOPY T_MENSAJE_PLANTILLAS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion        OUT NOCOPY T_MENSAJE_PLANTILLAS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_MENSAJE_PLANTILLAS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_plantilla => p_id_plantilla );
    p_nombre                 := v_row.NOMBRE; 
    p_activo                 := v_row.ACTIVO; 
    p_id_categoria           := v_row.ID_CATEGORIA; 
    p_detalle                := v_row.DETALLE; 
    p_plantilla              := v_row.PLANTILLA; 
    p_fecha_ini_vigencia     := v_row.FECHA_INI_VIGENCIA; 
    p_fecha_fin_vigencia     := v_row.FECHA_FIN_VIGENCIA; 
    p_cantidad_max_enviar    := v_row.CANTIDAD_MAX_ENVIAR; 
    p_cantidad_envio_por_dia := v_row.CANTIDAD_ENVIO_POR_DIA; 
    p_usuario_insercion      := v_row.USUARIO_INSERCION; 
    p_fecha_insercion        := v_row.FECHA_INSERCION; 
    p_usuario_modificacion   := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion     := v_row.FECHA_MODIFICACION; 
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
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
    v_return T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE; 
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      NOMBRE                 = p_nombre,
      ACTIVO                 = p_activo,
      ID_CATEGORIA           = p_id_categoria /*FK*/,
      DETALLE                = p_detalle,
      PLANTILLA              = p_plantilla,
      FECHA_INI_VIGENCIA     = p_fecha_ini_vigencia,
      FECHA_FIN_VIGENCIA     = p_fecha_fin_vigencia,
      CANTIDAD_MAX_ENVIAR    = p_cantidad_max_enviar,
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla
    RETURN 
      ID_PLANTILLA
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      NOMBRE                 = p_nombre,
      ACTIVO                 = p_activo,
      ID_CATEGORIA           = p_id_categoria /*FK*/,
      DETALLE                = p_detalle,
      PLANTILLA              = p_plantilla,
      FECHA_INI_VIGENCIA     = p_fecha_ini_vigencia,
      FECHA_FIN_VIGENCIA     = p_fecha_fin_vigencia,
      CANTIDAD_MAX_ENVIAR    = p_cantidad_max_enviar,
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END update_row;

  FUNCTION update_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
      p_detalle                => p_row.DETALLE,
      p_plantilla              => p_row.PLANTILLA,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
      p_detalle                => p_row.DETALLE,
      p_plantilla              => p_row.PLANTILLA,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_MENSAJE_PLANTILLAS
      SET
        NOMBRE                 = p_rows_tab(i).NOMBRE,
        ACTIVO                 = p_rows_tab(i).ACTIVO,
        ID_CATEGORIA           = p_rows_tab(i).ID_CATEGORIA /*FK*/,
        DETALLE                = p_rows_tab(i).DETALLE,
        PLANTILLA              = p_rows_tab(i).PLANTILLA,
        FECHA_INI_VIGENCIA     = p_rows_tab(i).FECHA_INI_VIGENCIA,
        FECHA_FIN_VIGENCIA     = p_rows_tab(i).FECHA_FIN_VIGENCIA,
        CANTIDAD_MAX_ENVIAR    = p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
        CANTIDAD_ENVIO_POR_DIA = p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
        USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION     = systimestamp
      WHERE
        ID_PLANTILLA = p_rows_tab(i).ID_PLANTILLA;
  END update_rows;

  PROCEDURE delete_row (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_MENSAJE_PLANTILLAS
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_MENSAJE_PLANTILLAS
       WHERE ID_PLANTILLA = p_rows_tab(i).ID_PLANTILLA;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_plantilla => p_id_plantilla
    )
    THEN
      RETURN update_row (
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_id_categoria           => p_id_categoria /*FK*/,
        p_detalle                => p_detalle,
        p_plantilla              => p_plantilla,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia );
    ELSE
      RETURN create_row (
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_id_categoria           => p_id_categoria /*FK*/,
        p_detalle                => p_detalle,
        p_plantilla              => p_plantilla,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre                 IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria           IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE,
    p_plantilla              IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE,
    p_fecha_ini_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_cantidad_max_enviar    IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_plantilla => p_id_plantilla
    )
    THEN
      update_row (
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_id_categoria           => p_id_categoria /*FK*/,
        p_detalle                => p_detalle,
        p_plantilla              => p_plantilla,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia );
    ELSE
      create_row (
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_id_categoria           => p_id_categoria /*FK*/,
        p_detalle                => p_detalle,
        p_plantilla              => p_plantilla,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  RETURN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_plantilla => p_row.ID_PLANTILLA
    )
    THEN
      RETURN update_row (
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
        p_detalle                => p_row.DETALLE,
        p_plantilla              => p_row.PLANTILLA,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
    ELSE
      RETURN create_row (
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
        p_detalle                => p_row.DETALLE,
        p_plantilla              => p_row.PLANTILLA,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_MENSAJE_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_plantilla => p_row.ID_PLANTILLA
    )
    THEN
      update_row (
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
        p_detalle                => p_row.DETALLE,
        p_plantilla              => p_row.PLANTILLA,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
    ELSE
      create_row (
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_id_categoria           => p_row.ID_CATEGORIA /*FK*/,
        p_detalle                => p_row.DETALLE,
        p_plantilla              => p_row.PLANTILLA,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).NOMBRE;
  END get_nombre;

  FUNCTION get_activo (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).ACTIVO;
  END get_activo;

  FUNCTION get_id_categoria (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).ID_CATEGORIA;
  END get_id_categoria;

  FUNCTION get_detalle (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).DETALLE;
  END get_detalle;

  FUNCTION get_plantilla (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).PLANTILLA;
  END get_plantilla;

  FUNCTION get_fecha_ini_vigencia (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).FECHA_INI_VIGENCIA;
  END get_fecha_ini_vigencia;

  FUNCTION get_fecha_fin_vigencia (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).FECHA_FIN_VIGENCIA;
  END get_fecha_fin_vigencia;

  FUNCTION get_cantidad_max_enviar (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).CANTIDAD_MAX_ENVIAR;
  END get_cantidad_max_enviar;

  FUNCTION get_cantidad_envio_por_dia (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).CANTIDAD_ENVIO_POR_DIA;
  END get_cantidad_envio_por_dia;

  FUNCTION get_usuario_insercion (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_MENSAJE_PLANTILLAS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_plantilla => p_id_plantilla ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre       IN T_MENSAJE_PLANTILLAS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_nombre;

  PROCEDURE set_activo (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_activo       IN T_MENSAJE_PLANTILLAS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_activo;

  PROCEDURE set_id_categoria (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_id_categoria IN T_MENSAJE_PLANTILLAS.ID_CATEGORIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      ID_CATEGORIA         = p_id_categoria /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_id_categoria;

  PROCEDURE set_detalle (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_detalle      IN T_MENSAJE_PLANTILLAS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_detalle;

  PROCEDURE set_plantilla (
    p_id_plantilla IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla    IN T_MENSAJE_PLANTILLAS.PLANTILLA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      PLANTILLA            = p_plantilla,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_plantilla;

  PROCEDURE set_fecha_ini_vigencia (
    p_id_plantilla       IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_fecha_ini_vigencia IN T_MENSAJE_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      FECHA_INI_VIGENCIA   = p_fecha_ini_vigencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_fecha_ini_vigencia;

  PROCEDURE set_fecha_fin_vigencia (
    p_id_plantilla       IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_fecha_fin_vigencia IN T_MENSAJE_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      FECHA_FIN_VIGENCIA   = p_fecha_fin_vigencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_fecha_fin_vigencia;

  PROCEDURE set_cantidad_max_enviar (
    p_id_plantilla        IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_cantidad_max_enviar IN T_MENSAJE_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      CANTIDAD_MAX_ENVIAR  = p_cantidad_max_enviar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_cantidad_max_enviar;

  PROCEDURE set_cantidad_envio_por_dia (
    p_id_plantilla           IN T_MENSAJE_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_cantidad_envio_por_dia IN T_MENSAJE_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_MENSAJE_PLANTILLAS
    SET
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_PLANTILLA = p_id_plantilla;
  END set_cantidad_envio_por_dia;

END T_MENSAJE_PLANTILLAS_API;
/

