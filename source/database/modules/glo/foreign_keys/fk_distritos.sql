alter table T_DISTRITOS
  add constraint FK_DISTRITOS_DEPARTAMENTOS foreign key (ID_DEPARTAMENTO)
  references T_DEPARTAMENTOS (ID_DEPARTAMENTO);
alter table T_DISTRITOS
  add constraint FK_DISTRITOS_PAISES foreign key (ID_PAIS)
  references T_PAISES (ID_PAIS);

