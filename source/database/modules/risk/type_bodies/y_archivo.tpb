create or replace type body y_archivo is

  constructor function y_archivo return self as result as
  begin
    self.contenido := null;
    self.url       := null;
    self.checksum  := null;
    self.tamano    := null;
    self.nombre    := null;
    self.extension := null;
    self.tipo_mime := null;
    return;
  end;

  static function parse_json(i_json in clob) return y_objeto is
    l_archivo     y_archivo;
    l_json_object json_object_t;
    l_gzip_base64 clob;
  begin
    l_json_object := json_object_t.parse(i_json);
  
    l_archivo     := new y_archivo();
    l_gzip_base64 := l_json_object.get_clob('contenido');
    if l_gzip_base64 is null or dbms_lob.getlength(l_gzip_base64) = 0 then
      l_archivo.contenido := null;
    else
      -- Decodifica en formato Base64 y descomprime con gzip
      l_archivo.contenido := utl_compress.lz_uncompress(k_util.base64decode(l_gzip_base64));
    end if;
    l_archivo.url       := l_json_object.get_string('url');
    l_archivo.checksum  := l_json_object.get_string('checksum');
    l_archivo.tamano    := l_json_object.get_number('tamano');
    l_archivo.nombre    := l_json_object.get_string('nombre');
    l_archivo.extension := l_json_object.get_string('extension');
    l_archivo.tipo_mime := l_json_object.get_string('tipo_mime');
  
    return l_archivo;
  end;

  overriding member function to_json return clob is
    l_json_object json_object_t;
    l_gzip_base64 clob;
  begin
    if self.contenido is null or dbms_lob.getlength(self.contenido) = 0 then
      l_json_object := json_object_t.parse('{"contenido":null}');
    else
      -- Comprime con gzip y codifica en formato Base64
      l_gzip_base64 := k_util.base64encode(utl_compress.lz_compress(self.contenido));
      -- Elimina caracteres de nueva línea para evitar error de sintaxis JSON
      l_gzip_base64 := replace(l_gzip_base64, utl_tcp.crlf);
      l_json_object := json_object_t.parse('{"contenido":"' ||
                                           l_gzip_base64 || '"}');
    end if;
    l_json_object.put('url', self.url);
    l_json_object.put('checksum', self.checksum);
    l_json_object.put('tamano', self.tamano);
    l_json_object.put('nombre', self.nombre);
    l_json_object.put('extension', self.extension);
    l_json_object.put('tipo_mime', self.tipo_mime);
    return l_json_object.to_clob;
  end;

end;
/
