alter table T_PERSONAS
  add constraint FK_PERSONAS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
