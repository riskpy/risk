create or replace type body y_lista_parametros is

  constructor function y_lista_parametros return self as result as
  begin
    self.parametros := new y_parametros();
    return;
  end;

  constructor function y_lista_parametros(i_parametros in y_parametros)
    return self as result as
  begin
    if i_parametros is not null then
      self.parametros := i_parametros;
    else
      self.parametros := new y_parametros();
    end if;
    return;
  end;

  constructor function y_lista_parametros(i_parametros in clob,
                                          -- OPERACION
                                          i_id_operacion in number default null,
                                          i_version      in varchar2 default null,
                                          -- PARAMETRO
                                          i_tabla       in varchar2 default null,
                                          i_tipo_filtro in varchar2 default null)
    return self as result as
    l_parametros    y_parametros;
    l_parametro     y_parametro;
    l_json_object   json_object_t;
    l_json_element  json_element_t;
    l_json_key_list json_key_list;
    i               integer;
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
    l_json_key_list := l_json_object.get_keys;
    i               := l_json_key_list.first;
    while i is not null loop
      if l_json_key_list(i) <> lower(l_json_key_list(i)) then
        l_json_object.rename_key(l_json_key_list(i),
                                 lower(l_json_key_list(i)));
      end if;
      i := l_json_key_list.next(i);
    end loop;
  
    for par in cr_parametros loop
      l_parametro        := new y_parametro();
      l_parametro.nombre := par.nombre;
    
      l_json_element := l_json_object.get(par.nombre);
    
      /*if par.obligatorio = 'S' then
        if not l_json_object.has(par.nombre) then
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0003',
                                                          nvl(par.etiqueta,
                                                              par.nombre)));
        else
          if l_json_element.is_null then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        end if;
      end if;*/
    
      case par.tipo_dato
      
        when 'S' then
          -- String
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_string then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if par.encriptado = 'S' then
            begin
              l_parametro.valor := anydata.convertvarchar2(k_util.decrypt(l_json_object.get_string(par.nombre)));
            exception
              when value_error then
                raise_application_error(-20000,
                                        k_error.f_mensaje_error('ora0008',
                                                                nvl(par.etiqueta,
                                                                    par.nombre)));
              when others then
                raise_application_error(-20000,
                                        k_error.f_mensaje_error('ora0009',
                                                                nvl(par.etiqueta,
                                                                    par.nombre)));
            end;
          else
            l_parametro.valor := anydata.convertvarchar2(l_json_object.get_string(par.nombre));
          end if;
          if l_parametro.valor.accessvarchar2 is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertvarchar2(par.valor_defecto);
          end if;
          if l_parametro.valor.accessvarchar2 is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
          if par.longitud_maxima is not null and
             nvl(length(l_parametro.valor.accessvarchar2), 0) >
             par.longitud_maxima then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0006',
                                                            nvl(par.etiqueta,
                                                                par.nombre),
                                                            to_char(par.longitud_maxima)));
          end if;
          if par.valores_posibles is not null and
             l_parametro.valor.accessvarchar2 is not null and not
              k_significado.f_existe_codigo(par.valores_posibles,
                                                                                             l_parametro.valor.accessvarchar2) then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0007',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'N' then
          -- Number
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_number then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertnumber(l_json_object.get_number(par.nombre));
          if l_parametro.valor.accessnumber is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertnumber(to_number(par.valor_defecto));
          end if;
          if l_parametro.valor.accessnumber is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
          if par.longitud_maxima is not null and
             nvl(length(to_char(abs(trunc(l_parametro.valor.accessnumber)))),
                 0) > par.longitud_maxima then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0006',
                                                            nvl(par.etiqueta,
                                                                par.nombre),
                                                            to_char(par.longitud_maxima)));
          end if;
          if par.valores_posibles is not null and
             l_parametro.valor.accessnumber is not null and not
              k_significado.f_existe_codigo(par.valores_posibles,
                                                                                           to_char(l_parametro.valor.accessnumber)) then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0007',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'B' then
          -- Boolean
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_boolean then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertnumber(sys.diutil.bool_to_int(l_json_object.get_boolean(par.nombre)));
          if l_parametro.valor.accessnumber is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertnumber(to_number(par.valor_defecto));
          end if;
          if l_parametro.valor.accessnumber is null and
             par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'D' then
          -- Date
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_string /*l_json_element.is_date*/
           then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          l_parametro.valor := anydata.convertdate(l_json_object.get_date(par.nombre));
          if l_parametro.valor.accessdate is null and
             par.valor_defecto is not null then
            l_parametro.valor := anydata.convertdate(to_date(par.valor_defecto,
                                                             par.formato));
          end if;
          if l_parametro.valor.accessdate is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'O' then
          -- Object
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_object then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if l_json_element is not null and l_json_element.is_object then
            l_parametro.valor := k_objeto_util.json_to_objeto(l_json_element.to_clob,
                                                              par.formato);
          end if;
        
          if l_parametro.valor is null and par.valor_defecto is not null then
            l_parametro.valor := k_objeto_util.json_to_objeto(par.valor_defecto,
                                                              par.formato);
          end if;
          if l_parametro.valor is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'J' then
          -- JSON Object
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_object then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if l_json_element is not null and l_json_element.is_object then
            l_parametro.valor := anydata.convertclob(l_json_element.to_clob);
          end if;
        
          if l_parametro.valor is null and par.valor_defecto is not null then
            l_parametro.valor := anydata.convertclob(json_object_t.parse(par.valor_defecto).to_clob);
          end if;
          if l_parametro.valor is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        when 'A' then
          -- JSON Array
          if l_json_element is not null and not l_json_element.is_null and
             not l_json_element.is_array then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0005',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
          if l_json_element is not null and l_json_element.is_array then
            l_parametro.valor := anydata.convertclob(l_json_element.to_clob);
          end if;
        
          if l_parametro.valor is null and par.valor_defecto is not null then
            l_parametro.valor := anydata.convertclob(json_array_t.parse(par.valor_defecto).to_clob);
          end if;
          if l_parametro.valor is null and par.obligatorio = 'S' then
            raise_application_error(-20000,
                                    k_error.f_mensaje_error('ora0004',
                                                            nvl(par.etiqueta,
                                                                par.nombre)));
          end if;
        
        else
          raise_application_error(-20000,
                                  k_error.f_mensaje_error('ora0002',
                                                          'parámetro',
                                                          nvl(par.etiqueta,
                                                              par.nombre)));
        
      end case;
    
      l_parametros.extend;
      l_parametros(l_parametros.count) := l_parametro;
    end loop;
    self.parametros := l_parametros;
    return;
  end;

  member function f_valor_parametro(i_nombre in varchar2) return anydata is
    l_valor anydata;
    i       integer;
  begin
    if self.parametros is not null then
      -- Busca el parámetro en la lista
      i := self.parametros.first;
      while i is not null and l_valor is null loop
        if lower(self.parametros(i).nombre) = lower(i_nombre) then
          l_valor := self.parametros(i).valor;
        end if;
        i := self.parametros.next(i);
      end loop;
    end if;
  
    -- Si el parámetro no se encuentra en la lista carga un valor nulo de tipo
    -- VARCHAR2 para evitar el error ORA-30625 al acceder al valor a través de
    -- AnyData.Access*
    if l_valor is null then
      l_valor := anydata.convertvarchar2(null);
    end if;
  
    return l_valor;
  end;

  member function f_valor_parametro_string(i_nombre in varchar2)
    return varchar2 is
  begin
    return anydata.accessvarchar2(f_valor_parametro(i_nombre));
  end;

  member function f_valor_parametro_number(i_nombre in varchar2)
    return number is
  begin
    return anydata.accessnumber(f_valor_parametro(i_nombre));
  end;

  member function f_valor_parametro_boolean(i_nombre in varchar2)
    return boolean is
  begin
    return sys.diutil.int_to_bool(anydata.accessnumber(f_valor_parametro(i_nombre)));
  end;

  member function f_valor_parametro_date(i_nombre in varchar2) return date is
  begin
    return anydata.accessdate(f_valor_parametro(i_nombre));
  end;

  member function f_valor_parametro_object(i_nombre in varchar2)
    return y_objeto is
    l_objeto   y_objeto;
    l_anydata  anydata;
    l_result   pls_integer;
    l_typeinfo anytype;
    l_typecode pls_integer;
  begin
    l_anydata := f_valor_parametro(i_nombre);
  
    l_typecode := l_anydata.gettype(l_typeinfo);
    if l_typecode = dbms_types.typecode_object then
      l_result := l_anydata.getobject(l_objeto);
    end if;
  
    return l_objeto;
  end;

  member function f_valor_parametro_json_object(i_nombre in varchar2)
    return json_object_t is
    l_json_object json_object_t;
    l_json_clob   clob;
  begin
    l_json_clob := anydata.accessclob(f_valor_parametro(i_nombre));
  
    if l_json_clob is null or dbms_lob.getlength(l_json_clob) = 0 then
      l_json_object := json_object_t.parse(k_json_util.c_json_object_vacio);
    else
      l_json_object := json_object_t.parse(l_json_clob);
    end if;
  
    return l_json_object;
  end;

  member function f_valor_parametro_json_array(i_nombre in varchar2)
    return json_array_t is
    l_json_array json_array_t;
    l_json_clob  clob;
  begin
    l_json_clob := anydata.accessclob(f_valor_parametro(i_nombre));
  
    if l_json_clob is null or dbms_lob.getlength(l_json_clob) = 0 then
      l_json_array := json_array_t.parse(k_json_util.c_json_array_vacio);
    else
      l_json_array := json_array_t.parse(l_json_clob);
    end if;
  
    return l_json_array;
  end;

end;
/

