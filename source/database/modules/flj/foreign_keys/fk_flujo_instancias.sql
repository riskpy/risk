alter table T_FLUJO_INSTANCIAS
  add constraint FK_FLUJO_INSTANCIAS_FLUJOS foreign key (ID_FLUJO)
  references T_FLUJOS (ID_FLUJO);
alter table T_FLUJO_INSTANCIAS
  add constraint FK_FFLUJO_INSTANCIAS_USUARIO_INGRESO foreign key (USUARIO_INGRESO)
  references T_USUARIOS (ALIAS);
