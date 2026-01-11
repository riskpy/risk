alter table T_ENTIDAD_USUARIOS
  add constraint FK_ENTIDAD_USUARIOS_ENTIDADES foreign key (ID_ENTIDAD)
  references T_ENTIDADES (ID_ENTIDAD);
alter table T_ENTIDAD_USUARIOS
  add constraint FK_ENTIDAD_USUARIOS_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
