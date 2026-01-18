/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-------------------------------------------------------------------------------
*/

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Generation of docs started
prompt ===================================
prompt

prompt
prompt Deleting docs...
prompt -----------------------------------
prompt
plugin plsqldoc delete;

prompt
prompt Generating docs...
prompt -----------------------------------
prompt
plugin plsqldoc generate t_aplicaciones;
plugin plsqldoc generate t_aplicacion_parametros;
plugin plsqldoc generate t_archivos;
plugin plsqldoc generate t_archivos_hist;
plugin plsqldoc generate t_archivo_definiciones;
plugin plsqldoc generate t_autenticacion_origenes;
plugin plsqldoc generate t_autenticacion_tipos;
plugin plsqldoc generate t_barrios;
plugin plsqldoc generate t_ciudades;
plugin plsqldoc generate t_correos;
plugin plsqldoc generate t_correo_adjuntos;
plugin plsqldoc generate t_correo_plantillas;
plugin plsqldoc generate t_datos;
plugin plsqldoc generate t_dato_definiciones;
plugin plsqldoc generate t_departamentos;
plugin plsqldoc generate t_dispositivos;
plugin plsqldoc generate t_dispositivo_suscripciones;
plugin plsqldoc generate t_dispositivo_ubicaciones;
plugin plsqldoc generate t_documento_tipos;
plugin plsqldoc generate t_dominios;
plugin plsqldoc generate t_entidades;
plugin plsqldoc generate t_entidad_roles;
plugin plsqldoc generate t_entidad_usuarios;
plugin plsqldoc generate t_errores;
plugin plsqldoc generate t_flujos;
plugin plsqldoc generate t_flujo_instancias;
plugin plsqldoc generate t_flujo_instancia_aprobaciones;
plugin plsqldoc generate t_flujo_instancia_historial;
plugin plsqldoc generate t_flujo_instancia_pasos;
plugin plsqldoc generate t_flujo_pasos;
plugin plsqldoc generate t_flujo_transiciones;
plugin plsqldoc generate t_idiomas;
plugin plsqldoc generate t_importaciones;
plugin plsqldoc generate t_importacion_parametros;
plugin plsqldoc generate t_mensajeria_categorias;
plugin plsqldoc generate t_mensajes;
plugin plsqldoc generate t_mensajes_recibidos;
plugin plsqldoc generate t_mensaje_plantillas;
plugin plsqldoc generate t_migraciones;
plugin plsqldoc generate t_modulos;
plugin plsqldoc generate t_monedas;
plugin plsqldoc generate t_monitoreos;
plugin plsqldoc generate t_monitoreo_ejecuciones;
plugin plsqldoc generate t_notificaciones;
plugin plsqldoc generate t_notificacion_plantillas;
plugin plsqldoc generate t_operaciones;
plugin plsqldoc generate t_operacion_logs;
plugin plsqldoc generate t_operacion_parametros;
plugin plsqldoc generate t_paises;
plugin plsqldoc generate t_parametros;
plugin plsqldoc generate t_parametro_definiciones;
plugin plsqldoc generate t_permisos;
plugin plsqldoc generate t_personas;
plugin plsqldoc generate t_reportes;
plugin plsqldoc generate t_roles;
plugin plsqldoc generate t_rol_permisos;
plugin plsqldoc generate t_rol_usuarios;
plugin plsqldoc generate t_servicios;
plugin plsqldoc generate t_sesiones;
plugin plsqldoc generate t_significados;
plugin plsqldoc generate t_significado_dominios;
plugin plsqldoc generate t_trabajos;
plugin plsqldoc generate t_usuarios;
plugin plsqldoc generate t_usuario_claves;
plugin plsqldoc generate t_usuario_suscripciones;
plugin plsqldoc generate v_estado_flujo;
plugin plsqldoc generate v_flujo_aprobador;
plugin plsqldoc generate v_historial_aprobaciones;
plugin plsqldoc generate v_historial_instancia;
plugin plsqldoc generate v_monitoreo_datos;
plugin plsqldoc generate v_monitoreo_roles_responsables;
plugin plsqldoc generate v_monitoreo_usu_responsables;
plugin plsqldoc generate v_operacion_logs;
plugin plsqldoc generate v_pasos_en_progreso;
plugin plsqldoc generate v_proximos_pasos;
plugin plsqldoc generate v_roles_responsables_en_progreso;
plugin plsqldoc generate v_roles_responsables_paso;
plugin plsqldoc generate v_usuarios_responsables_paso;
plugin plsqldoc generate y_archivo;
plugin plsqldoc generate y_archivos;
plugin plsqldoc generate y_barrio;
plugin plsqldoc generate y_cadenas;
plugin plsqldoc generate y_ciudad;
plugin plsqldoc generate y_correo;
plugin plsqldoc generate y_dato;
plugin plsqldoc generate y_datos;
plugin plsqldoc generate y_departamento;
plugin plsqldoc generate y_dispositivo;
plugin plsqldoc generate y_error;
plugin plsqldoc generate y_lista;
plugin plsqldoc generate y_lista_parametros;
plugin plsqldoc generate y_mensaje;
plugin plsqldoc generate y_notificacion;
plugin plsqldoc generate y_objeto;
plugin plsqldoc generate y_objetos;
plugin plsqldoc generate y_pagina;
plugin plsqldoc generate y_pagina_parametros;
plugin plsqldoc generate y_pais;
plugin plsqldoc generate y_parametro;
plugin plsqldoc generate y_parametros;
plugin plsqldoc generate y_permiso;
plugin plsqldoc generate y_permisos;
plugin plsqldoc generate y_plantilla;
plugin plsqldoc generate y_respuesta;
plugin plsqldoc generate y_rol;
plugin plsqldoc generate y_sesion;
plugin plsqldoc generate y_significado;
plugin plsqldoc generate y_tipo_atributo;
plugin plsqldoc generate y_tipo_atributos;
plugin plsqldoc generate y_usuario;
plugin plsqldoc generate k_aplicacion;
plugin plsqldoc generate k_archivo;
plugin plsqldoc generate k_auditoria;
plugin plsqldoc generate k_autenticacion;
plugin plsqldoc generate k_autorizacion;
plugin plsqldoc generate k_cadena;
plugin plsqldoc generate k_clave;
plugin plsqldoc generate k_dato;
plugin plsqldoc generate k_dispositivo;
plugin plsqldoc generate k_dominio;
plugin plsqldoc generate k_entidad;
plugin plsqldoc generate k_error;
plugin plsqldoc generate k_flujo;
plugin plsqldoc generate k_flujo_util;
plugin plsqldoc generate k_html;
plugin plsqldoc generate k_importacion;
plugin plsqldoc generate k_json_util;
plugin plsqldoc generate k_lob_util;
plugin plsqldoc generate k_mensajeria;
plugin plsqldoc generate k_modulo;
plugin plsqldoc generate k_monitoreo;
plugin plsqldoc generate k_monitoreo_aut;
plugin plsqldoc generate k_objeto_util;
plugin plsqldoc generate k_operacion;
plugin plsqldoc generate k_operacion_util;
plugin plsqldoc generate k_parametro;
plugin plsqldoc generate k_reporte;
plugin plsqldoc generate k_reporte_gen;
plugin plsqldoc generate k_servicio;
plugin plsqldoc generate k_servicio_aut;
plugin plsqldoc generate k_servicio_gen;
plugin plsqldoc generate k_servicio_glo;
plugin plsqldoc generate k_servicio_msj;
plugin plsqldoc generate k_sesion;
plugin plsqldoc generate k_significado;
plugin plsqldoc generate k_significado_util;
plugin plsqldoc generate k_sistema;
plugin plsqldoc generate k_trabajo;
plugin plsqldoc generate k_usuario;
plugin plsqldoc generate k_util;
plugin plsqldoc generate f_procesar_reporte;
plugin plsqldoc generate f_procesar_servicio;
plugin plsqldoc generate p_configurar_modificacion;
plugin plsqldoc generate gb_archivos;
plugin plsqldoc generate gb_datos;
plugin plsqldoc generate gb_entidades;
plugin plsqldoc generate gb_errores_actualizar_clave;
plugin plsqldoc generate gb_flujo_instancia_pasos;
plugin plsqldoc generate gb_mensajes;
plugin plsqldoc generate gb_operaciones;
plugin plsqldoc generate gb_operacion_parametros;
plugin plsqldoc generate gb_personas;
plugin plsqldoc generate gb_reportes;
plugin plsqldoc generate gb_roles;
plugin plsqldoc generate gb_servicios;
plugin plsqldoc generate gb_sesiones;
plugin plsqldoc generate gb_trabajos;
plugin plsqldoc generate gb_usuarios;
plugin plsqldoc generate gf_archivos;
plugin plsqldoc generate gf_operaciones;

prompt
prompt Generating index...
prompt -----------------------------------
prompt
plugin plsqldoc rebuild;

prompt
prompt ===================================
prompt Generation of docs completed
prompt ===================================
prompt

