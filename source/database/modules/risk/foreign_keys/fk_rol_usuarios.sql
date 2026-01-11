alter table T_ROL_USUARIOS
  add constraint FK_ROL_USUARIOS_ENTIDADES foreign key (ID_ENTIDAD)
  references T_ENTIDADES (ID_ENTIDAD);
alter table T_ROL_USUARIOS
  add constraint FK_ROL_USUARIOS_ROLES foreign key (ID_ROL)
  references T_ROLES (ID_ROL);
alter table T_ROL_USUARIOS
  add constraint FK_ROL_USUARIOS_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
alter table T_ROL_USUARIOS
  add constraint FK_ROL_USU_ENTIDAD_ROLES foreign key (ID_ENTIDAD, ID_ROL)
  references T_ENTIDAD_ROLES (ID_ENTIDAD, ID_ROL);
alter table T_ROL_USUARIOS
  add constraint FK_ROL_USU_ENTIDAD_USUARIOS foreign key (ID_ENTIDAD, ID_USUARIO, GRUPO)
  references T_ENTIDAD_USUARIOS (ID_ENTIDAD, ID_USUARIO, GRUPO);
