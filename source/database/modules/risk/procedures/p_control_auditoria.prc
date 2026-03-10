create or replace procedure p_control_auditoria is
  -- Variables a utilizar
  vl_aplicacion_permitida varchar2(1);
  vl_aplicacion_bloqueada varchar2(1);
  vl_usuario_permitido    varchar2(1);

  -- Constantes
  cl_aplicaciones_permitidas constant varchar2(50) := 'AUDITORIA_APLICACIONES_PERMITIDAS_SIN_MOTIVO';
  cl_aplicaciones_bloqueadas constant varchar2(50) := 'AUDITORIA_APLICACIONES_BLOQUEADAS';
  cl_usuarios_permitidos     constant varchar2(50) := 'AUDITORIA_USUARIOS_PERMITIDOS';
begin
  vl_usuario_permitido := k_cadena.f_buscar_cadena(pin_buscar => user,
                                                   pin_cadena => k_util.f_valor_parametro(cl_usuarios_permitidos));

  if vl_usuario_permitido = 'N' then
    if k_sistema.f_aplicacion_modificacion is null then
      raise_application_error(-20100,
                              'Modificación no permitida: Se debe configurar la aplicación para modificar registros.');
    end if;
  
    -- Verificamos si la aplicación desde la que se está intentando puede realizarlo sin especificar motivo.
    vl_aplicacion_permitida := k_cadena.f_buscar_cadena(pin_buscar => k_sistema.f_aplicacion_modificacion,
                                                        pin_cadena => k_util.f_valor_parametro(cl_aplicaciones_permitidas));
    if vl_aplicacion_permitida = 'N' then
      vl_aplicacion_bloqueada := k_cadena.f_buscar_cadena(pin_buscar => k_sistema.f_aplicacion_modificacion,
                                                          pin_cadena => k_util.f_valor_parametro(cl_aplicaciones_bloqueadas));
    
      if vl_aplicacion_bloqueada = 'S' then
        raise_application_error(-20105,
                                'Modificación no permitida: La aplicación con la que está operando se encuentra bloqueada');
      end if;
    
      if k_sistema.f_es_produccion then
        if k_sistema.f_motivo_modificacion is null then
          raise_application_error(-20110,
                                  'Modificación no permitida: Debe ingresar un motivo para la modificación');
        end if;
      end if;
    end if;
  end if;
end;
/
