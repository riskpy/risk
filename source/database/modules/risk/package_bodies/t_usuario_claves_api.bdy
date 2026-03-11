CREATE OR REPLACE PACKAGE BODY T_USUARIO_CLAVES_API IS
  /*
  This is the API for the table T_USUARIO_CLAVES.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-10 22:59:53
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
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_USUARIO_CLAVES
      WHERE
        ID_USUARIO = p_id_usuario
        AND TIPO = p_tipo
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
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_usuario => p_id_usuario,
          p_tipo       => p_tipo,
          p_orden      => p_orden )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
    v_return T_USUARIO_CLAVES%ROWTYPE; 
  BEGIN
    INSERT INTO T_USUARIO_CLAVES (
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_usuario,
      p_tipo,
      p_orden,
      p_estado,
      p_hash,
      p_salt,
      p_algoritmo,
      p_iteraciones,
      p_cantidad_intentos_fallidos,
      p_fecha_ultima_autenticacion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  IS
  BEGIN
    INSERT INTO T_USUARIO_CLAVES (
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_id_usuario,
      p_tipo,
      p_orden,
      p_estado,
      p_hash,
      p_salt,
      p_algoritmo,
      p_iteraciones,
      p_cantidad_intentos_fallidos,
      p_fecha_ultima_autenticacion,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_tipo                       => p_row.TIPO /*PK*/,
      p_orden                      => p_row.ORDEN /*PK*/,
      p_estado                     => p_row.ESTADO,
      p_hash                       => p_row.HASH,
      p_salt                       => p_row.SALT,
      p_algoritmo                  => p_row.ALGORITMO,
      p_iteraciones                => p_row.ITERACIONES,
      p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
      p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_tipo                       => p_row.TIPO /*PK*/,
      p_orden                      => p_row.ORDEN /*PK*/,
      p_estado                     => p_row.ESTADO,
      p_hash                       => p_row.HASH,
      p_salt                       => p_row.SALT,
      p_algoritmo                  => p_row.ALGORITMO,
      p_iteraciones                => p_row.ITERACIONES,
      p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
      p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_USUARIO_CLAVES (
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).HASH,
      p_rows_tab(i).SALT,
      p_rows_tab(i).ALGORITMO,
      p_rows_tab(i).ITERACIONES,
      p_rows_tab(i).CANTIDAD_INTENTOS_FALLIDOS,
      p_rows_tab(i).FECHA_ULTIMA_AUTENTICACION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
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
    INSERT INTO T_USUARIO_CLAVES (
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).ID_USUARIO,
      p_rows_tab(i).TIPO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).ESTADO,
      p_rows_tab(i).HASH,
      p_rows_tab(i).SALT,
      p_rows_tab(i).ALGORITMO,
      p_rows_tab(i).ITERACIONES,
      p_rows_tab(i).CANTIDAD_INTENTOS_FALLIDOS,
      p_rows_tab(i).FECHA_ULTIMA_AUTENTICACION,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
    v_row T_USUARIO_CLAVES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_USUARIO_CLAVES
      WHERE
        ID_USUARIO = p_id_usuario
        AND TIPO = p_tipo
        AND ORDEN = p_orden;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_id_usuario                 IN            T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN            T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN            T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                        OUT NOCOPY T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                          OUT NOCOPY T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                          OUT NOCOPY T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                     OUT NOCOPY T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                   OUT NOCOPY T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos    OUT NOCOPY T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion    OUT NOCOPY T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE,
    p_usuario_insercion             OUT NOCOPY T_USUARIO_CLAVES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion               OUT NOCOPY T_USUARIO_CLAVES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion          OUT NOCOPY T_USUARIO_CLAVES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion            OUT NOCOPY T_USUARIO_CLAVES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_USUARIO_CLAVES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden );
    p_estado                     := v_row.ESTADO; 
    p_hash                       := v_row.HASH; 
    p_salt                       := v_row.SALT; 
    p_algoritmo                  := v_row.ALGORITMO; 
    p_iteraciones                := v_row.ITERACIONES; 
    p_cantidad_intentos_fallidos := v_row.CANTIDAD_INTENTOS_FALLIDOS; 
    p_fecha_ultima_autenticacion := v_row.FECHA_ULTIMA_AUTENTICACION; 
    p_usuario_insercion          := v_row.USUARIO_INSERCION; 
    p_fecha_insercion            := v_row.FECHA_INSERCION; 
    p_usuario_modificacion       := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion         := v_row.FECHA_MODIFICACION; 
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
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
    v_return T_USUARIO_CLAVES%ROWTYPE; 
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      ESTADO                     = p_estado,
      HASH                       = p_hash,
      SALT                       = p_salt,
      ALGORITMO                  = p_algoritmo,
      ITERACIONES                = p_iteraciones,
      CANTIDAD_INTENTOS_FALLIDOS = p_cantidad_intentos_fallidos,
      FECHA_ULTIMA_AUTENTICACION = p_fecha_ultima_autenticacion,
      USUARIO_MODIFICACION       = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION         = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden
    RETURN 
      ID_USUARIO /*PK*/ /*FK*/,
      TIPO /*PK*/,
      ORDEN /*PK*/,
      ESTADO,
      HASH,
      SALT,
      ALGORITMO,
      ITERACIONES,
      CANTIDAD_INTENTOS_FALLIDOS,
      FECHA_ULTIMA_AUTENTICACION,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      ESTADO                     = p_estado,
      HASH                       = p_hash,
      SALT                       = p_salt,
      ALGORITMO                  = p_algoritmo,
      ITERACIONES                = p_iteraciones,
      CANTIDAD_INTENTOS_FALLIDOS = p_cantidad_intentos_fallidos,
      FECHA_ULTIMA_AUTENTICACION = p_fecha_ultima_autenticacion,
      USUARIO_MODIFICACION       = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION         = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END update_row;

  FUNCTION update_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_tipo                       => p_row.TIPO /*PK*/,
      p_orden                      => p_row.ORDEN /*PK*/,
      p_estado                     => p_row.ESTADO,
      p_hash                       => p_row.HASH,
      p_salt                       => p_row.SALT,
      p_algoritmo                  => p_row.ALGORITMO,
      p_iteraciones                => p_row.ITERACIONES,
      p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
      p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
      p_tipo                       => p_row.TIPO /*PK*/,
      p_orden                      => p_row.ORDEN /*PK*/,
      p_estado                     => p_row.ESTADO,
      p_hash                       => p_row.HASH,
      p_salt                       => p_row.SALT,
      p_algoritmo                  => p_row.ALGORITMO,
      p_iteraciones                => p_row.ITERACIONES,
      p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
      p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_USUARIO_CLAVES
      SET
        ESTADO                     = p_rows_tab(i).ESTADO,
        HASH                       = p_rows_tab(i).HASH,
        SALT                       = p_rows_tab(i).SALT,
        ALGORITMO                  = p_rows_tab(i).ALGORITMO,
        ITERACIONES                = p_rows_tab(i).ITERACIONES,
        CANTIDAD_INTENTOS_FALLIDOS = p_rows_tab(i).CANTIDAD_INTENTOS_FALLIDOS,
        FECHA_ULTIMA_AUTENTICACION = p_rows_tab(i).FECHA_ULTIMA_AUTENTICACION,
        USUARIO_MODIFICACION       = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION         = systimestamp
      WHERE
        ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND TIPO = p_rows_tab(i).TIPO
        AND ORDEN = p_rows_tab(i).ORDEN;
  END update_rows;

  PROCEDURE delete_row (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_USUARIO_CLAVES
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_USUARIO_CLAVES
       WHERE ID_USUARIO = p_rows_tab(i).ID_USUARIO
        AND TIPO = p_rows_tab(i).TIPO
        AND ORDEN = p_rows_tab(i).ORDEN;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden
    )
    THEN
      RETURN update_row (
        p_id_usuario                 => p_id_usuario /*PK*/ /*FK*/,
        p_tipo                       => p_tipo /*PK*/,
        p_orden                      => p_orden /*PK*/,
        p_estado                     => p_estado,
        p_hash                       => p_hash,
        p_salt                       => p_salt,
        p_algoritmo                  => p_algoritmo,
        p_iteraciones                => p_iteraciones,
        p_cantidad_intentos_fallidos => p_cantidad_intentos_fallidos,
        p_fecha_ultima_autenticacion => p_fecha_ultima_autenticacion );
    ELSE
      RETURN create_row (
        p_id_usuario                 => p_id_usuario /*PK*/ /*FK*/,
        p_tipo                       => p_tipo /*PK*/,
        p_orden                      => p_orden /*PK*/,
        p_estado                     => p_estado,
        p_hash                       => p_hash,
        p_salt                       => p_salt,
        p_algoritmo                  => p_algoritmo,
        p_iteraciones                => p_iteraciones,
        p_cantidad_intentos_fallidos => p_cantidad_intentos_fallidos,
        p_fecha_ultima_autenticacion => p_fecha_ultima_autenticacion );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/ /*FK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado                     IN T_USUARIO_CLAVES.ESTADO%TYPE,
    p_hash                       IN T_USUARIO_CLAVES.HASH%TYPE,
    p_salt                       IN T_USUARIO_CLAVES.SALT%TYPE,
    p_algoritmo                  IN T_USUARIO_CLAVES.ALGORITMO%TYPE,
    p_iteraciones                IN T_USUARIO_CLAVES.ITERACIONES%TYPE,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden
    )
    THEN
      update_row (
        p_id_usuario                 => p_id_usuario /*PK*/ /*FK*/,
        p_tipo                       => p_tipo /*PK*/,
        p_orden                      => p_orden /*PK*/,
        p_estado                     => p_estado,
        p_hash                       => p_hash,
        p_salt                       => p_salt,
        p_algoritmo                  => p_algoritmo,
        p_iteraciones                => p_iteraciones,
        p_cantidad_intentos_fallidos => p_cantidad_intentos_fallidos,
        p_fecha_ultima_autenticacion => p_fecha_ultima_autenticacion );
    ELSE
      create_row (
        p_id_usuario                 => p_id_usuario /*PK*/ /*FK*/,
        p_tipo                       => p_tipo /*PK*/,
        p_orden                      => p_orden /*PK*/,
        p_estado                     => p_estado,
        p_hash                       => p_hash,
        p_salt                       => p_salt,
        p_algoritmo                  => p_algoritmo,
        p_iteraciones                => p_iteraciones,
        p_cantidad_intentos_fallidos => p_cantidad_intentos_fallidos,
        p_fecha_ultima_autenticacion => p_fecha_ultima_autenticacion );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  RETURN T_USUARIO_CLAVES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_id_usuario => p_row.ID_USUARIO,
      p_tipo       => p_row.TIPO,
      p_orden      => p_row.ORDEN
    )
    THEN
      RETURN update_row (
        p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_tipo                       => p_row.TIPO /*PK*/,
        p_orden                      => p_row.ORDEN /*PK*/,
        p_estado                     => p_row.ESTADO,
        p_hash                       => p_row.HASH,
        p_salt                       => p_row.SALT,
        p_algoritmo                  => p_row.ALGORITMO,
        p_iteraciones                => p_row.ITERACIONES,
        p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
        p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
    ELSE
      RETURN create_row (
        p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_tipo                       => p_row.TIPO /*PK*/,
        p_orden                      => p_row.ORDEN /*PK*/,
        p_estado                     => p_row.ESTADO,
        p_hash                       => p_row.HASH,
        p_salt                       => p_row.SALT,
        p_algoritmo                  => p_row.ALGORITMO,
        p_iteraciones                => p_row.ITERACIONES,
        p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
        p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_USUARIO_CLAVES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_usuario => p_row.ID_USUARIO,
      p_tipo       => p_row.TIPO,
      p_orden      => p_row.ORDEN
    )
    THEN
      update_row (
        p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_tipo                       => p_row.TIPO /*PK*/,
        p_orden                      => p_row.ORDEN /*PK*/,
        p_estado                     => p_row.ESTADO,
        p_hash                       => p_row.HASH,
        p_salt                       => p_row.SALT,
        p_algoritmo                  => p_row.ALGORITMO,
        p_iteraciones                => p_row.ITERACIONES,
        p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
        p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
    ELSE
      create_row (
        p_id_usuario                 => p_row.ID_USUARIO /*PK*/ /*FK*/,
        p_tipo                       => p_row.TIPO /*PK*/,
        p_orden                      => p_row.ORDEN /*PK*/,
        p_estado                     => p_row.ESTADO,
        p_hash                       => p_row.HASH,
        p_salt                       => p_row.SALT,
        p_algoritmo                  => p_row.ALGORITMO,
        p_iteraciones                => p_row.ITERACIONES,
        p_cantidad_intentos_fallidos => p_row.CANTIDAD_INTENTOS_FALLIDOS,
        p_fecha_ultima_autenticacion => p_row.FECHA_ULTIMA_AUTENTICACION );
    END IF;
  END create_or_update_row;

  FUNCTION get_estado (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.ESTADO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).ESTADO;
  END get_estado;

  FUNCTION get_hash (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.HASH%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).HASH;
  END get_hash;

  FUNCTION get_salt (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.SALT%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).SALT;
  END get_salt;

  FUNCTION get_algoritmo (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.ALGORITMO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).ALGORITMO;
  END get_algoritmo;

  FUNCTION get_iteraciones (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.ITERACIONES%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).ITERACIONES;
  END get_iteraciones;

  FUNCTION get_cantidad_intentos_fallidos (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).CANTIDAD_INTENTOS_FALLIDOS;
  END get_cantidad_intentos_fallidos;

  FUNCTION get_fecha_ultima_autenticacion (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).FECHA_ULTIMA_AUTENTICACION;
  END get_fecha_ultima_autenticacion;

  FUNCTION get_usuario_insercion (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/ )
  RETURN T_USUARIO_CLAVES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_usuario => p_id_usuario,
      p_tipo       => p_tipo,
      p_orden      => p_orden ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_estado (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_estado     IN T_USUARIO_CLAVES.ESTADO%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      ESTADO               = p_estado,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_estado;

  PROCEDURE set_hash (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_hash       IN T_USUARIO_CLAVES.HASH%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      HASH                 = p_hash,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_hash;

  PROCEDURE set_salt (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_salt       IN T_USUARIO_CLAVES.SALT%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      SALT                 = p_salt,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_salt;

  PROCEDURE set_algoritmo (
    p_id_usuario IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_algoritmo  IN T_USUARIO_CLAVES.ALGORITMO%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      ALGORITMO            = p_algoritmo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_algoritmo;

  PROCEDURE set_iteraciones (
    p_id_usuario  IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo        IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden       IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_iteraciones IN T_USUARIO_CLAVES.ITERACIONES%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      ITERACIONES          = p_iteraciones,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_iteraciones;

  PROCEDURE set_cantidad_intentos_fallidos (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_cantidad_intentos_fallidos IN T_USUARIO_CLAVES.CANTIDAD_INTENTOS_FALLIDOS%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      CANTIDAD_INTENTOS_FALLIDOS = p_cantidad_intentos_fallidos,
      USUARIO_MODIFICACION       = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION         = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_cantidad_intentos_fallidos;

  PROCEDURE set_fecha_ultima_autenticacion (
    p_id_usuario                 IN T_USUARIO_CLAVES.ID_USUARIO%TYPE /*PK*/,
    p_tipo                       IN T_USUARIO_CLAVES.TIPO%TYPE /*PK*/,
    p_orden                      IN T_USUARIO_CLAVES.ORDEN%TYPE /*PK*/,
    p_fecha_ultima_autenticacion IN T_USUARIO_CLAVES.FECHA_ULTIMA_AUTENTICACION%TYPE )
  IS
  BEGIN
    UPDATE
      T_USUARIO_CLAVES
    SET
      FECHA_ULTIMA_AUTENTICACION = p_fecha_ultima_autenticacion,
      USUARIO_MODIFICACION       = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION         = systimestamp
    WHERE
      ID_USUARIO = p_id_usuario
      AND TIPO = p_tipo
      AND ORDEN = p_orden;
  END set_fecha_ultima_autenticacion;

END T_USUARIO_CLAVES_API;
/

