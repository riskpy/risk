alter table T_DEPARTAMENTOS
  add constraint FK_DEPARTAMENTOS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
