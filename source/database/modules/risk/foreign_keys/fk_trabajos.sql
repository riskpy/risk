alter table T_TRABAJOS
  add constraint FK_TRABAJOS_OPERACIONES foreign key (ID_TRABAJO)
  references T_OPERACIONES (ID_OPERACION);
