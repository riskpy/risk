create or replace package body k_parametro is

  function f_procesar_parametros(i_tabla       in varchar2,
                                 i_parametros  in clob,
                                 i_tipo_filtro in varchar2 default null)
    return y_parametros is
    l_lista_parametros y_lista_parametros;
  begin
    l_lista_parametros := new y_lista_parametros(i_parametros,
                                                 null,
                                                 null,
                                                 i_tabla,
                                                 i_tipo_filtro);
    return l_lista_parametros.parametros;
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

