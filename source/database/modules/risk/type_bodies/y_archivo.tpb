CREATE OR REPLACE TYPE BODY y_archivo IS

  CONSTRUCTOR FUNCTION y_archivo RETURN SELF AS RESULT AS
  BEGIN
    self.contenido := NULL;
    self.url       := NULL;
    self.checksum  := NULL;
    self.tamano    := NULL;
    self.nombre    := NULL;
    self.extension := NULL;
    self.tipo_mime := NULL;
    RETURN;
  END;

  STATIC FUNCTION parse_json(i_json IN CLOB) RETURN y_objeto IS
    l_archivo     y_archivo;
    l_json_object json_object_t;
    l_gzip_base64 CLOB;
  BEGIN
    l_json_object := json_object_t.parse(i_json);
  
    l_archivo     := NEW y_archivo();
    l_gzip_base64 := l_json_object.get_clob('contenido');
    IF l_gzip_base64 IS NULL OR dbms_lob.getlength(l_gzip_base64) = 0 THEN
      l_archivo.contenido := NULL;
    ELSE
      -- Decodifica en formato Base64 y descomprime con gzip
      l_archivo.contenido := utl_compress.lz_uncompress(k_util.base64decode(l_gzip_base64));
    END IF;
    l_archivo.url       := l_json_object.get_string('url');
    l_archivo.checksum  := l_json_object.get_string('checksum');
    l_archivo.tamano    := l_json_object.get_number('tamano');
    l_archivo.nombre    := l_json_object.get_string('nombre');
    l_archivo.extension := l_json_object.get_string('extension');
    l_archivo.tipo_mime := l_json_object.get_string('tipo_mime');
  
    RETURN l_archivo;
  END;

  OVERRIDING MEMBER FUNCTION to_json RETURN CLOB IS
    l_json_object json_object_t;
    l_gzip_base64 CLOB;
  BEGIN
    IF self.contenido IS NULL OR dbms_lob.getlength(self.contenido) = 0 THEN
      l_json_object := json_object_t.parse('{"contenido":null}');
    ELSE
      -- Comprime con gzip y codifica en formato Base64
      l_gzip_base64 := k_util.base64encode(utl_compress.lz_compress(self.contenido));
      -- Elimina caracteres de nueva línea para evitar error de sintaxis JSON
      l_gzip_base64 := REPLACE(l_gzip_base64, utl_tcp.crlf);
      l_json_object := json_object_t.parse('{"contenido":"' ||
                                           l_gzip_base64 || '"}');
    END IF;
    l_json_object.put('url', self.url);
    l_json_object.put('checksum', self.checksum);
    l_json_object.put('tamano', self.tamano);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('extension', self.extension);
    l_json_object.put('tipo_mime', self.tipo_mime);
    RETURN l_json_object.to_clob;
  END;

END;
/
