prompt Importing table t_parametro_definiciones...
set feedback off
set define off

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'METODO_VALIDACION_CREDENCIALES', 'Método de validación de credenciales', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'CONFIRMACION_DIRECCION_CORREO', 'Indica si está activa la confirmación de correo electrónico de usuarios (S/N)', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ESTADOS_ACTIVOS_USUARIO', 'Estados de usuario válidos para inicio de sesión. Separadas por coma. Ej.: A,P', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'BASE_DATOS_PRODUCCION', 'Nombre de la Base de Datos del entorno de Producción', null, 'ID_PARAMETRO', 'S', null, 'GEN', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'CANTIDAD_MAXIMA_SESIONES_USUARIO', 'Cantidad máxima permitida de sesiones activas por usuario', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'CLAVE_ENCRIPTACION_DESENCRIPTACION', 'Clave para encriptación y desencriptación. Generar con la función k_clave.f_randombytes_hex', null, 'ID_PARAMETRO', 'S', null, 'GEN', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'CLAVE_VALIDACION_ACCESS_TOKEN', 'Clave de validación del Access Token. Generar con la función k_clave.f_randombytes_base64', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'NOMBRE_ROL_DEFECTO', 'Nombre del Rol que se agrega por defecto a un usuario cuando se registra', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'TIEMPO_EXPIRACION_ACCESS_TOKEN', 'Tiempo de expiración del Access Token en segundos', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'TIEMPO_EXPIRACION_REFRESH_TOKEN', 'Tiempo de expiración del Refresh Token en horas', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'URL_SERVICIOS_PRODUCCION', 'URL base de los Servicios Web del entorno de Producción', null, 'ID_PARAMETRO', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'PAGINACION_CANTIDAD_DEFECTO_POR_PAGINA', 'Cantidad por defecto de elementos por página en paginación de listas', null, 'ID_PARAMETRO', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'PAGINACION_CANTIDAD_MAXIMA_POR_PAGINA', 'Cantidad máxima permitida de elementos por página en paginación de listas', null, 'ID_PARAMETRO', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'GOOGLE_IDENTIFICADOR_CLIENTE', 'Identificador del cliente de los Servicios Web de Google', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'GOOGLE_EMISOR_TOKEN', 'Emisor del token de Google', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'REPORTE_FORMATO_SALIDA_DEFECTO', 'Formato de salida por defecto para reportes', null, 'ID_PARAMETRO', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'REGEXP_VALIDAR_ALIAS_USUARIO', 'Expresión Regular para validación de alias de usuario', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'TIEMPO_TOLERANCIA_VALIDAR_OTP', 'Tiempo de tolerancia para validación de OTP en segundos', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ZONA_HORARIA', 'Zona horaria del entorno de Producción', null, 'ID_PARAMETRO', 'S', null, 'GLO', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ID_IDIOMA_ISO', 'Código del Idioma por defecto según estándar ISO 639-1', null, 'ID_PARAMETRO', 'S', null, 'GLO', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'ID_PAIS_ISO', 'Código del País por defecto según estándar ISO 3166-1 alpha-2', null, 'ID_PARAMETRO', 'S', null, 'GLO', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_PARAMETROS', 'AUTENTICACION_CANTIDAD_INTENTOS_PERMITIDOS', 'Cantidad de intentos permitidos de autenticación antes del bloqueo de clave', null, 'ID_PARAMETRO', 'S', null, 'AUT', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'VERSION_MINIMA', 'Version minima de la aplicación', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'PLATAFORMA_NOTIFICACION', 'Plataforma para las notificaciones push de la aplicación', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'TIEMPO_EXPIRACION_REFRESH_TOKEN', 'Tiempo de expiración del Refresh Token en horas', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'TIEMPO_EXPIRACION_ACCESS_TOKEN', 'Tiempo de expiración del Access Token en segundos', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'VERSION_ACTUAL', 'Version actual de la aplicación', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

insert into t_parametro_definiciones (TABLA, ID_PARAMETRO, DESCRIPCION, ORDEN, NOMBRE_REFERENCIA, TIPO_DATO, OBSERVACION, ID_DOMINIO, TIPO_FILTRO, FORMATO, LONGITUD_MAXIMA, OBLIGATORIO, VALOR_DEFECTO, ETIQUETA, VALORES_POSIBLES, ENCRIPTADO)
values ('T_APLICACION_PARAMETROS', 'CLAVE', 'Clave de la aplicación', null, 'ID_APLICACION', 'S', null, 'API', null, null, null, 'N', null, null, null, 'N');

prompt Done.
