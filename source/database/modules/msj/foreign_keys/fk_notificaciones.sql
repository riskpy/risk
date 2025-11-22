alter table T_NOTIFICACIONES
  add constraint FK_NOTIFICACIONES_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
