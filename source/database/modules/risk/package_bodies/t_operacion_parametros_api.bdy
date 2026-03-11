CREATE OR REPLACE PACKAGE BODY T_OPERACION_PARAMETROS_API IS
  /*
  This is the API for the table T_OPERACION_PARAMETROS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:51
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
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_OPERACION_PARAMETROS
      WHERE
        ID_OPERACION = p_id_operacion
        AND NOMBRE = p_nombre
        AND VERSION = p_version;
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
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_operacion => p_id_operacion,
          p_nombre       => p_nombre,
          p_version      => p_version )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
    v_return T_OPERACION_PARAMETROS%ROWTYPE; 
  BEGIN
    INSERT INTO T_OPERACION_PARAMETROS (
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_operacion,
      p_nombre,
      p_version,
      p_orden,
      p_activo,
      p_tipo_dato,
      p_formato,
      p_longitud_maxima,
      p_obligatorio,
      p_valor_defecto,
      p_etiqueta,
      p_detalle,
      p_valores_posibles,
      p_encriptado,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  IS
  BEGIN
    INSERT INTO T_OPERACION_PARAMETROS (
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_operacion,
      p_nombre,
      p_version,
      p_orden,
      p_activo,
      p_tipo_dato,
      p_formato,
      p_longitud_maxima,
      p_obligatorio,
      p_valor_defecto,
      p_etiqueta,
      p_detalle,
      p_valores_posibles,
      p_encriptado,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/,
      p_version          => p_row.VERSION /*PK*/ /*UK*/,
      p_orden            => p_row.ORDEN /*UK*/,
      p_activo           => p_row.ACTIVO,
      p_tipo_dato        => p_row.TIPO_DATO,
      p_formato          => p_row.FORMATO,
      p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
      p_obligatorio      => p_row.OBLIGATORIO,
      p_valor_defecto    => p_row.VALOR_DEFECTO,
      p_etiqueta         => p_row.ETIQUETA,
      p_detalle          => p_row.DETALLE,
      p_valores_posibles => p_row.VALORES_POSIBLES,
      p_encriptado       => p_row.ENCRIPTADO );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/,
      p_version          => p_row.VERSION /*PK*/ /*UK*/,
      p_orden            => p_row.ORDEN /*UK*/,
      p_activo           => p_row.ACTIVO,
      p_tipo_dato        => p_row.TIPO_DATO,
      p_formato          => p_row.FORMATO,
      p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
      p_obligatorio      => p_row.OBLIGATORIO,
      p_valor_defecto    => p_row.VALOR_DEFECTO,
      p_etiqueta         => p_row.ETIQUETA,
      p_detalle          => p_row.DETALLE,
      p_valores_posibles => p_row.VALORES_POSIBLES,
      p_encriptado       => p_row.ENCRIPTADO );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_OPERACION_PARAMETROS (
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_OPERACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).VERSION,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).TIPO_DATO,
      p_rows_tab(i).FORMATO,
      p_rows_tab(i).LONGITUD_MAXIMA,
      p_rows_tab(i).OBLIGATORIO,
      p_rows_tab(i).VALOR_DEFECTO,
      p_rows_tab(i).ETIQUETA,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).VALORES_POSIBLES,
      p_rows_tab(i).ENCRIPTADO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
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
    INSERT INTO T_OPERACION_PARAMETROS (
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_OPERACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).VERSION,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).TIPO_DATO,
      p_rows_tab(i).FORMATO,
      p_rows_tab(i).LONGITUD_MAXIMA,
      p_rows_tab(i).OBLIGATORIO,
      p_rows_tab(i).VALOR_DEFECTO,
      p_rows_tab(i).ETIQUETA,
      p_rows_tab(i).DETALLE,
      p_rows_tab(i).VALORES_POSIBLES,
      p_rows_tab(i).ENCRIPTADO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
    v_row T_OPERACION_PARAMETROS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_OPERACION_PARAMETROS
      WHERE
        ID_OPERACION = p_id_operacion
        AND NOMBRE = p_nombre
        AND VERSION = p_version;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  FUNCTION read_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*UK*/,
    p_orden        IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*UK*/ )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
    v_row T_OPERACION_PARAMETROS%ROWTYPE;
    CURSOR cur_row IS
      SELECT *
        FROM T_OPERACION_PARAMETROS
       WHERE ID_OPERACION = p_id_operacion
        AND ORDEN = p_orden
        AND VERSION = p_version;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END;

  PROCEDURE read_row (
    p_id_operacion         IN            T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre               IN            T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version              IN            T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden                   OUT NOCOPY T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo                  OUT NOCOPY T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato               OUT NOCOPY T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato                 OUT NOCOPY T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima         OUT NOCOPY T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio             OUT NOCOPY T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto           OUT NOCOPY T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta                OUT NOCOPY T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle                 OUT NOCOPY T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles        OUT NOCOPY T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado              OUT NOCOPY T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_OPERACION_PARAMETROS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_OPERACION_PARAMETROS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_OPERACION_PARAMETROS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_OPERACION_PARAMETROS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_OPERACION_PARAMETROS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version );
    p_orden                := v_row.ORDEN; 
    p_activo               := v_row.ACTIVO; 
    p_tipo_dato            := v_row.TIPO_DATO; 
    p_formato              := v_row.FORMATO; 
    p_longitud_maxima      := v_row.LONGITUD_MAXIMA; 
    p_obligatorio          := v_row.OBLIGATORIO; 
    p_valor_defecto        := v_row.VALOR_DEFECTO; 
    p_etiqueta             := v_row.ETIQUETA; 
    p_detalle              := v_row.DETALLE; 
    p_valores_posibles     := v_row.VALORES_POSIBLES; 
    p_encriptado           := v_row.ENCRIPTADO; 
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
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
    v_return T_OPERACION_PARAMETROS%ROWTYPE; 
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ORDEN                = p_orden /*UK*/,
      ACTIVO               = p_activo,
      TIPO_DATO            = p_tipo_dato,
      FORMATO              = p_formato,
      LONGITUD_MAXIMA      = p_longitud_maxima,
      OBLIGATORIO          = p_obligatorio,
      VALOR_DEFECTO        = p_valor_defecto,
      ETIQUETA             = p_etiqueta,
      DETALLE              = p_detalle,
      VALORES_POSIBLES     = p_valores_posibles,
      ENCRIPTADO           = p_encriptado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version
    RETURN 
      ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      NOMBRE /*PK*/,
      VERSION /*PK*/ /*UK*/,
      ORDEN /*UK*/,
      ACTIVO,
      TIPO_DATO,
      FORMATO,
      LONGITUD_MAXIMA,
      OBLIGATORIO,
      VALOR_DEFECTO,
      ETIQUETA,
      DETALLE,
      VALORES_POSIBLES,
      ENCRIPTADO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ORDEN                = p_orden /*UK*/,
      ACTIVO               = p_activo,
      TIPO_DATO            = p_tipo_dato,
      FORMATO              = p_formato,
      LONGITUD_MAXIMA      = p_longitud_maxima,
      OBLIGATORIO          = p_obligatorio,
      VALOR_DEFECTO        = p_valor_defecto,
      ETIQUETA             = p_etiqueta,
      DETALLE              = p_detalle,
      VALORES_POSIBLES     = p_valores_posibles,
      ENCRIPTADO           = p_encriptado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END update_row;

  FUNCTION update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/,
      p_version          => p_row.VERSION /*PK*/ /*UK*/,
      p_orden            => p_row.ORDEN /*UK*/,
      p_activo           => p_row.ACTIVO,
      p_tipo_dato        => p_row.TIPO_DATO,
      p_formato          => p_row.FORMATO,
      p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
      p_obligatorio      => p_row.OBLIGATORIO,
      p_valor_defecto    => p_row.VALOR_DEFECTO,
      p_etiqueta         => p_row.ETIQUETA,
      p_detalle          => p_row.DETALLE,
      p_valores_posibles => p_row.VALORES_POSIBLES,
      p_encriptado       => p_row.ENCRIPTADO );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/,
      p_version          => p_row.VERSION /*PK*/ /*UK*/,
      p_orden            => p_row.ORDEN /*UK*/,
      p_activo           => p_row.ACTIVO,
      p_tipo_dato        => p_row.TIPO_DATO,
      p_formato          => p_row.FORMATO,
      p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
      p_obligatorio      => p_row.OBLIGATORIO,
      p_valor_defecto    => p_row.VALOR_DEFECTO,
      p_etiqueta         => p_row.ETIQUETA,
      p_detalle          => p_row.DETALLE,
      p_valores_posibles => p_row.VALORES_POSIBLES,
      p_encriptado       => p_row.ENCRIPTADO );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_OPERACION_PARAMETROS
      SET
        ORDEN                = p_rows_tab(i).ORDEN /*UK*/,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        TIPO_DATO            = p_rows_tab(i).TIPO_DATO,
        FORMATO              = p_rows_tab(i).FORMATO,
        LONGITUD_MAXIMA      = p_rows_tab(i).LONGITUD_MAXIMA,
        OBLIGATORIO          = p_rows_tab(i).OBLIGATORIO,
        VALOR_DEFECTO        = p_rows_tab(i).VALOR_DEFECTO,
        ETIQUETA             = p_rows_tab(i).ETIQUETA,
        DETALLE              = p_rows_tab(i).DETALLE,
        VALORES_POSIBLES     = p_rows_tab(i).VALORES_POSIBLES,
        ENCRIPTADO           = p_rows_tab(i).ENCRIPTADO,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_OPERACION = p_rows_tab(i).ID_OPERACION
        AND NOMBRE = p_rows_tab(i).NOMBRE
        AND VERSION = p_rows_tab(i).VERSION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_OPERACION_PARAMETROS
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_OPERACION_PARAMETROS
       WHERE ID_OPERACION = p_rows_tab(i).ID_OPERACION
        AND NOMBRE = p_rows_tab(i).NOMBRE
        AND VERSION = p_rows_tab(i).VERSION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version
    )
    THEN
      RETURN update_row (
        p_id_operacion     => p_id_operacion /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/,
        p_version          => p_version /*PK*/ /*UK*/,
        p_orden            => p_orden /*UK*/,
        p_activo           => p_activo,
        p_tipo_dato        => p_tipo_dato,
        p_formato          => p_formato,
        p_longitud_maxima  => p_longitud_maxima,
        p_obligatorio      => p_obligatorio,
        p_valor_defecto    => p_valor_defecto,
        p_etiqueta         => p_etiqueta,
        p_detalle          => p_detalle,
        p_valores_posibles => p_valores_posibles,
        p_encriptado       => p_encriptado );
    ELSE
      RETURN create_row (
        p_id_operacion     => p_id_operacion /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/,
        p_version          => p_version /*PK*/ /*UK*/,
        p_orden            => p_orden /*UK*/,
        p_activo           => p_activo,
        p_tipo_dato        => p_tipo_dato,
        p_formato          => p_formato,
        p_longitud_maxima  => p_longitud_maxima,
        p_obligatorio      => p_obligatorio,
        p_valor_defecto    => p_valor_defecto,
        p_etiqueta         => p_etiqueta,
        p_detalle          => p_detalle,
        p_valores_posibles => p_valores_posibles,
        p_encriptado       => p_encriptado );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version
    )
    THEN
      update_row (
        p_id_operacion     => p_id_operacion /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/,
        p_version          => p_version /*PK*/ /*UK*/,
        p_orden            => p_orden /*UK*/,
        p_activo           => p_activo,
        p_tipo_dato        => p_tipo_dato,
        p_formato          => p_formato,
        p_longitud_maxima  => p_longitud_maxima,
        p_obligatorio      => p_obligatorio,
        p_valor_defecto    => p_valor_defecto,
        p_etiqueta         => p_etiqueta,
        p_detalle          => p_detalle,
        p_valores_posibles => p_valores_posibles,
        p_encriptado       => p_encriptado );
    ELSE
      create_row (
        p_id_operacion     => p_id_operacion /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/,
        p_version          => p_version /*PK*/ /*UK*/,
        p_orden            => p_orden /*UK*/,
        p_activo           => p_activo,
        p_tipo_dato        => p_tipo_dato,
        p_formato          => p_formato,
        p_longitud_maxima  => p_longitud_maxima,
        p_obligatorio      => p_obligatorio,
        p_valor_defecto    => p_valor_defecto,
        p_etiqueta         => p_etiqueta,
        p_detalle          => p_detalle,
        p_valores_posibles => p_valores_posibles,
        p_encriptado       => p_encriptado );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_operacion => p_row.ID_OPERACION,
      p_nombre       => p_row.NOMBRE,
      p_version      => p_row.VERSION
    )
    THEN
      RETURN update_row (
        p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/,
        p_version          => p_row.VERSION /*PK*/ /*UK*/,
        p_orden            => p_row.ORDEN /*UK*/,
        p_activo           => p_row.ACTIVO,
        p_tipo_dato        => p_row.TIPO_DATO,
        p_formato          => p_row.FORMATO,
        p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
        p_obligatorio      => p_row.OBLIGATORIO,
        p_valor_defecto    => p_row.VALOR_DEFECTO,
        p_etiqueta         => p_row.ETIQUETA,
        p_detalle          => p_row.DETALLE,
        p_valores_posibles => p_row.VALORES_POSIBLES,
        p_encriptado       => p_row.ENCRIPTADO );
    ELSE
      RETURN create_row (
        p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/,
        p_version          => p_row.VERSION /*PK*/ /*UK*/,
        p_orden            => p_row.ORDEN /*UK*/,
        p_activo           => p_row.ACTIVO,
        p_tipo_dato        => p_row.TIPO_DATO,
        p_formato          => p_row.FORMATO,
        p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
        p_obligatorio      => p_row.OBLIGATORIO,
        p_valor_defecto    => p_row.VALOR_DEFECTO,
        p_etiqueta         => p_row.ETIQUETA,
        p_detalle          => p_row.DETALLE,
        p_valores_posibles => p_row.VALORES_POSIBLES,
        p_encriptado       => p_row.ENCRIPTADO );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_operacion => p_row.ID_OPERACION,
      p_nombre       => p_row.NOMBRE,
      p_version      => p_row.VERSION
    )
    THEN
      update_row (
        p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/,
        p_version          => p_row.VERSION /*PK*/ /*UK*/,
        p_orden            => p_row.ORDEN /*UK*/,
        p_activo           => p_row.ACTIVO,
        p_tipo_dato        => p_row.TIPO_DATO,
        p_formato          => p_row.FORMATO,
        p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
        p_obligatorio      => p_row.OBLIGATORIO,
        p_valor_defecto    => p_row.VALOR_DEFECTO,
        p_etiqueta         => p_row.ETIQUETA,
        p_detalle          => p_row.DETALLE,
        p_valores_posibles => p_row.VALORES_POSIBLES,
        p_encriptado       => p_row.ENCRIPTADO );
    ELSE
      create_row (
        p_id_operacion     => p_row.ID_OPERACION /*PK*/ /*UK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/,
        p_version          => p_row.VERSION /*PK*/ /*UK*/,
        p_orden            => p_row.ORDEN /*UK*/,
        p_activo           => p_row.ACTIVO,
        p_tipo_dato        => p_row.TIPO_DATO,
        p_formato          => p_row.FORMATO,
        p_longitud_maxima  => p_row.LONGITUD_MAXIMA,
        p_obligatorio      => p_row.OBLIGATORIO,
        p_valor_defecto    => p_row.VALOR_DEFECTO,
        p_etiqueta         => p_row.ETIQUETA,
        p_detalle          => p_row.DETALLE,
        p_valores_posibles => p_row.VALORES_POSIBLES,
        p_encriptado       => p_row.ENCRIPTADO );
    END IF;
  END create_or_update_row;

  FUNCTION get_orden (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ORDEN%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).ORDEN;
  END get_orden;

  FUNCTION get_activo (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).ACTIVO;
  END get_activo;

  FUNCTION get_tipo_dato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).TIPO_DATO;
  END get_tipo_dato;

  FUNCTION get_formato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FORMATO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).FORMATO;
  END get_formato;

  FUNCTION get_longitud_maxima (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).LONGITUD_MAXIMA;
  END get_longitud_maxima;

  FUNCTION get_obligatorio (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).OBLIGATORIO;
  END get_obligatorio;

  FUNCTION get_valor_defecto (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).VALOR_DEFECTO;
  END get_valor_defecto;

  FUNCTION get_etiqueta (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ETIQUETA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).ETIQUETA;
  END get_etiqueta;

  FUNCTION get_detalle (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.DETALLE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).DETALLE;
  END get_detalle;

  FUNCTION get_valores_posibles (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).VALORES_POSIBLES;
  END get_valores_posibles;

  FUNCTION get_encriptado (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).ENCRIPTADO;
  END get_encriptado;

  FUNCTION get_usuario_insercion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_operacion => p_id_operacion,
      p_nombre       => p_nombre,
      p_version      => p_version ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_orden (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_orden        IN T_OPERACION_PARAMETROS.ORDEN%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ORDEN                = p_orden /*UK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_orden;

  PROCEDURE set_activo (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_activo       IN T_OPERACION_PARAMETROS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_activo;

  PROCEDURE set_tipo_dato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_tipo_dato    IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      TIPO_DATO            = p_tipo_dato,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_tipo_dato;

  PROCEDURE set_formato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_formato      IN T_OPERACION_PARAMETROS.FORMATO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      FORMATO              = p_formato,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_formato;

  PROCEDURE set_longitud_maxima (
    p_id_operacion    IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre          IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version         IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_longitud_maxima IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      LONGITUD_MAXIMA      = p_longitud_maxima,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_longitud_maxima;

  PROCEDURE set_obligatorio (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_obligatorio  IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      OBLIGATORIO          = p_obligatorio,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_obligatorio;

  PROCEDURE set_valor_defecto (
    p_id_operacion  IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre        IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version       IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_valor_defecto IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      VALOR_DEFECTO        = p_valor_defecto,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_valor_defecto;

  PROCEDURE set_etiqueta (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_etiqueta     IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ETIQUETA             = p_etiqueta,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_etiqueta;

  PROCEDURE set_detalle (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_detalle      IN T_OPERACION_PARAMETROS.DETALLE%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      DETALLE              = p_detalle,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_detalle;

  PROCEDURE set_valores_posibles (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      VALORES_POSIBLES     = p_valores_posibles,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_valores_posibles;

  PROCEDURE set_encriptado (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_encriptado   IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_OPERACION_PARAMETROS
    SET
      ENCRIPTADO           = p_encriptado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_OPERACION = p_id_operacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_encriptado;

END T_OPERACION_PARAMETROS_API;
/

