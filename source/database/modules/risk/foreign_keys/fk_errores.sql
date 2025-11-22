alter table T_ERRORES
  add constraint FK_ERRORES_DOMINIOS foreign key (ID_DOMINIO)
  references T_DOMINIOS (ID_DOMINIO);
alter table T_ERRORES
  add constraint FK_ERRORES_IDIOMAS foreign key (ID_IDIOMA)
  references T_IDIOMAS (ID_IDIOMA);
alter table T_ERRORES
  add constraint FK_ERRORES_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
