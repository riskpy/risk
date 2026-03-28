alter table T_ERRORES
  add constraint FK_ERRORES_DOMINIOS foreign key (ID_DOMINIO)
  references T_DOMINIOS (ID_DOMINIO);
