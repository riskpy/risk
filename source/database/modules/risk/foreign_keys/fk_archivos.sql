alter table T_ARCHIVOS
  add constraint FK_ARC_ARCHIVO_DEFINICIONES foreign key (TABLA, CAMPO)
  references T_ARCHIVO_DEFINICIONES (TABLA, CAMPO);
