alter table T_CORREOS
  add constraint FK_CORREOS_CATEGORIAS foreign key (ID_CATEGORIA)
  references T_MENSAJERIA_CATEGORIAS (ID_CATEGORIA);
