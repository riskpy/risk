alter table T_CORREO_ADJUNTOS
  add constraint FK_CORREO_ADJUNTO_CORREOS foreign key (ID_CORREO)
  references T_CORREOS (ID_CORREO);
