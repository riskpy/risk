alter table T_PERSONAS
  add constraint FK_PERSONAS_DOCUMENTO_TIPOS foreign key (TIPO_DOCUMENTO)
  references T_DOCUMENTO_TIPOS (ID_DOCUMENTO_TIPO);
alter table T_PERSONAS
  add constraint FK_PERSONAS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
