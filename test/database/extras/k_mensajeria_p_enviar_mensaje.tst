PL/SQL Developer Test script 3.0
7
begin
  -- Call the procedure
  k_mensajeria.p_enviar_mensaje(i_id_plantilla    => :i_id_plantilla,
                                i_datos_extra     => :i_datos_extra,
                                i_id_usuario      => :i_id_usuario,
                                i_numero_telefono => :i_numero_telefono);
end;
4
i_id_plantilla
1
PLANTILLA_DEMO
5
i_datos_extra
1
{"entidad":"Entidad de Prueba"}
5
i_id_usuario
1
1
4
i_numero_telefono
1
0972000000
5
0
