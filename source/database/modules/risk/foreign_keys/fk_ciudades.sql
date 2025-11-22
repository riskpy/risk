alter table T_CIUDADES
  add constraint FK_CIUDADES_DEPARTAMENTOS foreign key (ID_DEPARTAMENTO)
  references T_DEPARTAMENTOS (ID_DEPARTAMENTO);
alter table T_CIUDADES
  add constraint FK_CIUDADES_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);
