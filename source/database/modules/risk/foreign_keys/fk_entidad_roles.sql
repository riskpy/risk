alter table T_ENTIDAD_ROLES
  add constraint FK_ENTIDAD_ROLES_ENTIDADES foreign key (ID_ENTIDAD)
  references T_ENTIDADES (ID_ENTIDAD);
alter table T_ENTIDAD_ROLES
  add constraint FK_ENTIDAD_ROLES_ROLES foreign key (ID_ROL)
  references T_ROLES (ID_ROL);
