create or replace package body k_parametro is

  function f_parametro_definicion(i_tabla        in varchar2,
                                  i_id_parametro in varchar2)
    return t_parametro_definiciones%rowtype is
    rw_parametro_definicion t_parametro_definiciones%rowtype;
  begin
    begin
      select a.*
        into rw_parametro_definicion
        from t_parametro_definiciones a
       where a.tabla = i_tabla
         and a.id_parametro = i_id_parametro;
    exception
      when no_data_found then
        rw_parametro_definicion := null;
      when others then
        rw_parametro_definicion := null;
    end;
    return rw_parametro_definicion;
  end;

  function f_validar_parametro(i_parametro_definicion in ry_datos_definicion_parametro,
                               i_parametro            in json_element_t,
                               i_parametros           in json_object_t)
    return anydata is
    l_valor        anydata;
    l_json_object  json_object_t;
    l_json_element json_element_t;
  begin
    l_json_object  := i_parametros;
    l_json_element := i_parametro;
  
    /*if i_parametro_definicion.obligatorio = 'S' then
      if not l_json_object.has(i_parametro_definicion.nombre) then
        raise_application_error(-20000,
                                k_error.f_mensaje_error('ora0003',
                                                        nvl(i_parametro_definicion.etiqueta,
                                                            i_parametro_definicion.nombre)));
      else
        if l_json_element.is_null then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      end if;
    end if;*/
  
    case i_parametro_definicion.tipo_dato
    
      when c_tipo_dato_string then
        -- String
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_string then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        if i_parametro_definicion.encriptado = 'S' then
          begin
            l_valor := anydata.convertvarchar2(k_util.decrypt(l_json_object.get_string(i_parametro_definicion.nombre)));
          exception
            when value_error then
              raise_application_error(-20000,
                                      k_error.f_mensaje_error('ora0008',
                                                              nvl(i_parametro_definicion.etiqueta,
                                                                  i_parametro_definicion.nombre)));
            when others then
              raise_application_error(-20000,
                                      k_error.f_mensaje_error('ora0009',
                                                              nvl(i_parametro_definicion.etiqueta,
                                                                  i_parametro_definicion.nombre)));
          end;
        else
          l_valor := anydata.convertvarchar2(l_json_object.get_string(i_parametro_definicion.nombre));
        end if;
        if l_valor.accessvarchar2 is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertvarchar2(i_parametro_definicion.valor_defecto);
        end if;
        if l_valor.accessvarchar2 is null and
           i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
        if i_parametro_definicion.longitud_maxima is not null and
           nvl(length(l_valor.accessvarchar2), 0) >
           i_parametro_definicion.longitud_maxima then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0006',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre),
                                                          to_char(i_parametro_definicion.longitud_maxima)));
        end if;
        if i_parametro_definicion.valores_posibles is not null and
           l_valor.accessvarchar2 is not null and
           not k_significado.f_existe_codigo(i_parametro_definicion.valores_posibles,
                                             l_valor.accessvarchar2) then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0007',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_number then
        -- Number
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_number then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        l_valor := anydata.convertnumber(l_json_object.get_number(i_parametro_definicion.nombre));
        if l_valor.accessnumber is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertnumber(to_number(i_parametro_definicion.valor_defecto));
        end if;
        if l_valor.accessnumber is null and
           i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
        if i_parametro_definicion.longitud_maxima is not null and
           nvl(length(to_char(abs(trunc(l_valor.accessnumber)))), 0) >
           i_parametro_definicion.longitud_maxima then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0006',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre),
                                                          to_char(i_parametro_definicion.longitud_maxima)));
        end if;
        if i_parametro_definicion.valores_posibles is not null and
           l_valor.accessnumber is not null and not
            k_significado.f_existe_codigo(i_parametro_definicion.valores_posibles,
                                                                               to_char(l_valor.accessnumber)) then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0007',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_boolean then
        -- Boolean
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_boolean then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        l_valor := anydata.convertnumber(sys.diutil.bool_to_int(l_json_object.get_boolean(i_parametro_definicion.nombre)));
        if l_valor.accessnumber is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertnumber(to_number(i_parametro_definicion.valor_defecto));
        end if;
        if l_valor.accessnumber is null and
           i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_date then
        -- Date
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_string /*l_json_element.is_date*/
         then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        l_valor := anydata.convertdate(l_json_object.get_date(i_parametro_definicion.nombre));
        if l_valor.accessdate is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertdate(to_date(i_parametro_definicion.valor_defecto,
                                                 i_parametro_definicion.formato));
        end if;
        if l_valor.accessdate is null and
           i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_object then
        -- Object
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_object then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        if l_json_element is not null and l_json_element.is_object then
          l_valor := k_objeto_util.json_to_objeto(l_json_element.to_clob,
                                                  i_parametro_definicion.formato);
        end if;
      
        if l_valor is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := k_objeto_util.json_to_objeto(i_parametro_definicion.valor_defecto,
                                                  i_parametro_definicion.formato);
        end if;
        if l_valor is null and i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_json_object then
        -- JSON Object
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_object then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        if l_json_element is not null and l_json_element.is_object then
          l_valor := anydata.convertclob(l_json_element.to_clob);
        end if;
      
        if l_valor is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertclob(json_object_t.parse(i_parametro_definicion.valor_defecto).to_clob);
        end if;
        if l_valor is null and i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_json_array then
        -- JSON Array
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_array then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        if l_json_element is not null and l_json_element.is_array then
          l_valor := anydata.convertclob(l_json_element.to_clob);
        end if;
      
        if l_valor is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertclob(json_array_t.parse(i_parametro_definicion.valor_defecto).to_clob);
        end if;
        if l_valor is null and i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      when c_tipo_dato_clob then
        -- CLOB
        if l_json_element is not null and not l_json_element.is_null and
           not l_json_element.is_string then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0005',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
        if i_parametro_definicion.encriptado = 'S' then
          begin
            l_valor := anydata.convertclob(k_util.decrypt(l_json_object.get_string(i_parametro_definicion.nombre)));
          exception
            when value_error then
              raise_application_error(-20000,
                                      k_error.f_mensaje_error('ora0008',
                                                              nvl(i_parametro_definicion.etiqueta,
                                                                  i_parametro_definicion.nombre)));
            when others then
              raise_application_error(-20000,
                                      k_error.f_mensaje_error('ora0009',
                                                              nvl(i_parametro_definicion.etiqueta,
                                                                  i_parametro_definicion.nombre)));
          end;
        else
          l_valor := anydata.convertclob(l_json_object.get_string(i_parametro_definicion.nombre));
        end if;
        if l_valor.accessvarchar2 is null and
           i_parametro_definicion.valor_defecto is not null then
          l_valor := anydata.convertclob(i_parametro_definicion.valor_defecto);
        end if;
        if l_valor.accessvarchar2 is null and
           i_parametro_definicion.obligatorio = 'S' then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0004',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
        if i_parametro_definicion.longitud_maxima is not null and
           nvl(length(l_valor.accessvarchar2), 0) >
           i_parametro_definicion.longitud_maxima then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0006',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre),
                                                          to_char(i_parametro_definicion.longitud_maxima)));
        end if;
        if i_parametro_definicion.valores_posibles is not null and
           l_valor.accessvarchar2 is not null and
           not k_significado.f_existe_codigo(i_parametro_definicion.valores_posibles,
                                             l_valor.accessvarchar2) then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0007',
                                                          nvl(i_parametro_definicion.etiqueta,
                                                              i_parametro_definicion.nombre)));
        end if;
      
      else
        raise_application_error(-20000,
                                k_error.f_mensaje_error('ora0002',
                                                        'parámetro',
                                                        nvl(i_parametro_definicion.etiqueta,
                                                            i_parametro_definicion.nombre)));
      
    end case;
  
    return l_valor;
  end;

  function f_procesar_parametros(i_parametros in clob,
                                 -- OPERACION
                                 i_id_operacion in number default null,
                                 i_version      in varchar2 default null,
                                 -- PARAMETRO
                                 i_tabla       in varchar2 default null,
                                 i_tipo_filtro in varchar2 default null)
    return y_parametros is
    l_parametros           y_parametros;
    l_parametro            y_parametro;
    l_json_object          json_object_t;
    l_json_element         json_element_t;
    l_parametro_definicion ry_datos_definicion_parametro;
    c_id_ope_par_automaticos constant pls_integer := 1000;
    c_tipo_operacion         constant varchar2(10) := 'OPERACION';
    c_tipo_parametro         constant varchar2(10) := 'PARAMETRO';
  
    cursor cr_parametros is
      select x.*
        from ( -- OPERACION
              select c_tipo_operacion tipo,
                      lower(op.nombre) nombre,
                      op.orden,
                      op.activo,
                      op.tipo_dato,
                      op.formato,
                      op.longitud_maxima,
                      op.obligatorio,
                      op.valor_defecto,
                      op.etiqueta,
                      op.detalle,
                      op.valores_posibles,
                      op.encriptado
                from t_operacion_parametros op, t_operaciones o
               where o.id_operacion = op.id_operacion
                 and op.activo = 'S'
                 and op.id_operacion = i_id_operacion
                 and op.version = nvl(i_version, o.version_actual)
              union
              -- Parámetros automáticos
              select c_tipo_operacion tipo,
                      lower(op.nombre) nombre,
                      op.orden,
                      op.activo,
                      op.tipo_dato,
                      op.formato,
                      op.longitud_maxima,
                      op.obligatorio,
                      op.valor_defecto,
                      op.etiqueta,
                      op.detalle,
                      op.valores_posibles,
                      op.encriptado
                from t_operacion_parametros op
               where op.activo = 'S'
                 and op.id_operacion = c_id_ope_par_automaticos
                 and exists
               (select 1
                        from t_operaciones o
                       where lower(op.nombre) in
                             (select lower(trim(column_value))
                                from k_cadena.f_separar_cadenas(o.parametros_automaticos,
                                                                ','))
                         and o.id_operacion = i_id_operacion)
              union all
              -- PARAMETRO
              select c_tipo_parametro tipo,
                      lower(pd.id_parametro) nombre,
                      pd.orden,
                      'S' activo,
                      pd.tipo_dato,
                      pd.formato formato,
                      pd.longitud_maxima longitud_maxima,
                      pd.obligatorio obligatorio,
                      pd.valor_defecto valor_defecto,
                      pd.etiqueta etiqueta,
                      pd.observacion detalle,
                      pd.valores_posibles valores_posibles,
                      pd.encriptado encriptado
                from t_parametro_definiciones pd
               where pd.tabla = i_tabla
                 and pd.tipo_filtro = nvl(i_tipo_filtro, pd.tipo_filtro)) x
       where x.tipo = case
               when i_id_operacion is not null then
                c_tipo_operacion
               when i_tabla is not null then
                c_tipo_parametro
             end
       order by x.orden;
  begin
    -- Inicializa respuesta
    l_parametros := new y_parametros();
  
    if i_parametros is null or dbms_lob.getlength(i_parametros) = 0 then
      l_json_object := json_object_t.parse(k_json_util.c_json_object_vacio);
    else
      l_json_object := json_object_t.parse(i_parametros);
    end if;
  
    -- Renombra claves a minúsculas
    k_json_util.p_renombrar_claves(l_json_object);
  
    for par in cr_parametros loop
      l_parametro        := new y_parametro();
      l_parametro.nombre := par.nombre;
    
      l_parametro_definicion := new
                                ry_datos_definicion_parametro(par.tipo,
                                                              par.nombre,
                                                              par.orden,
                                                              par.activo,
                                                              par.tipo_dato,
                                                              par.formato,
                                                              par.longitud_maxima,
                                                              par.obligatorio,
                                                              par.valor_defecto,
                                                              par.etiqueta,
                                                              par.detalle,
                                                              par.valores_posibles,
                                                              par.encriptado);
    
      l_json_element := l_json_object.get(par.nombre);
    
      l_parametro.valor := f_validar_parametro(l_parametro_definicion,
                                               l_json_element,
                                               l_json_object);
    
      l_parametros.extend;
      l_parametros(l_parametros.count) := l_parametro;
    end loop;
  
    return l_parametros;
  end;

  function f_procesar_parametros(i_tabla       in varchar2,
                                 i_parametros  in clob,
                                 i_tipo_filtro in varchar2 default null)
    return y_parametros is
  begin
    return f_procesar_parametros(i_parametros,
                                 null,
                                 null,
                                 i_tabla,
                                 i_tipo_filtro);
  end;

  function f_datos_valor_parametro(i_tabla        in varchar2,
                                   i_id_parametro in varchar2,
                                   i_referencia   in varchar2 default null)
    return ry_datos_valor_parametro is
    l_valor                 varchar2(32767);
    l_nombre_referencia     t_parametro_definiciones.nombre_referencia%type;
    l_datos_valor_parametro ry_datos_valor_parametro;
  begin
    -- Valida definición
    begin
      select d.nombre_referencia,
             d.tipo_dato,
             d.formato,
             d.valor_defecto,
             d.encriptado
        into l_nombre_referencia,
             l_datos_valor_parametro.tipo_dato,
             l_datos_valor_parametro.formato,
             l_datos_valor_parametro.valor_defecto,
             l_datos_valor_parametro.encriptado
        from t_parametro_definiciones d
       where upper(d.tabla) = upper(i_tabla)
         and upper(d.id_parametro) = upper(i_id_parametro);
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Definición de parámetro inexistente');
    end;
  
    begin
      if i_referencia is not null then
        execute immediate 'declare
  l_valor varchar2(32767);
begin
  begin
    select valor
      into l_valor
      from ' || i_tabla || '
     where id_parametro = :1
       and to_char(' || l_nombre_referencia ||
                          ') = :2;
  exception
    when others then
      l_valor := null;
  end;
  :3 := l_valor;
end;'
          using in i_id_parametro, in i_referencia, out l_valor;
      else
        execute immediate 'declare
  l_valor varchar2(32767);
begin
  begin
    select valor
      into l_valor
      from ' || i_tabla || '
     where id_parametro = :1;
  exception
    when others then
      l_valor := null;
  end;
  :2 := l_valor;
end;'
          using in i_id_parametro, out l_valor;
      end if;
    exception
      when others then
        raise_application_error(-20000,
                                'Error al buscar valor de parámetro. ' ||
                                sqlerrm);
    end;
  
    l_datos_valor_parametro.valor := l_valor;
  
    return l_datos_valor_parametro;
  end;

  function f_valor_parametro_string(i_tabla        in varchar2,
                                    i_id_parametro in varchar2,
                                    i_referencia   in varchar2 default null)
    return varchar2 is
    l_datos_valor_parametro ry_datos_valor_parametro;
  begin
    l_datos_valor_parametro := f_datos_valor_parametro(i_tabla,
                                                       i_id_parametro,
                                                       i_referencia);
    return nvl(l_datos_valor_parametro.valor,
               l_datos_valor_parametro.valor_defecto);
  end;

  function f_valor_parametro_number(i_tabla        in varchar2,
                                    i_id_parametro in varchar2,
                                    i_referencia   in varchar2 default null)
    return number is
    l_datos_valor_parametro ry_datos_valor_parametro;
  begin
    l_datos_valor_parametro := f_datos_valor_parametro(i_tabla,
                                                       i_id_parametro,
                                                       i_referencia);
    return to_number(nvl(l_datos_valor_parametro.valor,
                         l_datos_valor_parametro.valor_defecto),
                     nvl(l_datos_valor_parametro.formato,
                         '999G999G999G999G999D00'));
  end;

  function f_valor_parametro_boolean(i_tabla        in varchar2,
                                     i_id_parametro in varchar2,
                                     i_referencia   in varchar2 default null)
    return boolean is
    l_datos_valor_parametro ry_datos_valor_parametro;
  begin
    l_datos_valor_parametro := f_datos_valor_parametro(i_tabla,
                                                       i_id_parametro,
                                                       i_referencia);
    return k_util.string_to_bool(nvl(l_datos_valor_parametro.valor,
                                     l_datos_valor_parametro.valor_defecto));
  end;

  function f_valor_parametro_date(i_tabla        in varchar2,
                                  i_id_parametro in varchar2,
                                  i_referencia   in varchar2 default null)
    return date is
    l_datos_valor_parametro ry_datos_valor_parametro;
  begin
    l_datos_valor_parametro := f_datos_valor_parametro(i_tabla,
                                                       i_id_parametro,
                                                       i_referencia);
    return to_date(nvl(l_datos_valor_parametro.valor,
                       l_datos_valor_parametro.valor_defecto),
                   nvl(l_datos_valor_parametro.formato, 'dd/mm/yyyy'));
  end;

  function f_valor_parametro(i_tabla        in varchar2,
                             i_id_parametro in varchar2,
                             i_referencia   in varchar2 default null)
    return varchar2 is
  begin
    return f_valor_parametro_string(i_tabla, i_id_parametro, i_referencia);
  end;

  procedure p_definir_parametro(i_tabla        in varchar2,
                                i_id_parametro in varchar2,
                                i_valor        in varchar2,
                                i_referencia   in varchar2 default null) is
    l_nombre_referencia t_parametro_definiciones.nombre_referencia%type;
    l_tipo_dato         t_parametro_definiciones.tipo_dato%type;
  begin
    -- Valida definición
    begin
      select d.nombre_referencia, d.tipo_dato
        into l_nombre_referencia, l_tipo_dato
        from t_parametro_definiciones d
       where upper(d.tabla) = upper(i_tabla)
         and upper(d.id_parametro) = upper(i_id_parametro);
    exception
      when no_data_found then
        raise_application_error(-20000,
                                'Definición de parámetro inexistente');
    end;
  
    begin
      if i_referencia is not null then
        execute immediate 'begin
  update ' || i_tabla || '
     set valor = :1
   where id_parametro = :2
     and to_char(' || l_nombre_referencia ||
                          ') = :3;

  if sql%notfound then
    insert into ' || i_tabla || '
      (' || l_nombre_referencia || ', id_parametro, valor)
    values
      (:3, :2, :1);
  end if;
end;'
          using in i_valor, in i_id_parametro, in i_referencia;
      else
        execute immediate 'begin
  update ' || i_tabla || '
     set valor = :1
   where id_parametro = :2;

  if sql%notfound then
    insert into ' || i_tabla || '
      (id_parametro, valor)
    values
      (:2, :1);
  end if;
end;'
          using in i_valor, in i_id_parametro;
      end if;
    exception
      when others then
        raise_application_error(-20000,
                                'Error al definir parámetro. ' || sqlerrm);
    end;
  end;

end;
/

