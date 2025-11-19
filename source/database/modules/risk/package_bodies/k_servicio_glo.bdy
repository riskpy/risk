create or replace package body k_servicio_glo is

  function listar_paises(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_pais;
  
    cursor cr_elementos(i_id_pais in number) is
      select p.id_pais,
             p.nombre,
             p.iso_alpha_2,
             p.iso_alpha_3,
             p.iso_numeric
        from t_paises p
       where p.id_pais = nvl(i_id_pais, p.id_pais)
       order by p.nombre;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_pais')) loop
      l_elemento             := new y_pais();
      l_elemento.id_pais     := ele.id_pais;
      l_elemento.nombre      := ele.nombre;
      l_elemento.iso_alpha_2 := ele.iso_alpha_2;
      l_elemento.iso_alpha_3 := ele.iso_alpha_3;
      l_elemento.iso_numeric := ele.iso_numeric;
    
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

  function listar_departamentos(i_parametros in y_parametros)
    return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_departamento;
  
    cursor cr_elementos(i_id_departamento in number,
                        i_id_pais         in number) is
      select a.id_departamento, a.nombre, a.id_pais
        from t_departamentos a
       where a.id_departamento = nvl(i_id_departamento, a.id_departamento)
         and a.id_pais = nvl(i_id_pais, a.id_pais)
       order by a.nombre;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_departamento'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_pais')) loop
      l_elemento                 := new y_departamento();
      l_elemento.id_departamento := ele.id_departamento;
      l_elemento.nombre          := ele.nombre;
      l_elemento.id_pais         := ele.id_pais;
    
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

  function listar_ciudades(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_ciudad;
  
    cursor cr_elementos(i_id_ciudad       in number,
                        i_id_pais         in number,
                        i_id_departamento in number) is
      select a.id_ciudad, a.nombre, a.id_pais, a.id_departamento
        from t_ciudades a
       where a.id_ciudad = nvl(i_id_ciudad, a.id_ciudad)
         and a.id_pais = nvl(i_id_pais, a.id_pais)
         and a.id_departamento = nvl(i_id_departamento, a.id_departamento)
       order by a.nombre;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_ciudad'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_pais'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_departamento')) loop
      l_elemento                 := new y_ciudad();
      l_elemento.id_ciudad       := ele.id_ciudad;
      l_elemento.nombre          := ele.nombre;
      l_elemento.id_pais         := ele.id_pais;
      l_elemento.id_departamento := ele.id_departamento;
    
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

  function listar_barrios(i_parametros in y_parametros) return y_respuesta is
    l_rsp       y_respuesta;
    l_pagina    y_pagina;
    l_elementos y_objetos;
    l_elemento  y_barrio;
  
    cursor cr_elementos(i_id_barrio       in number,
                        i_id_pais         in number,
                        i_id_departamento in number,
                        i_id_ciudad       in number) is
      select a.id_barrio,
             a.nombre,
             a.id_pais,
             a.id_departamento,
             a.id_ciudad
        from t_barrios a
       where a.id_barrio = nvl(i_id_barrio, a.id_barrio)
         and a.id_pais = nvl(i_id_pais, a.id_pais)
         and a.id_departamento = nvl(i_id_departamento, a.id_departamento)
         and a.id_ciudad = nvl(i_id_ciudad, a.id_ciudad)
       order by a.nombre;
  begin
    -- Inicializa respuesta
    l_rsp       := new y_respuesta();
    l_elementos := new y_objetos();
  
    for ele in cr_elementos(k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_barrio'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_pais'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_departamento'),
                            k_operacion.f_valor_parametro_number(i_parametros,
                                                                 'id_ciudad')) loop
      l_elemento                 := new y_barrio();
      l_elemento.id_barrio       := ele.id_barrio;
      l_elemento.nombre          := ele.nombre;
      l_elemento.id_pais         := ele.id_pais;
      l_elemento.id_departamento := ele.id_departamento;
      l_elemento.id_ciudad       := ele.id_ciudad;
    
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

end;
/
