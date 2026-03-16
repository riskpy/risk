-- alter session set plsql_ccflags = 'mi_risk:true';
k_modulo;

select *
  from all_plsql_object_settings
 where type = 'PACKAGE'
   and owner = 'RISK'
   and name = 'K_MODULO';

begin
  dbms_preprocessor.print_post_processed_source('PACKAGE', 'RISK', 'K_MODULO');
end;

declare
  l_plsql_ccflags varchar2(4000);
begin
  select listagg('mi_' || lower(m.id_modulo) || ':true', ',') within group(order by m.id_modulo)
    into l_plsql_ccflags
    from t_modulos m
   where m.activo = 'S';

  execute immediate 'alter session set plsql_ccflags = ''' ||
                    l_plsql_ccflags || '''';
end;
