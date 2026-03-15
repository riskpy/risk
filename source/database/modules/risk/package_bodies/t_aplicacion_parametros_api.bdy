CREATE OR REPLACE PACKAGE BODY T_APLICACION_PARAMETROS_API IS
  /*
  This is the API for the table T_APLICACION_PARAMETROS.
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
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_APLICACION_PARAMETROS
      WHERE
        ID_APLICACION = p_id_aplicacion
        AND ID_PARAMETRO = p_id_parametro;
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
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_aplicacion => p_id_aplicacion,
          p_id_parametro  => p_id_parametro )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE           /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE            /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE                  DEFAULT NULL )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
    v_return T_APLICACION_PARAMETROS%ROWTYPE; 
  BEGIN
    INSERT INTO T_APLICACION_PARAMETROS (
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_id_parametro,
      p_valor,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE           /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE            /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE                  DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_APLICACION_PARAMETROS (
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_aplicacion,
      p_id_parametro,
      p_valor,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
      p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
      p_valor         => p_row.VALOR );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
      p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
      p_valor         => p_row.VALOR );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_APLICACION_PARAMETROS (
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).ID_PARAMETRO,
      p_rows_tab(i).VALOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
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
    INSERT INTO T_APLICACION_PARAMETROS (
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_APLICACION,
      p_rows_tab(i).ID_PARAMETRO,
      p_rows_tab(i).VALOR,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
    v_row T_APLICACION_PARAMETROS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_APLICACION_PARAMETROS
      WHERE
        ID_APLICACION = p_id_aplicacion
        AND ID_PARAMETRO = p_id_parametro;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_aplicacion        IN            T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/ /*FK*/,
    p_id_parametro         IN            T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor                   OUT NOCOPY T_APLICACION_PARAMETROS.VALOR%TYPE,
    p_usuario_insercion       OUT NOCOPY T_APLICACION_PARAMETROS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_APLICACION_PARAMETROS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_APLICACION_PARAMETROS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_APLICACION_PARAMETROS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_APLICACION_PARAMETROS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro );
    p_valor                := v_row.VALOR; 
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
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
    v_return T_APLICACION_PARAMETROS%ROWTYPE; 
  BEGIN
    UPDATE
      T_APLICACION_PARAMETROS
    SET
      VALOR                = p_valor,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PARAMETRO = p_id_parametro
    RETURN 
      ID_APLICACION /*PK*/ /*FK*/,
      ID_PARAMETRO /*PK*/,
      VALOR,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACION_PARAMETROS
    SET
      VALOR                = p_valor,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PARAMETRO = p_id_parametro;
  END update_row;

  FUNCTION update_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
      p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
      p_valor         => p_row.VALOR );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
      p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
      p_valor         => p_row.VALOR );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_APLICACION_PARAMETROS
      SET
        VALOR                = p_rows_tab(i).VALOR,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        ID_APLICACION = p_rows_tab(i).ID_APLICACION
        AND ID_PARAMETRO = p_rows_tab(i).ID_PARAMETRO;
  END update_rows;

  PROCEDURE delete_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_APLICACION_PARAMETROS
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PARAMETRO = p_id_parametro;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_APLICACION_PARAMETROS
       WHERE ID_APLICACION = p_rows_tab(i).ID_APLICACION
        AND ID_PARAMETRO = p_rows_tab(i).ID_PARAMETRO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro
    )
    THEN
      RETURN update_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/ /*FK*/,
        p_id_parametro  => p_id_parametro /*PK*/,
        p_valor         => p_valor );
    ELSE
      RETURN create_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/ /*FK*/,
        p_id_parametro  => p_id_parametro /*PK*/,
        p_valor         => p_valor );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/ /*FK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro
    )
    THEN
      update_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/ /*FK*/,
        p_id_parametro  => p_id_parametro /*PK*/,
        p_valor         => p_valor );
    ELSE
      create_row (
        p_id_aplicacion => p_id_aplicacion /*PK*/ /*FK*/,
        p_id_parametro  => p_id_parametro /*PK*/,
        p_valor         => p_valor );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION,
      p_id_parametro  => p_row.ID_PARAMETRO
    )
    THEN
      RETURN update_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
        p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
        p_valor         => p_row.VALOR );
    ELSE
      RETURN create_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
        p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
        p_valor         => p_row.VALOR );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_APLICACION_PARAMETROS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_aplicacion => p_row.ID_APLICACION,
      p_id_parametro  => p_row.ID_PARAMETRO
    )
    THEN
      update_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
        p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
        p_valor         => p_row.VALOR );
    ELSE
      create_row (
        p_id_aplicacion => p_row.ID_APLICACION /*PK*/ /*FK*/,
        p_id_parametro  => p_row.ID_PARAMETRO /*PK*/,
        p_valor         => p_row.VALOR );
    END IF;
  END create_or_update_row;

  FUNCTION get_valor (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS.VALOR%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro ).VALOR;
  END get_valor;

  FUNCTION get_usuario_insercion (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/ )
  RETURN T_APLICACION_PARAMETROS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_aplicacion => p_id_aplicacion,
      p_id_parametro  => p_id_parametro ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_valor (
    p_id_aplicacion IN T_APLICACION_PARAMETROS.ID_APLICACION%TYPE /*PK*/,
    p_id_parametro  IN T_APLICACION_PARAMETROS.ID_PARAMETRO%TYPE /*PK*/,
    p_valor         IN T_APLICACION_PARAMETROS.VALOR%TYPE )
  IS
  BEGIN
    UPDATE
      T_APLICACION_PARAMETROS
    SET
      VALOR                = p_valor,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_APLICACION = p_id_aplicacion
      AND ID_PARAMETRO = p_id_parametro;
  END set_valor;

  FUNCTION get_default_row
  RETURN T_APLICACION_PARAMETROS%ROWTYPE
  IS
    v_row T_APLICACION_PARAMETROS%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_APLICACION_PARAMETROS_API;
/

