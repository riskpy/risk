CREATE OR REPLACE PACKAGE BODY T_IMPORTACION_PARAMETROS_API IS
  /*
  This is the API for the table T_IMPORTACION_PARAMETROS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:57
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
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_IMPORTACION_PARAMETROS
      WHERE
        ID_IMPORTACION = p_id_importacion
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
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_importacion => p_id_importacion,
          p_nombre         => p_nombre,
          p_version        => p_version )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE          /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE                  /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE                 /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE       DEFAULT NULL,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE               DEFAULT NULL,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE       DEFAULT NULL,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE               DEFAULT 'trim(:variable)' )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
    v_return T_IMPORTACION_PARAMETROS%ROWTYPE; 
  BEGIN
    INSERT INTO T_IMPORTACION_PARAMETROS (
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_importacion,
      p_nombre,
      p_version,
      p_posicion_inicial,
      p_longitud,
      p_posicion_decimal,
      p_mapeador,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE          /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE                  /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE                 /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE       DEFAULT NULL,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE               DEFAULT NULL,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE       DEFAULT NULL,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE               DEFAULT 'trim(:variable)' )
  IS
  BEGIN
    INSERT INTO T_IMPORTACION_PARAMETROS (
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_importacion,
      p_nombre,
      p_version,
      p_posicion_inicial,
      p_longitud,
      p_posicion_decimal,
      p_mapeador,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
      p_version          => p_row.VERSION /*PK*/ /*FK*/,
      p_posicion_inicial => p_row.POSICION_INICIAL,
      p_longitud         => p_row.LONGITUD,
      p_posicion_decimal => p_row.POSICION_DECIMAL,
      p_mapeador         => p_row.MAPEADOR );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
      p_version          => p_row.VERSION /*PK*/ /*FK*/,
      p_posicion_inicial => p_row.POSICION_INICIAL,
      p_longitud         => p_row.LONGITUD,
      p_posicion_decimal => p_row.POSICION_DECIMAL,
      p_mapeador         => p_row.MAPEADOR );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_IMPORTACION_PARAMETROS (
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_IMPORTACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).VERSION,
      p_rows_tab(i).POSICION_INICIAL,
      p_rows_tab(i).LONGITUD,
      p_rows_tab(i).POSICION_DECIMAL,
      p_rows_tab(i).MAPEADOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
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
    INSERT INTO T_IMPORTACION_PARAMETROS (
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_IMPORTACION,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).VERSION,
      p_rows_tab(i).POSICION_INICIAL,
      p_rows_tab(i).LONGITUD,
      p_rows_tab(i).POSICION_DECIMAL,
      p_rows_tab(i).MAPEADOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
    v_row T_IMPORTACION_PARAMETROS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_IMPORTACION_PARAMETROS
      WHERE
        ID_IMPORTACION = p_id_importacion
        AND NOMBRE = p_nombre
        AND VERSION = p_version;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_importacion       IN            T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_nombre               IN            T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/ /*FK*/,
    p_version              IN            T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ /*FK*/,
    p_posicion_inicial        OUT NOCOPY T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE,
    p_longitud                OUT NOCOPY T_IMPORTACION_PARAMETROS.LONGITUD%TYPE,
    p_posicion_decimal        OUT NOCOPY T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE,
    p_mapeador                OUT NOCOPY T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE,
    p_usuario_insercion       OUT NOCOPY T_IMPORTACION_PARAMETROS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_IMPORTACION_PARAMETROS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_IMPORTACION_PARAMETROS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_IMPORTACION_PARAMETROS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_IMPORTACION_PARAMETROS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version );
    p_posicion_inicial     := v_row.POSICION_INICIAL; 
    p_longitud             := v_row.LONGITUD; 
    p_posicion_decimal     := v_row.POSICION_DECIMAL; 
    p_mapeador             := v_row.MAPEADOR; 
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
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
    v_return T_IMPORTACION_PARAMETROS%ROWTYPE; 
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      POSICION_INICIAL     = p_posicion_inicial,
      LONGITUD             = p_longitud,
      POSICION_DECIMAL     = p_posicion_decimal,
      MAPEADOR             = p_mapeador,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version
    RETURN 
      ID_IMPORTACION /*PK*/ /*FK*/,
      NOMBRE /*PK*/ /*FK*/,
      VERSION /*PK*/ /*FK*/,
      POSICION_INICIAL,
      LONGITUD,
      POSICION_DECIMAL,
      MAPEADOR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      POSICION_INICIAL     = p_posicion_inicial,
      LONGITUD             = p_longitud,
      POSICION_DECIMAL     = p_posicion_decimal,
      MAPEADOR             = p_mapeador,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END update_row;

  FUNCTION update_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
      p_version          => p_row.VERSION /*PK*/ /*FK*/,
      p_posicion_inicial => p_row.POSICION_INICIAL,
      p_longitud         => p_row.LONGITUD,
      p_posicion_decimal => p_row.POSICION_DECIMAL,
      p_mapeador         => p_row.MAPEADOR );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
      p_version          => p_row.VERSION /*PK*/ /*FK*/,
      p_posicion_inicial => p_row.POSICION_INICIAL,
      p_longitud         => p_row.LONGITUD,
      p_posicion_decimal => p_row.POSICION_DECIMAL,
      p_mapeador         => p_row.MAPEADOR );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_IMPORTACION_PARAMETROS
      SET
        POSICION_INICIAL     = p_rows_tab(i).POSICION_INICIAL,
        LONGITUD             = p_rows_tab(i).LONGITUD,
        POSICION_DECIMAL     = p_rows_tab(i).POSICION_DECIMAL,
        MAPEADOR             = p_rows_tab(i).MAPEADOR,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_IMPORTACION = p_rows_tab(i).ID_IMPORTACION
        AND NOMBRE = p_rows_tab(i).NOMBRE
        AND VERSION = p_rows_tab(i).VERSION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_IMPORTACION_PARAMETROS
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_IMPORTACION_PARAMETROS
       WHERE ID_IMPORTACION = p_rows_tab(i).ID_IMPORTACION
        AND NOMBRE = p_rows_tab(i).NOMBRE
        AND VERSION = p_rows_tab(i).VERSION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version
    )
    THEN
      RETURN update_row (
        p_id_importacion   => p_id_importacion /*PK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/ /*FK*/,
        p_version          => p_version /*PK*/ /*FK*/,
        p_posicion_inicial => p_posicion_inicial,
        p_longitud         => p_longitud,
        p_posicion_decimal => p_posicion_decimal,
        p_mapeador         => p_mapeador );
    ELSE
      RETURN create_row (
        p_id_importacion   => p_id_importacion /*PK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/ /*FK*/,
        p_version          => p_version /*PK*/ /*FK*/,
        p_posicion_inicial => p_posicion_inicial,
        p_longitud         => p_longitud,
        p_posicion_decimal => p_posicion_decimal,
        p_mapeador         => p_mapeador );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/ /*FK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ /*FK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE,
    p_longitud         IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE,
    p_mapeador         IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version
    )
    THEN
      update_row (
        p_id_importacion   => p_id_importacion /*PK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/ /*FK*/,
        p_version          => p_version /*PK*/ /*FK*/,
        p_posicion_inicial => p_posicion_inicial,
        p_longitud         => p_longitud,
        p_posicion_decimal => p_posicion_decimal,
        p_mapeador         => p_mapeador );
    ELSE
      create_row (
        p_id_importacion   => p_id_importacion /*PK*/ /*FK*/,
        p_nombre           => p_nombre /*PK*/ /*FK*/,
        p_version          => p_version /*PK*/ /*FK*/,
        p_posicion_inicial => p_posicion_inicial,
        p_longitud         => p_longitud,
        p_posicion_decimal => p_posicion_decimal,
        p_mapeador         => p_mapeador );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_row.ID_IMPORTACION,
      p_nombre         => p_row.NOMBRE,
      p_version        => p_row.VERSION
    )
    THEN
      RETURN update_row (
        p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
        p_version          => p_row.VERSION /*PK*/ /*FK*/,
        p_posicion_inicial => p_row.POSICION_INICIAL,
        p_longitud         => p_row.LONGITUD,
        p_posicion_decimal => p_row.POSICION_DECIMAL,
        p_mapeador         => p_row.MAPEADOR );
    ELSE
      RETURN create_row (
        p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
        p_version          => p_row.VERSION /*PK*/ /*FK*/,
        p_posicion_inicial => p_row.POSICION_INICIAL,
        p_longitud         => p_row.LONGITUD,
        p_posicion_decimal => p_row.POSICION_DECIMAL,
        p_mapeador         => p_row.MAPEADOR );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_IMPORTACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_row.ID_IMPORTACION,
      p_nombre         => p_row.NOMBRE,
      p_version        => p_row.VERSION
    )
    THEN
      update_row (
        p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
        p_version          => p_row.VERSION /*PK*/ /*FK*/,
        p_posicion_inicial => p_row.POSICION_INICIAL,
        p_longitud         => p_row.LONGITUD,
        p_posicion_decimal => p_row.POSICION_DECIMAL,
        p_mapeador         => p_row.MAPEADOR );
    ELSE
      create_row (
        p_id_importacion   => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_nombre           => p_row.NOMBRE /*PK*/ /*FK*/,
        p_version          => p_row.VERSION /*PK*/ /*FK*/,
        p_posicion_inicial => p_row.POSICION_INICIAL,
        p_longitud         => p_row.LONGITUD,
        p_posicion_decimal => p_row.POSICION_DECIMAL,
        p_mapeador         => p_row.MAPEADOR );
    END IF;
  END create_or_update_row;

  FUNCTION get_posicion_inicial (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).POSICION_INICIAL;
  END get_posicion_inicial;

  FUNCTION get_longitud (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).LONGITUD;
  END get_longitud;

  FUNCTION get_posicion_decimal (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).POSICION_DECIMAL;
  END get_posicion_decimal;

  FUNCTION get_mapeador (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).MAPEADOR;
  END get_mapeador;

  FUNCTION get_usuario_insercion (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_IMPORTACION_PARAMETROS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion,
      p_nombre         => p_nombre,
      p_version        => p_version ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_posicion_inicial (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_posicion_inicial IN T_IMPORTACION_PARAMETROS.POSICION_INICIAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      POSICION_INICIAL     = p_posicion_inicial,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_posicion_inicial;

  PROCEDURE set_longitud (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_longitud       IN T_IMPORTACION_PARAMETROS.LONGITUD%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      LONGITUD             = p_longitud,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_longitud;

  PROCEDURE set_posicion_decimal (
    p_id_importacion   IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre           IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_posicion_decimal IN T_IMPORTACION_PARAMETROS.POSICION_DECIMAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      POSICION_DECIMAL     = p_posicion_decimal,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_posicion_decimal;

  PROCEDURE set_mapeador (
    p_id_importacion IN T_IMPORTACION_PARAMETROS.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre         IN T_IMPORTACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version        IN T_IMPORTACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_mapeador       IN T_IMPORTACION_PARAMETROS.MAPEADOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACION_PARAMETROS
    SET
      MAPEADOR             = p_mapeador,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
      AND NOMBRE = p_nombre
      AND VERSION = p_version;
  END set_mapeador;

  FUNCTION get_default_row
  RETURN T_IMPORTACION_PARAMETROS%ROWTYPE
  IS
    v_row T_IMPORTACION_PARAMETROS%ROWTYPE;
  BEGIN
    v_row.MAPEADOR          := 'trim(:variable)';
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_IMPORTACION_PARAMETROS_API;
/

