create or replace package body k_lob_util is

  function f_obtener_blob_desde_clob(i_clob in clob) return blob is
    l_blob    blob;
    l_charset varchar2(100);
  
    l_src_off  integer := 1;
    l_dest_off integer := 1;
    l_lang_ctx integer := 0;
    l_warning  integer := 0;
  begin
    -- 1) Obtener el charset actual de la BD
    select value
      into l_charset
      from nls_database_parameters
     where parameter = 'NLS_CHARACTERSET';
  
    -- 2) Crear un BLOB temporal (escribible)
    dbms_lob.createtemporary(l_blob, true, dbms_lob.session);
  
    -- 3) Convertir CLOB --> BLOB usando el charset de la BD
    dbms_lob.converttoblob(dest_lob     => l_blob,
                           src_clob     => i_clob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_off,
                           src_offset   => l_src_off,
                           blob_csid    => nls_charset_id(l_charset),
                           lang_context => l_lang_ctx,
                           warning      => l_warning);
  
    return l_blob;
  end;

  function f_obtener_clob_desde_blob(i_blob in blob) return clob is
    l_clob    clob;
    l_charset varchar2(100);
  
    l_src_off  integer := 1;
    l_dest_off integer := 1;
    l_lang_ctx integer := 0;
    l_warning  integer := 0;
  begin
    -- 1) Obtener charset de la BD
    select value
      into l_charset
      from nls_database_parameters
     where parameter = 'NLS_CHARACTERSET';
  
    -- 2) Crear un CLOB temporal
    dbms_lob.createtemporary(l_clob, true, dbms_lob.session);
  
    -- 3) Convertir BLOB ? CLOB usando el charset de la BD
    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => i_blob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_off,
                           src_offset   => l_src_off,
                           blob_csid    => nls_charset_id(l_charset),
                           lang_context => l_lang_ctx,
                           warning      => l_warning);
  
    return l_clob;
  end;

end;
/
