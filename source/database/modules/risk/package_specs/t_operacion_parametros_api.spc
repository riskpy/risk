CREATE OR REPLACE PACKAGE T_OPERACION_PARAMETROS_API IS
  /*
  This is the API for the table T_OPERACION_PARAMETROS.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-15 15:13:57"
    generated_by="JAVIER"
    p_table_name="T_OPERACION_PARAMETROS"
    p_owner="RISK_RISK"
    p_enable_insertion_of_rows="TRUE"
    p_enable_column_defaults="TRUE"
    p_enable_update_of_rows="TRUE"
    p_enable_deletion_of_rows="TRUE"
    p_enable_parameter_prefixes="TRUE"
    p_enable_proc_with_out_params="TRUE"
    p_enable_getter_and_setter="TRUE"
    p_col_prefix_in_method_names="TRUE"
    p_return_row_instead_of_pk="FALSE"
    p_double_quote_names="FALSE"
    p_default_bulk_limit="1000"
    p_enable_dml_view="TRUE"
    p_dml_view_name="T_OPERACION_PARAMETROS_DML_V"
    p_dml_view_trigger_name="T_OPERACION_PARAMETROS_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_OPERACION_PARAMETROS_V"
    p_api_name="T_OPERACION_PARAMETROS_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_OPERACION_PARAMETROS%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE            /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE                  /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE                 /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE                   /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE              ,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE                DEFAULT NULL,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE        DEFAULT NULL,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE            DEFAULT 'N' ,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE          DEFAULT NULL,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE               DEFAULT NULL,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE                DEFAULT NULL,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE       DEFAULT NULL,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE             DEFAULT 'N'  )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE create_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE            /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE                  /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE                 /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE                   /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE              ,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE                DEFAULT NULL,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE        DEFAULT NULL,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE            DEFAULT 'N' ,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE          DEFAULT NULL,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE               DEFAULT NULL,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE                DEFAULT NULL,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE       DEFAULT NULL,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE             DEFAULT 'N'  );

  FUNCTION create_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE create_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  FUNCTION read_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*UK*/,
    p_orden        IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*UK*/ )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE read_row (
    p_id_operacion         IN            T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre               IN            T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version              IN            T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden                   OUT NOCOPY T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo                  OUT NOCOPY T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato               OUT NOCOPY T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato                 OUT NOCOPY T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima         OUT NOCOPY T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio             OUT NOCOPY T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto           OUT NOCOPY T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta                OUT NOCOPY T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle                 OUT NOCOPY T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles        OUT NOCOPY T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado              OUT NOCOPY T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_OPERACION_PARAMETROS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_OPERACION_PARAMETROS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_OPERACION_PARAMETROS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_OPERACION_PARAMETROS.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE );

  FUNCTION update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/ /*UK*/ /*FK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ /*UK*/,
    p_orden            IN T_OPERACION_PARAMETROS.ORDEN%TYPE /*UK*/,
    p_activo           IN T_OPERACION_PARAMETROS.ACTIVO%TYPE,
    p_tipo_dato        IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE,
    p_formato          IN T_OPERACION_PARAMETROS.FORMATO%TYPE,
    p_longitud_maxima  IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE,
    p_obligatorio      IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE,
    p_valor_defecto    IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE,
    p_etiqueta         IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE,
    p_detalle          IN T_OPERACION_PARAMETROS.DETALLE%TYPE,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE,
    p_encriptado       IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE )
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_OPERACION_PARAMETROS%ROWTYPE );

  FUNCTION get_orden (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ORDEN%TYPE;

  FUNCTION get_activo (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ACTIVO%TYPE;

  FUNCTION get_tipo_dato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE;

  FUNCTION get_formato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FORMATO%TYPE;

  FUNCTION get_longitud_maxima (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE;

  FUNCTION get_obligatorio (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE;

  FUNCTION get_valor_defecto (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE;

  FUNCTION get_etiqueta (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ETIQUETA%TYPE;

  FUNCTION get_detalle (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.DETALLE%TYPE;

  FUNCTION get_valores_posibles (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE;

  FUNCTION get_encriptado (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/ )
  RETURN T_OPERACION_PARAMETROS.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_orden (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_orden        IN T_OPERACION_PARAMETROS.ORDEN%TYPE );

  PROCEDURE set_activo (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_activo       IN T_OPERACION_PARAMETROS.ACTIVO%TYPE );

  PROCEDURE set_tipo_dato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_tipo_dato    IN T_OPERACION_PARAMETROS.TIPO_DATO%TYPE );

  PROCEDURE set_formato (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_formato      IN T_OPERACION_PARAMETROS.FORMATO%TYPE );

  PROCEDURE set_longitud_maxima (
    p_id_operacion    IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre          IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version         IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_longitud_maxima IN T_OPERACION_PARAMETROS.LONGITUD_MAXIMA%TYPE );

  PROCEDURE set_obligatorio (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_obligatorio  IN T_OPERACION_PARAMETROS.OBLIGATORIO%TYPE );

  PROCEDURE set_valor_defecto (
    p_id_operacion  IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre        IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version       IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_valor_defecto IN T_OPERACION_PARAMETROS.VALOR_DEFECTO%TYPE );

  PROCEDURE set_etiqueta (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_etiqueta     IN T_OPERACION_PARAMETROS.ETIQUETA%TYPE );

  PROCEDURE set_detalle (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_detalle      IN T_OPERACION_PARAMETROS.DETALLE%TYPE );

  PROCEDURE set_valores_posibles (
    p_id_operacion     IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre           IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version          IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_valores_posibles IN T_OPERACION_PARAMETROS.VALORES_POSIBLES%TYPE );

  PROCEDURE set_encriptado (
    p_id_operacion IN T_OPERACION_PARAMETROS.ID_OPERACION%TYPE /*PK*/,
    p_nombre       IN T_OPERACION_PARAMETROS.NOMBRE%TYPE /*PK*/,
    p_version      IN T_OPERACION_PARAMETROS.VERSION%TYPE /*PK*/,
    p_encriptado   IN T_OPERACION_PARAMETROS.ENCRIPTADO%TYPE );

  FUNCTION get_default_row
  RETURN T_OPERACION_PARAMETROS%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_OPERACION_PARAMETROS_API;
/

