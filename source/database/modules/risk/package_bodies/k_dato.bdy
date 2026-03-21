create or replace package body k_dato is

  function f_recuperar_dato(i_tabla      in varchar2,
                            i_campo      in varchar2,
                            i_referencia in varchar2) return varchar2 is
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
    return f_recuperar_dato(i_tabla, i_campo, i_referencia);
  end;

  function f_recuperar_dato_number(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2) return number is
  begin
    return to_number(f_recuperar_dato(i_tabla, i_campo, i_referencia));
  end;

  function f_recuperar_dato_boolean(i_tabla      in varchar2,
                                    i_campo      in varchar2,
                                    i_referencia in varchar2) return boolean is
  begin
    return k_util.string_to_bool(f_recuperar_dato(i_tabla,
                                                  i_campo,
                                                  i_referencia));
  end;

  function f_recuperar_dato_date(i_tabla      in varchar2,
                                 i_campo      in varchar2,
                                 i_referencia in varchar2) return date is
  begin
    return k_util.string_to_date(f_recuperar_dato(i_tabla,
                                                  i_campo,
                                                  i_referencia));
  end;

  function f_recuperar_referencia(i_tabla     in varchar2,
                                  i_campo     in varchar2,
                                  i_contenido in varchar2) return varchar2 is
    l_dato t_datos.referencia%type;
  begin
    begin
      select a.referencia
        into l_dato
        from t_datos a
       where upper(a.tabla) = upper(i_tabla)
         and upper(a.campo) = upper(i_campo)
         and a.contenido = i_contenido;
    exception
      when no_data_found then
        raise_application_error(-20000, 'Dato adicional inexistente');
      when others then
        raise_application_error(-20000,
                                'Error al recuperar la referencia del dato');
    end;
    return l_dato;
  end;

  procedure p_guardar_dato(i_tabla      in varchar2,
                           i_campo      in varchar2,
                           i_referencia in varchar2,
                           i_dato       in varchar2) is
  begin
    update t_datos a
       set a.contenido = substr(i_dato, 1, 4000)
     where upper(a.tabla) = upper(i_tabla)
       and upper(a.campo) = upper(i_campo)
       and a.referencia = i_referencia;
  
    if sql%notfound then
      insert into t_datos
        (tabla, campo, referencia, contenido)
      values
        (upper(i_tabla),
         upper(i_campo),
         i_referencia,
         substr(i_dato, 1, 4000));
    end if;
  end;

  procedure p_guardar_dato_string(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in varchar2) is
  begin
    -- Valida definición
    if not
        t_dato_definiciones_api.row_exists(upper(i_tabla), upper(i_campo)) then
      raise_application_error(-20000,
                              'Definición de dato adicional inexistente');
    end if;
  
    if t_dato_definiciones_api.get_tipo_dato(upper(i_tabla), upper(i_campo)) <> 'S' then
      -- String
      raise_application_error(-20000, 'Tipo de dato incorrecto');
    end if;
  
    p_guardar_dato(i_tabla, i_campo, i_referencia, i_dato);
  end;

  procedure p_guardar_dato_number(i_tabla      in varchar2,
                                  i_campo      in varchar2,
                                  i_referencia in varchar2,
                                  i_dato       in number) is
  begin
    -- Valida definición
    if not
        t_dato_definiciones_api.row_exists(upper(i_tabla), upper(i_campo)) then
      raise_application_error(-20000,
                              'Definición de dato adicional inexistente');
    end if;
  
    if t_dato_definiciones_api.get_tipo_dato(upper(i_tabla), upper(i_campo)) <> 'N' then
      -- Number
      raise_application_error(-20000, 'Tipo de dato incorrecto');
    end if;
  
    p_guardar_dato(i_tabla, i_campo, i_referencia, to_char(i_dato));
  end;

  procedure p_guardar_dato_boolean(i_tabla      in varchar2,
                                   i_campo      in varchar2,
                                   i_referencia in varchar2,
                                   i_dato       in boolean) is
  begin
    -- Valida definición
    if not
        t_dato_definiciones_api.row_exists(upper(i_tabla), upper(i_campo)) then
      raise_application_error(-20000,
                              'Definición de dato adicional inexistente');
    end if;
  
    if t_dato_definiciones_api.get_tipo_dato(upper(i_tabla), upper(i_campo)) <> 'B' then
      -- Boolean
      raise_application_error(-20000, 'Tipo de dato incorrecto');
    end if;
  
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   k_util.bool_to_string(i_dato));
  end;

  procedure p_guardar_dato_date(i_tabla      in varchar2,
                                i_campo      in varchar2,
                                i_referencia in varchar2,
                                i_dato       in date) is
  begin
    -- Valida definición
    if not
        t_dato_definiciones_api.row_exists(upper(i_tabla), upper(i_campo)) then
      raise_application_error(-20000,
                              'Definición de dato adicional inexistente');
    end if;
  
    if t_dato_definiciones_api.get_tipo_dato(upper(i_tabla), upper(i_campo)) <> 'D' then
      -- Date
      raise_application_error(-20000, 'Tipo de dato incorrecto');
    end if;
  
    p_guardar_dato(i_tabla,
                   i_campo,
                   i_referencia,
                   k_util.date_to_string(i_dato));
  end;

  procedure p_guardar_dato_autonomo(i_tabla      in varchar2,
                                    i_campo      in varchar2,
                                    i_referencia in varchar2,
                                    i_dato       in varchar2) is
    pragma autonomous_transaction;
  begin
    p_guardar_dato(i_tabla, i_campo, i_referencia, i_dato);
  
    commit;
  exception
    when others then
      console.error('Error al guardar dato: ' || sqlerrm);
      rollback;
  end;

end;
/

