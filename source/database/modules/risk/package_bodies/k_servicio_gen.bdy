create or replace package body k_servicio_gen is

  function version_sistema(i_parametros in y_parametros) return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Obteniendo versión del sistema';
    begin
      select version_actual
        into l_dato.contenido
        from t_modulos
       where id_modulo = k_modulo.c_id_risk;
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      'gen0001',
                                      'Error al obtener versión del sistema');
        raise k_operacion.ex_error_general;
    end;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function version_servicio(i_parametros in y_parametros) return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
    --
    l_servicio t_operaciones.nombre%type;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Obteniendo parámetros';
    l_servicio  := k_operacion.f_valor_parametro_string(i_parametros,
                                                        'servicio');
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    l_servicio is not null,
                                    'Debe ingresar servicio');
  
    l_rsp.lugar := 'Obteniendo versión del servicio ' || l_servicio;
    begin
      select version_actual
        into l_dato.contenido
        from t_operaciones
       where nombre = upper(l_servicio);
    exception
      when others then
        k_operacion.p_respuesta_error(l_rsp,
                                      'gen0001',
                                      'Error al obtener versión del servicio ' ||
                                      l_servicio);
        raise k_operacion.ex_error_general;
    end;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function valor_parametro(i_parametros in y_parametros) return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'parametro') is not null,
                                    'Debe ingresar parametro');
  
    l_rsp.lugar      := 'Obteniendo valor del parametro';
    l_dato.contenido := k_util.f_valor_parametro(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'parametro'));
  
    if l_dato.contenido is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    'gen0001',
                                    'Parametro inexistente');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function significado_codigo(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp  y_respuesta;
    l_dato y_dato;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'dominio') is not null,
                                    'Debe ingresar dominio');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'codigo') is not null,
                                    'Debe ingresar codigo');
  
    l_rsp.lugar      := 'Obteniendo significado';
    l_dato.contenido := k_significado.f_significado_codigo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                'dominio'),
                                                           k_operacion.f_valor_parametro_string(i_parametros,
                                                                                                'codigo'));
  
    if l_dato.contenido is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    'gen0001',
                                    'Significado inexistente');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function listar_significados(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_significado;
  
    cursor cr_elementos(i_dominio in varchar2) is
      select a.dominio, a.codigo, a.significado, a.referencia, a.activo
        from t_significados a
       where a.dominio = i_dominio
       order by a.significado;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'dominio')) loop
      l_elemento             := new y_significado();
      l_elemento.dominio     := ele.dominio;
      l_elemento.codigo      := ele.codigo;
      l_elemento.significado := ele.significado;
      l_elemento.referencia  := ele.referencia;
      l_elemento.activo      := ele.activo;
    
      l_elementos.extend;
      l_elementos(l_elementos.count) := l_elemento;
    end loop;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               k_servicio.f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function listar_errores(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_error;
    l_id_idioma t_idiomas.id_idioma%type;
    l_id_pais   t_paises.id_pais%type;
  
    cursor cr_elementos(i_clave in varchar2) is
      select a.clave, a.mensaje
        from t_errores a
       where a.clave = nvl(i_clave, a.clave)
         and nvl(a.id_idioma, nvl(l_id_idioma, -1)) = nvl(l_id_idioma, -1)
         and nvl(a.id_pais, nvl(l_id_pais, -1)) = nvl(l_id_pais, -1)
       order by a.clave,
                decode(a.clave, null, 0, 1) +
                decode(a.id_idioma, null, 0, 1) +
                decode(a.id_pais, null, 0, 1) desc;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    l_id_idioma := k_sistema.f_idioma;
    l_id_pais   := k_sistema.f_pais;
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_string(i_parametros,
                                                                 'clave')) loop
      l_elemento         := new y_error();
      l_elemento.clave   := ele.clave;
      l_elemento.mensaje := ele.mensaje;
    
      l_elementos.extend;
      l_elementos(l_elementos.count) := l_elemento;
    end loop;
  
    l_pagina := k_servicio.f_paginar_elementos(l_elementos,
                                               k_servicio.f_pagina_parametros(i_parametros));
  
    k_operacion.p_respuesta_ok(l_rsp, l_pagina);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function recuperar_archivo(i_parametros in y_parametros) return y_respuesta is
    l_rsp     y_respuesta;
    l_archivo y_archivo;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tabla') is not null,
                                    'Debe ingresar tabla');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'campo') is not null,
                                    'Debe ingresar campo');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'referencia') is not null,
                                    'Debe ingresar referencia');
  
    l_rsp.lugar := 'Recuperando archivo';
    l_archivo   := k_archivo.f_recuperar_archivo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'tabla'),
                                                 k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'campo'),
                                                 k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'referencia'),
                                                 k_operacion.f_valor_parametro_number(i_parametros,
                                                                                      'version'));
  
    if (l_archivo.contenido is null or
       dbms_lob.getlength(l_archivo.contenido) = 0) and
       l_archivo.url is null then
      k_operacion.p_respuesta_error(l_rsp,
                                    'gen0001',
                                    'Archivo inexistente');
      raise k_operacion.ex_error_general;
    end if;
  
    k_operacion.p_respuesta_ok(l_rsp, l_archivo);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function guardar_archivo(i_parametros in y_parametros) return y_respuesta is
    l_rsp     y_respuesta;
    l_archivo y_archivo;
  begin
    -- Inicializa respuesta
    l_rsp := new y_respuesta();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'tabla') is not null,
                                    'Debe ingresar tabla');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'campo') is not null,
                                    'Debe ingresar campo');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'referencia') is not null,
                                    'Debe ingresar referencia');
  
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_object(i_parametros,
                                                                         'archivo') is not null,
                                    'Debe ingresar archivo');
    l_archivo := treat(k_operacion.f_valor_parametro_object(i_parametros,
                                                            'archivo') as
                       y_archivo);
  
    l_rsp.lugar := 'Guardando archivo';
    k_archivo.p_guardar_archivo(k_operacion.f_valor_parametro_string(i_parametros,
                                                                     'tabla'),
                                k_operacion.f_valor_parametro_string(i_parametros,
                                                                     'campo'),
                                k_operacion.f_valor_parametro_string(i_parametros,
                                                                     'referencia'),
                                l_archivo);
  
    k_operacion.p_respuesta_ok(l_rsp);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

  function recuperar_texto(i_parametros in y_parametros) return y_respuesta is
    l_rsp     y_respuesta;
    l_dato    y_dato;
    l_archivo y_archivo;
  begin
    -- Inicializa respuesta
    l_rsp  := new y_respuesta();
    l_dato := new y_dato();
  
    l_rsp.lugar := 'Validando parametros';
    k_operacion.p_validar_parametro(l_rsp,
                                    k_operacion.f_valor_parametro_string(i_parametros,
                                                                         'referencia') is not null,
                                    'Debe ingresar referencia');
  
    l_rsp.lugar := 'Recuperando texto';
    l_archivo   := k_archivo.f_recuperar_archivo(k_archivo.c_carpeta_textos,
                                                 'ARCHIVO',
                                                 k_operacion.f_valor_parametro_string(i_parametros,
                                                                                      'referencia'));
  
    if l_archivo.contenido is null or
       dbms_lob.getlength(l_archivo.contenido) = 0 then
      k_operacion.p_respuesta_error(l_rsp, 'gen0001', 'Texto inexistente');
      raise k_operacion.ex_error_general;
    end if;
  
    l_dato.contenido := k_util.blob_to_clob(l_archivo.contenido);
  
    k_operacion.p_respuesta_ok(l_rsp, l_dato);
    return l_rsp;
  exception
    when k_operacion.ex_error_parametro then
      return l_rsp;
    when k_operacion.ex_error_general then
      return l_rsp;
    when others then
      k_operacion.p_respuesta_excepcion(l_rsp,
                                        utl_call_stack.error_number(1),
                                        utl_call_stack.error_msg(1),
                                        dbms_utility.format_error_stack);
      return l_rsp;
  end;

end;
/

