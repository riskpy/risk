alter table T_USUARIO_CLAVES
  add constraint FK_USUARIO_CLAVES_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
