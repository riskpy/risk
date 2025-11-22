alter table T_FLUJO_PASOS
  add constraint FK_FLUJO_PASOS_FLUJOS foreign key (ID_FLUJO)
  references T_FLUJOS (ID_FLUJO);
