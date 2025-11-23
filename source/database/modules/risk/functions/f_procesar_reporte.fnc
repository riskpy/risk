create or replace function f_procesar_reporte(i_nombre     in varchar2,
                                              i_dominio    in varchar2,
                                              i_parametros in clob,
                                              i_contexto   in clob default null,
                                              i_version    in varchar2 default null)
  return clob is
begin
  return k_reporte.f_procesar_reporte(i_nombre     => i_nombre,
                                      i_dominio    => i_dominio,
                                      i_parametros => i_parametros,
                                      i_contexto   => i_contexto,
                                      i_version    => i_version);
end;
/
