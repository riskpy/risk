alter table T_DOMINIOS
  add constraint FK_DOMINIOS_MODULOS foreign key (ID_MODULO)
  references T_MODULOS (ID_MODULO);
