alter table T_REPORTES
  add constraint FK_REPORTES_OPERACIONES foreign key (ID_REPORTE)
  references T_OPERACIONES (ID_OPERACION);
