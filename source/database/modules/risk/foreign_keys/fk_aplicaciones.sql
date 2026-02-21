alter table T_APLICACIONES
  add constraint FK_APLICACIONES_DOMINIOS foreign key (ID_DOMINIO)
  references T_DOMINIOS (ID_DOMINIO);
