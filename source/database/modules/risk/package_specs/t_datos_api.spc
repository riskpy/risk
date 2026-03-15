CREATE OR REPLACE PACKAGE T_DATOS_API IS
  /*
  This is the API for the table T_DATOS.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-15 15:14:01"
    generated_by="JAVIER"
    p_table_name="T_DATOS"
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
    p_dml_view_name="T_DATOS_DML_V"
    p_dml_view_trigger_name="T_DATOS_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_DATOS_V"
    p_api_name="T_DATOS_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_DATOS%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_DATOS%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_tabla      IN T_DATOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE              DEFAULT NULL )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE create_row (
    p_tabla      IN T_DATOS.TABLA%TYPE                   /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE                   /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE              /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE              DEFAULT NULL );

  FUNCTION create_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE create_row (
    p_row IN T_DATOS%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE read_row (
    p_tabla                IN            T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo                IN            T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia           IN            T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido               OUT NOCOPY T_DATOS.CONTENIDO%TYPE,
    p_usuario_insercion       OUT NOCOPY T_DATOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_DATOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_DATOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_DATOS.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE );

  FUNCTION update_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE update_row (
    p_row IN T_DATOS%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/ /*FK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/ /*FK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_DATOS%ROWTYPE )
  RETURN T_DATOS%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_DATOS%ROWTYPE );

  FUNCTION get_contenido (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.CONTENIDO%TYPE;

  FUNCTION get_usuario_insercion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_DATOS.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_contenido (
    p_tabla      IN T_DATOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_DATOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_DATOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_DATOS.CONTENIDO%TYPE );

  FUNCTION get_default_row
  RETURN T_DATOS%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_DATOS_API;
/

