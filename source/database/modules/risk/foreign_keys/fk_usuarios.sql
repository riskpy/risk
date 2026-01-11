alter table T_USUARIOS
  add constraint FK_USUARIOS_PERSONAS foreign key (ID_PERSONA)
  references T_PERSONAS (ID_PERSONA);
alter table T_USUARIOS
  add constraint FK_USU_AUTENTICACION_ORIGENES foreign key (ORIGEN)
  references T_AUTENTICACION_ORIGENES (ID_AUTENTICACION_ORIGEN);
