CREATE OR REPLACE PACKAGE BODY T_ARCHIVO_DEFINICIONES_API IS
  /*
  This is the API for the table T_ARCHIVO_DEFINICIONES.
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
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN BOOLEAN
  IS
    v_return BOOLEAN := FALSE;
    v_dummy  PLS_INTEGER;
    CURSOR   cur_bool IS
      SELECT 1 FROM T_ARCHIVO_DEFINICIONES
      WHERE
        TABLA = p_tabla
        AND CAMPO = p_campo;
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
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN VARCHAR2
  IS
  BEGIN
    RETURN
      CASE
        WHEN row_exists(
          p_tabla => p_tabla,
          p_campo => p_campo )
        THEN 'Y'
        ELSE 'N'
      END;
  END;

  FUNCTION create_row (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE                     /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE                     /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE              DEFAULT NULL,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE            DEFAULT NULL,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE                    ,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE        DEFAULT NULL,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE   DEFAULT NULL,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE         DEFAULT 'N'  )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
    v_return T_ARCHIVO_DEFINICIONES%ROWTYPE; 
  BEGIN
    INSERT INTO T_ARCHIVO_DEFINICIONES (
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_descripcion,
      p_tamano_maximo,
      p_orden,
      p_nombre_referencia,
      p_extensiones_permitidas,
      p_historico_activo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END create_row;

  PROCEDURE create_row (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE                     /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE                     /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE              DEFAULT NULL,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE            DEFAULT NULL,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE                    ,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE        DEFAULT NULL,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE   DEFAULT NULL,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE         DEFAULT 'N'  )
  IS
  BEGIN
    INSERT INTO T_ARCHIVO_DEFINICIONES (
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_tabla,
      p_campo,
      p_descripcion,
      p_tamano_maximo,
      p_orden,
      p_nombre_referencia,
      p_extensiones_permitidas,
      p_historico_activo,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_row;

  FUNCTION create_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
  BEGIN
    RETURN create_row (
      p_tabla                  => p_row.TABLA /*PK*/,
      p_campo                  => p_row.CAMPO /*PK*/,
      p_descripcion            => p_row.DESCRIPCION,
      p_tamano_maximo          => p_row.TAMANO_MAXIMO,
      p_orden                  => p_row.ORDEN,
      p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
      p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
      p_historico_activo       => p_row.HISTORICO_ACTIVO );
  END create_row;

  PROCEDURE create_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  IS
  BEGIN
    create_row (
      p_tabla                  => p_row.TABLA /*PK*/,
      p_campo                  => p_row.CAMPO /*PK*/,
      p_descripcion            => p_row.DESCRIPCION,
      p_tamano_maximo          => p_row.TAMANO_MAXIMO,
      p_orden                  => p_row.ORDEN,
      p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
      p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
      p_historico_activo       => p_row.HISTORICO_ACTIVO );
  END create_row;

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab
  IS
    v_return t_rows_tab;
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
    INSERT INTO T_ARCHIVO_DEFINICIONES (
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).TAMANO_MAXIMO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).NOMBRE_REFERENCIA,
      p_rows_tab(i).EXTENSIONES_PERMITIDAS,
      p_rows_tab(i).HISTORICO_ACTIVO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp )
    RETURN 
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
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
    INSERT INTO T_ARCHIVO_DEFINICIONES (
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION )
    VALUES (
      p_rows_tab(i).TABLA,
      p_rows_tab(i).CAMPO,
      p_rows_tab(i).DESCRIPCION,
      p_rows_tab(i).TAMANO_MAXIMO,
      p_rows_tab(i).ORDEN,
      p_rows_tab(i).NOMBRE_REFERENCIA,
      p_rows_tab(i).EXTENSIONES_PERMITIDAS,
      p_rows_tab(i).HISTORICO_ACTIVO,
      substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      systimestamp );
  END create_rows;

  FUNCTION read_row (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
    v_row T_ARCHIVO_DEFINICIONES%ROWTYPE;
    CURSOR cur_row IS
      SELECT * FROM T_ARCHIVO_DEFINICIONES
      WHERE
        TABLA = p_tabla
        AND CAMPO = p_campo;
  BEGIN
    OPEN cur_row;
    FETCH cur_row INTO v_row;
    CLOSE cur_row;
    RETURN v_row;
  END read_row;

  PROCEDURE read_row (
    p_tabla                  IN            T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN            T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion               OUT NOCOPY T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE,
    p_tamano_maximo             OUT NOCOPY T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE,
    p_orden                     OUT NOCOPY T_ARCHIVO_DEFINICIONES.ORDEN%TYPE,
    p_nombre_referencia         OUT NOCOPY T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE,
    p_extensiones_permitidas    OUT NOCOPY T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE,
    p_historico_activo          OUT NOCOPY T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE,
    p_usuario_insercion         OUT NOCOPY T_ARCHIVO_DEFINICIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion           OUT NOCOPY T_ARCHIVO_DEFINICIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion      OUT NOCOPY T_ARCHIVO_DEFINICIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion        OUT NOCOPY T_ARCHIVO_DEFINICIONES.FECHA_MODIFICACION%TYPE )
  IS
    v_row T_ARCHIVO_DEFINICIONES%ROWTYPE;
  BEGIN
    v_row := read_row (
      p_tabla => p_tabla,
      p_campo => p_campo );
    p_descripcion            := v_row.DESCRIPCION; 
    p_tamano_maximo          := v_row.TAMANO_MAXIMO; 
    p_orden                  := v_row.ORDEN; 
    p_nombre_referencia      := v_row.NOMBRE_REFERENCIA; 
    p_extensiones_permitidas := v_row.EXTENSIONES_PERMITIDAS; 
    p_historico_activo       := v_row.HISTORICO_ACTIVO; 
    p_usuario_insercion      := v_row.USUARIO_INSERCION; 
    p_fecha_insercion        := v_row.FECHA_INSERCION; 
    p_usuario_modificacion   := v_row.USUARIO_MODIFICACION; 
    p_fecha_modificacion     := v_row.FECHA_MODIFICACION; 
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
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
    v_return T_ARCHIVO_DEFINICIONES%ROWTYPE; 
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      DESCRIPCION            = p_descripcion,
      TAMANO_MAXIMO          = p_tamano_maximo,
      ORDEN                  = p_orden,
      NOMBRE_REFERENCIA      = p_nombre_referencia,
      EXTENSIONES_PERMITIDAS = p_extensiones_permitidas,
      HISTORICO_ACTIVO       = p_historico_activo,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo
    RETURN 
      TABLA /*PK*/,
      CAMPO /*PK*/,
      DESCRIPCION,
      TAMANO_MAXIMO,
      ORDEN,
      NOMBRE_REFERENCIA,
      EXTENSIONES_PERMITIDAS,
      HISTORICO_ACTIVO,
      USUARIO_INSERCION,
      FECHA_INSERCION,
      USUARIO_MODIFICACION,
      FECHA_MODIFICACION
    INTO
      v_return; 
    RETURN v_return;
  END update_row;

  PROCEDURE update_row (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      DESCRIPCION            = p_descripcion,
      TAMANO_MAXIMO          = p_tamano_maximo,
      ORDEN                  = p_orden,
      NOMBRE_REFERENCIA      = p_nombre_referencia,
      EXTENSIONES_PERMITIDAS = p_extensiones_permitidas,
      HISTORICO_ACTIVO       = p_historico_activo,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END update_row;

  FUNCTION update_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
  BEGIN
    RETURN update_row (
      p_tabla                  => p_row.TABLA /*PK*/,
      p_campo                  => p_row.CAMPO /*PK*/,
      p_descripcion            => p_row.DESCRIPCION,
      p_tamano_maximo          => p_row.TAMANO_MAXIMO,
      p_orden                  => p_row.ORDEN,
      p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
      p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
      p_historico_activo       => p_row.HISTORICO_ACTIVO );
  END update_row;

  PROCEDURE update_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  IS
  BEGIN
    update_row (
      p_tabla                  => p_row.TABLA /*PK*/,
      p_campo                  => p_row.CAMPO /*PK*/,
      p_descripcion            => p_row.DESCRIPCION,
      p_tamano_maximo          => p_row.TAMANO_MAXIMO,
      p_orden                  => p_row.ORDEN,
      p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
      p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
      p_historico_activo       => p_row.HISTORICO_ACTIVO );
  END update_row;

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      UPDATE
        T_ARCHIVO_DEFINICIONES
      SET
        DESCRIPCION            = p_rows_tab(i).DESCRIPCION,
        TAMANO_MAXIMO          = p_rows_tab(i).TAMANO_MAXIMO,
        ORDEN                  = p_rows_tab(i).ORDEN,
        NOMBRE_REFERENCIA      = p_rows_tab(i).NOMBRE_REFERENCIA,
        EXTENSIONES_PERMITIDAS = p_rows_tab(i).EXTENSIONES_PERMITIDAS,
        HISTORICO_ACTIVO       = p_rows_tab(i).HISTORICO_ACTIVO,
        USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
        FECHA_MODIFICACION     = systimestamp
      WHERE
        TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO;
  END update_rows;

  PROCEDURE delete_row (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  IS
  BEGIN
    DELETE FROM T_ARCHIVO_DEFINICIONES
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END delete_row;

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab )
  IS
  BEGIN
    FORALL i IN INDICES OF p_rows_tab
      DELETE FROM T_ARCHIVO_DEFINICIONES
       WHERE TABLA = p_rows_tab(i).TABLA
        AND CAMPO = p_rows_tab(i).CAMPO;
  END delete_rows;

  FUNCTION create_or_update_row (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla => p_tabla,
      p_campo => p_campo
    )
    THEN
      RETURN update_row (
        p_tabla                  => p_tabla /*PK*/,
        p_campo                  => p_campo /*PK*/,
        p_descripcion            => p_descripcion,
        p_tamano_maximo          => p_tamano_maximo,
        p_orden                  => p_orden,
        p_nombre_referencia      => p_nombre_referencia,
        p_extensiones_permitidas => p_extensiones_permitidas,
        p_historico_activo       => p_historico_activo );
    ELSE
      RETURN create_row (
        p_tabla                  => p_tabla /*PK*/,
        p_campo                  => p_campo /*PK*/,
        p_descripcion            => p_descripcion,
        p_tamano_maximo          => p_tamano_maximo,
        p_orden                  => p_orden,
        p_nombre_referencia      => p_nombre_referencia,
        p_extensiones_permitidas => p_extensiones_permitidas,
        p_historico_activo       => p_historico_activo );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion            IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE,
    p_tamano_maximo          IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE,
    p_orden                  IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE,
    p_nombre_referencia      IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE,
    p_historico_activo       IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla => p_tabla,
      p_campo => p_campo
    )
    THEN
      update_row (
        p_tabla                  => p_tabla /*PK*/,
        p_campo                  => p_campo /*PK*/,
        p_descripcion            => p_descripcion,
        p_tamano_maximo          => p_tamano_maximo,
        p_orden                  => p_orden,
        p_nombre_referencia      => p_nombre_referencia,
        p_extensiones_permitidas => p_extensiones_permitidas,
        p_historico_activo       => p_historico_activo );
    ELSE
      create_row (
        p_tabla                  => p_tabla /*PK*/,
        p_campo                  => p_campo /*PK*/,
        p_descripcion            => p_descripcion,
        p_tamano_maximo          => p_tamano_maximo,
        p_orden                  => p_orden,
        p_nombre_referencia      => p_nombre_referencia,
        p_extensiones_permitidas => p_extensiones_permitidas,
        p_historico_activo       => p_historico_activo );
    END IF;
  END create_or_update_row;

  FUNCTION create_or_update_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
  BEGIN
    IF row_exists(
      p_tabla => p_row.TABLA,
      p_campo => p_row.CAMPO
    )
    THEN
      RETURN update_row (
        p_tabla                  => p_row.TABLA /*PK*/,
        p_campo                  => p_row.CAMPO /*PK*/,
        p_descripcion            => p_row.DESCRIPCION,
        p_tamano_maximo          => p_row.TAMANO_MAXIMO,
        p_orden                  => p_row.ORDEN,
        p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
        p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
        p_historico_activo       => p_row.HISTORICO_ACTIVO );
    ELSE
      RETURN create_row (
        p_tabla                  => p_row.TABLA /*PK*/,
        p_campo                  => p_row.CAMPO /*PK*/,
        p_descripcion            => p_row.DESCRIPCION,
        p_tamano_maximo          => p_row.TAMANO_MAXIMO,
        p_orden                  => p_row.ORDEN,
        p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
        p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
        p_historico_activo       => p_row.HISTORICO_ACTIVO );
    END IF;
  END create_or_update_row;

  PROCEDURE create_or_update_row (
    p_row IN T_ARCHIVO_DEFINICIONES%ROWTYPE )
  IS
  BEGIN
    IF row_exists(
      p_tabla => p_row.TABLA,
      p_campo => p_row.CAMPO
    )
    THEN
      update_row (
        p_tabla                  => p_row.TABLA /*PK*/,
        p_campo                  => p_row.CAMPO /*PK*/,
        p_descripcion            => p_row.DESCRIPCION,
        p_tamano_maximo          => p_row.TAMANO_MAXIMO,
        p_orden                  => p_row.ORDEN,
        p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
        p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
        p_historico_activo       => p_row.HISTORICO_ACTIVO );
    ELSE
      create_row (
        p_tabla                  => p_row.TABLA /*PK*/,
        p_campo                  => p_row.CAMPO /*PK*/,
        p_descripcion            => p_row.DESCRIPCION,
        p_tamano_maximo          => p_row.TAMANO_MAXIMO,
        p_orden                  => p_row.ORDEN,
        p_nombre_referencia      => p_row.NOMBRE_REFERENCIA,
        p_extensiones_permitidas => p_row.EXTENSIONES_PERMITIDAS,
        p_historico_activo       => p_row.HISTORICO_ACTIVO );
    END IF;
  END create_or_update_row;

  FUNCTION get_descripcion (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).DESCRIPCION;
  END get_descripcion;

  FUNCTION get_tamano_maximo (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).TAMANO_MAXIMO;
  END get_tamano_maximo;

  FUNCTION get_orden (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).ORDEN;
  END get_orden;

  FUNCTION get_nombre_referencia (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).NOMBRE_REFERENCIA;
  END get_nombre_referencia;

  FUNCTION get_extensiones_permitidas (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).EXTENSIONES_PERMITIDAS;
  END get_extensiones_permitidas;

  FUNCTION get_historico_activo (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).HISTORICO_ACTIVO;
  END get_historico_activo;

  FUNCTION get_usuario_insercion (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.USUARIO_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).USUARIO_INSERCION;
  END get_usuario_insercion;

  FUNCTION get_fecha_insercion (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.FECHA_INSERCION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).FECHA_INSERCION;
  END get_fecha_insercion;

  FUNCTION get_usuario_modificacion (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.USUARIO_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).USUARIO_MODIFICACION;
  END get_usuario_modificacion;

  FUNCTION get_fecha_modificacion (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/ )
  RETURN T_ARCHIVO_DEFINICIONES.FECHA_MODIFICACION%TYPE
  IS
  BEGIN
    RETURN read_row (
      p_tabla => p_tabla,
      p_campo => p_campo ).FECHA_MODIFICACION;
  END get_fecha_modificacion;

  PROCEDURE set_descripcion (
    p_tabla       IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo       IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_descripcion IN T_ARCHIVO_DEFINICIONES.DESCRIPCION%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      DESCRIPCION          = p_descripcion,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_descripcion;

  PROCEDURE set_tamano_maximo (
    p_tabla         IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo         IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_tamano_maximo IN T_ARCHIVO_DEFINICIONES.TAMANO_MAXIMO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      TAMANO_MAXIMO        = p_tamano_maximo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_tamano_maximo;

  PROCEDURE set_orden (
    p_tabla IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_orden IN T_ARCHIVO_DEFINICIONES.ORDEN%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      ORDEN                = p_orden,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_orden;

  PROCEDURE set_nombre_referencia (
    p_tabla             IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo             IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_nombre_referencia IN T_ARCHIVO_DEFINICIONES.NOMBRE_REFERENCIA%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      NOMBRE_REFERENCIA    = p_nombre_referencia,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_nombre_referencia;

  PROCEDURE set_extensiones_permitidas (
    p_tabla                  IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo                  IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_extensiones_permitidas IN T_ARCHIVO_DEFINICIONES.EXTENSIONES_PERMITIDAS%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      EXTENSIONES_PERMITIDAS = p_extensiones_permitidas,
      USUARIO_MODIFICACION   = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION     = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_extensiones_permitidas;

  PROCEDURE set_historico_activo (
    p_tabla            IN T_ARCHIVO_DEFINICIONES.TABLA%TYPE /*PK*/,
    p_campo            IN T_ARCHIVO_DEFINICIONES.CAMPO%TYPE /*PK*/,
    p_historico_activo IN T_ARCHIVO_DEFINICIONES.HISTORICO_ACTIVO%TYPE )
  IS
  BEGIN
    UPDATE
      T_ARCHIVO_DEFINICIONES
    SET
      HISTORICO_ACTIVO     = p_historico_activo,
      USUARIO_MODIFICACION = substr(coalesce(k_sistema.f_usuario, user), 1, 300),
      FECHA_MODIFICACION   = systimestamp
    WHERE
      TABLA = p_tabla
      AND CAMPO = p_campo;
  END set_historico_activo;

  FUNCTION get_default_row
  RETURN T_ARCHIVO_DEFINICIONES%ROWTYPE
  IS
    v_row T_ARCHIVO_DEFINICIONES%ROWTYPE;
  BEGIN
    v_row.HISTORICO_ACTIVO  := 'N' ;
    v_row.USUARIO_INSERCION := SUBSTR(USER, 1, 300) ;
    v_row.FECHA_INSERCION   := SYSTIMESTAMP ;
    RETURN v_row;
  END get_default_row;

END T_ARCHIVO_DEFINICIONES_API;
/

