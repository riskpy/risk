alter table T_OPERACIONES
  add constraint FK_OPERACIONES_DOMINIOS foreign key (DOMINIO)
  references T_DOMINIOS (ID_DOMINIO);
