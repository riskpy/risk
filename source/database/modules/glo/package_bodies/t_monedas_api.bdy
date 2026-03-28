CREATE OR REPLACE PACKAGE BODY T_MONEDAS_API IS
  /*
  This is the API for the table T_MONEDAS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-23 22:44:11
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
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_MONEDAS
      WHERE
        ID_MONEDA = p_id_moneda;
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
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_id_moneda => p_id_moneda )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION get_pk_by_unique_cols (
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/ )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
    v_return T_MONEDAS.ID_MONEDA%TYPE;
  BEGIN
    v_return := read_row ( p_iso_alpha_3 => p_iso_alpha_3 ).ID_MONEDA;
    RETURN v_return;
  END get_pk_by_unique_cols;

  FUNCTION get_pk_by_unique_cols (
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
    v_return T_MONEDAS.ID_MONEDA%TYPE;
  BEGIN
    v_return := read_row ( p_iso_numeric => p_iso_numeric ).ID_MONEDA;
    RETURN v_return;
  END get_pk_by_unique_cols;

  FUNCTION create_row (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE              DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE            ,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_formato     IN T_MONEDAS.FORMATO%TYPE                DEFAULT NULL,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE                DEFAULT NULL,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE                DEFAULT NULL /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE            DEFAULT NULL /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE            DEFAULT NULL /*UK*/ )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
    v_return T_MONEDAS.ID_MONEDA%TYPE; 
  BEGIN
    INSERT INTO T_MONEDAS (
      ID_MONEDA /*PK*/,
      DESCRIPCION,
      ACTIVO,
      FORMATO,
      SIMBOLO,
      ID_PAIS /*FK*/,
      ISO_ALPHA_3 /*UK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      ISO_NUMERIC /*UK*/ )
    VALUES (
      p_id_moneda,
      p_descripcion,
      p_activo,
      p_formato,
      p_simbolo,
      p_id_pais,
      p_iso_alpha_3,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp,
      p_iso_numeric )
    RETURN 
      ID_MONEDA
    INTO
      v_return;
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE              DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE            ,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_formato     IN T_MONEDAS.FORMATO%TYPE                DEFAULT NULL,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE                DEFAULT NULL,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE                DEFAULT NULL /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE            DEFAULT NULL /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE            DEFAULT NULL /*UK*/ )
  IS
  BEGIN
    INSERT INTO T_MONEDAS (
      ID_MONEDA /*PK*/,
      DESCRIPCION,
      ACTIVO,
      FORMATO,
      SIMBOLO,
      ID_PAIS /*FK*/,
      ISO_ALPHA_3 /*UK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      ISO_NUMERIC /*UK*/ )
    VALUES (
      p_id_moneda,
      p_descripcion,
      p_activo,
      p_formato,
      p_simbolo,
      p_id_pais,
      p_iso_alpha_3,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp,
      p_iso_numeric );
  END create_row;

  FUNCTION create_row (
    p_row IN T_MONEDAS%ROWTYPE )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
  BEGIN
    RETURN create_row (
      p_id_moneda   => p_row.ID_MONEDA /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_activo      => p_row.ACTIVO,
      p_formato     => p_row.FORMATO,
      p_simbolo     => p_row.SIMBOLO,
      p_id_pais     => p_row.ID_PAIS /*FK*/,
      p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
      p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_MONEDAS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_id_moneda   => p_row.ID_MONEDA /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_activo      => p_row.ACTIVO,
      p_formato     => p_row.FORMATO,
      p_simbolo     => p_row.SIMBOLO,
      p_id_pais     => p_row.ID_PAIS /*FK*/,
      p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
      p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MONEDAS (
      ID_MONEDA /*PK*/,
      DESCRIPCION,
      ACTIVO,
      FORMATO,
      SIMBOLO,
      ID_PAIS /*FK*/,
      ISO_ALPHA_3 /*UK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      ISO_NUMERIC /*UK*/ )
    VALUES (
      p_rows_tab(i).ID_MONEDA,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).FORMATO,
      p_rows_tab(i).SIMBOLO,
      p_rows_tab(i).ID_PAIS,
      p_rows_tab(i).ISO_ALPHA_3,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp,
      p_rows_tab(i).ISO_NUMERIC )
    RETURN 
      ID_MONEDA /*PK*/,
      DESCRIPCION,
      ACTIVO,
      FORMATO,
      SIMBOLO,
      ID_PAIS /*FK*/,
      ISO_ALPHA_3 /*UK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION,
      ISO_NUMERIC /*UK*/
    BULK COLLECT INTO v_return;
    RETURN v_return;
  END create_rows;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_MONEDAS (
      ID_MONEDA /*PK*/,
      DESCRIPCION,
      ACTIVO,
      FORMATO,
      SIMBOLO,
      ID_PAIS /*FK*/,
      ISO_ALPHA_3 /*UK*/,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      ISO_NUMERIC /*UK*/ )
    VALUES (
      p_rows_tab(i).ID_MONEDA,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).ACTIVO,
      p_rows_tab(i).FORMATO,
      p_rows_tab(i).SIMBOLO,
      p_rows_tab(i).ID_PAIS,
      p_rows_tab(i).ISO_ALPHA_3,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp,
      p_rows_tab(i).ISO_NUMERIC );
  END create_rows;

  FUNCTION read_row (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS%ROWTYPE
  IS
    v_row T_MONEDAS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_MONEDAS
      WHERE
        ID_MONEDA = p_id_moneda;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  FUNCTION read_row (
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/ )
  RETURN T_MONEDAS%ROWTYPE
  IS
    v_row T_MONEDAS%ROWTYPE;
    CURSOR cur_row IS
      SELECT *
        FROM T_MONEDAS
       WHERE COALESCE(ISO_ALPHA_3, '@@@@@@@@@@@@@@@') = COALESCE(p_iso_alpha_3, '@@@@@@@@@@@@@@@');
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END;

  FUNCTION read_row (
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  RETURN T_MONEDAS%ROWTYPE
  IS
    v_row T_MONEDAS%ROWTYPE;
    CURSOR cur_row IS
      SELECT *
        FROM T_MONEDAS
       WHERE COALESCE(ISO_NUMERIC, -999999999999999.999999999999999) = COALESCE(p_iso_numeric, -999999999999999.999999999999999);
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END;

  PROCEDURE read_row (
    p_id_moneda            IN            T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_descripcion             OUT NOCOPY T_MONEDAS.DESCRIPCION%TYPE,
    p_activo                  OUT NOCOPY T_MONEDAS.ACTIVO%TYPE,
    p_formato                 OUT NOCOPY T_MONEDAS.FORMATO%TYPE,
    p_simbolo                 OUT NOCOPY T_MONEDAS.SIMBOLO%TYPE,
    p_id_pais                 OUT NOCOPY T_MONEDAS.ID_PAIS%TYPE /*FK*/,
    p_iso_alpha_3             OUT NOCOPY T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/,
    p_usuario_insercion       OUT NOCOPY T_MONEDAS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_MONEDAS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_MONEDAS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_MONEDAS.FECHA_MODIFICACION%TYPE,
    p_iso_numeric             OUT NOCOPY T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  IS
    v_row T_MONEDAS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_id_moneda => p_id_moneda );
    p_descripcion          := v_row.DESCRIPCION; 
    p_activo               := v_row.ACTIVO; 
    p_formato              := v_row.FORMATO; 
    p_simbolo              := v_row.SIMBOLO; 
    p_id_pais              := v_row.ID_PAIS; 
    p_iso_alpha_3          := v_row.ISO_ALPHA_3; 
    p_usuario_insercion    := v_row.USUARIO_INSERCION; 
    p_fecha_insercion      := v_row.FECHA_INSERCION; 
    p_usuario_modificacion := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion   := v_row.FECHA_MODIFICACION; 
    p_iso_numeric          := v_row.ISO_NUMERIC; 
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
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE,
    p_formato     IN T_MONEDAS.FORMATO%TYPE,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
    v_return T_MONEDAS.ID_MONEDA%TYPE; 
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      DESCRIPCION          = p_descripcion,
      ACTIVO               = p_activo,
      FORMATO              = p_formato,
      SIMBOLO              = p_simbolo,
      ID_PAIS              = p_id_pais /*FK*/,
      ISO_ALPHA_3          = p_iso_alpha_3 /*UK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp,
      ISO_NUMERIC          = p_iso_numeric /*UK*/
    WHERE
      ID_MONEDA = p_id_moneda
    RETURN 
      ID_MONEDA
    INTO
      v_return;
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE,
    p_formato     IN T_MONEDAS.FORMATO%TYPE,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      DESCRIPCION          = p_descripcion,
      ACTIVO               = p_activo,
      FORMATO              = p_formato,
      SIMBOLO              = p_simbolo,
      ID_PAIS              = p_id_pais /*FK*/,
      ISO_ALPHA_3          = p_iso_alpha_3 /*UK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp,
      ISO_NUMERIC          = p_iso_numeric /*UK*/
    WHERE
      ID_MONEDA = p_id_moneda;
  END update_row;

  FUNCTION update_row (
    p_row IN T_MONEDAS%ROWTYPE )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
  BEGIN
    RETURN update_row (
      p_id_moneda   => p_row.ID_MONEDA /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_activo      => p_row.ACTIVO,
      p_formato     => p_row.FORMATO,
      p_simbolo     => p_row.SIMBOLO,
      p_id_pais     => p_row.ID_PAIS /*FK*/,
      p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
      p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_MONEDAS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_id_moneda   => p_row.ID_MONEDA /*PK*/,
      p_descripcion => p_row.DESCRIPCION,
      p_activo      => p_row.ACTIVO,
      p_formato     => p_row.FORMATO,
      p_simbolo     => p_row.SIMBOLO,
      p_id_pais     => p_row.ID_PAIS /*FK*/,
      p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
      p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_MONEDAS
      SET
        DESCRIPCION          = p_rows_tab(i).DESCRIPCION,
        ACTIVO               = p_rows_tab(i).ACTIVO,
        FORMATO              = p_rows_tab(i).FORMATO,
        SIMBOLO              = p_rows_tab(i).SIMBOLO,
        ID_PAIS              = p_rows_tab(i).ID_PAIS /*FK*/,
        ISO_ALPHA_3          = p_rows_tab(i).ISO_ALPHA_3 /*UK*/,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp,
        ISO_NUMERIC          = p_rows_tab(i).ISO_NUMERIC /*UK*/
      WHERE
        ID_MONEDA = p_rows_tab(i).ID_MONEDA;
  END update_rows;

  PROCEDURE delete_row (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_MONEDAS
    WHERE
      ID_MONEDA = p_id_moneda;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_MONEDAS
       WHERE ID_MONEDA = p_rows_tab(i).ID_MONEDA;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE,
    p_formato     IN T_MONEDAS.FORMATO%TYPE,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_moneda => p_id_moneda
    )
    THEN
      RETURN update_row (
        p_id_moneda   => p_id_moneda /*PK*/,
        p_descripcion => p_descripcion,
        p_activo      => p_activo,
        p_formato     => p_formato,
        p_simbolo     => p_simbolo,
        p_id_pais     => p_id_pais /*FK*/,
        p_iso_alpha_3 => p_iso_alpha_3 /*UK*/,
        p_iso_numeric => p_iso_numeric /*UK*/ );
    ELSE
      RETURN create_row (
        p_id_moneda   => p_id_moneda /*PK*/,
        p_descripcion => p_descripcion,
        p_activo      => p_activo,
        p_formato     => p_formato,
        p_simbolo     => p_simbolo,
        p_id_pais     => p_id_pais /*FK*/,
        p_iso_alpha_3 => p_iso_alpha_3 /*UK*/,
        p_iso_numeric => p_iso_numeric /*UK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE DEFAULT NULL /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE,
    p_activo      IN T_MONEDAS.ACTIVO%TYPE,
    p_formato     IN T_MONEDAS.FORMATO%TYPE,
    p_simbolo     IN T_MONEDAS.SIMBOLO%TYPE,
    p_id_pais     IN T_MONEDAS.ID_PAIS%TYPE /*FK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE /*UK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE /*UK*/ )
  IS
  BEGIN
    IF row_exists(
      p_id_moneda => p_id_moneda
    )
    THEN
      update_row (
        p_id_moneda   => p_id_moneda /*PK*/,
        p_descripcion => p_descripcion,
        p_activo      => p_activo,
        p_formato     => p_formato,
        p_simbolo     => p_simbolo,
        p_id_pais     => p_id_pais /*FK*/,
        p_iso_alpha_3 => p_iso_alpha_3 /*UK*/,
        p_iso_numeric => p_iso_numeric /*UK*/ );
    ELSE
      create_row (
        p_id_moneda   => p_id_moneda /*PK*/,
        p_descripcion => p_descripcion,
        p_activo      => p_activo,
        p_formato     => p_formato,
        p_simbolo     => p_simbolo,
        p_id_pais     => p_id_pais /*FK*/,
        p_iso_alpha_3 => p_iso_alpha_3 /*UK*/,
        p_iso_numeric => p_iso_numeric /*UK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_MONEDAS%ROWTYPE )
  RETURN T_MONEDAS.ID_MONEDA%TYPE
  IS
  BEGIN
    IF row_exists(
      p_id_moneda => p_row.ID_MONEDA
    )
    THEN
      RETURN update_row (
        p_id_moneda   => p_row.ID_MONEDA /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_activo      => p_row.ACTIVO,
        p_formato     => p_row.FORMATO,
        p_simbolo     => p_row.SIMBOLO,
        p_id_pais     => p_row.ID_PAIS /*FK*/,
        p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
        p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
    ELSE
      RETURN create_row (
        p_id_moneda   => p_row.ID_MONEDA /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_activo      => p_row.ACTIVO,
        p_formato     => p_row.FORMATO,
        p_simbolo     => p_row.SIMBOLO,
        p_id_pais     => p_row.ID_PAIS /*FK*/,
        p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
        p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_MONEDAS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_id_moneda => p_row.ID_MONEDA
    )
    THEN
      update_row (
        p_id_moneda   => p_row.ID_MONEDA /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_activo      => p_row.ACTIVO,
        p_formato     => p_row.FORMATO,
        p_simbolo     => p_row.SIMBOLO,
        p_id_pais     => p_row.ID_PAIS /*FK*/,
        p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
        p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
    ELSE
      create_row (
        p_id_moneda   => p_row.ID_MONEDA /*PK*/,
        p_descripcion => p_row.DESCRIPCION,
        p_activo      => p_row.ACTIVO,
        p_formato     => p_row.FORMATO,
        p_simbolo     => p_row.SIMBOLO,
        p_id_pais     => p_row.ID_PAIS /*FK*/,
        p_iso_alpha_3 => p_row.ISO_ALPHA_3 /*UK*/,
        p_iso_numeric => p_row.ISO_NUMERIC /*UK*/ );
    END IF;
  END create_or_update_row;

  FUNCTION get_descripcion (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.DESCRIPCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).DESCRIPCION;
  END get_descripcion;

  FUNCTION get_activo (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).ACTIVO;
  END get_activo;

  FUNCTION get_formato (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.FORMATO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).FORMATO;
  END get_formato;

  FUNCTION get_simbolo (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.SIMBOLO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).SIMBOLO;
  END get_simbolo;

  FUNCTION get_id_pais (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.ID_PAIS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).ID_PAIS;
  END get_id_pais;

  FUNCTION get_iso_alpha_3 (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.ISO_ALPHA_3%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).ISO_ALPHA_3;
  END get_iso_alpha_3;

  FUNCTION get_usuario_insercion (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  FUNCTION get_iso_numeric (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/ )
  RETURN T_MONEDAS.ISO_NUMERIC%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_id_moneda => p_id_moneda ).ISO_NUMERIC;
  END get_iso_numeric;

  PROCEDURE set_descripcion (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_descripcion IN T_MONEDAS.DESCRIPCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      DESCRIPCION          = p_descripcion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_descripcion;

  PROCEDURE set_activo (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_activo    IN T_MONEDAS.ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      ACTIVO               = p_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_activo;

  PROCEDURE set_formato (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_formato   IN T_MONEDAS.FORMATO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      FORMATO              = p_formato,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_formato;

  PROCEDURE set_simbolo (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_simbolo   IN T_MONEDAS.SIMBOLO%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      SIMBOLO              = p_simbolo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_simbolo;

  PROCEDURE set_id_pais (
    p_id_moneda IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_id_pais   IN T_MONEDAS.ID_PAIS%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      ID_PAIS              = p_id_pais /*FK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_id_pais;

  PROCEDURE set_iso_alpha_3 (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_iso_alpha_3 IN T_MONEDAS.ISO_ALPHA_3%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      ISO_ALPHA_3          = p_iso_alpha_3 /*UK*/,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_iso_alpha_3;

  PROCEDURE set_iso_numeric (
    p_id_moneda   IN T_MONEDAS.ID_MONEDA%TYPE /*PK*/,
    p_iso_numeric IN T_MONEDAS.ISO_NUMERIC%TYPE )
  IS
  BEGIN
    UPDATE
      T_MONEDAS
    SET
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp,
      ISO_NUMERIC          = p_iso_numeric /*UK*/
    WHERE
      ID_MONEDA = p_id_moneda;
  END set_iso_numeric;

  FUNCTION get_default_row
  RETURN T_MONEDAS%ROWTYPE
  IS
    v_row T_MONEDAS%ROWTYPE;
  BEGIN
    v_row.ACTIVO            := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_MONEDAS_API;
/

