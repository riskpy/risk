PL/SQL Developer Test script 3.0
26
declare
  l_audit_column_mappings varchar2(4000);
  l_audit_user_expression varchar2(4000);
begin
  l_audit_column_mappings := 'created=' ||
                             k_auditoria.g_nombre_campo_created ||
                             ', created_by=' ||
                             k_auditoria.g_nombre_campo_created_by ||
                             ', updated=' ||
                             k_auditoria.g_nombre_campo_updated ||
                             ', updated_by=' ||
                             k_auditoria.g_nombre_campo_updated_by;
  l_audit_user_expression := 'substr(coalesce(k_sistema.f_usuario, user), 1, 300)';

  om_tapigen.compile_api(p_table_name               => upper(:table_name),
                         p_owner                    => upper(:owner),
                         p_enable_insertion_of_rows => true,
                         p_enable_column_defaults   => true,
                         p_enable_update_of_rows    => true,
                         p_enable_deletion_of_rows  => true,
                         p_double_quote_names       => false,
                         p_enable_dml_view          => true,
                         p_enable_one_to_one_view   => true,
                         p_audit_column_mappings    => l_audit_column_mappings,
                         p_audit_user_expression    => l_audit_user_expression);
end;
2
table_name
0
5
owner
0
5
0
