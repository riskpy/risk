alter table T_SESIONES
  add constraint FK_SESIONES_APLICACIONES foreign key (ID_APLICACION)
  references T_APLICACIONES (ID_APLICACION);
alter table T_SESIONES
  add constraint FK_SESIONES_DISPOSITIVOS foreign key (ID_DISPOSITIVO)
  references T_DISPOSITIVOS (ID_DISPOSITIVO);
alter table T_SESIONES
  add constraint FK_SESIONES_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
