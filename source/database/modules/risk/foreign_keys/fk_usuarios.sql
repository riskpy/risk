alter table T_USUARIOS
  add constraint FK_USUARIOS_PERSONAS foreign key (ID_PERSONA)
  references T_PERSONAS (ID_PERSONA);
