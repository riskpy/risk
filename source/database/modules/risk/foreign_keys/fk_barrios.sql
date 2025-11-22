alter table T_BARRIOS
  add constraint FK_BARRIOS_CIUDADES foreign key (ID_CIUDAD)
  references T_CIUDADES (ID_CIUDAD);
alter table T_BARRIOS
  add constraint FK_BARRIOS_DEPARTAMENTOS foreign key (ID_DEPARTAMENTO)
  references T_DEPARTAMENTOS (ID_DEPARTAMENTO);
alter table T_BARRIOS
  add constraint FK_BARRIOS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
