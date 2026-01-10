create or replace package body k_util is

  c_algoritmo constant pls_integer := as_crypto.encrypt_aes +
                                      as_crypto.chain_cbc +
                                      as_crypto.pad_pkcs5; -- dbms_crypto.aes_cbc_pkcs5;

  procedure p_generar_trigger_secuencia(i_tabla    in varchar2,
                                        i_campo    in varchar2,
                                        i_trigger  in varchar2 default null,
                                        i_ejecutar in boolean default true) is
    l_sentencia varchar2(4000);
    l_trigger   varchar2(30);
  begin
    l_trigger := lower(nvl(i_trigger, 'gs_' || substr(i_tabla, 3)));
  
    -- Genera secuencia
    l_sentencia := 'CREATE SEQUENCE s_' || lower(i_campo) || ' NOCACHE';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  
    -- Genera trigger
    l_sentencia := 'CREATE OR REPLACE TRIGGER ' || l_trigger || '
  BEFORE INSERT ON ' || lower(i_tabla) || '
  FOR EACH ROW
BEGIN
  /*
  --------------------------------- MIT License ---------------------------------
  Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  -------------------------------------------------------------------------------
  */

  IF :new.' || lower(i_campo) || ' IS NULL THEN
    :new.' || lower(i_campo) || ' := s_' ||
                   lower(i_campo) || '.nextval;
  END IF;
END;';
    if i_ejecutar then
      execute immediate l_sentencia;
    else
      dbms_output.put_line(l_sentencia);
    end if;
  end;

  function f_valor_secuencia_id(i_tabla in varchar2) return number is
    l_valor     number;
    l_secuencia all_sequences.sequence_name%type;
  begin
    begin
      select 'ISEQ$$_' || object_id
        into l_secuencia
        from all_objects
       where object_type = 'TABLE'
         and object_name = upper(i_tabla);
    
      execute immediate 'select ' || l_secuencia || '.nextval from dual'
        into l_valor;
    exception
      when others then
        l_valor := null;
    end;
  
    return l_valor;
  end;

  function f_valor_parametro(i_id_parametro in varchar2) return varchar2 is
  begin
    return k_parametro.f_valor_parametro(k_parametro.c_tabla_parametros,
                                         i_id_parametro);
  exception
    when others then
      return null;
  end;

  procedure p_actualizar_valor_parametro(i_id_parametro in varchar2,
                                         i_valor        in varchar2) is
  begin
    k_parametro.p_definir_parametro(k_parametro.c_tabla_parametros,
                                    i_id_parametro,
                                    i_valor);
  end;

  function f_hash(i_data      in varchar2,
                  i_hash_type in pls_integer) return varchar2 deterministic is
  begin
    return rawtohex(as_crypto.hash(utl_raw.cast_to_raw(i_data),
                                   i_hash_type));
  end;

  -- https://stackoverflow.com/a/16900226
  function get_dotnet_ticks(intimestamp in timestamp) return number as
    -- **********************************************************************************
    -- File name:         Get_DotNet_Ticks
    -- Original Author:   Roberto Lopes
    -- Creation Date:     October 2012
    -- Description:       Returns the number of ticks for the provided timestamp, based
    --                    on the Microsoft .Net algorithm
    -- **********************************************************************************
    begindate timestamp := to_timestamp('0001-01-03', 'YYYY-MM-DD'); --.Net Ticks are counted starting from this date
  begin
    return(extract(day from(intimestamp - begindate)) * 86400000 +
           (to_number(to_char(intimestamp, 'SSSSSFF3')))) * 10000;
  end;

  -- https://stackoverflow.com/a/50413505
  function guid return varchar2 as
  begin
    return regexp_replace(sys_guid(),
                          '(.{8})(.{4})(.{4})(.{4})(.{12})',
                          '\1-\2-\3-\4-\5');
  end;

  function randomuuid return varchar2 as
    language java name 'RandomUUID.create() return java.lang.String';

  /**
  Genera par de claves RSA separadas por punto (.)
  Formato: public_key.private_key
  
  %author dmezac 01/04/2025
  %return Par de claves RSA separadas por punto (.) en formato public_key.private_key
  */
  function rsakeypairgenerator return varchar2 as
    language java name 'RsaKeyPairGenerator.create() return java.lang.String';

  function bool_to_string(i_bool in boolean) return varchar2 is
  begin
    if i_bool is null then
      return null;
    elsif i_bool then
      return 'S';
    else
      return 'N';
    end if;
  end;

  function string_to_bool(i_string in varchar2) return boolean is
  begin
    if i_string is null then
      return null;
    elsif lower(i_string) in ('1', 'true', 't', 'yes', 'y', 'si', 's') then
      return true;
    elsif lower(i_string) in ('0', 'false', 'f', 'no', 'n') then
      return false;
    else
      return null;
    end if;
  end;

  function blob_to_clob(p_data in blob) return clob is
    -- -----------------------------------------------------------------------------------
    -- File Name    : https://oracle-base.com/dba/miscellaneous/blob_to_clob.sql
    -- Author       : Tim Hall
    -- Description  : Converts a BLOB to a CLOB.
    -- Last Modified: 26/12/2016
    -- -----------------------------------------------------------------------------------
    l_clob         clob;
    l_dest_offset  pls_integer := 1;
    l_src_offset   pls_integer := 1;
    l_lang_context pls_integer := dbms_lob.default_lang_ctx;
    l_warning      pls_integer;
  begin
    dbms_lob.createtemporary(lob_loc => l_clob, cache => true);
  
    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => p_data,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => dbms_lob.default_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);
  
    return l_clob;
  end;

  function clob_to_blob(p_data    in clob,
                        p_charset in varchar2 default null) return blob is
    -- -----------------------------------------------------------------------------------
    -- File Name    : https://oracle-base.com/dba/miscellaneous/clob_to_blob.sql
    -- Author       : Tim Hall
    -- Description  : Converts a CLOB to a BLOB.
    -- Last Modified: 26/12/2016
    -- -----------------------------------------------------------------------------------
    l_blob         blob;
    l_dest_offset  pls_integer := 1;
    l_src_offset   pls_integer := 1;
    l_lang_context pls_integer := dbms_lob.default_lang_ctx;
    l_warning      pls_integer := dbms_lob.warn_inconvertible_char;
    l_blob_csid    number := nvl(nls_charset_id(p_charset),
                                 dbms_lob.default_csid);
  begin
    dbms_lob.createtemporary(lob_loc => l_blob, cache => true);
  
    dbms_lob.converttoblob(dest_lob     => l_blob,
                           src_clob     => p_data,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);
  
    return l_blob;
  end;

  function base64encode(i_blob in blob) return clob is
    -- -----------------------------------------------------------------------------------
    -- File Name    : https://oracle-base.com/dba/miscellaneous/base64encode.sql
    -- Author       : Tim Hall
    -- Description  : Encodes a BLOB into a Base64 CLOB.
    -- Last Modified: 09/11/2011
    -- -----------------------------------------------------------------------------------
    l_clob clob;
    l_step pls_integer := 12000; -- make sure you set a multiple of 3 not higher than 24573
  begin
    if i_blob is not null and dbms_lob.getlength(i_blob) > 0 then
      for i in 0 .. trunc((dbms_lob.getlength(i_blob) - 1) / l_step) loop
        l_clob := l_clob ||
                  utl_raw.cast_to_varchar2(utl_encode.base64_encode(dbms_lob.substr(i_blob,
                                                                                    l_step,
                                                                                    i *
                                                                                    l_step + 1)));
      end loop;
    end if;
    return l_clob;
  end;

  function base64decode(i_clob in clob) return blob is
    -- -----------------------------------------------------------------------------------
    -- File Name    : https://oracle-base.com/dba/miscellaneous/base64decode.sql
    -- Author       : Tim Hall
    -- Description  : Decodes a Base64 CLOB into a BLOB
    -- Last Modified: 09/11/2011
    -- -----------------------------------------------------------------------------------
    l_blob   blob;
    l_raw    raw(32767);
    l_amt    number := 7700;
    l_offset number := 1;
    l_temp   varchar2(32767);
  begin
    begin
      dbms_lob.createtemporary(l_blob, false, dbms_lob.call);
      loop
        dbms_lob.read(i_clob, l_amt, l_offset, l_temp);
        l_offset := l_offset + l_amt;
        l_raw    := utl_encode.base64_decode(utl_raw.cast_to_raw(l_temp));
        dbms_lob.append(l_blob, to_blob(l_raw));
      end loop;
    exception
      when no_data_found then
        null;
    end;
    return l_blob;
  end;

  function encrypt(i_src in varchar2) return varchar2 is
  begin
    return rawtohex(as_crypto.encrypt(src => utl_i18n.string_to_raw(i_src,
                                                                    'AL32UTF8'),
                                      typ => c_algoritmo,
                                      key => hextoraw(f_valor_parametro('CLAVE_ENCRIPTACION_DESENCRIPTACION'))));
  end;

  function decrypt(i_src in varchar2) return varchar2 is
  begin
    return utl_i18n.raw_to_char(as_crypto.decrypt(src => hextoraw(i_src),
                                                  typ => c_algoritmo,
                                                  key => hextoraw(f_valor_parametro('CLAVE_ENCRIPTACION_DESENCRIPTACION'))),
                                'AL32UTF8');
  end;

  function read_http_body(resp in out utl_http.resp) return clob as
    l_http_body clob;
    l_data      varchar2(1024);
  begin
    begin
      loop
        utl_http.read_text(resp, l_data, 1024);
        l_http_body := l_http_body || l_data;
      end loop;
    exception
      when utl_http.end_of_body then
        null;
      when others then
        l_http_body := null;
    end;
    return l_http_body;
  end;

  function f_base_datos return varchar2 is
  begin
    return sys_context('USERENV', 'DB_NAME');
  end;

  function f_terminal return varchar2 is
  begin
    return sys_context('USERENV', 'TERMINAL');
  end;

  function f_host return varchar2 is
  begin
    return sys_context('USERENV', 'HOST');
  end;

  function f_direccion_ip return varchar2 is
  begin
    return sys_context('USERENV', 'IP_ADDRESS');
  end;

  function f_esquema_actual return varchar2 is
  begin
    return sys_context('USERENV', 'CURRENT_SCHEMA');
  end;

  function f_charset return varchar2 is
    l_characterset nls_database_parameters.value%type;
  begin
    begin
      select value
        into l_characterset
        from nls_database_parameters
       where parameter = 'NLS_CHARACTERSET';
    exception
      when others then
        l_characterset := null;
    end;
    return utl_i18n.map_charset(l_characterset);
  end;

  function f_es_valor_numerico(i_valor in varchar2) return boolean is
    l_numero number(20, 2);
    l_result boolean;
  begin
    l_result := false;
    l_numero := to_number(i_valor);
    l_result := true;
    return l_result;
  exception
    when others then
      return l_result;
  end;

  function f_es_valor_numerico_sn(i_valor in varchar2) return varchar2 is
  begin
    return bool_to_string(f_es_valor_numerico(i_valor));
  end;

  function f_zona_horaria(i_zona_horaria in varchar2) return varchar2 is
    l_zona   number(18, 2);
    l_tiempo number(15);
    l_hora   number(15);
    l_minuto number(3);
    --
    l_retorno    varchar2(10);
    l_validacion date;
  begin
    if f_es_valor_numerico(i_zona_horaria) then
      l_zona := to_number(i_zona_horaria);
    
      l_tiempo := l_zona * 3600;
    
      l_hora   := trunc(l_tiempo / 3600);
      l_tiempo := abs((l_tiempo - (l_hora * 3600)) mod 3600);
      l_minuto := trunc(l_tiempo / 60);
    
      l_retorno := to_char(l_hora) || ':' || to_char(l_minuto);
    else
      l_retorno := i_zona_horaria;
    end if;
  
    select cast(current_timestamp at time zone (select l_retorno from dual) as date) fecha
      into l_validacion
      from dual;
  
    return l_retorno;
  exception
    when others then
      return null;
  end;

end;
/

