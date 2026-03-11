CREATE OR REPLACE PACKAGE T_ENTIDAD_ROLES_API IS
  /*
  This is the API for the table T_ENTIDAD_ROLES.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-10 22:59:55"
    generated_by="JAVIER"
    p_table_name="T_ENTIDAD_ROLES"
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
    p_dml_view_name="T_ENTIDAD_ROLES_DML_V"
    p_dml_view_trigger_name="T_ENTIDAD_ROLES_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_ENTIDAD_ROLES_V"
    p_api_name="T_ENTIDAD_ROLES_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_ENTIDAD_ROLES%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_ENTIDAD_ROLES%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE create_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE );

  FUNCTION create_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE create_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE read_row (
    p_id_entidad                         IN            T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN            T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                                OUT NOCOPY T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas    OUT NOCOPY T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE,
    p_usuario_insercion                     OUT NOCOPY T_ENTIDAD_ROLES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion                       OUT NOCOPY T_ENTIDAD_ROLES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion                  OUT NOCOPY T_ENTIDAD_ROLES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion                    OUT NOCOPY T_ENTIDAD_ROLES.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE );

  FUNCTION update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/ /*FK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ /*FK*/,
    p_estado                             IN T_ENTIDAD_ROLES.ESTADO%TYPE,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE )
  RETURN T_ENTIDAD_ROLES%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_ENTIDAD_ROLES%ROWTYPE );

  FUNCTION get_estado (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.ESTADO%TYPE;

  FUNCTION get_cantidad_autorizaciones_requeridas (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/ )
  RETURN T_ENTIDAD_ROLES.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_estado (
    p_id_entidad IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol     IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/,
    p_estado     IN T_ENTIDAD_ROLES.ESTADO%TYPE );

  PROCEDURE set_cantidad_autorizaciones_requeridas (
    p_id_entidad                         IN T_ENTIDAD_ROLES.ID_ENTIDAD%TYPE /*PK*/,
    p_id_rol                             IN T_ENTIDAD_ROLES.ID_ROL%TYPE /*PK*/,
    p_cantidad_autorizaciones_requeridas IN T_ENTIDAD_ROLES.CANTIDAD_AUTORIZACIONES_REQUERIDAS%TYPE );

END T_ENTIDAD_ROLES_API;
/

