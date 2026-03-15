CREATE OR REPLACE PACKAGE BODY T_ARCHIVOS_API IS
  /*
  This is the API for the table T_ARCHIVOS.
  - generator: OM_TAPIGEN
  - generator_version: 0.6.3
  - generator_action: COMPILE_API
  - generated_at: 2026-03-15 15:13:59
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
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_ARCHIVOS
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
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
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
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE              DEFAULT NULL,
    p_url            IN T_ARCHIVOS.URL%TYPE                    DEFAULT NULL,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE               DEFAULT NULL,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE                 DEFAULT NULL,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE                 DEFAULT NULL,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE              DEFAULT NULL,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE         DEFAULT NULL )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
    v_return T_ARCHIVOS%ROWTYPE; 
  BEGIN
    INSERT INTO T_ARCHIVOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_referencia,
      p_contenido,
      p_url,
      p_checksum,
      p_tamano,
      p_nombre,
      p_extension,
      p_version_actual,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE              DEFAULT NULL,
    p_url            IN T_ARCHIVOS.URL%TYPE                    DEFAULT NULL,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE               DEFAULT NULL,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE                 DEFAULT NULL,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE                 DEFAULT NULL,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE              DEFAULT NULL,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE         DEFAULT NULL )
  IS
  BEGIN
    INSERT INTO T_ARCHIVOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_referencia,
      p_contenido,
      p_url,
      p_checksum,
      p_tamano,
      p_nombre,
      p_extension,
      p_version_actual,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
      p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia     => p_row.REFERENCIA /*PK*/,
      p_contenido      => p_row.CONTENIDO,
      p_url            => p_row.URL,
      p_checksum       => p_row.CHECKSUM,
      p_tamano         => p_row.TAMANO,
      p_nombre         => p_row.NOMBRE,
      p_extension      => p_row.EXTENSION,
      p_version_actual => p_row.VERSION_ACTUAL );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
      p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia     => p_row.REFERENCIA /*PK*/,
      p_contenido      => p_row.CONTENIDO,
      p_url            => p_row.URL,
      p_checksum       => p_row.CHECKSUM,
      p_tamano         => p_row.TAMANO,
      p_nombre         => p_row.NOMBRE,
      p_extension      => p_row.EXTENSION,
      p_version_actual => p_row.VERSION_ACTUAL );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_ARCHIVOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).CONTENIDO,
      p_rows_tab(i).URL,
      p_rows_tab(i).CHECKSUM,
      p_rows_tab(i).TAMANO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).EXTENSION,
      p_rows_tab(i).VERSION_ACTUAL,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
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
    INSERT INTO T_ARCHIVOS (
      TABLA /*PK*/ /*FK*/,
      CAMPO /*PK*/ /*FK*/,
      REFERENCIA /*PK*/,
      CONTENIDO,
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).REFERENCIA,
      p_rows_tab(i).CONTENIDO,
      p_rows_tab(i).URL,
      p_rows_tab(i).CHECKSUM,
      p_rows_tab(i).TAMANO,
      p_rows_tab(i).NOMBRE,
      p_rows_tab(i).EXTENSION,
      p_rows_tab(i).VERSION_ACTUAL,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
    v_row T_ARCHIVOS%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_ARCHIVOS
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
    p_tabla                IN            T_ARCHIVOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo                IN            T_ARCHIVOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia           IN            T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido               OUT NOCOPY T_ARCHIVOS.CONTENIDO%TYPE,
    p_url                     OUT NOCOPY T_ARCHIVOS.URL%TYPE,
    p_checksum                OUT NOCOPY T_ARCHIVOS.CHECKSUM%TYPE,
    p_tamano                  OUT NOCOPY T_ARCHIVOS.TAMANO%TYPE,
    p_nombre                  OUT NOCOPY T_ARCHIVOS.NOMBRE%TYPE,
    p_extension               OUT NOCOPY T_ARCHIVOS.EXTENSION%TYPE,
    p_version_actual          OUT NOCOPY T_ARCHIVOS.VERSION_ACTUAL%TYPE,
    p_usuario_insercion       OUT NOCOPY T_ARCHIVOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_ARCHIVOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_ARCHIVOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_ARCHIVOS.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_ARCHIVOS%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia );
    p_contenido            := v_row.CONTENIDO; 
    p_url                  := v_row.URL; 
    p_checksum             := v_row.CHECKSUM; 
    p_tamano               := v_row.TAMANO; 
    p_nombre               := v_row.NOMBRE; 
    p_extension            := v_row.EXTENSION; 
    p_version_actual       := v_row.VERSION_ACTUAL; 
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
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE,
    p_url            IN T_ARCHIVOS.URL%TYPE,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
    v_return T_ARCHIVOS%ROWTYPE; 
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      CONTENIDO            = p_contenido,
      URL                  = p_url,
      CHECKSUM             = p_checksum,
      TAMANO               = p_tamano,
      NOMBRE               = p_nombre,
      EXTENSION            = p_extension,
      VERSION_ACTUAL       = p_version_actual,
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
      URL,
      CHECKSUM,
      TAMANO,
      NOMBRE,
      EXTENSION,
      VERSION_ACTUAL,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE,
    p_url            IN T_ARCHIVOS.URL%TYPE,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      CONTENIDO            = p_contenido,
      URL                  = p_url,
      CHECKSUM             = p_checksum,
      TAMANO               = p_tamano,
      NOMBRE               = p_nombre,
      EXTENSION            = p_extension,
      VERSION_ACTUAL       = p_version_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END update_row;

  FUNCTION update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
      p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia     => p_row.REFERENCIA /*PK*/,
      p_contenido      => p_row.CONTENIDO,
      p_url            => p_row.URL,
      p_checksum       => p_row.CHECKSUM,
      p_tamano         => p_row.TAMANO,
      p_nombre         => p_row.NOMBRE,
      p_extension      => p_row.EXTENSION,
      p_version_actual => p_row.VERSION_ACTUAL );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
      p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
      p_referencia     => p_row.REFERENCIA /*PK*/,
      p_contenido      => p_row.CONTENIDO,
      p_url            => p_row.URL,
      p_checksum       => p_row.CHECKSUM,
      p_tamano         => p_row.TAMANO,
      p_nombre         => p_row.NOMBRE,
      p_extension      => p_row.EXTENSION,
      p_version_actual => p_row.VERSION_ACTUAL );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_ARCHIVOS
      SET
        CONTENIDO            = p_rows_tab(i).CONTENIDO,
        URL                  = p_rows_tab(i).URL,
        CHECKSUM             = p_rows_tab(i).CHECKSUM,
        TAMANO               = p_rows_tab(i).TAMANO,
        NOMBRE               = p_rows_tab(i).NOMBRE,
        EXTENSION            = p_rows_tab(i).EXTENSION,
        VERSION_ACTUAL       = p_rows_tab(i).VERSION_ACTUAL,
        USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION   = systimestamp
      WHERE
        TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO
        AND REFERENCIA = p_rows_tab(i).REFERENCIA;
  END update_rows;

  PROCEDURE delete_row (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_ARCHIVOS
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
      DELETE FROM T_ARCHIVOS
       WHERE TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO
        AND REFERENCIA = p_rows_tab(i).REFERENCIA;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE,
    p_url            IN T_ARCHIVOS.URL%TYPE,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia
    )
    THEN
      RETURN update_row (
        p_tabla          => p_tabla /*PK*/ /*FK*/,
        p_campo          => p_campo /*PK*/ /*FK*/,
        p_referencia     => p_referencia /*PK*/,
        p_contenido      => p_contenido,
        p_url            => p_url,
        p_checksum       => p_checksum,
        p_tamano         => p_tamano,
        p_nombre         => p_nombre,
        p_extension      => p_extension,
        p_version_actual => p_version_actual );
    ELSE
      RETURN create_row (
        p_tabla          => p_tabla /*PK*/ /*FK*/,
        p_campo          => p_campo /*PK*/ /*FK*/,
        p_referencia     => p_referencia /*PK*/,
        p_contenido      => p_contenido,
        p_url            => p_url,
        p_checksum       => p_checksum,
        p_tamano         => p_tamano,
        p_nombre         => p_nombre,
        p_extension      => p_extension,
        p_version_actual => p_version_actual );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido      IN T_ARCHIVOS.CONTENIDO%TYPE,
    p_url            IN T_ARCHIVOS.URL%TYPE,
    p_checksum       IN T_ARCHIVOS.CHECKSUM%TYPE,
    p_tamano         IN T_ARCHIVOS.TAMANO%TYPE,
    p_nombre         IN T_ARCHIVOS.NOMBRE%TYPE,
    p_extension      IN T_ARCHIVOS.EXTENSION%TYPE,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia
    )
    THEN
      update_row (
        p_tabla          => p_tabla /*PK*/ /*FK*/,
        p_campo          => p_campo /*PK*/ /*FK*/,
        p_referencia     => p_referencia /*PK*/,
        p_contenido      => p_contenido,
        p_url            => p_url,
        p_checksum       => p_checksum,
        p_tamano         => p_tamano,
        p_nombre         => p_nombre,
        p_extension      => p_extension,
        p_version_actual => p_version_actual );
    ELSE
      create_row (
        p_tabla          => p_tabla /*PK*/ /*FK*/,
        p_campo          => p_campo /*PK*/ /*FK*/,
        p_referencia     => p_referencia /*PK*/,
        p_contenido      => p_contenido,
        p_url            => p_url,
        p_checksum       => p_checksum,
        p_tamano         => p_tamano,
        p_nombre         => p_nombre,
        p_extension      => p_extension,
        p_version_actual => p_version_actual );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_row.TABLA,
      p_campo      => p_row.CAMPO,
      p_referencia => p_row.REFERENCIA
    )
    THEN
      RETURN update_row (
        p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
        p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia     => p_row.REFERENCIA /*PK*/,
        p_contenido      => p_row.CONTENIDO,
        p_url            => p_row.URL,
        p_checksum       => p_row.CHECKSUM,
        p_tamano         => p_row.TAMANO,
        p_nombre         => p_row.NOMBRE,
        p_extension      => p_row.EXTENSION,
        p_version_actual => p_row.VERSION_ACTUAL );
    ELSE
      RETURN create_row (
        p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
        p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia     => p_row.REFERENCIA /*PK*/,
        p_contenido      => p_row.CONTENIDO,
        p_url            => p_row.URL,
        p_checksum       => p_row.CHECKSUM,
        p_tamano         => p_row.TAMANO,
        p_nombre         => p_row.NOMBRE,
        p_extension      => p_row.EXTENSION,
        p_version_actual => p_row.VERSION_ACTUAL );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla      => p_row.TABLA,
      p_campo      => p_row.CAMPO,
      p_referencia => p_row.REFERENCIA
    )
    THEN
      update_row (
        p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
        p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia     => p_row.REFERENCIA /*PK*/,
        p_contenido      => p_row.CONTENIDO,
        p_url            => p_row.URL,
        p_checksum       => p_row.CHECKSUM,
        p_tamano         => p_row.TAMANO,
        p_nombre         => p_row.NOMBRE,
        p_extension      => p_row.EXTENSION,
        p_version_actual => p_row.VERSION_ACTUAL );
    ELSE
      create_row (
        p_tabla          => p_row.TABLA /*PK*/ /*FK*/,
        p_campo          => p_row.CAMPO /*PK*/ /*FK*/,
        p_referencia     => p_row.REFERENCIA /*PK*/,
        p_contenido      => p_row.CONTENIDO,
        p_url            => p_row.URL,
        p_checksum       => p_row.CHECKSUM,
        p_tamano         => p_row.TAMANO,
        p_nombre         => p_row.NOMBRE,
        p_extension      => p_row.EXTENSION,
        p_version_actual => p_row.VERSION_ACTUAL );
    END IF;
  END create_or_update_row;

  FUNCTION get_contenido (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.CONTENIDO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).CONTENIDO;
  END get_contenido;

  FUNCTION get_url (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.URL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).URL;
  END get_url;

  FUNCTION get_checksum (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.CHECKSUM%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).CHECKSUM;
  END get_checksum;

  FUNCTION get_tamano (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.TAMANO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).TAMANO;
  END get_tamano;

  FUNCTION get_nombre (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.NOMBRE%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).NOMBRE;
  END get_nombre;

  FUNCTION get_extension (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.EXTENSION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).EXTENSION;
  END get_extension;

  FUNCTION get_version_actual (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.VERSION_ACTUAL%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).VERSION_ACTUAL;
  END get_version_actual;

  FUNCTION get_usuario_insercion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla      => p_tabla,
      p_campo      => p_campo,
      p_referencia => p_referencia ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_contenido (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_ARCHIVOS.CONTENIDO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      CONTENIDO            = p_contenido,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_contenido;

  PROCEDURE set_url (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_url        IN T_ARCHIVOS.URL%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      URL                  = p_url,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_url;

  PROCEDURE set_checksum (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_checksum   IN T_ARCHIVOS.CHECKSUM%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      CHECKSUM             = p_checksum,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_checksum;

  PROCEDURE set_tamano (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_tamano     IN T_ARCHIVOS.TAMANO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      TAMANO               = p_tamano,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_tamano;

  PROCEDURE set_nombre (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_nombre     IN T_ARCHIVOS.NOMBRE%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      NOMBRE               = p_nombre,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_nombre;

  PROCEDURE set_extension (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_extension  IN T_ARCHIVOS.EXTENSION%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      EXTENSION            = p_extension,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_extension;

  PROCEDURE set_version_actual (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVOS
    SET
      VERSION_ACTUAL       = p_version_actual,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
      AND REFERENCIA = p_referencia;
  END set_version_actual;

  FUNCTION get_default_row
  RETURN T_ARCHIVOS%ROWTYPE
  IS
    v_row T_ARCHIVOS%ROWTYPE;
  BEGIN
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_ARCHIVOS_API;
/

