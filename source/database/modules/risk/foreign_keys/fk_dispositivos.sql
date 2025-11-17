alter table T_DISPOSITIVOS
  add constraint FK_DISPOSITIVOS_APLICACIONES foreign key (ID_APLICACION)
  references T_APLICACIONES (ID_APLICACION);
alter table T_DISPOSITIVOS
  add constraint FK_DISPOSITIVOS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
alter table T_DISPOSITIVOS
  add constraint FK_DISPOSITIVOS_IDIOMAS foreign key (ID_IDIOMA)
  references T_IDIOMAS (ID_IDIOMA);
