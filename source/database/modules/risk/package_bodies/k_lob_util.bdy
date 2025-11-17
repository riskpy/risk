CREATE OR REPLACE PACKAGE BODY k_lob_util IS

  FUNCTION f_obtener_blob_desde_clob(i_clob IN CLOB) RETURN BLOB IS
    l_blob    BLOB;
    l_charset VARCHAR2(100);
  
    l_src_off  INTEGER := 1;
    l_dest_off INTEGER := 1;
    l_lang_ctx INTEGER := 0;
    l_warning  INTEGER := 0;
  BEGIN
    -- 1) Obtener el charset actual de la BD
    SELECT VALUE
      INTO l_charset
      FROM nls_database_parameters
     WHERE parameter = 'NLS_CHARACTERSET';
  
    -- 2) Crear un BLOB temporal (escribible)
    dbms_lob.createtemporary(l_blob, TRUE, dbms_lob.session);
  
    -- 3) Convertir CLOB --> BLOB usando el charset de la BD
    dbms_lob.converttoblob(dest_lob     => l_blob,
                           src_clob     => i_clob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_off,
                           src_offset   => l_src_off,
                           blob_csid    => nls_charset_id(l_charset),
                           lang_context => l_lang_ctx,
                           warning      => l_warning);
  
    RETURN l_blob;
  END;

  FUNCTION f_obtener_clob_desde_blob(i_blob IN BLOB) RETURN CLOB IS
    l_clob    CLOB;
    l_charset VARCHAR2(100);
  
    l_src_off  INTEGER := 1;
    l_dest_off INTEGER := 1;
    l_lang_ctx INTEGER := 0;
    l_warning  INTEGER := 0;
  BEGIN
    -- 1) Obtener charset de la BD
    SELECT VALUE
      INTO l_charset
      FROM nls_database_parameters
     WHERE parameter = 'NLS_CHARACTERSET';
  
    -- 2) Crear un CLOB temporal
    dbms_lob.createtemporary(l_clob, TRUE, dbms_lob.session);
  
    -- 3) Convertir BLOB ? CLOB usando el charset de la BD
    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => i_blob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_off,
                           src_offset   => l_src_off,
                           blob_csid    => nls_charset_id(l_charset),
                           lang_context => l_lang_ctx,
                           warning      => l_warning);
  
    RETURN l_clob;
  END;

END;
/
