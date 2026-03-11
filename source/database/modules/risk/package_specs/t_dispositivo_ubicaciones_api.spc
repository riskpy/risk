CREATE OR REPLACE PACKAGE T_DISPOSITIVO_UBICACIONES_API IS
  /*
  This is the API for the table T_DISPOSITIVO_UBICACIONES.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-10 22:59:54"
    generated_by="JAVIER"
    p_table_name="T_DISPOSITIVO_UBICACIONES"
    p_owner="RISK_RISK"
    p_enable_insertion_of_rows="TRUE"
    p_enable_column_defaults="FALSE"
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
    p_dml_view_name="T_DISPOSITIVO_UBICACIONES_DML_V"
    p_dml_view_trigger_name="T_DISPOSITIVO_UBICACIONES_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_DISPOSITIVO_UBICACIONES_V"
    p_api_name="T_DISPOSITIVO_UBICACIONES_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_DISPOSITIVO_UBICACIONES%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE create_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE );

  FUNCTION create_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE create_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE read_row (
    p_id_dispositivo       IN            T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden                IN            T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha                   OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud                 OUT NOCOPY T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud                OUT NOCOPY T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE,
    p_usuario_insercion       OUT NOCOPY T_DISPOSITIVO_UBICACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DISPOSITIVO_UBICACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DISPOSITIVO_UBICACIONES.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE );

  FUNCTION update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/ /*FK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE )
  RETURN T_DISPOSITIVO_UBICACIONES%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_DISPOSITIVO_UBICACIONES%ROWTYPE );

  FUNCTION get_fecha (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE;

  FUNCTION get_latitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE;

  FUNCTION get_longitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/ )
  RETURN T_DISPOSITIVO_UBICACIONES.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_fecha (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_fecha          IN T_DISPOSITIVO_UBICACIONES.FECHA%TYPE );

  PROCEDURE set_latitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_latitud        IN T_DISPOSITIVO_UBICACIONES.LATITUD%TYPE );

  PROCEDURE set_longitud (
    p_id_dispositivo IN T_DISPOSITIVO_UBICACIONES.ID_DISPOSITIVO%TYPE /*PK*/,
    p_orden          IN T_DISPOSITIVO_UBICACIONES.ORDEN%TYPE /*PK*/,
    p_longitud       IN T_DISPOSITIVO_UBICACIONES.LONGITUD%TYPE );

END T_DISPOSITIVO_UBICACIONES_API;
/

