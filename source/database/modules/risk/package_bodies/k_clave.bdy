create or replace package body k_clave is

  c_algoritmo      constant pls_integer := as_crypto.hmac_sh1;
  c_iteraciones    constant pls_integer := 128; -- 4096
  c_longitud_bytes constant pls_integer := 32;

  -- Excepciones
  ex_credenciales_invalidas exception;
  ex_tokens_invalidos       exception;

  -- https://mikepargeter.wordpress.com/2012/11/26/pbkdf2-in-oracle
  -- https://www.ietf.org/rfc/rfc6070.txt
  function pbkdf2(p_password   in varchar2,
                  p_salt       in varchar2,
                  p_count      in integer,
                  p_key_length in integer) return varchar2 is
    l_block_count integer;
    l_last        raw(32767);
    l_xorsum      raw(32767);
    l_result      raw(32767);
  begin
    -- SHA-1   ==> 20 bytes
    -- SHA-256 ==> 32 bytes
    l_block_count := ceil(p_key_length / 20);
    for i in 1 .. l_block_count loop
      l_last   := utl_raw.concat(utl_raw.cast_to_raw(p_salt),
                                 utl_raw.cast_from_binary_integer(i,
                                                                  utl_raw.big_endian));
      l_xorsum := null;
      for j in 1 .. p_count loop
        l_last := as_crypto.mac(l_last,
                                c_algoritmo,
                                utl_raw.cast_to_raw(p_password));
        if l_xorsum is null then
          l_xorsum := l_last;
        else
          l_xorsum := utl_raw.bit_xor(l_xorsum, l_last);
        end if;
      end loop;
      l_result := utl_raw.concat(l_result, l_xorsum);
    end loop;
    return rawtohex(utl_raw.substr(l_result, 1, p_key_length));
  end;

  function f_randombytes_hex return varchar2 is
  begin
    return rawtohex(as_crypto.randombytes(c_longitud_bytes));
  end;

  function f_randombytes_base64 return varchar2 is
  begin
    return utl_raw.cast_to_varchar2(utl_encode.base64_encode(as_crypto.randombytes(c_longitud_bytes)));
  end;

  function f_salt return varchar2 is
  begin
    return f_randombytes_hex;
  end;

  function f_hash(i_clave in varchar2,
                  i_salt  in varchar2) return varchar2 is
  begin
    return pbkdf2(i_clave, i_salt, c_iteraciones, c_longitud_bytes);
  end;

  function f_validar_clave(i_id_usuario in number,
                           i_clave      in varchar2,
                           i_tipo_clave in char default 'A') return boolean is
    l_hash        t_usuario_claves.hash%type;
    l_salt        t_usuario_claves.salt%type;
    l_iteraciones t_usuario_claves.iteraciones%type;
  begin
    begin
      select c.hash, c.salt, c.iteraciones
        into l_hash, l_salt, l_iteraciones
        from t_usuario_claves c
       where c.id_usuario = i_id_usuario
         and c.tipo = i_tipo_clave
         and orden = (select max(uc2.orden)
                        from t_usuario_claves uc2
                       where uc2.id_usuario = c.id_usuario
                         and uc2.tipo = c.tipo)
         and c.estado in ('N', 'A');
    exception
      when others then
        raise ex_credenciales_invalidas;
    end;
  
    if l_hash <> pbkdf2(i_clave,
                        l_salt,
                        l_iteraciones,
                        utl_raw.length(hextoraw(l_hash))) then
      raise ex_credenciales_invalidas;
    end if;
  
    return true;
  exception
    when ex_credenciales_invalidas then
      return false;
    when others then
      return false;
  end;

  procedure p_registrar_intento_fallido(i_id_usuario in number,
                                        i_tipo_clave in char default 'A') is
    pragma autonomous_transaction;
    l_cantidad_intentos_permitidos pls_integer;
  begin
    l_cantidad_intentos_permitidos := to_number(k_util.f_valor_parametro('AUTENTICACION_CANTIDAD_INTENTOS_PERMITIDOS'));
    update t_usuario_claves a
       set cantidad_intentos_fallidos = case
                                          when nvl(cantidad_intentos_fallidos,
                                                   0) >=
                                               l_cantidad_intentos_permitidos then
                                           cantidad_intentos_fallidos
                                          else
                                           nvl(cantidad_intentos_fallidos, 0) + 1
                                        end,
           estado = case
                      when nvl(cantidad_intentos_fallidos, 0) >=
                           l_cantidad_intentos_permitidos then
                       'B'
                      else
                       estado
                    end
     where id_usuario = i_id_usuario
       and tipo = i_tipo_clave
       and orden = (select max(uc2.orden)
                      from t_usuario_claves uc2
                     where uc2.id_usuario = a.id_usuario
                       and uc2.tipo = a.tipo);
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_registrar_autenticacion(i_id_usuario in number,
                                      i_tipo_clave in char default 'A') is
    pragma autonomous_transaction;
  begin
    update t_usuario_claves a
       set cantidad_intentos_fallidos = 0,
           fecha_ultima_autenticacion = sysdate,
           estado = case
                      when nvl(estado, 'N') = 'N' then
                       'A'
                      else
                       estado
                    end
     where id_usuario = i_id_usuario
       and tipo = i_tipo_clave
       and orden = (select max(uc2.orden)
                      from t_usuario_claves uc2
                     where uc2.id_usuario = a.id_usuario
                       and uc2.tipo = a.tipo);
    commit;
  exception
    when others then
      rollback;
  end;

  procedure p_validar_politicas(i_alias      in varchar2,
                                i_clave      in varchar2,
                                i_tipo_clave in char default 'A') is
    l_dominio               t_significados.dominio%type;
    l_caracteres_prohibidos t_significados.significado%type;
    l_lon_clave             number(6) := 0;
    l_can_letras            number(6) := 0;
    l_can_letras_may        number(6) := 0;
    l_can_letras_min        number(6) := 0;
    l_can_numeros           number(6) := 0;
    l_can_otros             number(6) := 0;
    l_can_repeticiones      number(6) := 0;
    l_caracter              varchar2(1);
  begin
    l_dominio   := 'POLITICA_VALIDACION_CLAVE_' ||
                   k_significado.f_significado_codigo('TIPO_CLAVE',
                                                      i_tipo_clave);
    l_lon_clave := length(i_clave);
  
    -- Valida la longitud de la clave
    if l_lon_clave <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'LONGITUD_MINIMA')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'LONGITUD_MINIMA') ||
                              ' caracteres');
    end if;
  
    for i in 1 .. l_lon_clave loop
      l_caracter := substr(i_clave, i, 1);
    
      -- Cuenta la cantidad de mayusculas, minusculas, numeros y caracteres especiales
      if l_caracter between 'A' and 'Z' then
        l_can_letras_may := l_can_letras_may + 1;
      elsif l_caracter between 'a' and 'z' then
        l_can_letras_min := l_can_letras_min + 1;
      elsif l_caracter between '0' and '9' then
        l_can_numeros := l_can_numeros + 1;
      else
        l_can_otros := l_can_otros + 1;
      end if;
    
      -- Valida la cantidad de repeticiones de un mismo caracter
      l_can_repeticiones := 0;
      for j in i .. l_lon_clave loop
        if l_caracter = substr(i_clave, j, 1) then
          l_can_repeticiones := l_can_repeticiones + 1;
        end if;
      end loop;
      if l_can_repeticiones >
         to_number(k_significado.f_significado_codigo(l_dominio,
                                                      'CAN_MAX_CARACTERES_IGUALES')) then
        raise_application_error(-20000,
                                'La clave no puede contener más de ' ||
                                k_significado.f_significado_codigo(l_dominio,
                                                                   'CAN_MAX_CARACTERES_IGUALES') ||
                                ' caracteres iguales');
      end if;
    end loop;
  
    l_can_letras := l_can_letras_min + l_can_letras_may;
  
    -- Valida que la clave no sea igual al usuario
    if k_util.string_to_bool(k_significado.f_significado_codigo(l_dominio,
                                                                'VAL_ALIAS_IGUAL')) and
       upper(i_clave) = upper(i_alias) then
      raise_application_error(-20000,
                              'La clave no puede ser igual al usuario');
    end if;
    -- Valida que la clave no contenga el usuario
    if k_util.string_to_bool(k_significado.f_significado_codigo(l_dominio,
                                                                'VAL_ALIAS_CONTENIDO')) and
       instr(upper(i_clave), upper(i_alias)) > 0 then
      raise_application_error(-20000,
                              'La clave no debe contener el usuario');
    end if;
  
    -- Valida la cantidad de letras
    if l_can_letras <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'CAN_MIN_LETRAS_ABECEDARIO')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'CAN_MIN_LETRAS_ABECEDARIO') ||
                              ' letras del abecedario');
    end if;
    -- Valida la cantidad de letras mayusculas
    if l_can_letras_may <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'CAN_MIN_MAYUSCULAS')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'CAN_MIN_MAYUSCULAS') ||
                              ' letra mayúscula');
    end if;
    -- Valida la cantidad de letras minusculas
    if l_can_letras_min <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'CAN_MIN_MINUSCULAS')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'CAN_MIN_MINUSCULAS') ||
                              ' letra minúscula');
    end if;
    -- Valida la cantidad de numeros
    if l_can_numeros <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'CAN_MIN_NUMEROS')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'CAN_MIN_NUMEROS') ||
                              ' número');
    end if;
    -- Valida la cantidad de caracteres especiales
    if l_can_otros <
       to_number(k_significado.f_significado_codigo(l_dominio,
                                                    'CAN_MIN_CARACTERES_ESPECIALES')) then
      raise_application_error(-20000,
                              'La clave debe contener al menos ' ||
                              k_significado.f_significado_codigo(l_dominio,
                                                                 'CAN_MIN_CARACTERES_ESPECIALES') ||
                              ' caracter especial');
    end if;
  
    -- Valida caracteres prohibidos
    l_caracteres_prohibidos := k_significado.f_significado_codigo(l_dominio,
                                                                  'CARACTERES_PROHIBIDOS');
    for i in 1 .. length(l_caracteres_prohibidos) loop
      l_caracter := substr(l_caracteres_prohibidos, i, 1);
      if instr(i_clave, l_caracter) > 0 then
        raise_application_error(-20000,
                                'La clave no puede contener el caracter "' ||
                                l_caracter || '"');
      end if;
    end loop;
  end;

  procedure p_registrar_clave(i_alias      in varchar2,
                              i_clave      in varchar2,
                              i_tipo_clave in char default 'A') is
    l_id_usuario t_usuarios.id_usuario%type;
    l_orden      t_usuario_claves.orden%type;
    l_hash       t_usuario_claves.hash%type;
    l_salt       t_usuario_claves.salt%type;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_id_usuario(i_alias);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    -- Valida políticas
    p_validar_politicas(i_alias, i_clave, i_tipo_clave);
  
    -- Genera salt
    l_salt := f_salt;
    -- Genera hash
    l_hash := f_hash(i_clave, l_salt);
  
    select nvl(max(c.orden), 0) + 1
      into l_orden
      from t_usuario_claves c
     where c.id_usuario = l_id_usuario
       and c.tipo = i_tipo_clave;
  
    -- Inserta clave de usuario
    insert into t_usuario_claves
      (id_usuario,
       tipo,
       orden,
       estado,
       hash,
       salt,
       algoritmo,
       iteraciones,
       cantidad_intentos_fallidos,
       fecha_ultima_autenticacion)
    values
      (l_id_usuario,
       i_tipo_clave,
       l_orden,
       'N',
       l_hash,
       l_salt,
       c_algoritmo,
       c_iteraciones,
       0,
       null);
  exception
    when k_usuario.ex_usuario_inexistente then
      raise_application_error(-20000, 'Usuario inexistente');
    when dup_val_on_index then
      raise_application_error(-20000,
                              'Usuario ya tiene una clave registrada');
  end;

  procedure p_desbloquear_clave(i_alias      in varchar2,
                                i_tipo_clave in char default 'A') is
    l_id_usuario t_usuarios.id_usuario%type;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_id_usuario(i_alias);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    -- Actualiza clave de usuario
    update t_usuario_claves a
       set estado                     = 'N',
           cantidad_intentos_fallidos = 0,
           fecha_ultima_autenticacion = null
     where id_usuario = l_id_usuario
       and tipo = i_tipo_clave
       and orden = (select max(uc2.orden)
                      from t_usuario_claves uc2
                     where uc2.id_usuario = a.id_usuario
                       and uc2.tipo = a.tipo);
  
    if sql%notfound then
      raise_application_error(-20000, 'Usuario sin clave registrada');
    end if;
  exception
    when k_usuario.ex_usuario_inexistente then
      raise_application_error(-20000, 'Usuario inexistente');
  end;

  procedure p_restablecer_clave(i_alias      in varchar2,
                                i_clave      in varchar2,
                                i_tipo_clave in char default 'A') is
    l_id_usuario t_usuarios.id_usuario%type;
    l_hash       t_usuario_claves.hash%type;
    l_salt       t_usuario_claves.salt%type;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_id_usuario(i_alias);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    -- Valida políticas
    p_validar_politicas(i_alias, i_clave, i_tipo_clave);
  
    -- Genera salt
    l_salt := f_salt;
    -- Genera hash
    l_hash := f_hash(i_clave, l_salt);
  
    -- Actualiza clave de usuario
    update t_usuario_claves a
       set hash                       = l_hash,
           salt                       = l_salt,
           algoritmo                  = c_algoritmo,
           iteraciones                = c_iteraciones,
           estado                     = 'N',
           cantidad_intentos_fallidos = 0,
           fecha_ultima_autenticacion = null
     where id_usuario = l_id_usuario
       and tipo = i_tipo_clave
       and orden = (select max(uc2.orden)
                      from t_usuario_claves uc2
                     where uc2.id_usuario = a.id_usuario
                       and uc2.tipo = a.tipo);
  
    if sql%notfound then
      raise_application_error(-20000, 'Usuario sin clave registrada');
    end if;
  exception
    when k_usuario.ex_usuario_inexistente then
      raise_application_error(-20000, 'Usuario inexistente');
  end;

  procedure p_cambiar_clave(i_alias         in varchar2,
                            i_clave_antigua in varchar2,
                            i_clave_nueva   in varchar2,
                            i_tipo_clave    in char default 'A') is
    l_id_usuario t_usuarios.id_usuario%type;
    l_orden      t_usuario_claves.orden%type;
    l_hash       t_usuario_claves.hash%type;
    l_salt       t_usuario_claves.salt%type;
  begin
    -- Busca usuario
    l_id_usuario := k_usuario.f_id_usuario(i_alias);
  
    if l_id_usuario is null then
      raise k_usuario.ex_usuario_inexistente;
    end if;
  
    if not f_validar_clave(l_id_usuario, i_clave_antigua, i_tipo_clave) then
      raise ex_credenciales_invalidas;
    end if;
  
    -- Valida políticas
    p_validar_politicas(i_alias, i_clave_nueva, i_tipo_clave);
  
    -- Genera salt
    l_salt := f_salt;
    -- Genera hash
    l_hash := f_hash(i_clave_nueva, l_salt);
  
    -- Actualiza clave de usuario antigua
    update t_usuario_claves a
       set estado = 'I'
     where id_usuario = l_id_usuario
       and tipo = i_tipo_clave
       and orden = (select max(uc2.orden)
                      from t_usuario_claves uc2
                     where uc2.id_usuario = a.id_usuario
                       and uc2.tipo = a.tipo)
       and estado in ('N', 'A');
  
    if sql%notfound then
      raise_application_error(-20000, 'Usuario sin clave activa');
    end if;
  
    select nvl(max(c.orden), 0) + 1
      into l_orden
      from t_usuario_claves c
     where c.id_usuario = l_id_usuario
       and c.tipo = i_tipo_clave;
  
    -- Inserta clave de usuario nueva
    insert into t_usuario_claves
      (id_usuario,
       tipo,
       orden,
       estado,
       hash,
       salt,
       algoritmo,
       iteraciones,
       cantidad_intentos_fallidos,
       fecha_ultima_autenticacion)
    values
      (l_id_usuario,
       i_tipo_clave,
       l_orden,
       'N',
       l_hash,
       l_salt,
       c_algoritmo,
       c_iteraciones,
       0,
       null);
  exception
    when k_usuario.ex_usuario_inexistente then
      raise_application_error(-20000, 'Credenciales inválidas');
    when ex_credenciales_invalidas then
      raise_application_error(-20000, 'Credenciales inválidas');
  end;

end;
/
