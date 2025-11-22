alter table T_ROL_USUARIOS
  add constraint FK_ROL_USUARIOS_ROLES foreign key (ID_ROL)
  references T_ROLES (ID_ROL);
alter table T_ROL_USUARIOS
  add constraint FK_ROL_USUARIOS_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
