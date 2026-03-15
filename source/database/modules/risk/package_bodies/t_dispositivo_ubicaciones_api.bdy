CREATE OR REPLACE PACKAGE BODY T_DISPOSITIVO_UBICACIONES_API IS
  /*
  This is the API for the table T_DISPOSITIVO_UBICACIONES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:14:03
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
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_DISPOSITIVO_UBICACIONES
      WHERE
        ID_DISPOSITIVO = p_id_dispositivo
        AND ORDEN = p_orden;
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
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_dispositivo => p_id_dispositivo,
          p_orden          => p_orden )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE          /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE                   /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE                  ,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE                ,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE                )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
    v_return T_DISPOSITIVO_UBICACIONES%ROWTYPE; 
  BEGIN
    INSERT INTO T_DISPOSITIVO_UBICACIONES (
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_dispositivo,
      p_orden,
      p_fecha,
      p_latitud,
      p_longitud,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE          /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE                   /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE                  ,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE                ,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE                )
  IS
  BEGIN
    INSERT INTO T_DISPOSITIVO_UBICACIONES (
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_dispositivo,
      p_orden,
      p_fecha,
      p_latitud,
      p_longitud,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
      p_orden          => p_row.ORDEN /*PK*/,
      p_fecha          => p_row.FECHA,
      p_latitud        => p_row.LATITUD,
      p_longitud       => p_row.LONGITUD );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
      p_orden          => p_row.ORDEN /*PK*/,
      p_fecha          => p_row.FECHA,
      p_latitud        => p_row.LATITUD,
      p_longitud       => p_row.LONGITUD );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_DISPOSITIVO_UBICACIONES (
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DISPOSITIVO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).FECHA,
      p_rows_tab(i).LATITUD,
      p_rows_tab(i).LONGITUD,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
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
    INSERT INTO T_DISPOSITIVO_UBICACIONES (
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_DISPOSITIVO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).FECHA,
      p_rows_tab(i).LATITUD,
      p_rows_tab(i).LONGITUD,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
    v_row T_DISPOSITIVO_UBICACIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_DISPOSITIVO_UBICACIONES
      WHERE
        ID_DISPOSITIVO = p_id_dispositivo
        AND ORDEN = p_orden;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_dispositivo       IN            T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden                IN            T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha                   OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud                 OUT NOCOPY T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud                OUT NOCOPY T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE,
    p_usuario_insercion       OUT NOCOPY T_DISPOSITIVO_UBICACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DISPOSITIVO_UBICACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_DISPOSITIVO_UBICACIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden );
    p_fecha                := v_row.FECHA; 
    p_latitud              := v_row.LATITUD; 
    p_longitud             := v_row.LONGITUD; 
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
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
    v_return T_DISPOSITIVO_UBICACIONES%ROWTYPE; 
  BEGIN
    UPDATE
      T_DISPOSITIVO_UBICACIONES
    SET
      FECHA                = p_fecha,
      LATITUD              = p_latitud,
      LONGITUD             = p_longitud,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden
    RETURN 
      ID_DISPOSITIVO /*PK*/ /*FK*/,
      ORDEN /*PK*/,
      FECHA,
      LATITUD,
      LONGITUD,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  IS
  BEGIN
    UPDATE
      T_DISPOSITIVO_UBICACIONES
    SET
      FECHA                = p_fecha,
      LATITUD              = p_latitud,
      LONGITUD             = p_longitud,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden;
  END update_row;

  FUNCTION update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
      p_orden          => p_row.ORDEN /*PK*/,
      p_fecha          => p_row.FECHA,
      p_latitud        => p_row.LATITUD,
      p_longitud       => p_row.LONGITUD );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
      p_orden          => p_row.ORDEN /*PK*/,
      p_fecha          => p_row.FECHA,
      p_latitud        => p_row.LATITUD,
      p_longitud       => p_row.LONGITUD );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_DISPOSITIVO_UBICACIONES
      SET
        FECHA                = p_rows_tab(i).FECHA,
        LATITUD              = p_rows_tab(i).LATITUD,
        LONGITUD             = p_rows_tab(i).LONGITUD,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_DISPOSITIVO = p_rows_tab(i).ID_DISPOSITIVO
        AND ORDEN = p_rows_tab(i).ORDEN;
  END update_rows;

  PROCEDURE delete_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_DISPOSITIVO_UBICACIONES
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_DISPOSITIVO_UBICACIONES
       WHERE ID_DISPOSITIVO = p_rows_tab(i).ID_DISPOSITIVO
        AND ORDEN = p_rows_tab(i).ORDEN;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden
    )
    THEN
      RETURN update_row (
        p_id_dispositivo => p_id_dispositivo /*PK*/ /*FK*/,
        p_orden          => p_orden /*PK*/,
        p_fecha          => p_fecha,
        p_latitud        => p_latitud,
        p_longitud       => p_longitud );
    ELSE
      RETURN create_row (
        p_id_dispositivo => p_id_dispositivo /*PK*/ /*FK*/,
        p_orden          => p_orden /*PK*/,
        p_fecha          => p_fecha,
        p_latitud        => p_latitud,
        p_longitud       => p_longitud );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden
    )
    THEN
      update_row (
        p_id_dispositivo => p_id_dispositivo /*PK*/ /*FK*/,
        p_orden          => p_orden /*PK*/,
        p_fecha          => p_fecha,
        p_latitud        => p_latitud,
        p_longitud       => p_longitud );
    ELSE
      create_row (
        p_id_dispositivo => p_id_dispositivo /*PK*/ /*FK*/,
        p_orden          => p_orden /*PK*/,
        p_fecha          => p_fecha,
        p_latitud        => p_latitud,
        p_longitud       => p_longitud );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_dispositivo => p_row.ID_DISPOSITIVO,
      p_orden          => p_row.ORDEN
    )
    THEN
      RETURN update_row (
        p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
        p_orden          => p_row.ORDEN /*PK*/,
        p_fecha          => p_row.FECHA,
        p_latitud        => p_row.LATITUD,
        p_longitud       => p_row.LONGITUD );
    ELSE
      RETURN create_row (
        p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
        p_orden          => p_row.ORDEN /*PK*/,
        p_fecha          => p_row.FECHA,
        p_latitud        => p_row.LATITUD,
        p_longitud       => p_row.LONGITUD );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_dispositivo => p_row.ID_DISPOSITIVO,
      p_orden          => p_row.ORDEN
    )
    THEN
      update_row (
        p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
        p_orden          => p_row.ORDEN /*PK*/,
        p_fecha          => p_row.FECHA,
        p_latitud        => p_row.LATITUD,
        p_longitud       => p_row.LONGITUD );
    ELSE
      create_row (
        p_id_dispositivo => p_row.ID_DISPOSITIVO /*PK*/ /*FK*/,
        p_orden          => p_row.ORDEN /*PK*/,
        p_fecha          => p_row.FECHA,
        p_latitud        => p_row.LATITUD,
        p_longitud       => p_row.LONGITUD );
    END IF;
  END create_or_update_row;

  FUNCTION get_fecha (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).FECHA;
  END get_fecha;

  FUNCTION get_latitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).LATITUD;
  END get_latitud;

  FUNCTION get_longitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).LONGITUD;
  END get_longitud;

  FUNCTION get_usuario_insercion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_dispositivo => p_id_dispositivo,
      p_orden          => p_orden ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_fecha (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE )
  IS
  BEGIN
    UPDATE
      T_DISPOSITIVO_UBICACIONES
    SET
      FECHA                = p_fecha,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden;
  END set_fecha;

  PROCEDURE set_latitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE )
  IS
  BEGIN
    UPDATE
      T_DISPOSITIVO_UBICACIONES
    SET
      LATITUD              = p_latitud,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden;
  END set_latitud;

  PROCEDURE set_longitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  IS
  BEGIN
    UPDATE
      T_DISPOSITIVO_UBICACIONES
    SET
      LONGITUD             = p_longitud,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_DISPOSITIVO = p_id_dispositivo
      AND ORDEN = p_orden;
  END set_longitud;

  FUNCTION get_default_row
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE
  IS
    v_row T_DISPOSITIVO_UBICACIONES%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_DISPOSITIVO_UBICACIONES_API;
/

