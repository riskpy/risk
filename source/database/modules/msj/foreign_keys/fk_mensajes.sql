alter table T_MENSAJES
  add constraint FK_MENSAJES_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
