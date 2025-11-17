alter table T_PARAMETROS
  add constraint FK_PARAMETROS_DOMINIOS foreign key (ID_DOMINIO)
  references T_DOMINIOS (ID_DOMINIO);
