# Base de Datos

## Contenido
* [Introducción](#introducción)
* [Instalación](#instalación)
* [Operaciones](#operaciones)
* [Configuraciones](#configuraciones)
* [API PL/SQL](plsqldoc/index.html)
* [Guía de estilo para Desarrollo](styleguide.md)

## Introducción
Este componente consiste en una instancia de Base de Datos Oracle con un esquema central en el que se encuentra instalada una colección de objetos (paquetes, types, tablas, entre otros), que se encarga de persistir los datos e implementar la mayor parte de la lógica de negocio del sistema.

## Instalación
En la carpeta *source/database* está disponible una serie de scripts para la instalación y manejo del esquema de Base de Datos:

Script|Descripción
------|-----------
compile_schema.sql|Compila objetos inválidos del esquema actual.
create_private_synonyms.sql|Crea sinónimos privados en cada esquema de módulo para referenciar objetos de otros esquemas sin necesidad de usar el prefijo de esquema.
create_public_synonyms.sql|Crea sinónimos públicos para los objetos de los esquemas del proyecto, permitiendo acceder a ellos sin prefijo de esquema.
create_schemas.sql|Crea los usuarios y roles del proyecto y les concede los permisos básicos necesarios para operar.
define_variables.sql|Define las variables de sustitución (nombres de esquema/usuario) utilizadas por los scripts de instalación.
drop_private_synonyms.sql|Elimina sinónimos privados obsoletos (que apuntan a objetos inexistentes).
drop_public_synonyms.sql|Elimina sinónimos públicos obsoletos (que apuntan a objetos inexistentes).
drop_schemas.sql|Elimina los usuarios y roles creados por el proceso de instalación (incluye CASCADE).
grant_objects.sql|Otorga privilegios de ejecución/selección/inserción/actualización a los usuarios de módulo sobre los objetos del esquema del proyecto.
grant_objects_access_role.sql|Otorga permisos necesarios al rol de acceso a la Base de Datos desde el API.
install_audit.sql|Genera campos y triggers de auditoría para tablas del esquema actual.
install_dependencies.sql|Instala en el esquema actual las dependencias de terceros (Ver [Dependencias](#dependencias)).
install_headless.sql|Crea usuarios, otorga permisos necesarios e instala los objetos de Base de Datos del Proyecto RISK.
install_tapi.sql|Genera API's para tablas del esquema actual.
set_compiler_flags.sql|Configura las banderas de compilación condicional PL/SQL (PLSQL_CCFLAGS) para los módulos y recompila el paquete K_MODULO.
uninstall_audit.sql|Elimina campos y triggers de auditoría para tablas del esquema actual.
uninstall_dependencies.sql|Desinstala del esquema actual las dependencias de terceros.
uninstall_headless.sql|Elimina usuarios creados y sus objetos de Base de Datos.
uninstall_tapi.sql|Elimina API's para tablas del esquema actual.

### Dependencias

Dependencia|Descripción
-----------|-----------
[as_crypto](https://github.com/antonscheffer/as_crypto)|Contiene funciones/procedimientos básicos de criptografía (alternativa a dbms_crypto)
[as_pdf](https://github.com/jtsoya539/as_pdf)|Genera archivos en formato PDF
[as_xlsx](https://github.com/antonscheffer/as_xlsx)|Genera archivos en formato XLSX
[as_zip](https://github.com/antonscheffer/as_zip)|Comprime y descomprime archivos en formato ZIP
[csv](https://oracle-base.com/dba/script?category=miscellaneous&file=csv.sql)|Genera archivos en formato CSV
[LOB2Table](https://sourceforge.net/projects/lob2table/)|Importa archivos en formato CSV o columnas fijas
[oos_util_totp](https://github.com/OraOpenSource/oos-utils)|Genera y valida códigos con el algoritmo TOTP
[zt_qr](https://github.com/zorantica/plsql-qr-code)|Genera códigos QR
[zt_word](https://github.com/zorantica/plsql-word)|Genera archivos en formato DOCX
[fn_gen_inserts](https://github.com/teopost/oracle-scripts)|Genera script para insertar registros en una tabla
[console](https://github.com/ogobrecht/console)|Herramienta para logging
[om_tapigen](https://github.com/OraMUC/table-api-generator)|Generador de API's para tablas
[plex](https://github.com/ogobrecht/plex)|Herramienta para exportación de objetos
[audit_utility](https://github.com/connormcd/audit_utility)|Genera tablas, paquetes y triggers de auditoría para capturar cambios en tablas (utilizado para registrar DML y mantenimiento).
[occ](https://github.com/yerba1704/occ)|Framework de reglas de calidad para objetos PL/SQL (ora* CODECOP), usado para validar convenciones de código y estructura de objetos.
[occ-utplsql](https://github.com/yerba1704/occ-utplsql)|Extensión que genera pruebas unitarias de utPLSQL basadas en las reglas de ora* CODECOP.

### Configuración de PL/SQL Documentation (plsqldoc)

Para configurar el Plug-In PL/SQL Documentation (plsqldoc) en PL/SQL Developer seguir estos pasos:

1. Ir al menú *Plug-Ins* y en el apartado *plsqldoc* dar click en *Configure...*

![](plugins_configure.png)

2. Usar la siguiente configuración:

![](plsqldoc_config.png)

## Operaciones

El corazón de RISK está en las operaciones y el procesamiento de sus parámetros.

Una operación es cualquier programa o proceso que recibe parámetros de entrada y retorna una salida como resultado.

El resultado de una operación puede variar desde un simple indicador de éxito/error a datos complejos con propiedades y listas, o incluso archivos, como en el caso de los reportes.

Existen 6 tipos de operaciones:

Tipo|Descripción
----|-----------
Parámetros|Es un tipo de operación que sirve para agrupar ciertos parámetros especiales y no tiene una implementación
Servicio|Es un proceso que recibe datos de entrada y retorna datos de salida. Sirve de comunicación entre el API y la Base de Datos
Reporte|Es un proceso que recibe datos de entrada y retorna como salida un archivo de reporte, que puede ser en formatos PDF, DOCX, XLSX, CSV, HTML. Sirve de comunicación entre el API y la Base de Datos
Trabajo|Es un proceso que se ejecuta automáticamente en un intervalo de repetición configurado
Monitoreo|Es un proceso periódico que verifica el estado del sistema o de datos y genera alertas o informes
Importación|TO-DO

### Parámetros

Tipos de datos existentes y soporte:

Tipo de dato|Parámetro de operación|Parámetro de sesión|Parámetro de contexto|Parámetro adicional|Dato adicional
------------|----------------------|-------------------|---------------------|-------------------|--------------
S-STRING|✅|✅|✅|✅|✅
N-NUMBER|✅|✅|🔜|🔜|🔜
B-BOOLEAN|✅|✅|🔜|🔜|🔜
D-DATE|✅|✅|🔜|🔜|🔜
O-OBJECT|✅|❌|❌|❌|❌
J-JSON OBJECT|✅|✅|❌|❌|❌
A-JSON ARRAY|✅|✅|❌|❌|❌
C-CLOB|✅|✅|❌|❌|❌

### Logs
TO-DO

## Configuraciones

### Parámetros
TO-DO

### Diccionario
TO-DO