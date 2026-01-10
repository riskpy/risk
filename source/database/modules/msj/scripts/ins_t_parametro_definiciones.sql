prompt Importing table t_parametro_definiciones...
set feedback off
set define off

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'DIRECCION_CORREO_PRUEBAS', 'Dirección de correo electrónico para pruebas', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'DIRECCION_CORREO_REMITENTE', 'Dirección de correo del remitente para mensajería', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ENVIO_CORREOS_ACTIVO', 'Indica si está activo el envío de correos electrónicos (E-mail) (S/N)', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ENVIO_MENSAJES_ACTIVO', 'Indica si está activo el envío de mensajes de texto (SMS) (S/N)', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ENVIO_NOTIFICACIONES_ACTIVO', 'Indica si está activo el envío de notificaciones push (S/N)', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'NUMERO_TELEFONO_PRUEBAS', 'Número de teléfono para pruebas', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'NUMERO_TELEFONO_REMITENTE', 'Número de teléfono del remitente para mensajería', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'REGEXP_VALIDAR_DIRECCION_CORREO', 'Expresión Regular para validación de direcciones de correo electrónico', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'REGEXP_VALIDAR_NUMERO_TELEFONO', 'Expresión Regular para validación de números de teléfono', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'SUSCRIPCION_PRUEBAS', 'Tag o expresión destino para pruebas de notificaciones push', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'MENSAJERIA_CANTIDAD_INTENTOS_PERMITIDOS', 'Cantidad de intentos permitidos para envío de mensajes', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'DIRECCION_CORREO_MONITOREOS', 'Dirección de correo electrónico principal para monitoreos de conflictos', null, 'ID_PARAMETRO', 'S', null, 'MSJ', null, null, null, 'N', null, null, null, 'N');

prompt Done.
