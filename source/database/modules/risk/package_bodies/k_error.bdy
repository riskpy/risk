create or replace package body k_error is

  function f_tipo_excepcion(i_sqlcode in number) return varchar2 is
    l_tipo_error varchar2(3);
  begin
    if abs(i_sqlcode) between 20000 and 20999 then
      l_tipo_error := c_user_defined_error;
    else
      l_tipo_error := c_oracle_predefined_error;
    end if;
    return l_tipo_error;
  end;

  function f_mensaje_excepcion(i_sqlerrm in varchar2) return varchar2 is
    l_posicion integer;
    l_mensaje  varchar2(32767);
  begin
    l_mensaje := i_sqlerrm;
  
    -- ORA-NNNNN:
    l_posicion := regexp_instr(l_mensaje, 'ORA-[0-9]{5}:', 1, 2);
    if l_posicion > length('ORA-NNNNN:') then
      l_mensaje := regexp_replace(substr(l_mensaje, 1, l_posicion - 1),
                                  'ORA-[0-9]{5}:');
    else
      l_mensaje := regexp_replace(l_mensaje, 'ORA-[0-9]{5}:');
    end if;
  
    -- PL/SQL:
    l_posicion := instr(l_mensaje, 'PL/SQL:', 1, 2);
    if l_posicion > length('PL/SQL:') then
      l_mensaje := replace(substr(l_mensaje, 1, l_posicion - 1), 'PL/SQL:');
    else
      l_mensaje := replace(l_mensaje, 'PL/SQL:');
    end if;
  
    return trim(l_mensaje);
  end;

  function f_mensaje_error(i_clave     in varchar2,
                           i_cadenas   in y_cadenas,
                           i_wrap_char in varchar2 default c_wrap_char)
    return varchar2 is
    l_mensaje   t_errores.mensaje%type;
    l_id_idioma t_idiomas.id_idioma%type;
    l_id_pais   t_paises.id_pais%type;
  begin
    l_id_idioma := k_sistema.f_idioma;
    l_id_pais   := k_sistema.f_pais;
  
    begin
      with lv_mensajes as
       (select mensaje
          from t_errores
         where clave = i_clave
           and nvl(id_idioma, nvl(l_id_idioma, -1)) = nvl(l_id_idioma, -1)
           and nvl(id_pais, nvl(l_id_pais, -1)) = nvl(l_id_pais, -1)
         order by decode(clave, null, 0, 1) + decode(id_idioma, null, 0, 1) +
                  decode(id_pais, null, 0, 1) desc)
      select mensaje into l_mensaje from lv_mensajes where rownum = 1;
    exception
      when no_data_found then
        l_mensaje := 'Error no registrado [' || i_clave || ']';
    end;
  
    return k_cadena.f_unir_cadenas(l_mensaje,
                                   i_cadenas,
                                   nvl(i_wrap_char, c_wrap_char));
  end;

  function f_mensaje_error(i_clave     in varchar2,
                           i_cadena1   in varchar2 default null,
                           i_cadena2   in varchar2 default null,
                           i_cadena3   in varchar2 default null,
                           i_cadena4   in varchar2 default null,
                           i_cadena5   in varchar2 default null,
                           i_wrap_char in varchar2 default c_wrap_char)
    return varchar2 is
    l_mensaje   t_errores.mensaje%type;
    l_id_idioma t_idiomas.id_idioma%type;
    l_id_pais   t_paises.id_pais%type;
  begin
    l_id_idioma := k_sistema.f_idioma;
    l_id_pais   := k_sistema.f_pais;
  
    begin
      with lv_mensajes as
       (select mensaje
          from t_errores
         where clave = i_clave
           and nvl(id_idioma, nvl(l_id_idioma, -1)) = nvl(l_id_idioma, -1)
           and nvl(id_pais, nvl(l_id_pais, -1)) = nvl(l_id_pais, -1)
         order by decode(clave, null, 0, 1) + decode(id_idioma, null, 0, 1) +
                  decode(id_pais, null, 0, 1) desc)
      select mensaje into l_mensaje from lv_mensajes where rownum = 1;
    exception
      when no_data_found then
        l_mensaje := 'Error no registrado [' || i_clave || ']';
    end;
  
    return k_cadena.f_unir_cadenas(l_mensaje,
                                   i_cadena1,
                                   i_cadena2,
                                   i_cadena3,
                                   i_cadena4,
                                   i_cadena5,
                                   nvl(i_wrap_char, c_wrap_char));
  end;

end;
/
