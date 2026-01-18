create or replace procedure p_configurar_modificacion(pin_aplicacion in varchar2,
                                                      pin_motivo     in varchar2 default null) is
begin
  k_sistema.p_configurar_modificacion(pin_aplicacion => pin_aplicacion,
                                      pin_motivo     => pin_motivo);
end;
/
