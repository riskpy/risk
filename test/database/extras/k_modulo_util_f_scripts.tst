PL/SQL Developer Test script 3.0
9
begin
  :result := k_modulo_util.f_scripts(i_id_modulo            => :i_id_modulo,
                                     i_motivo_modificacion  => :i_motivo_modificacion,
                                     i_incluir_parametros   => true,
                                     i_incluir_significados => true,
                                     i_incluir_errores      => true,
                                     i_incluir_aplicaciones => true,
                                     i_incluir_operaciones  => true);
end;
3
result
1
<BLOB>
4209
i_id_modulo
0
5
i_motivo_modificacion
0
5
0
