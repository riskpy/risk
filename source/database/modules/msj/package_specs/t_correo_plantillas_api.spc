CREATE OR REPLACE PACKAGE T_CORREO_PLANTILLAS_API IS
  /*
  This is the API for the table T_CORREO_PLANTILLAS.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-15 15:14:05"
    generated_by="JAVIER"
    p_table_name="T_CORREO_PLANTILLAS"
    p_owner="RISK_MSJ"
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
    p_dml_view_name="T_CORREO_PLANTILLAS_DML_V"
    p_dml_view_trigger_name="T_CORREO_PLANTILLAS_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_CORREO_PLANTILLAS_V"
    p_api_name="T_CORREO_PLANTILLAS_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_CORREO_PLANTILLAS%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_CORREO_PLANTILLAS%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE           DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE                 DEFAULT NULL,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE            /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE                DEFAULT NULL,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE       ,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE     )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE create_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE           DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE                 DEFAULT NULL,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE                 DEFAULT 'N' ,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE            /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE                DEFAULT NULL,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE       ,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE     );

  FUNCTION create_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE create_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS%ROWTYPE;

  PROCEDURE read_row (
    p_id_plantilla         IN            T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_CORREO_PLANTILLAS.NOMBRE%TYPE,
    p_activo                  OUT NOCOPY T_CORREO_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria            OUT NOCOPY T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle                 OUT NOCOPY T_CORREO_PLANTILLAS.DETALLE%TYPE,
    p_plantilla_asunto        OUT NOCOPY T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE,
    p_plantilla_contenido     OUT NOCOPY T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_CORREO_PLANTILLAS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_CORREO_PLANTILLAS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_CORREO_PLANTILLAS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_CORREO_PLANTILLAS.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE update_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE );

  FUNCTION update_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE update_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE create_or_update_row (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE DEFAULT NULL /*PK*/,
    p_nombre              IN T_CORREO_PLANTILLAS.NOMBRE%TYPE,
    p_activo              IN T_CORREO_PLANTILLAS.ACTIVO%TYPE,
    p_id_categoria        IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE /*FK*/,
    p_detalle             IN T_CORREO_PLANTILLAS.DETALLE%TYPE,
    p_plantilla_asunto    IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE )
  RETURN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_CORREO_PLANTILLAS%ROWTYPE );

  FUNCTION get_nombre (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.NOMBRE%TYPE;

  FUNCTION get_activo (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.ACTIVO%TYPE;

  FUNCTION get_id_categoria (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE;

  FUNCTION get_detalle (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.DETALLE%TYPE;

  FUNCTION get_plantilla_asunto (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE;

  FUNCTION get_plantilla_contenido (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/ )
  RETURN T_CORREO_PLANTILLAS.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_nombre (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_nombre       IN T_CORREO_PLANTILLAS.NOMBRE%TYPE );

  PROCEDURE set_activo (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_activo       IN T_CORREO_PLANTILLAS.ACTIVO%TYPE );

  PROCEDURE set_id_categoria (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_id_categoria IN T_CORREO_PLANTILLAS.ID_CATEGORIA%TYPE );

  PROCEDURE set_detalle (
    p_id_plantilla IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_detalle      IN T_CORREO_PLANTILLAS.DETALLE%TYPE );

  PROCEDURE set_plantilla_asunto (
    p_id_plantilla     IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla_asunto IN T_CORREO_PLANTILLAS.PLANTILLA_ASUNTO%TYPE );

  PROCEDURE set_plantilla_contenido (
    p_id_plantilla        IN T_CORREO_PLANTILLAS.ID_PLANTILLA%TYPE /*PK*/,
    p_plantilla_contenido IN T_CORREO_PLANTILLAS.PLANTILLA_CONTENIDO%TYPE );

  FUNCTION get_default_row
  RETURN T_CORREO_PLANTILLAS%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_CORREO_PLANTILLAS_API;
/

