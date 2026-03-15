CREATE OR REPLACE PACKAGE BODY T_SIGNIFICADOS_API IS
  /*
  This is the API for the table T_SIGNIFICADOS.
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
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_SIGNIFICADOS
      WHERE
        DOMINIO = p_dominio
        AND CODIGO = p_codigo;
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
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_dominio => p_dominio,
          p_codigo  => p_codigo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE                 /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE                  /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE            DEFAULT NULL,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE             DEFAULT NULL,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE           DEFAULT NULL )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
    v_return T_SIGNIFICADOS%ROWTYPE; 
  BEGIN
    INSERT INTO T_SIGNIFICADOS (
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_dominio,
      p_codigo,
      p_significado,
      p_referencia,
      p_activo,
      p_referencia_2,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE                 /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE                  /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE            DEFAULT NULL,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE             DEFAULT NULL,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE           DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_SIGNIFICADOS (
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_dominio,
      p_codigo,
      p_significado,
      p_referencia,
      p_activo,
      p_referencia_2,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_dominio      => p_row.DOMINIO /*PK*/,
      p_codigo       => p_row.CODIGO /*PK*/,
      p_significado  => p_row.SIGNIFICADO,
      p_referencia   => p_row.REFERENCIA,
      p_activo       => p_row.ACTIVO,
      p_referencia_2 => p_row.REFERENCIA_2 );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_dominio      => p_row.DOMINIO /*PK*/,
      p_codigo       => p_row.CODIGO /*PK*/,
      p_significado  => p_row.SIGNIFICADO,
      p_referencia   => p_row.REFERENCIA,
      p_activo       => p_row.ACTIVO,
      p_referencia_2 => p_row.REFERENCIA_2 );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_SIGNIFICADOS (
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).DOMINIO,
      p_rows_tab(i).CODIGO,
      p_rows_tab(i).SIGNIFICADO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).REFERENCIA_2,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
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
    INSERT INTO T_SIGNIFICADOS (
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).DOMINIO,
      p_rows_tab(i).CODIGO,
      p_rows_tab(i).SIGNIFICADO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).REFERENCIA_2,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
    v_row T_SIGNIFICADOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_SIGNIFICADOS
      WHERE
        DOMINIO = p_dominio
        AND CODIGO = p_codigo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_dominio              IN            T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo               IN            T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado             OUT NOCOPY T_SIGNIFICADOS.SIGNIFICADO%TYPE,
    p_referencia              OUT NOCOPY T_SIGNIFICADOS.REFERENCIA%TYPE,
    p_activo                  OUT NOCOPY T_SIGNIFICADOS.ACTIVO%TYPE,
    p_referencia_2            OUT NOCOPY T_SIGNIFICADOS.REFERENCIA_2%TYPE,
    p_usuario_insercion       OUT NOCOPY T_SIGNIFICADOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_SIGNIFICADOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_SIGNIFICADOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_SIGNIFICADOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_SIGNIFICADOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo );
    p_significado          := v_row.SIGNIFICADO; 
    p_referencia           := v_row.REFERENCIA; 
    p_activo               := v_row.ACTIVO; 
    p_referencia_2         := v_row.REFERENCIA_2; 
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
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
    v_return T_SIGNIFICADOS%ROWTYPE; 
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      SIGNIFICADO          = p_significado,
      REFERENCIA           = p_referencia,
      ACTIVO               = p_activo,
      REFERENCIA_2         = p_referencia_2,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo
    RETURN 
      DOMINIO /*PK*/,
      CODIGO /*PK*/,
      SIGNIFICADO,
      REFERENCIA,
      ACTIVO,
      REFERENCIA_2,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE )
  IS
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      SIGNIFICADO          = p_significado,
      REFERENCIA           = p_referencia,
      ACTIVO               = p_activo,
      REFERENCIA_2         = p_referencia_2,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_dominio      => p_row.DOMINIO /*PK*/,
      p_codigo       => p_row.CODIGO /*PK*/,
      p_significado  => p_row.SIGNIFICADO,
      p_referencia   => p_row.REFERENCIA,
      p_activo       => p_row.ACTIVO,
      p_referencia_2 => p_row.REFERENCIA_2 );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_dominio      => p_row.DOMINIO /*PK*/,
      p_codigo       => p_row.CODIGO /*PK*/,
      p_significado  => p_row.SIGNIFICADO,
      p_referencia   => p_row.REFERENCIA,
      p_activo       => p_row.ACTIVO,
      p_referencia_2 => p_row.REFERENCIA_2 );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_SIGNIFICADOS
      SET
        SIGNIFICADO          = p_rows_tab(i).SIGNIFICADO,
        REFERENCIA           = p_rows_tab(i).REFERENCIA,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        REFERENCIA_2         = p_rows_tab(i).REFERENCIA_2,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        DOMINIO = p_rows_tab(i).DOMINIO
        AND CODIGO = p_rows_tab(i).CODIGO;
  END update_rows;

  PROCEDURE delete_row (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_SIGNIFICADOS
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_SIGNIFICADOS
       WHERE DOMINIO = p_rows_tab(i).DOMINIO
        AND CODIGO = p_rows_tab(i).CODIGO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_dominio => p_dominio,
      p_codigo  => p_codigo
    )
    THEN
      RETURN update_row (
        p_dominio      => p_dominio /*PK*/,
        p_codigo       => p_codigo /*PK*/,
        p_significado  => p_significado,
        p_referencia   => p_referencia,
        p_activo       => p_activo,
        p_referencia_2 => p_referencia_2 );
    ELSE
      RETURN create_row (
        p_dominio      => p_dominio /*PK*/,
        p_codigo       => p_codigo /*PK*/,
        p_significado  => p_significado,
        p_referencia   => p_referencia,
        p_activo       => p_activo,
        p_referencia_2 => p_referencia_2 );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado  IN T_SIGNIFICADOS.SIGNIFICADO%TYPE,
    p_referencia   IN T_SIGNIFICADOS.REFERENCIA%TYPE,
    p_activo       IN T_SIGNIFICADOS.ACTIVO%TYPE,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_dominio => p_dominio,
      p_codigo  => p_codigo
    )
    THEN
      update_row (
        p_dominio      => p_dominio /*PK*/,
        p_codigo       => p_codigo /*PK*/,
        p_significado  => p_significado,
        p_referencia   => p_referencia,
        p_activo       => p_activo,
        p_referencia_2 => p_referencia_2 );
    ELSE
      create_row (
        p_dominio      => p_dominio /*PK*/,
        p_codigo       => p_codigo /*PK*/,
        p_significado  => p_significado,
        p_referencia   => p_referencia,
        p_activo       => p_activo,
        p_referencia_2 => p_referencia_2 );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_dominio => p_row.DOMINIO,
      p_codigo  => p_row.CODIGO
    )
    THEN
      RETURN update_row (
        p_dominio      => p_row.DOMINIO /*PK*/,
        p_codigo       => p_row.CODIGO /*PK*/,
        p_significado  => p_row.SIGNIFICADO,
        p_referencia   => p_row.REFERENCIA,
        p_activo       => p_row.ACTIVO,
        p_referencia_2 => p_row.REFERENCIA_2 );
    ELSE
      RETURN create_row (
        p_dominio      => p_row.DOMINIO /*PK*/,
        p_codigo       => p_row.CODIGO /*PK*/,
        p_significado  => p_row.SIGNIFICADO,
        p_referencia   => p_row.REFERENCIA,
        p_activo       => p_row.ACTIVO,
        p_referencia_2 => p_row.REFERENCIA_2 );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_SIGNIFICADOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_dominio => p_row.DOMINIO,
      p_codigo  => p_row.CODIGO
    )
    THEN
      update_row (
        p_dominio      => p_row.DOMINIO /*PK*/,
        p_codigo       => p_row.CODIGO /*PK*/,
        p_significado  => p_row.SIGNIFICADO,
        p_referencia   => p_row.REFERENCIA,
        p_activo       => p_row.ACTIVO,
        p_referencia_2 => p_row.REFERENCIA_2 );
    ELSE
      create_row (
        p_dominio      => p_row.DOMINIO /*PK*/,
        p_codigo       => p_row.CODIGO /*PK*/,
        p_significado  => p_row.SIGNIFICADO,
        p_referencia   => p_row.REFERENCIA,
        p_activo       => p_row.ACTIVO,
        p_referencia_2 => p_row.REFERENCIA_2 );
    END IF;
  END create_or_update_row;

  FUNCTION get_significado (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.SIGNIFICADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).SIGNIFICADO;
  END get_significado;

  FUNCTION get_referencia (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.REFERENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).REFERENCIA;
  END get_referencia;

  FUNCTION get_activo (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).ACTIVO;
  END get_activo;

  FUNCTION get_referencia_2 (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.REFERENCIA_2%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).REFERENCIA_2;
  END get_referencia_2;

  FUNCTION get_usuario_insercion (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/ )
  RETURN T_SIGNIFICADOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_dominio => p_dominio,
      p_codigo  => p_codigo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_significado (
    p_dominio     IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo      IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_significado IN T_SIGNIFICADOS.SIGNIFICADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      SIGNIFICADO          = p_significado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END set_significado;

  PROCEDURE set_referencia (
    p_dominio    IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo     IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_referencia IN T_SIGNIFICADOS.REFERENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      REFERENCIA           = p_referencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END set_referencia;

  PROCEDURE set_activo (
    p_dominio IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo  IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_activo  IN T_SIGNIFICADOS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END set_activo;

  PROCEDURE set_referencia_2 (
    p_dominio      IN T_SIGNIFICADOS.DOMINIO%TYPE /*PK*/,
    p_codigo       IN T_SIGNIFICADOS.CODIGO%TYPE /*PK*/,
    p_referencia_2 IN T_SIGNIFICADOS.REFERENCIA_2%TYPE )
  IS
  BEGIN
    UPDATE
      T_SIGNIFICADOS
    SET
      REFERENCIA_2         = p_referencia_2,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      DOMINIO = p_dominio
      AND CODIGO = p_codigo;
  END set_referencia_2;

  FUNCTION get_default_row
  RETURN T_SIGNIFICADOS%ROWTYPE
  IS
    v_row T_SIGNIFICADOS%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_SIGNIFICADOS_API;
/

