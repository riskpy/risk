CREATE OR REPLACE PACKAGE T_APLICACIONES_API IS
  /*
  This is the API for the table T_APLICACIONES.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-10 22:59:50"
    generated_by="JAVIER"
    p_table_name="T_APLICACIONES"
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
    p_dml_view_name="T_APLICACIONES_DML_V"
    p_dml_view_trigger_name="T_APLICACIONES_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_APLICACIONES_V"
    p_api_name="T_APLICACIONES_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_APLICACIONES%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_APLICACIONES%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE create_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ );

  FUNCTION create_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE create_row (
    p_row IN T_APLICACIONES%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES%ROWTYPE;

  PROCEDURE read_row (
    p_id_aplicacion        IN            T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_nombre                  OUT NOCOPY T_APLICACIONES.NOMBRE%TYPE,
    p_tipo                    OUT NOCOPY T_APLICACIONES.TIPO%TYPE,
    p_activo                  OUT NOCOPY T_APLICACIONES.ACTIVO%TYPE,
    p_detalle                 OUT NOCOPY T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio              OUT NOCOPY T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/,
    p_usuario_insercion       OUT NOCOPY T_APLICACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_APLICACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_APLICACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_APLICACIONES.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ );

  FUNCTION update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE update_row (
    p_row IN T_APLICACIONES%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE create_or_update_row (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE DEFAULT NULL /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE /*FK*/ );

  FUNCTION create_or_update_row (
    p_row IN T_APLICACIONES%ROWTYPE )
  RETURN T_APLICACIONES.ID_APLICACION%TYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_APLICACIONES%ROWTYPE );

  FUNCTION get_nombre (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.NOMBRE%TYPE;

  FUNCTION get_tipo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.TIPO%TYPE;

  FUNCTION get_activo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.ACTIVO%TYPE;

  FUNCTION get_detalle (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.DETALLE%TYPE;

  FUNCTION get_id_dominio (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.ID_DOMINIO%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/ )
  RETURN T_APLICACIONES.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_nombre (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_nombre        IN T_APLICACIONES.NOMBRE%TYPE );

  PROCEDURE set_tipo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_tipo          IN T_APLICACIONES.TIPO%TYPE );

  PROCEDURE set_activo (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_activo        IN T_APLICACIONES.ACTIVO%TYPE );

  PROCEDURE set_detalle (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_detalle       IN T_APLICACIONES.DETALLE%TYPE );

  PROCEDURE set_id_dominio (
    p_id_aplicacion IN T_APLICACIONES.ID_APLICACION%TYPE /*PK*/,
    p_id_dominio    IN T_APLICACIONES.ID_DOMINIO%TYPE );

END T_APLICACIONES_API;
/

