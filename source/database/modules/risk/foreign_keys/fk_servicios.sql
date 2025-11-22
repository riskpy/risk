alter table T_SERVICIOS
  add constraint FK_SERVICIOS_OPERACIONES foreign key (ID_SERVICIO)
  references T_OPERACIONES (ID_OPERACION);
