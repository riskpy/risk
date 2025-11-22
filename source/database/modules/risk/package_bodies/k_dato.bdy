create or replace package body k_dato is

  function f_recuperar_dato(i_tabla      in varchar2,
                            i_campo      in varchar2,
                            i_referencia in varchar2) return anydata is
    l_dato t_datos.contenido%type;
  begin
    begin
      select a.contenido
        into l_dato
        from t_datos a
       where upper(a.tabla) = upper(i_tabla)
         and upper(a.campo) = upper(i_campo)
         and a.referencia = i_referencia;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Dato adicional inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al recuperar dato adicional');
    end;
  
    return l_dato;
  end;

  function f_recuperar_dato_string(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return varchar2 is
  begin
    return anydata.accessvarchar2(f_recuperar_dato(i_tabla,
                                                   i_campo,
                                                   i_referencia));
  exception
    when others then
      return null;
  end;

  function f_recuperar_dato_number(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return number is
  begin
    return anydata.accessnumber(f_recuperar_dato(i_tabla,
                                                 i_campo,
                                                 i_referencia));
  exception
    when others then
      return null;
  end;

  function f_recuperar_dato_boolean(i_tabla      in varchar2,
                                    i_campo      in varchar2,
                                    i_referencia in varchar2) return boolean is
  begin
    return sys.diutil.int_to_bool(anydata.accessnumber(f_recuperar_dato(i_tabla,
                                                                        i_campo,
                                                                        i_referencia)));
  exception
    when others then
      return null;
  end;

  function f_recuperar_dato_date(i_tabla      in varchar2,
                                 i_campo      in varchar2,
                                 i_referencia in varchar2) return date is
  begin
    return anydata.accessdate(f_recuperar_dato(i_tabla,
                                               i_campo,
                                               i_referencia));
  exception
    when others then
      return null;
  end;

  function f_recuperar_dato_object(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return y_objeto is
    l_objeto   y_objeto;
    l_anydata  anydata;
    l_result   pls_integer;
    l_typeinfo anytype;
    l_typecode pls_integer;
  begin
    l_anydata := f_recuperar_dato(i_tabla, i_campo, i_referencia);
  
    l_typecode := l_anydata.gettype(l_typeinfo);
    if l_typecode = dbms_types.typecode_object then
      l_result := l_anydata.getobject(l_objeto);
    end if;
  
    return l_objeto;
  exception
    when others then
      return null;
  end;

  procedure p_guardar_dato(i_tabla      in varchar2,
                           i_campo      in varchar2,
                           i_referencia in varchar2,
                           i_dato       in anydata) is
  begin
    update t_datos a
       set a.contenido = i_dato
     where upper(a.tabla) = upper(i_tabla)
       and upper(a.campo) = upper(i_campo)
       and a.referencia = i_referencia;
  
    if sql%notfound then
      insert into t_datos
        (tabla, campo, referencia, contenido)
      values
        (upper(i_tabla), upper(i_campo), i_referencia, i_dato);
    end if;
  end;

  procedure p_guardar_dato_string(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in varchar2) is
  begin
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertvarchar2(i_dato));
  end;

  procedure p_guardar_dato_number(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in number) is
  begin
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertnumber(i_dato));
  end;

  procedure p_guardar_dato_boolean(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2,
                                   i_dato       in boolean) is
  begin
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertnumber(sys.diutil.bool_to_int(i_dato)));
  end;

  procedure p_guardar_dato_date(i_tabla      in varchar2,
                                i_campo      in varchar2,
                                i_referencia in varchar2,
                                i_dato       in date) is
  begin
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertdate(i_dato));
  end;

  procedure p_guardar_dato_object(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in y_objeto) is
  begin
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   anydata.convertobject(i_dato));
  end;

end;
/
