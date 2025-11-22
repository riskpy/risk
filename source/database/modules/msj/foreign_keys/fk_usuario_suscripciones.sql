alter table T_USUARIO_SUSCRIPCIONES
  add constraint FK_USU_SUS_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
