CREATE OR REPLACE PACKAGE T_MONITOREOS_API IS
  /*
  This is the API for the table T_MONITOREOS.

  GENERATION OPTIONS
  - Must be in the lines 5-42 to be reusable by the generator
  - DO NOT TOUCH THIS until you know what you do
  - Read the docs under github.com/OraMUC/table-api-generator ;-)
  <options
    generator="OM_TAPIGEN"
    generator_version="0.6.3"
    generator_action="COMPILE_API"
    generated_at="2026-03-15 15:13:58"
    generated_by="JAVIER"
    p_table_name="T_MONITOREOS"
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
    p_dml_view_name="T_MONITOREOS_DML_V"
    p_dml_view_trigger_name="T_MONITOREOS_IOIUD"
    p_enable_one_to_one_view="TRUE"
    p_one_to_one_view_name="T_MONITOREOS_V"
    p_api_name="T_MONITOREOS_API"
    p_sequence_name=""
    p_exclude_column_list=""
    p_audit_column_mappings="created=FECHA_INSERCION, created_by=USUARIO_INSERCION, updated=FECHA_MODIFICACION, updated_by=USUARIO_MODIFICACION"
    p_audit_user_expression="substr(coalesce(k_sistema.f_usuario, user), 1, 300)"
    p_row_version_column_mapping=""
    p_tenant_column_mapping=""
    p_enable_custom_defaults="FALSE"
    p_custom_default_values=""/>
  */

  TYPE t_rows_tab          IS TABLE OF T_MONITOREOS%ROWTYPE;
  TYPE t_strong_ref_cursor IS REF CURSOR RETURN T_MONITOREOS%ROWTYPE;

  FUNCTION bulk_is_complete
  RETURN BOOLEAN;

  PROCEDURE set_bulk_limit (
    p_bulk_limit IN PLS_INTEGER );

  FUNCTION get_bulk_limit
  RETURN PLS_INTEGER;

  FUNCTION row_exists (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN BOOLEAN;

  FUNCTION row_exists_yn (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN VARCHAR2;

  FUNCTION create_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE                       DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE                              DEFAULT NULL,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE                        DEFAULT NULL,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE                             DEFAULT 'N' ,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE                       DEFAULT NULL,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE                       DEFAULT NULL,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE                          DEFAULT 3 ,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE               DEFAULT NULL,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE             DEFAULT NULL,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE   DEFAULT NULL,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE                 DEFAULT NULL,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE              DEFAULT NULL,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE                 DEFAULT 1 ,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE                 DEFAULT 'N' ,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE                      DEFAULT 'N' ,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE                         DEFAULT 'D' ,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE              DEFAULT 'N' ,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE                 DEFAULT 'N' ,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE                        DEFAULT NULL,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE                        DEFAULT NULL,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE                        DEFAULT NULL )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE create_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE                       DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE                              DEFAULT NULL,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE                        DEFAULT NULL,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE                             DEFAULT 'N' ,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE                       DEFAULT NULL,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE                       DEFAULT NULL,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE                          DEFAULT 3 ,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE               DEFAULT NULL,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE             DEFAULT NULL,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE     DEFAULT NULL,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE   DEFAULT NULL,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE                 DEFAULT NULL,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE              DEFAULT NULL,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE                 DEFAULT 1 ,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE                 DEFAULT 'N' ,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE                      DEFAULT 'N' ,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE                         DEFAULT 'D' ,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE              DEFAULT 'N' ,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE                 DEFAULT 'N' ,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE                        DEFAULT NULL,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE                        DEFAULT NULL,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE                        DEFAULT NULL );

  FUNCTION create_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE create_row (
    p_row IN T_MONITOREOS%ROWTYPE );

  FUNCTION create_rows (
    p_rows_tab IN t_rows_tab )
  RETURN t_rows_tab;

  PROCEDURE create_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION read_row (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS%ROWTYPE;

  PROCEDURE read_row (
    p_id_monitoreo                     IN            T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ /*FK*/,
    p_causa                               OUT NOCOPY T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                         OUT NOCOPY T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                              OUT NOCOPY T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                        OUT NOCOPY T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                        OUT NOCOPY T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                           OUT NOCOPY T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones                OUT NOCOPY T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion              OUT NOCOPY T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto      OUT NOCOPY T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto    OUT NOCOPY T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables                  OUT NOCOPY T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables               OUT NOCOPY T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo                  OUT NOCOPY T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion                  OUT NOCOPY T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                       OUT NOCOPY T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                          OUT NOCOPY T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado               OUT NOCOPY T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil                  OUT NOCOPY T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                         OUT NOCOPY T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                         OUT NOCOPY T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                         OUT NOCOPY T_MONITOREOS.COMENTARIOS%TYPE,
    p_usuario_insercion                   OUT NOCOPY T_MONITOREOS.USUARIO_INSERCION%TYPE,
    p_fecha_insercion                     OUT NOCOPY T_MONITOREOS.FECHA_INSERCION%TYPE,
    p_usuario_modificacion                OUT NOCOPY T_MONITOREOS.USUARIO_MODIFICACION%TYPE,
    p_fecha_modificacion                  OUT NOCOPY T_MONITOREOS.FECHA_MODIFICACION%TYPE );

  FUNCTION read_rows (
    p_ref_cursor IN t_strong_ref_cursor )
  RETURN t_rows_tab;

  FUNCTION update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE );

  FUNCTION update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE update_row (
    p_row IN T_MONITOREOS%ROWTYPE );

  PROCEDURE update_rows (
    p_rows_tab IN t_rows_tab );

  PROCEDURE delete_row (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ );

  PROCEDURE delete_rows (
    p_rows_tab IN t_rows_tab );

  FUNCTION create_or_update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE create_or_update_row (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE DEFAULT NULL /*PK*/ /*FK*/,
    p_causa                            IN T_MONITOREOS.CAUSA%TYPE,
    p_plan_accion                      IN T_MONITOREOS.PLAN_ACCION%TYPE,
    p_activo                           IN T_MONITOREOS.ACTIVO%TYPE,
    p_consulta_sql                     IN T_MONITOREOS.CONSULTA_SQL%TYPE,
    p_bloque_plsql                     IN T_MONITOREOS.BLOQUE_PLSQL%TYPE,
    p_prioridad                        IN T_MONITOREOS.PRIORIDAD%TYPE,
    p_cantidad_ejecuciones             IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE,
    p_fecha_ultima_ejecucion           IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE,
    p_cantidad_ejecuciones_conflicto   IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE,
    p_roles_responsables               IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE,
    p_usuarios_responsables            IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE,
    p_nivel_aviso_correo               IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE,
    p_aviso_notificacion               IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE,
    p_aviso_mensaje                    IN T_MONITOREOS.AVISO_MENSAJE%TYPE,
    p_frecuencia                       IN T_MONITOREOS.FRECUENCIA%TYPE,
    p_opera_sistema_cerrado            IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE,
    p_opera_dia_no_habil               IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE,
    p_hora_minima                      IN T_MONITOREOS.HORA_MINIMA%TYPE,
    p_hora_maxima                      IN T_MONITOREOS.HORA_MAXIMA%TYPE,
    p_comentarios                      IN T_MONITOREOS.COMENTARIOS%TYPE );

  FUNCTION create_or_update_row (
    p_row IN T_MONITOREOS%ROWTYPE )
  RETURN T_MONITOREOS.ID_MONITOREO%TYPE;

  PROCEDURE create_or_update_row (
    p_row IN T_MONITOREOS%ROWTYPE );

  FUNCTION get_causa (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CAUSA%TYPE;

  FUNCTION get_plan_accion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.PLAN_ACCION%TYPE;

  FUNCTION get_activo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.ACTIVO%TYPE;

  FUNCTION get_consulta_sql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CONSULTA_SQL%TYPE;

  FUNCTION get_bloque_plsql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.BLOQUE_PLSQL%TYPE;

  FUNCTION get_prioridad (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.PRIORIDAD%TYPE;

  FUNCTION get_cantidad_ejecuciones (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE;

  FUNCTION get_fecha_ultima_ejecucion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE;

  FUNCTION get_cantidad_ejecuciones_conflicto (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE;

  FUNCTION get_fecha_ultima_ejecucion_conflicto (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE;

  FUNCTION get_roles_responsables (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.ROLES_RESPONSABLES%TYPE;

  FUNCTION get_usuarios_responsables (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE;

  FUNCTION get_nivel_aviso_correo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE;

  FUNCTION get_aviso_notificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.AVISO_NOTIFICACION%TYPE;

  FUNCTION get_aviso_mensaje (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.AVISO_MENSAJE%TYPE;

  FUNCTION get_frecuencia (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FRECUENCIA%TYPE;

  FUNCTION get_opera_sistema_cerrado (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE;

  FUNCTION get_opera_dia_no_habil (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE;

  FUNCTION get_hora_minima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.HORA_MINIMA%TYPE;

  FUNCTION get_hora_maxima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.HORA_MAXIMA%TYPE;

  FUNCTION get_comentarios (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.COMENTARIOS%TYPE;

  FUNCTION get_usuario_insercion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIO_INSERCION%TYPE;

  FUNCTION get_fecha_insercion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_INSERCION%TYPE;

  FUNCTION get_usuario_modificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.USUARIO_MODIFICACION%TYPE;

  FUNCTION get_fecha_modificacion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/ )
  RETURN T_MONITOREOS.FECHA_MODIFICACION%TYPE;

  PROCEDURE set_causa (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_causa        IN T_MONITOREOS.CAUSA%TYPE );

  PROCEDURE set_plan_accion (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_plan_accion  IN T_MONITOREOS.PLAN_ACCION%TYPE );

  PROCEDURE set_activo (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_activo       IN T_MONITOREOS.ACTIVO%TYPE );

  PROCEDURE set_consulta_sql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_consulta_sql IN T_MONITOREOS.CONSULTA_SQL%TYPE );

  PROCEDURE set_bloque_plsql (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_bloque_plsql IN T_MONITOREOS.BLOQUE_PLSQL%TYPE );

  PROCEDURE set_prioridad (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_prioridad    IN T_MONITOREOS.PRIORIDAD%TYPE );

  PROCEDURE set_cantidad_ejecuciones (
    p_id_monitoreo         IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_cantidad_ejecuciones IN T_MONITOREOS.CANTIDAD_EJECUCIONES%TYPE );

  PROCEDURE set_fecha_ultima_ejecucion (
    p_id_monitoreo           IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION%TYPE );

  PROCEDURE set_cantidad_ejecuciones_conflicto (
    p_id_monitoreo                   IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_cantidad_ejecuciones_conflicto IN T_MONITOREOS.CANTIDAD_EJECUCIONES_CONFLICTO%TYPE );

  PROCEDURE set_fecha_ultima_ejecucion_conflicto (
    p_id_monitoreo                     IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_fecha_ultima_ejecucion_conflicto IN T_MONITOREOS.FECHA_ULTIMA_EJECUCION_CONFLICTO%TYPE );

  PROCEDURE set_roles_responsables (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_roles_responsables IN T_MONITOREOS.ROLES_RESPONSABLES%TYPE );

  PROCEDURE set_usuarios_responsables (
    p_id_monitoreo          IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_usuarios_responsables IN T_MONITOREOS.USUARIOS_RESPONSABLES%TYPE );

  PROCEDURE set_nivel_aviso_correo (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_nivel_aviso_correo IN T_MONITOREOS.NIVEL_AVISO_CORREO%TYPE );

  PROCEDURE set_aviso_notificacion (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_aviso_notificacion IN T_MONITOREOS.AVISO_NOTIFICACION%TYPE );

  PROCEDURE set_aviso_mensaje (
    p_id_monitoreo  IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_aviso_mensaje IN T_MONITOREOS.AVISO_MENSAJE%TYPE );

  PROCEDURE set_frecuencia (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_frecuencia   IN T_MONITOREOS.FRECUENCIA%TYPE );

  PROCEDURE set_opera_sistema_cerrado (
    p_id_monitoreo          IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_opera_sistema_cerrado IN T_MONITOREOS.OPERA_SISTEMA_CERRADO%TYPE );

  PROCEDURE set_opera_dia_no_habil (
    p_id_monitoreo       IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_opera_dia_no_habil IN T_MONITOREOS.OPERA_DIA_NO_HABIL%TYPE );

  PROCEDURE set_hora_minima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_hora_minima  IN T_MONITOREOS.HORA_MINIMA%TYPE );

  PROCEDURE set_hora_maxima (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_hora_maxima  IN T_MONITOREOS.HORA_MAXIMA%TYPE );

  PROCEDURE set_comentarios (
    p_id_monitoreo IN T_MONITOREOS.ID_MONITOREO%TYPE /*PK*/,
    p_comentarios  IN T_MONITOREOS.COMENTARIOS%TYPE );

  FUNCTION get_default_row
  RETURN T_MONITOREOS%ROWTYPE;
  /*
  Helper to get a prepopulated row with the table defaults from the dictionary.
  */

END T_MONITOREOS_API;
/

