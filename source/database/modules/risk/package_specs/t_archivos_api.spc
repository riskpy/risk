CREATE OR REPLACE PACKAGE T_ARCHIVOS_API IS
  /*
  This is the API for the table T_ARCHIVOS.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-15 15:13:59"
    generated_by="JAVIER"
    p_table_name="T_ARCHIVOS"
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
    p_dml_view_name="T_ARCHIVOS_DML_V"
    p_dml_view_trigger_name="T_ARCHIVOS_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_ARCHIVOS_V"
    p_api_name="T_ARCHIVOS_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_ARCHIVOS%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_ARCHIVOS%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN VARCHAR2;

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
  RETURN T_ARCHIVOS%ROWTYPE;

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
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE         DEFAULT NULL );

  FUNCTION create_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE;

  PROCEDURE create_row (
    p_row IN T_ARCHIVOS%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS%ROWTYPE;

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
    p_fecha_modificacion      OUT NOCOPY T_ARCHIVOS.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

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
  RETURN T_ARCHIVOS%ROWTYPE;

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
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE );

  FUNCTION update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE;

  PROCEDURE update_row (
    p_row IN T_ARCHIVOS%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

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
  RETURN T_ARCHIVOS%ROWTYPE;

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
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_ARCHIVOS%ROWTYPE )
  RETURN T_ARCHIVOS%ROWTYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_ARCHIVOS%ROWTYPE );

  FUNCTION get_contenido (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.CONTENIDO%TYPE;

  FUNCTION get_url (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.URL%TYPE;

  FUNCTION get_checksum (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.CHECKSUM%TYPE;

  FUNCTION get_tamano (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.TAMANO%TYPE;

  FUNCTION get_nombre (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.NOMBRE%TYPE;

  FUNCTION get_extension (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.EXTENSION%TYPE;

  FUNCTION get_version_actual (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.VERSION_ACTUAL%TYPE;

  FUNCTION get_usuario_insercion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/ )
  RETURN T_ARCHIVOS.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_contenido (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_contenido  IN T_ARCHIVOS.CONTENIDO%TYPE );

  PROCEDURE set_url (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_url        IN T_ARCHIVOS.URL%TYPE );

  PROCEDURE set_checksum (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_checksum   IN T_ARCHIVOS.CHECKSUM%TYPE );

  PROCEDURE set_tamano (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_tamano     IN T_ARCHIVOS.TAMANO%TYPE );

  PROCEDURE set_nombre (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_nombre     IN T_ARCHIVOS.NOMBRE%TYPE );

  PROCEDURE set_extension (
    p_tabla      IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo      IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_extension  IN T_ARCHIVOS.EXTENSION%TYPE );

  PROCEDURE set_version_actual (
    p_tabla          IN T_ARCHIVOS.TABLA%TYPE /*PK*/,
    p_campo          IN T_ARCHIVOS.CAMPO%TYPE /*PK*/,
    p_referencia     IN T_ARCHIVOS.REFERENCIA%TYPE /*PK*/,
    p_version_actual IN T_ARCHIVOS.VERSION_ACTUAL%TYPE );

  FUNCTION get_default_row
  RETURN T_ARCHIVOS%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_ARCHIVOS_API;
/

