CREATE OR REPLACE PACKAGE BODY T_DATOS_API IS
  /*
  This is the API for the table T_DATOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:14:01
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
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_DATOS
      WHERE
        TABLA = p_tabla
        AND CAMPO = p_campo
        AND REFERENCIA = p_referencia;
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
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_tabla      => p_tabla,
          p_campo      => p_campo,
          p_referencia => p_referencia )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_tabla      IN T_DATOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE              DEFAULT NULL )
  RETURN T_DATOS%ROWTYPE
  IS
    v_return T_DATOS%ROWTYPE; 
  BEGIN
    INSERT INTO T_DATOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_referencia,
      p_contenido,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_tabla      IN T_DATOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE              DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_DATOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_referencia,
      p_contenido,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
      p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia => p_row.REFERENCIA /*PK*/,
      p_contenido  => p_row.CONTENIDO );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_DATOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
      p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia => p_row.REFERENCIA /*PK*/,
      p_contenido  => p_row.CONTENIDO );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_DATOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).CONTENIDO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
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
    INSERT INTO T_DATOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).CONTENIDO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS%ROWTYPE
  IS
    v_row T_DATOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_DATOS
      WHERE
        TABLA = p_tabla
        AND CAMPO = p_campo
        AND REFERENCIA = p_referencia;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_tabla                IN            T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo                IN            T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia           IN            T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido               OUT NOCOPY T_DATOS.CONTENIDO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_DATOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DATOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DATOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DATOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_DATOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia );
    p_contenido            := v_row.CONTENIDO; 
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
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  RETURN T_DATOS%ROWTYPE
  IS
    v_return T_DATOS%ROWTYPE; 
  BEGIN
    UPDATE
      T_DATOS
    SET
      CONTENIDO            = p_contenido,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia
    RETURN 
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DATOS
    SET
      CONTENIDO            = p_contenido,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END update_row;

  FUNCTION update_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
      p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia => p_row.REFERENCIA /*PK*/,
      p_contenido  => p_row.CONTENIDO );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_DATOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
      p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia => p_row.REFERENCIA /*PK*/,
      p_contenido  => p_row.CONTENIDO );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_DATOS
      SET
        CONTENIDO            = p_rows_tab(i).CONTENIDO,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO
        AND REFERENCIA = p_rows_tab(i).REFERENCIA;
  END update_rows;

  PROCEDURE delete_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_DATOS
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_DATOS
       WHERE TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO
        AND REFERENCIA = p_rows_tab(i).REFERENCIA;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  RETURN T_DATOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia
    )
    THEN
      RETURN update_row (
        p_tabla      => p_tabla /*PK*/ /*FK*/,
        p_campo      => p_campo /*PK*/ /*FK*/,
        p_referencia => p_referencia /*PK*/,
        p_contenido  => p_contenido );
    ELSE
      RETURN create_row (
        p_tabla      => p_tabla /*PK*/ /*FK*/,
        p_campo      => p_campo /*PK*/ /*FK*/,
        p_referencia => p_referencia /*PK*/,
        p_contenido  => p_contenido );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia
    )
    THEN
      update_row (
        p_tabla      => p_tabla /*PK*/ /*FK*/,
        p_campo      => p_campo /*PK*/ /*FK*/,
        p_referencia => p_referencia /*PK*/,
        p_contenido  => p_contenido );
    ELSE
      create_row (
        p_tabla      => p_tabla /*PK*/ /*FK*/,
        p_campo      => p_campo /*PK*/ /*FK*/,
        p_referencia => p_referencia /*PK*/,
        p_contenido  => p_contenido );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_row.TABLA,
      p_campo      => p_row.CAMPO,
      p_referencia => p_row.REFERENCIA
    )
    THEN
      RETURN update_row (
        p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
        p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia => p_row.REFERENCIA /*PK*/,
        p_contenido  => p_row.CONTENIDO );
    ELSE
      RETURN create_row (
        p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
        p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia => p_row.REFERENCIA /*PK*/,
        p_contenido  => p_row.CONTENIDO );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_DATOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_row.TABLA,
      p_campo      => p_row.CAMPO,
      p_referencia => p_row.REFERENCIA
    )
    THEN
      update_row (
        p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
        p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia => p_row.REFERENCIA /*PK*/,
        p_contenido  => p_row.CONTENIDO );
    ELSE
      create_row (
        p_tabla      => p_row.TABLA /*PK*/ /*FK*/,
        p_campo      => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia => p_row.REFERENCIA /*PK*/,
        p_contenido  => p_row.CONTENIDO );
    END IF;
  END create_or_update_row;

  FUNCTION get_contenido (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.CONTENIDO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).CONTENIDO;
  END get_contenido;

  FUNCTION get_usuario_insercion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_contenido (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  IS
  BEGIN
    UPDATE
      T_DATOS
    SET
      CONTENIDO            = p_contenido,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_contenido;

  FUNCTION get_default_row
  RETURN T_DATOS%ROWTYPE
  IS
    v_row T_DATOS%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_DATOS_API;
/

