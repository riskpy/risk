alter table T_ROL_PERMISOS
  add constraint FK_ROL_PERMISOS_PERMISOS foreign key (ID_PERMISO)
  references T_PERMISOS (ID_PERMISO);
alter table T_ROL_PERMISOS
  add constraint FK_ROL_PERMISOS_ROLES foreign key (ID_ROL)
  references T_ROLES (ID_ROL);
