create or replace package body k_sistema is

  type ly_parametros is table of anydata index by varchar2(50);
  type ly_cola is table of varchar2(32767);

  g_indice     varchar2(50);
  g_parametros ly_parametros;
  g_cola       ly_cola;

  function f_es_produccion return boolean is
  begin
    return upper(k_util.f_valor_parametro('BASE_DATOS_PRODUCCION')) = upper(k_util.f_base_datos);
  end;

  function f_fecha return date is
  begin
    return f_valor_parametro_date(c_fecha);
  end;

  function f_id_usuario return number is
  begin
    return f_valor_parametro_number(c_id_usuario);
  end;

  function f_usuario return varchar2 is
  begin
    return f_valor_parametro_string(c_usuario);
  end;

  function f_pais return number is
  begin
    return f_valor_parametro_number(c_id_pais);
  end;

  function f_zona_horaria return varchar2 is
  begin
    return f_valor_parametro_string(c_zona_horaria);
  end;

  function f_idioma return number is
  begin
    return f_valor_parametro_number(c_id_idioma);
  end;

  function f_valor_parametro(i_parametro in varchar2) return anydata is
    l_valor anydata;
  begin
    if g_parametros.exists(i_parametro) then
      l_valor := g_parametros(i_parametro);
    end if;
  
    -- Si el parámetro no se encuentra en la lista carga un valor nulo de tipo
    -- VARCHAR2 para evitar el error ORA-30625 al acceder al valor a través de
    -- AnyData.Access*
    if l_valor is null then
      l_valor := anydata.convertvarchar2(null);
    end if;
  
    return l_valor;
  end;

  function f_valor_parametro_string(i_parametro in varchar2) return varchar2 is
  begin
    return anydata.accessvarchar2(f_valor_parametro(i_parametro));
  end;

  function f_valor_parametro_number(i_parametro in varchar2) return number is
  begin
    return anydata.accessnumber(f_valor_parametro(i_parametro));
  end;

  function f_valor_parametro_boolean(i_parametro in varchar2) return boolean is
  begin
    return sys.diutil.int_to_bool(anydata.accessnumber(f_valor_parametro(i_parametro)));
  end;

  function f_valor_parametro_date(i_parametro in varchar2) return date is
  begin
    return anydata.accessdate(f_valor_parametro(i_parametro));
  end;

  procedure p_definir_parametro(i_parametro in varchar2,
                                i_valor     in anydata) is
  begin
    g_parametros(i_parametro) := i_valor;
  end;

  procedure p_definir_parametro_string(i_parametro in varchar2,
                                       i_valor     in varchar2) is
  begin
    p_definir_parametro(i_parametro, anydata.convertvarchar2(i_valor));
  end;

  procedure p_definir_parametro_number(i_parametro in varchar2,
                                       i_valor     in number) is
  begin
    p_definir_parametro(i_parametro, anydata.convertnumber(i_valor));
  end;

  procedure p_definir_parametro_boolean(i_parametro in varchar2,
                                        i_valor     in boolean) is
  begin
    p_definir_parametro(i_parametro,
                        anydata.convertnumber(sys.diutil.bool_to_int(i_valor)));
  end;

  procedure p_definir_parametro_date(i_parametro in varchar2,
                                     i_valor     in date) is
  begin
    p_definir_parametro(i_parametro, anydata.convertdate(i_valor));
  end;

  procedure p_inicializar_parametros is
  begin
    -- Elimina parámetros
    p_eliminar_parametros;
  
    -- Define parámetros por defecto
    declare
      l_nombre         t_modulos.nombre%type;
      l_version_actual t_modulos.version_actual%type;
      l_fecha_actual   t_modulos.fecha_actual%type;
    begin
      select nombre, version_actual, fecha_actual
        into l_nombre, l_version_actual, l_fecha_actual
        from t_modulos
       where id_modulo = 'RISK';
      p_definir_parametro_string(c_sistema, l_nombre);
      p_definir_parametro_string(c_version, l_version_actual);
      p_definir_parametro_date(c_fecha, l_fecha_actual);
    exception
      when others then
        null;
    end;
    p_definir_parametro_string(c_usuario, user);
  
    declare
      l_id_pais t_paises.id_pais%type;
    begin
      select p.id_pais
        into l_id_pais
        from t_paises p
       where p.iso_alpha_2 = k_util.f_valor_parametro('ID_PAIS_ISO');
      p_definir_parametro_number(c_id_pais, l_id_pais);
    exception
      when others then
        null;
    end;
  
    p_definir_parametro_string(c_zona_horaria,
                               k_util.f_valor_parametro('ZONA_HORARIA'));
  
    declare
      l_id_idioma t_idiomas.id_idioma%type;
    begin
      select i.id_idioma
        into l_id_idioma
        from t_idiomas i
       where i.iso_639_1 = k_util.f_valor_parametro('ID_IDIOMA_ISO');
      p_definir_parametro_number(c_id_idioma, l_id_idioma);
    exception
      when others then
        null;
    end;
  
  end;

  procedure p_limpiar_parametros is
  begin
    g_indice := g_parametros.first;
    while g_indice is not null loop
      g_parametros(g_indice) := null;
      g_indice := g_parametros.next(g_indice);
    end loop;
  end;

  procedure p_eliminar_parametros is
  begin
    g_parametros.delete;
  end;

  procedure p_imprimir_parametros is
    l_typeinfo anytype;
    l_typecode pls_integer;
  begin
    g_indice := g_parametros.first;
    while g_indice is not null loop
      dbms_output.put(g_indice || ': ');
      if g_parametros(g_indice) is not null then
        l_typecode := g_parametros(g_indice).gettype(l_typeinfo);
        if l_typecode = dbms_types.typecode_varchar2 then
          dbms_output.put(anydata.accessvarchar2(g_parametros(g_indice)));
        elsif l_typecode = dbms_types.typecode_number then
          dbms_output.put(to_char(anydata.accessnumber(g_parametros(g_indice))));
        elsif l_typecode = dbms_types.typecode_date then
          dbms_output.put(to_char(anydata.accessdate(g_parametros(g_indice)),
                                  'YYYY-MM-DD'));
        else
          dbms_output.put('Tipo de dato no soportado');
        end if;
      end if;
      dbms_output.new_line;
      g_indice := g_parametros.next(g_indice);
    end loop;
  end;

  --
  procedure p_inicializar_cola is
  begin
    g_cola := new ly_cola();
  end;

  procedure p_encolar(i_valor in varchar2) is
  begin
    if g_cola is null then
      p_inicializar_cola;
    end if;
    g_cola.extend;
    g_cola(g_cola.count) := i_valor;
  end;

  function f_desencolar return varchar2 is
    l_valor varchar2(32767);
  begin
    if g_cola is null then
      p_inicializar_cola;
    end if;
    if g_cola.exists(g_cola.first) then
      l_valor := g_cola(g_cola.first);
      g_cola.delete(g_cola.first);
    end if;
    return l_valor;
  end;

  procedure p_imprimir_cola is
    i integer;
  begin
    if g_cola is not null then
      i := g_cola.first;
      while i is not null loop
        dbms_output.put_line(to_char(i) || ': ' || g_cola(i));
        i := g_cola.next(i);
      end loop;
    end if;
  end;
  --

begin
  -- Define parámetros por defecto
  p_inicializar_parametros;
end;
/
