alter table T_MONITOREOS
  add constraint FK_MONITOREOS_OPERACIONES foreign key (ID_MONITOREO)
  references T_OPERACIONES (ID_OPERACION);
