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

  procedure p_guardar_dato_autonomo(i_tabla      in varchar2,
                                    i_campo      in varchar2,
                                    i_referencia in varchar2,
                                    i_dato       in varchar2) is
    pragma autonomous_transaction;
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
  
    commit;
  exception
    when others then
      console.error('Error al guardar dato: ' || sqlerrm);
      rollback;
  end;

end;
/
