alter table T_CORREOS
  add constraint FK_CORREOS_USUARIOS foreign key (ID_USUARIO)
  references T_USUARIOS (ID_USUARIO);
