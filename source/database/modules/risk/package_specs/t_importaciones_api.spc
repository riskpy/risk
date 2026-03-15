CREATE OR REPLACE PACKAGE T_IMPORTACIONES_API IS
  /*
  This is the API for the table T_IMPORTACIONES.

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
    p_table_name="T_IMPORTACIONES"
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
    p_dml_view_name="T_IMPORTACIONES_DML_V"
    p_dml_view_trigger_name="T_IMPORTACIONES_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_IMPORTACIONES_V"
    p_api_name="T_IMPORTACIONES_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_IMPORTACIONES%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_IMPORTACIONES%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE         DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE       DEFAULT NULL,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE      DEFAULT NULL,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE          DEFAULT NULL,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE           DEFAULT NULL,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE          DEFAULT NULL,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE         DEFAULT NULL,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE      DEFAULT NULL )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE create_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE         DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE       DEFAULT NULL,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE      DEFAULT NULL,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE          DEFAULT NULL,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE           DEFAULT NULL,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE          DEFAULT NULL,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE         DEFAULT NULL,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE      DEFAULT NULL );

  FUNCTION create_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE create_row (
    p_row IN T_IMPORTACIONES%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES%ROWTYPE;

  PROCEDURE read_row (
    p_id_importacion       IN            T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ /*FK*/,
    p_separador_campos        OUT NOCOPY T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo       OUT NOCOPY T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial           OUT NOCOPY T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla            OUT NOCOPY T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla           OUT NOCOPY T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo          OUT NOCOPY T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior       OUT NOCOPY T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE,
    p_usuario_insercion       OUT NOCOPY T_IMPORTACIONES.USUARIO_INSERCION%TYPE,
    p_fecha_insercion         OUT NOCOPY T_IMPORTACIONES.FECHA_INSERCION%TYPE,
    p_usuario_modificacion    OUT NOCOPY T_IMPORTACIONES.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion      OUT NOCOPY T_IMPORTACIONES.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE );

  FUNCTION update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE create_or_update_row (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_separador_campos  IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE,
    p_linea_inicial     IN T_IMPORTACIONES.LINEA_INICIAL%TYPE,
    p_nombre_tabla      IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE,
    p_truncar_tabla     IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE,
    p_proceso_previo    IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE )
  RETURN T_IMPORTACIONES.ID_IMPORTACION%TYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_IMPORTACIONES%ROWTYPE );

  FUNCTION get_separador_campos (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE;

  FUNCTION get_delimitador_campo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE;

  FUNCTION get_linea_inicial (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.LINEA_INICIAL%TYPE;

  FUNCTION get_nombre_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.NOMBRE_TABLA%TYPE;

  FUNCTION get_truncar_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE;

  FUNCTION get_proceso_previo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.PROCESO_PREVIO%TYPE;

  FUNCTION get_proceso_posterior (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/ )
  RETURN T_IMPORTACIONES.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_separador_campos (
    p_id_importacion   IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_separador_campos IN T_IMPORTACIONES.SEPARADOR_CAMPOS%TYPE );

  PROCEDURE set_delimitador_campo (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_delimitador_campo IN T_IMPORTACIONES.DELIMITADOR_CAMPO%TYPE );

  PROCEDURE set_linea_inicial (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_linea_inicial  IN T_IMPORTACIONES.LINEA_INICIAL%TYPE );

  PROCEDURE set_nombre_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_nombre_tabla   IN T_IMPORTACIONES.NOMBRE_TABLA%TYPE );

  PROCEDURE set_truncar_tabla (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_truncar_tabla  IN T_IMPORTACIONES.TRUNCAR_TABLA%TYPE );

  PROCEDURE set_proceso_previo (
    p_id_importacion IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_proceso_previo IN T_IMPORTACIONES.PROCESO_PREVIO%TYPE );

  PROCEDURE set_proceso_posterior (
    p_id_importacion    IN T_IMPORTACIONES.ID_IMPORTACION%TYPE /*PK*/,
    p_proceso_posterior IN T_IMPORTACIONES.PROCESO_POSTERIOR%TYPE );

  FUNCTION get_default_row
  RETURN T_IMPORTACIONES%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_IMPORTACIONES_API;
/

