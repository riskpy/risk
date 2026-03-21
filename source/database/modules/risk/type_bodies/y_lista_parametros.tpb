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
  begin
    self.parametros := k_parametro.f_procesar_parametros(i_parametros,
                                                         i_id_operacion,
                                                         i_version,
                                                         i_tabla,
                                                         i_tipo_filtro);
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

  member function f_valor_parametro_clob(i_nombre in varchar2) return clob is
  begin
    return anydata.accessclob(f_valor_parametro(i_nombre));
  end;

end;
/

