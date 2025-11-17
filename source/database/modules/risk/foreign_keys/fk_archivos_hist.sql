alter table T_ARCHIVOS_HIST
  add constraint FK_ARC_HIS_ARC_DEFINICIONES foreign key (TABLA, CAMPO)
  references T_ARCHIVO_DEFINICIONES (TABLA, CAMPO);
