alter table T_MONEDAS
  add constraint FK_MONEDAS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
