CREATE OR REPLACE PACKAGE BODY T_IMPORTACIONES_API IS
  /*
  This is the API for the table T_IMPORTACIONES.
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
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_IMPORTACIONES
      WHERE
        ID_IMPORTACION = p_id_importacion;
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
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_importacion => p_id_importacion )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE         DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE       DEFAULT NULL,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE      DEFAULT NULL,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE          DEFAULT NULL,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE           DEFAULT NULL,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE          DEFAULT NULL,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE         DEFAULT NULL,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE      DEFAULT NULL )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
    v_return T_IMPORTACIONES.ID_IMPORTACION%TYPE; 
  BEGIN
    INSERT INTO T_IMPORTACIONES (
      ID_IMPORTACION /*PK*/ /*FK*/,
      SEPARADOR_CAMPOS,
      DELIMITADOR_CAMPO,
      LINEA_INICIAL,
      NOMBRE_TABLA,
      TRUNCAR_TABLA,
      PROCESO_PREVIO,
      PROCESO_POSTERIOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_importacion,
      p_separador_campos,
      p_delimitador_campo,
      p_linea_inicial,
      p_nombre_tabla,
      p_truncar_tabla,
      p_proceso_previo,
      p_proceso_posterior,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_IMPORTACION
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE         DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE       DEFAULT NULL,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE      DEFAULT NULL,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE          DEFAULT NULL,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE           DEFAULT NULL,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE          DEFAULT NULL,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE         DEFAULT NULL,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE      DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_IMPORTACIONES (
      ID_IMPORTACION /*PK*/ /*FK*/,
      SEPARADOR_CAMPOS,
      DELIMITADOR_CAMPO,
      LINEA_INICIAL,
      NOMBRE_TABLA,
      TRUNCAR_TABLA,
      PROCESO_PREVIO,
      PROCESO_POSTERIOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_importacion,
      p_separador_campos,
      p_delimitador_campo,
      p_linea_inicial,
      p_nombre_tabla,
      p_truncar_tabla,
      p_proceso_previo,
      p_proceso_posterior,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_separador_campos  => p_row.SEPARADOR_CAMPOS,
      p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
      p_linea_inicial     => p_row.LINEA_INICIAL,
      p_nombre_tabla      => p_row.NOMBRE_TABLA,
      p_truncar_tabla     => p_row.TRUNCAR_TABLA,
      p_proceso_previo    => p_row.PROCESO_PREVIO,
      p_proceso_posterior => p_row.PROCESO_POSTERIOR );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_separador_campos  => p_row.SEPARADOR_CAMPOS,
      p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
      p_linea_inicial     => p_row.LINEA_INICIAL,
      p_nombre_tabla      => p_row.NOMBRE_TABLA,
      p_truncar_tabla     => p_row.TRUNCAR_TABLA,
      p_proceso_previo    => p_row.PROCESO_PREVIO,
      p_proceso_posterior => p_row.PROCESO_POSTERIOR );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_IMPORTACIONES (
      ID_IMPORTACION /*PK*/ /*FK*/,
      SEPARADOR_CAMPOS,
      DELIMITADOR_CAMPO,
      LINEA_INICIAL,
      NOMBRE_TABLA,
      TRUNCAR_TABLA,
      PROCESO_PREVIO,
      PROCESO_POSTERIOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_IMPORTACION,
      p_rows_tab(i).SEPARADOR_CAMPOS,
      p_rows_tab(i).DELIMITADOR_CAMPO,
      p_rows_tab(i).LINEA_INICIAL,
      p_rows_tab(i).NOMBRE_TABLA,
      p_rows_tab(i).TRUNCAR_TABLA,
      p_rows_tab(i).PROCESO_PREVIO,
      p_rows_tab(i).PROCESO_POSTERIOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_IMPORTACION /*PK*/ /*FK*/,
      SEPARADOR_CAMPOS,
      DELIMITADOR_CAMPO,
      LINEA_INICIAL,
      NOMBRE_TABLA,
      TRUNCAR_TABLA,
      PROCESO_PREVIO,
      PROCESO_POSTERIOR,
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
    INSERT INTO T_IMPORTACIONES (
      ID_IMPORTACION /*PK*/ /*FK*/,
      SEPARADOR_CAMPOS,
      DELIMITADOR_CAMPO,
      LINEA_INICIAL,
      NOMBRE_TABLA,
      TRUNCAR_TABLA,
      PROCESO_PREVIO,
      PROCESO_POSTERIOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_IMPORTACION,
      p_rows_tab(i).SEPARADOR_CAMPOS,
      p_rows_tab(i).DELIMITADOR_CAMPO,
      p_rows_tab(i).LINEA_INICIAL,
      p_rows_tab(i).NOMBRE_TABLA,
      p_rows_tab(i).TRUNCAR_TABLA,
      p_rows_tab(i).PROCESO_PREVIO,
      p_rows_tab(i).PROCESO_POSTERIOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES%ROWTYPE
  IS
    v_row T_IMPORTACIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_IMPORTACIONES
      WHERE
        ID_IMPORTACION = p_id_importacion;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_importacion       IN            T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_separador_campos        OUT NOCOPY T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo       OUT NOCOPY T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial           OUT NOCOPY T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla            OUT NOCOPY T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla           OUT NOCOPY T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo          OUT NOCOPY T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior       OUT NOCOPY T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE,
    p_usuario_insercion       OUT NOCOPY T_IMPORTACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_IMPORTACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_IMPORTACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_IMPORTACIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_IMPORTACIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_importacion => p_id_importacion );
    p_separador_campos     := v_row.SEPARADOR_CAMPOS; 
    p_delimitador_campo    := v_row.DELIMITADOR_CAMPO; 
    p_linea_inicial        := v_row.LINEA_INICIAL; 
    p_nombre_tabla         := v_row.NOMBRE_TABLA; 
    p_truncar_tabla        := v_row.TRUNCAR_TABLA; 
    p_proceso_previo       := v_row.PROCESO_PREVIO; 
    p_proceso_posterior    := v_row.PROCESO_POSTERIOR; 
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
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
    v_return T_IMPORTACIONES.ID_IMPORTACION%TYPE; 
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      SEPARADOR_CAMPOS     = p_separador_campos,
      DELIMITADOR_CAMPO    = p_delimitador_campo,
      LINEA_INICIAL        = p_linea_inicial,
      NOMBRE_TABLA         = p_nombre_tabla,
      TRUNCAR_TABLA        = p_truncar_tabla,
      PROCESO_PREVIO       = p_proceso_previo,
      PROCESO_POSTERIOR    = p_proceso_posterior,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion
    RETURN 
      ID_IMPORTACION
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      SEPARADOR_CAMPOS     = p_separador_campos,
      DELIMITADOR_CAMPO    = p_delimitador_campo,
      LINEA_INICIAL        = p_linea_inicial,
      NOMBRE_TABLA         = p_nombre_tabla,
      TRUNCAR_TABLA        = p_truncar_tabla,
      PROCESO_PREVIO       = p_proceso_previo,
      PROCESO_POSTERIOR    = p_proceso_posterior,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END update_row;

  FUNCTION update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_separador_campos  => p_row.SEPARADOR_CAMPOS,
      p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
      p_linea_inicial     => p_row.LINEA_INICIAL,
      p_nombre_tabla      => p_row.NOMBRE_TABLA,
      p_truncar_tabla     => p_row.TRUNCAR_TABLA,
      p_proceso_previo    => p_row.PROCESO_PREVIO,
      p_proceso_posterior => p_row.PROCESO_POSTERIOR );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
      p_separador_campos  => p_row.SEPARADOR_CAMPOS,
      p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
      p_linea_inicial     => p_row.LINEA_INICIAL,
      p_nombre_tabla      => p_row.NOMBRE_TABLA,
      p_truncar_tabla     => p_row.TRUNCAR_TABLA,
      p_proceso_previo    => p_row.PROCESO_PREVIO,
      p_proceso_posterior => p_row.PROCESO_POSTERIOR );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_IMPORTACIONES
      SET
        SEPARADOR_CAMPOS     = p_rows_tab(i).SEPARADOR_CAMPOS,
        DELIMITADOR_CAMPO    = p_rows_tab(i).DELIMITADOR_CAMPO,
        LINEA_INICIAL        = p_rows_tab(i).LINEA_INICIAL,
        NOMBRE_TABLA         = p_rows_tab(i).NOMBRE_TABLA,
        TRUNCAR_TABLA        = p_rows_tab(i).TRUNCAR_TABLA,
        PROCESO_PREVIO       = p_rows_tab(i).PROCESO_PREVIO,
        PROCESO_POSTERIOR    = p_rows_tab(i).PROCESO_POSTERIOR,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_IMPORTACION = p_rows_tab(i).ID_IMPORTACION;
  END update_rows;

  PROCEDURE delete_row (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_IMPORTACIONES
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_IMPORTACIONES
       WHERE ID_IMPORTACION = p_rows_tab(i).ID_IMPORTACION;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_id_importacion
    )
    THEN
      RETURN update_row (
        p_id_importacion    => p_id_importacion /*PK*/ /*FK*/,
        p_separador_campos  => p_separador_campos,
        p_delimitador_campo => p_delimitador_campo,
        p_linea_inicial     => p_linea_inicial,
        p_nombre_tabla      => p_nombre_tabla,
        p_truncar_tabla     => p_truncar_tabla,
        p_proceso_previo    => p_proceso_previo,
        p_proceso_posterior => p_proceso_posterior );
    ELSE
      RETURN create_row (
        p_id_importacion    => p_id_importacion /*PK*/ /*FK*/,
        p_separador_campos  => p_separador_campos,
        p_delimitador_campo => p_delimitador_campo,
        p_linea_inicial     => p_linea_inicial,
        p_nombre_tabla      => p_nombre_tabla,
        p_truncar_tabla     => p_truncar_tabla,
        p_proceso_previo    => p_proceso_previo,
        p_proceso_posterior => p_proceso_posterior );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_id_importacion
    )
    THEN
      update_row (
        p_id_importacion    => p_id_importacion /*PK*/ /*FK*/,
        p_separador_campos  => p_separador_campos,
        p_delimitador_campo => p_delimitador_campo,
        p_linea_inicial     => p_linea_inicial,
        p_nombre_tabla      => p_nombre_tabla,
        p_truncar_tabla     => p_truncar_tabla,
        p_proceso_previo    => p_proceso_previo,
        p_proceso_posterior => p_proceso_posterior );
    ELSE
      create_row (
        p_id_importacion    => p_id_importacion /*PK*/ /*FK*/,
        p_separador_campos  => p_separador_campos,
        p_delimitador_campo => p_delimitador_campo,
        p_linea_inicial     => p_linea_inicial,
        p_nombre_tabla      => p_nombre_tabla,
        p_truncar_tabla     => p_truncar_tabla,
        p_proceso_previo    => p_proceso_previo,
        p_proceso_posterior => p_proceso_posterior );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_row.ID_IMPORTACION
    )
    THEN
      RETURN update_row (
        p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_separador_campos  => p_row.SEPARADOR_CAMPOS,
        p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
        p_linea_inicial     => p_row.LINEA_INICIAL,
        p_nombre_tabla      => p_row.NOMBRE_TABLA,
        p_truncar_tabla     => p_row.TRUNCAR_TABLA,
        p_proceso_previo    => p_row.PROCESO_PREVIO,
        p_proceso_posterior => p_row.PROCESO_POSTERIOR );
    ELSE
      RETURN create_row (
        p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_separador_campos  => p_row.SEPARADOR_CAMPOS,
        p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
        p_linea_inicial     => p_row.LINEA_INICIAL,
        p_nombre_tabla      => p_row.NOMBRE_TABLA,
        p_truncar_tabla     => p_row.TRUNCAR_TABLA,
        p_proceso_previo    => p_row.PROCESO_PREVIO,
        p_proceso_posterior => p_row.PROCESO_POSTERIOR );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_importacion => p_row.ID_IMPORTACION
    )
    THEN
      update_row (
        p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_separador_campos  => p_row.SEPARADOR_CAMPOS,
        p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
        p_linea_inicial     => p_row.LINEA_INICIAL,
        p_nombre_tabla      => p_row.NOMBRE_TABLA,
        p_truncar_tabla     => p_row.TRUNCAR_TABLA,
        p_proceso_previo    => p_row.PROCESO_PREVIO,
        p_proceso_posterior => p_row.PROCESO_POSTERIOR );
    ELSE
      create_row (
        p_id_importacion    => p_row.ID_IMPORTACION /*PK*/ /*FK*/,
        p_separador_campos  => p_row.SEPARADOR_CAMPOS,
        p_delimitador_campo => p_row.DELIMITADOR_CAMPO,
        p_linea_inicial     => p_row.LINEA_INICIAL,
        p_nombre_tabla      => p_row.NOMBRE_TABLA,
        p_truncar_tabla     => p_row.TRUNCAR_TABLA,
        p_proceso_previo    => p_row.PROCESO_PREVIO,
        p_proceso_posterior => p_row.PROCESO_POSTERIOR );
    END IF;
  END create_or_update_row;

  FUNCTION get_separador_campos (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).SEPARADOR_CAMPOS;
  END get_separador_campos;

  FUNCTION get_delimitador_campo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).DELIMITADOR_CAMPO;
  END get_delimitador_campo;

  FUNCTION get_linea_inicial (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.LINEA_INICIAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).LINEA_INICIAL;
  END get_linea_inicial;

  FUNCTION get_nombre_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.NOMBRE_TABLA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).NOMBRE_TABLA;
  END get_nombre_tabla;

  FUNCTION get_truncar_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).TRUNCAR_TABLA;
  END get_truncar_tabla;

  FUNCTION get_proceso_previo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.PROCESO_PREVIO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).PROCESO_PREVIO;
  END get_proceso_previo;

  FUNCTION get_proceso_posterior (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).PROCESO_POSTERIOR;
  END get_proceso_posterior;

  FUNCTION get_usuario_insercion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_importacion => p_id_importacion ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_separador_campos (
    p_id_importacion   IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_separador_campos IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      SEPARADOR_CAMPOS     = p_separador_campos,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_separador_campos;

  PROCEDURE set_delimitador_campo (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      DELIMITADOR_CAMPO    = p_delimitador_campo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_delimitador_campo;

  PROCEDURE set_linea_inicial (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_linea_inicial  IN T_IMPORTACIONES.LINEA_INICIAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      LINEA_INICIAL        = p_linea_inicial,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_linea_inicial;

  PROCEDURE set_nombre_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre_tabla   IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      NOMBRE_TABLA         = p_nombre_tabla,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_nombre_tabla;

  PROCEDURE set_truncar_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_truncar_tabla  IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      TRUNCAR_TABLA        = p_truncar_tabla,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_truncar_tabla;

  PROCEDURE set_proceso_previo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_proceso_previo IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      PROCESO_PREVIO       = p_proceso_previo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_proceso_previo;

  PROCEDURE set_proceso_posterior (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_IMPORTACIONES
    SET
      PROCESO_POSTERIOR    = p_proceso_posterior,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_IMPORTACION = p_id_importacion;
  END set_proceso_posterior;

  FUNCTION get_default_row
  RETURN T_IMPORTACIONES%ROWTYPE
  IS
    v_row T_IMPORTACIONES%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_IMPORTACIONES_API;
/

