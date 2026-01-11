alter table T_ENTIDADES
  add constraint FK_ENT_AUTENTICACION_ORIGENES foreign key (ORIGEN)
  references T_AUTENTICACION_ORIGENES (ID_AUTENTICACION_ORIGEN);
alter table T_ENTIDADES
  add constraint FK_ENTIDADES_PERSONAS foreign key (ID_PERSONA)
  references T_PERSONAS (ID_PERSONA);
