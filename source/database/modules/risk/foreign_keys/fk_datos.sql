alter table T_DATOS
  add constraint FK_DATOS_DATO_DEFINICIONES foreign key (TABLA, CAMPO)
  references T_DATO_DEFINICIONES (TABLA, CAMPO);
