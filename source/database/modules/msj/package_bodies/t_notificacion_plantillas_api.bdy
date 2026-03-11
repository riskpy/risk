CREATE OR REPLACE PACKAGE BODY T_NOTIFICACION_PLANTILLAS_API IS
  /*
  This is the API for the table T_NOTIFICACION_PLANTILLAS.
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
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_NOTIFICACION_PLANTILLAS
      WHERE
        ID_APLICACION = p_id_aplicacion
        AND ID_PLANTILLA = p_id_plantilla;
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
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_aplicacion => p_id_aplicacion,
          p_id_plantilla  => p_id_plantilla )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
    v_return T_NOTIFICACION_PLANTILLAS%ROWTYPE; 
  BEGIN
    INSERT INTO T_NOTIFICACION_PLANTILLAS (
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_id_plantilla,
      p_nombre,
      p_activo,
      p_detalle,
      p_fecha_ini_vigencia,
      p_fecha_fin_vigencia,
      p_accion,
      p_cantidad_max_enviar,
      p_propiedades,
      p_cantidad_envio_por_dia,
      p_plantilla_titulo,
      p_plantilla_contenido,
      p_plantilla_datos_extra,
      p_id_categoria,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  IS
  BEGIN
    INSERT INTO T_NOTIFICACION_PLANTILLAS (
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_id_plantilla,
      p_nombre,
      p_activo,
      p_detalle,
      p_fecha_ini_vigencia,
      p_fecha_fin_vigencia,
      p_accion,
      p_cantidad_max_enviar,
      p_propiedades,
      p_cantidad_envio_por_dia,
      p_plantilla_titulo,
      p_plantilla_contenido,
      p_plantilla_datos_extra,
      p_id_categoria,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_detalle                => p_row.DETALLE,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_accion                 => p_row.ACCION,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_propiedades            => p_row.PROPIEDADES,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
      p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
      p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
      p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
      p_id_categoria           => p_row.ID_CATEGORIA );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_detalle                => p_row.DETALLE,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_accion                 => p_row.ACCION,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_propiedades            => p_row.PROPIEDADES,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
      p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
      p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
      p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
      p_id_categoria           => p_row.ID_CATEGORIA );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_NOTIFICACION_PLANTILLAS (
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).ID_PLANTILLA,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).FECHA_INI_VIGENCIA,
      p_rows_tab(i).FECHA_FIN_VIGENCIA,
      p_rows_tab(i).ACCION,
      p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
      p_rows_tab(i).PROPIEDADES,
      p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
      p_rows_tab(i).PLANTILLA_TITULO,
      p_rows_tab(i).PLANTILLA_CONTENIDO,
      p_rows_tab(i).PLANTILLA_DATOS_EXTRA,
      p_rows_tab(i).ID_CATEGORIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
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
    INSERT INTO T_NOTIFICACION_PLANTILLAS (
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).ID_PLANTILLA,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).FECHA_INI_VIGENCIA,
      p_rows_tab(i).FECHA_FIN_VIGENCIA,
      p_rows_tab(i).ACCION,
      p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
      p_rows_tab(i).PROPIEDADES,
      p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
      p_rows_tab(i).PLANTILLA_TITULO,
      p_rows_tab(i).PLANTILLA_CONTENIDO,
      p_rows_tab(i).PLANTILLA_DATOS_EXTRA,
      p_rows_tab(i).ID_CATEGORIA,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
    v_row T_NOTIFICACION_PLANTILLAS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_NOTIFICACION_PLANTILLAS
      WHERE
        ID_APLICACION = p_id_aplicacion
        AND ID_PLANTILLA = p_id_plantilla;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_aplicacion          IN            T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN            T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                    OUT NOCOPY T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                    OUT NOCOPY T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                   OUT NOCOPY T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia        OUT NOCOPY T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia        OUT NOCOPY T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                    OUT NOCOPY T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar       OUT NOCOPY T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades               OUT NOCOPY T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia    OUT NOCOPY T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo          OUT NOCOPY T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido       OUT NOCOPY T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra     OUT NOCOPY T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria              OUT NOCOPY T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE,
    p_usuario_insercion         OUT NOCOPY T_NOTIFICACION_PLANTILLAS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion           OUT NOCOPY T_NOTIFICACION_PLANTILLAS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion      OUT NOCOPY T_NOTIFICACION_PLANTILLAS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion        OUT NOCOPY T_NOTIFICACION_PLANTILLAS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_NOTIFICACION_PLANTILLAS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla );
    p_nombre                 := v_row.NOMBRE; 
    p_activo                 := v_row.ACTIVO; 
    p_detalle                := v_row.DETALLE; 
    p_fecha_ini_vigencia     := v_row.FECHA_INI_VIGENCIA; 
    p_fecha_fin_vigencia     := v_row.FECHA_FIN_VIGENCIA; 
    p_accion                 := v_row.ACCION; 
    p_cantidad_max_enviar    := v_row.CANTIDAD_MAX_ENVIAR; 
    p_propiedades            := v_row.PROPIEDADES; 
    p_cantidad_envio_por_dia := v_row.CANTIDAD_ENVIO_POR_DIA; 
    p_plantilla_titulo       := v_row.PLANTILLA_TITULO; 
    p_plantilla_contenido    := v_row.PLANTILLA_CONTENIDO; 
    p_plantilla_datos_extra  := v_row.PLANTILLA_DATOS_EXTRA; 
    p_id_categoria           := v_row.ID_CATEGORIA; 
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
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
    v_return T_NOTIFICACION_PLANTILLAS%ROWTYPE; 
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      NOMBRE                 = p_nombre,
      ACTIVO                 = p_activo,
      DETALLE                = p_detalle,
      FECHA_INI_VIGENCIA     = p_fecha_ini_vigencia,
      FECHA_FIN_VIGENCIA     = p_fecha_fin_vigencia,
      ACCION                 = p_accion,
      CANTIDAD_MAX_ENVIAR    = p_cantidad_max_enviar,
      PROPIEDADES            = p_propiedades,
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      PLANTILLA_TITULO       = p_plantilla_titulo,
      PLANTILLA_CONTENIDO    = p_plantilla_contenido,
      PLANTILLA_DATOS_EXTRA  = p_plantilla_datos_extra,
      ID_CATEGORIA           = p_id_categoria,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla
    RETURN 
      ID_APLICACION /*PK*/,
      ID_PLANTILLA /*PK*/,
      NOMBRE,
      ACTIVO,
      DETALLE,
      FECHA_INI_VIGENCIA,
      FECHA_FIN_VIGENCIA,
      ACCION,
      CANTIDAD_MAX_ENVIAR,
      PROPIEDADES,
      CANTIDAD_ENVIO_POR_DIA,
      PLANTILLA_TITULO,
      PLANTILLA_CONTENIDO,
      PLANTILLA_DATOS_EXTRA,
      ID_CATEGORIA,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      NOMBRE                 = p_nombre,
      ACTIVO                 = p_activo,
      DETALLE                = p_detalle,
      FECHA_INI_VIGENCIA     = p_fecha_ini_vigencia,
      FECHA_FIN_VIGENCIA     = p_fecha_fin_vigencia,
      ACCION                 = p_accion,
      CANTIDAD_MAX_ENVIAR    = p_cantidad_max_enviar,
      PROPIEDADES            = p_propiedades,
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      PLANTILLA_TITULO       = p_plantilla_titulo,
      PLANTILLA_CONTENIDO    = p_plantilla_contenido,
      PLANTILLA_DATOS_EXTRA  = p_plantilla_datos_extra,
      ID_CATEGORIA           = p_id_categoria,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END update_row;

  FUNCTION update_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_detalle                => p_row.DETALLE,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_accion                 => p_row.ACCION,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_propiedades            => p_row.PROPIEDADES,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
      p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
      p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
      p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
      p_id_categoria           => p_row.ID_CATEGORIA );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
      p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
      p_nombre                 => p_row.NOMBRE,
      p_activo                 => p_row.ACTIVO,
      p_detalle                => p_row.DETALLE,
      p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
      p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
      p_accion                 => p_row.ACCION,
      p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
      p_propiedades            => p_row.PROPIEDADES,
      p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
      p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
      p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
      p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
      p_id_categoria           => p_row.ID_CATEGORIA );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_NOTIFICACION_PLANTILLAS
      SET
        NOMBRE                 = p_rows_tab(i).NOMBRE,
        ACTIVO                 = p_rows_tab(i).ACTIVO,
        DETALLE                = p_rows_tab(i).DETALLE,
        FECHA_INI_VIGENCIA     = p_rows_tab(i).FECHA_INI_VIGENCIA,
        FECHA_FIN_VIGENCIA     = p_rows_tab(i).FECHA_FIN_VIGENCIA,
        ACCION                 = p_rows_tab(i).ACCION,
        CANTIDAD_MAX_ENVIAR    = p_rows_tab(i).CANTIDAD_MAX_ENVIAR,
        PROPIEDADES            = p_rows_tab(i).PROPIEDADES,
        CANTIDAD_ENVIO_POR_DIA = p_rows_tab(i).CANTIDAD_ENVIO_POR_DIA,
        PLANTILLA_TITULO       = p_rows_tab(i).PLANTILLA_TITULO,
        PLANTILLA_CONTENIDO    = p_rows_tab(i).PLANTILLA_CONTENIDO,
        PLANTILLA_DATOS_EXTRA  = p_rows_tab(i).PLANTILLA_DATOS_EXTRA,
        ID_CATEGORIA           = p_rows_tab(i).ID_CATEGORIA,
        USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION     = systimestamp
      WHERE
        ID_APLICACION = p_rows_tab(i).ID_APLICACION
        AND ID_PLANTILLA = p_rows_tab(i).ID_PLANTILLA;
  END update_rows;

  PROCEDURE delete_row (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_NOTIFICACION_PLANTILLAS
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_NOTIFICACION_PLANTILLAS
       WHERE ID_APLICACION = p_rows_tab(i).ID_APLICACION
        AND ID_PLANTILLA = p_rows_tab(i).ID_PLANTILLA;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla
    )
    THEN
      RETURN update_row (
        p_id_aplicacion          => p_id_aplicacion /*PK*/,
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_detalle                => p_detalle,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_accion                 => p_accion,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_propiedades            => p_propiedades,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia,
        p_plantilla_titulo       => p_plantilla_titulo,
        p_plantilla_contenido    => p_plantilla_contenido,
        p_plantilla_datos_extra  => p_plantilla_datos_extra,
        p_id_categoria           => p_id_categoria );
    ELSE
      RETURN create_row (
        p_id_aplicacion          => p_id_aplicacion /*PK*/,
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_detalle                => p_detalle,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_accion                 => p_accion,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_propiedades            => p_propiedades,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia,
        p_plantilla_titulo       => p_plantilla_titulo,
        p_plantilla_contenido    => p_plantilla_contenido,
        p_plantilla_datos_extra  => p_plantilla_datos_extra,
        p_id_categoria           => p_id_categoria );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                 IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE,
    p_activo                 IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE,
    p_detalle                IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE,
    p_fecha_ini_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE,
    p_fecha_fin_vigencia     IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE,
    p_accion                 IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE,
    p_cantidad_max_enviar    IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE,
    p_propiedades            IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE,
    p_plantilla_titulo       IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE,
    p_plantilla_contenido    IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_plantilla_datos_extra  IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE,
    p_id_categoria           IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla
    )
    THEN
      update_row (
        p_id_aplicacion          => p_id_aplicacion /*PK*/,
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_detalle                => p_detalle,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_accion                 => p_accion,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_propiedades            => p_propiedades,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia,
        p_plantilla_titulo       => p_plantilla_titulo,
        p_plantilla_contenido    => p_plantilla_contenido,
        p_plantilla_datos_extra  => p_plantilla_datos_extra,
        p_id_categoria           => p_id_categoria );
    ELSE
      create_row (
        p_id_aplicacion          => p_id_aplicacion /*PK*/,
        p_id_plantilla           => p_id_plantilla /*PK*/,
        p_nombre                 => p_nombre,
        p_activo                 => p_activo,
        p_detalle                => p_detalle,
        p_fecha_ini_vigencia     => p_fecha_ini_vigencia,
        p_fecha_fin_vigencia     => p_fecha_fin_vigencia,
        p_accion                 => p_accion,
        p_cantidad_max_enviar    => p_cantidad_max_enviar,
        p_propiedades            => p_propiedades,
        p_cantidad_envio_por_dia => p_cantidad_envio_por_dia,
        p_plantilla_titulo       => p_plantilla_titulo,
        p_plantilla_contenido    => p_plantilla_contenido,
        p_plantilla_datos_extra  => p_plantilla_datos_extra,
        p_id_categoria           => p_id_categoria );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  RETURN T_NOTIFICACION_PLANTILLAS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION,
      p_id_plantilla  => p_row.ID_PLANTILLA
    )
    THEN
      RETURN update_row (
        p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_detalle                => p_row.DETALLE,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_accion                 => p_row.ACCION,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_propiedades            => p_row.PROPIEDADES,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
        p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
        p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
        p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
        p_id_categoria           => p_row.ID_CATEGORIA );
    ELSE
      RETURN create_row (
        p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_detalle                => p_row.DETALLE,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_accion                 => p_row.ACCION,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_propiedades            => p_row.PROPIEDADES,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
        p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
        p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
        p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
        p_id_categoria           => p_row.ID_CATEGORIA );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_NOTIFICACION_PLANTILLAS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION,
      p_id_plantilla  => p_row.ID_PLANTILLA
    )
    THEN
      update_row (
        p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_detalle                => p_row.DETALLE,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_accion                 => p_row.ACCION,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_propiedades            => p_row.PROPIEDADES,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
        p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
        p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
        p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
        p_id_categoria           => p_row.ID_CATEGORIA );
    ELSE
      create_row (
        p_id_aplicacion          => p_row.ID_APLICACION /*PK*/,
        p_id_plantilla           => p_row.ID_PLANTILLA /*PK*/,
        p_nombre                 => p_row.NOMBRE,
        p_activo                 => p_row.ACTIVO,
        p_detalle                => p_row.DETALLE,
        p_fecha_ini_vigencia     => p_row.FECHA_INI_VIGENCIA,
        p_fecha_fin_vigencia     => p_row.FECHA_FIN_VIGENCIA,
        p_accion                 => p_row.ACCION,
        p_cantidad_max_enviar    => p_row.CANTIDAD_MAX_ENVIAR,
        p_propiedades            => p_row.PROPIEDADES,
        p_cantidad_envio_por_dia => p_row.CANTIDAD_ENVIO_POR_DIA,
        p_plantilla_titulo       => p_row.PLANTILLA_TITULO,
        p_plantilla_contenido    => p_row.PLANTILLA_CONTENIDO,
        p_plantilla_datos_extra  => p_row.PLANTILLA_DATOS_EXTRA,
        p_id_categoria           => p_row.ID_CATEGORIA );
    END IF;
  END create_or_update_row;

  FUNCTION get_nombre (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).NOMBRE;
  END get_nombre;

  FUNCTION get_activo (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).ACTIVO;
  END get_activo;

  FUNCTION get_detalle (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).DETALLE;
  END get_detalle;

  FUNCTION get_fecha_ini_vigencia (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).FECHA_INI_VIGENCIA;
  END get_fecha_ini_vigencia;

  FUNCTION get_fecha_fin_vigencia (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).FECHA_FIN_VIGENCIA;
  END get_fecha_fin_vigencia;

  FUNCTION get_accion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).ACCION;
  END get_accion;

  FUNCTION get_cantidad_max_enviar (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).CANTIDAD_MAX_ENVIAR;
  END get_cantidad_max_enviar;

  FUNCTION get_propiedades (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).PROPIEDADES;
  END get_propiedades;

  FUNCTION get_cantidad_envio_por_dia (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).CANTIDAD_ENVIO_POR_DIA;
  END get_cantidad_envio_por_dia;

  FUNCTION get_plantilla_titulo (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).PLANTILLA_TITULO;
  END get_plantilla_titulo;

  FUNCTION get_plantilla_contenido (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).PLANTILLA_CONTENIDO;
  END get_plantilla_contenido;

  FUNCTION get_plantilla_datos_extra (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).PLANTILLA_DATOS_EXTRA;
  END get_plantilla_datos_extra;

  FUNCTION get_id_categoria (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).ID_CATEGORIA;
  END get_id_categoria;

  FUNCTION get_usuario_insercion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_NOTIFICACION_PLANTILLAS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_plantilla  => p_id_plantilla ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_nombre (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre        IN T_NOTIFICACION_PLANTILLAS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_nombre;

  PROCEDURE set_activo (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_activo        IN T_NOTIFICACION_PLANTILLAS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_activo;

  PROCEDURE set_detalle (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_detalle       IN T_NOTIFICACION_PLANTILLAS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_detalle;

  PROCEDURE set_fecha_ini_vigencia (
    p_id_aplicacion      IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla       IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_fecha_ini_vigencia IN T_NOTIFICACION_PLANTILLAS.FECHA_INI_VIGENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      FECHA_INI_VIGENCIA   = p_fecha_ini_vigencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_fecha_ini_vigencia;

  PROCEDURE set_fecha_fin_vigencia (
    p_id_aplicacion      IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla       IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_fecha_fin_vigencia IN T_NOTIFICACION_PLANTILLAS.FECHA_FIN_VIGENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      FECHA_FIN_VIGENCIA   = p_fecha_fin_vigencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_fecha_fin_vigencia;

  PROCEDURE set_accion (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_accion        IN T_NOTIFICACION_PLANTILLAS.ACCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      ACCION               = p_accion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_accion;

  PROCEDURE set_cantidad_max_enviar (
    p_id_aplicacion       IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla        IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_cantidad_max_enviar IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_MAX_ENVIAR%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      CANTIDAD_MAX_ENVIAR  = p_cantidad_max_enviar,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_cantidad_max_enviar;

  PROCEDURE set_propiedades (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_propiedades   IN T_NOTIFICACION_PLANTILLAS.PROPIEDADES%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      PROPIEDADES          = p_propiedades,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_propiedades;

  PROCEDURE set_cantidad_envio_por_dia (
    p_id_aplicacion          IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla           IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_cantidad_envio_por_dia IN T_NOTIFICACION_PLANTILLAS.CANTIDAD_ENVIO_POR_DIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      CANTIDAD_ENVIO_POR_DIA = p_cantidad_envio_por_dia,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_cantidad_envio_por_dia;

  PROCEDURE set_plantilla_titulo (
    p_id_aplicacion    IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla     IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla_titulo IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_TITULO%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      PLANTILLA_TITULO     = p_plantilla_titulo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_plantilla_titulo;

  PROCEDURE set_plantilla_contenido (
    p_id_aplicacion       IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla        IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla_contenido IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      PLANTILLA_CONTENIDO  = p_plantilla_contenido,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_plantilla_contenido;

  PROCEDURE set_plantilla_datos_extra (
    p_id_aplicacion         IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla          IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla_datos_extra IN T_NOTIFICACION_PLANTILLAS.PLANTILLA_DATOS_EXTRA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      PLANTILLA_DATOS_EXTRA = p_plantilla_datos_extra,
      USUARIO_MODIFICACION  = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION    = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_plantilla_datos_extra;

  PROCEDURE set_id_categoria (
    p_id_aplicacion IN T_NOTIFICACION_PLANTILLAS.ID_APLICACION%TYPE /*PK*/,
    p_id_plantilla  IN T_NOTIFICACION_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_id_categoria  IN T_NOTIFICACION_PLANTILLAS.ID_CATEGORIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_NOTIFICACION_PLANTILLAS
    SET
      ID_CATEGORIA         = p_id_categoria,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PLANTILLA = p_id_plantilla;
  END set_id_categoria;

END T_NOTIFICACION_PLANTILLAS_API;
/

