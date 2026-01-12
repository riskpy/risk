prompt Importing table t_aplicaciones...
set feedback off
set define off

insert into t_aplicaciones (ID_APLICACION, NOMBRE, TIPO, ACTIVO, DETALLE)
values ('MSJ', 'RISK MSJ', 'S', 'S', 'Servicio para envío de mensajes a los usuarios a través de Correo electrónico (E-mail), Mensaje de texto (SMS) y Notificación push');

prompt Done.
