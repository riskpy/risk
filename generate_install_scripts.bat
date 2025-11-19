@echo off
setlocal enabledelayedexpansion

:: Base directory for modules
set BASE_DIR=%~dp0source\database\modules

:: Create a temporary directory for sorted files
set TEMP_DIR=%TEMP%\sorted_files
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"

:: Loop through each module directory
for /d %%d in ("%BASE_DIR%\*") do (
    echo Processing module: %%~nxd
    
    :: Generate module install.sql
    echo Generating install script for %%~nxd...
(
    echo /*
    echo --------------------------------- MIT License ---------------------------------
    echo Copyright ^(c^) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
    echo.
    echo Permission is hereby granted, free of charge, to any person obtaining a copy
    echo of this software and associated documentation files ^(the ^"Software^"^), to deal
    echo in the Software without restriction, including without limitation the rights
    echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    echo copies of the Software, and to permit persons to whom the Software is
    echo furnished to do so, subject to the following conditions:
    echo.
    echo The above copyright notice and this permission notice shall be included in all
    echo copies or substantial portions of the Software.
    echo.
    echo THE SOFTWARE IS PROVIDED ^"AS IS^", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    echo SOFTWARE.
    echo -------------------------------------------------------------------------------
    echo */
    echo.
    echo spool install.log
    echo.
    echo set feedback off
    echo set define off
    echo.
    echo prompt ###################################
    echo prompt #   _____   _____   _____  _  __  #
    echo prompt #  ^|  __ \ ^|_   _^| / ____^|^| ^|/ /  #
    echo prompt #  ^| ^|__^) ^|  ^| ^|  ^| ^(___  ^| ' /   #
    echo prompt #  ^|  _  /   ^| ^|   \___ \ ^|  ^<    #
    echo prompt #  ^| ^| \ \  _^| ^|_  ____^) ^|^| . \   #
    echo prompt #  ^|_^|  \_\^|_____^|^|_____/ ^|_^|\_\  #
    echo prompt #                                 #
    echo prompt #            jtsoya539            #
    echo prompt ###################################
    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Installation started
    echo prompt ===================================
    echo prompt
    echo @@../../set_compiler_flags.sql %%~nxd
    if not "%%~nxd"=="risk" (
        echo @@../risk/package_specs/k_modulo.spc
    )

    echo.
    echo prompt
    echo prompt Creating sequences...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of sequence files
    if exist "%%d\sequences\*.seq" (
        dir /b "%%d\sequences\*.seq" > "%TEMP_DIR%\sequences.txt"
        sort "%TEMP_DIR%\sequences.txt" /o "%TEMP_DIR%\sequences_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\sequences_sorted.txt) do (
            echo @@sequences/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating tables...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of table files
    if exist "%%d\tables\*.tab" (
        dir /b "%%d\tables\*.tab" > "%TEMP_DIR%\tables.txt"
        sort "%TEMP_DIR%\tables.txt" /o "%TEMP_DIR%\tables_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\tables_sorted.txt) do (
            echo @@tables/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating foreign keys...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of foreign key files
    if exist "%%d\foreign_keys\*.sql" (
        dir /b "%%d\foreign_keys\*.sql" > "%TEMP_DIR%\foreign_keys.txt"
        sort "%TEMP_DIR%\foreign_keys.txt" /o "%TEMP_DIR%\foreign_keys_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\foreign_keys_sorted.txt) do (
            echo @@foreign_keys/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating views...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of view files
    if exist "%%d\views\*.vw" (
        dir /b "%%d\views\*.vw" > "%TEMP_DIR%\views.txt"
        sort "%TEMP_DIR%\views.txt" /o "%TEMP_DIR%\views_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\views_sorted.txt) do (
            echo @@views/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating type specs...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of type spec files
    if exist "%%d\type_specs\*.tps" (
        dir /b "%%d\type_specs\*.tps" > "%TEMP_DIR%\type_specs.txt"
        sort "%TEMP_DIR%\type_specs.txt" /o "%TEMP_DIR%\type_specs_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\type_specs_sorted.txt) do (
            echo @@type_specs/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating type bodies...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of type body files
    if exist "%%d\type_bodies\*.tpb" (
        dir /b "%%d\type_bodies\*.tpb" > "%TEMP_DIR%\type_bodies.txt"
        sort "%TEMP_DIR%\type_bodies.txt" /o "%TEMP_DIR%\type_bodies_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\type_bodies_sorted.txt) do (
            echo @@type_bodies/%%f
        )
    )

    echo.
    echo prompt
    echo prompt Creating java sources...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of java source files
    if exist "%%d\java\*.jsp" (
        dir /b "%%d\java\*.jsp" > "%TEMP_DIR%\java.txt"
        sort "%TEMP_DIR%\java.txt" /o "%TEMP_DIR%\java_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\java_sorted.txt) do (
            echo @@java/%%f
        )
    )

    echo.
    echo prompt
    echo prompt Creating functions...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of function files
    if exist "%%d\functions\*.fnc" (
        dir /b "%%d\functions\*.fnc" > "%TEMP_DIR%\functions.txt"
        sort "%TEMP_DIR%\functions.txt" /o "%TEMP_DIR%\functions_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\functions_sorted.txt) do (
            echo @@functions/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating procedures...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of procedure files
    if exist "%%d\procedures\*.prc" (
        dir /b "%%d\procedures\*.prc" > "%TEMP_DIR%\procedures.txt"
        sort "%TEMP_DIR%\procedures.txt" /o "%TEMP_DIR%\procedures_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\procedures_sorted.txt) do (
            echo @@procedures/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating package specs...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of package spec files
    if exist "%%d\package_specs\*.spc" (
        dir /b "%%d\package_specs\*.spc" > "%TEMP_DIR%\package_specs.txt"
        sort "%TEMP_DIR%\package_specs.txt" /o "%TEMP_DIR%\package_specs_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\package_specs_sorted.txt) do (
            echo @@package_specs/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating package bodies...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of package body files
    if exist "%%d\package_bodies\*.bdy" (
        dir /b "%%d\package_bodies\*.bdy" > "%TEMP_DIR%\package_bodies.txt"
        sort "%TEMP_DIR%\package_bodies.txt" /o "%TEMP_DIR%\package_bodies_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\package_bodies_sorted.txt) do (
            echo @@package_bodies/%%f
        )
    )
    
    echo.
    echo prompt
    echo prompt Creating triggers...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of trigger files
    if exist "%%d\triggers\*.trg" (
        dir /b "%%d\triggers\*.trg" > "%TEMP_DIR%\triggers.txt"
        sort "%TEMP_DIR%\triggers.txt" /o "%TEMP_DIR%\triggers_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\triggers_sorted.txt) do (
            echo @@triggers/%%f
        )
    )
    
    echo.
    echo @@../../compile_schema.sql

    echo.
    echo prompt
    echo prompt Running scripts...
    echo prompt -----------------------------------
    echo prompt
    if "%%~nxd"=="auditorias" (
        echo begin p_configurar_modificacion^(pin_aplicacion =^> 'SQLPLUS'^); end;
        echo /
    )
    echo @@scripts/ins_t_modulos.sql
    echo @@scripts/ins_t_dominios.sql
    echo @@scripts/ins_t_significado_dominios.sql
    echo @@scripts/ins_t_significados.sql
    echo @@scripts/ins_t_parametro_definiciones.sql
    echo @@scripts/ins_t_parametros.sql
    echo @@scripts/ins_t_aplicaciones.sql
    echo @@scripts/ins_t_errores.sql
    if "%%~nxd"=="risk" (
        echo @@scripts/ins_t_autenticacion_origenes.sql
        echo @@scripts/ins_t_roles.sql
    )
    :: Create sorted list of operation install script files
    if exist "%%d\scripts\operations\install*.sql" (
        dir /b "%%d\scripts\operations\install*.sql" > "%TEMP_DIR%\operations_install.txt"
        sort "%TEMP_DIR%\operations_install.txt" /o "%TEMP_DIR%\operations_install_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\operations_install_sorted.txt) do (
            echo @@scripts/operations/%%f
        )
    )
    echo commit;
    echo /

    echo.
    echo prompt
    echo prompt Running additional scripts...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of additional install script files
    if exist "%%d\install_scripts*.sql" (
        dir /b "%%d\install_scripts*.sql" > "%TEMP_DIR%\install_scripts.txt"
        sort "%TEMP_DIR%\install_scripts.txt" /o "%TEMP_DIR%\install_scripts_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\install_scripts_sorted.txt) do (
            echo @@%%f
        )
    )
    echo commit;
    echo /

    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Installation completed
    echo prompt ===================================
    echo prompt
    echo.
    echo spool off
) > "%%d\install.sql"

    :: Generate module uninstall.sql
    echo Generating uninstall script for %%~nxd...
(
    echo /*
    echo --------------------------------- MIT License ---------------------------------
    echo Copyright ^(c^) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
    echo.
    echo Permission is hereby granted, free of charge, to any person obtaining a copy
    echo of this software and associated documentation files ^(the ^"Software^"^), to deal
    echo in the Software without restriction, including without limitation the rights
    echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    echo copies of the Software, and to permit persons to whom the Software is
    echo furnished to do so, subject to the following conditions:
    echo.
    echo The above copyright notice and this permission notice shall be included in all
    echo copies or substantial portions of the Software.
    echo.
    echo THE SOFTWARE IS PROVIDED ^"AS IS^", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    echo SOFTWARE.
    echo -------------------------------------------------------------------------------
    echo */
    echo.
    echo spool uninstall.log
    echo.
    echo set feedback off
    echo set define off
    echo.
    echo prompt ###################################
    echo prompt #   _____   _____   _____  _  __  #
    echo prompt #  ^|  __ \ ^|_   _^| / ____^|^| ^|/ /  #
    echo prompt #  ^| ^|__^) ^|  ^| ^|  ^| ^(___  ^| ' /   #
    echo prompt #  ^|  _  /   ^| ^|   \___ \ ^|  ^<    #
    echo prompt #  ^| ^| \ \  _^| ^|_  ____^) ^|^| . \   #
    echo prompt #  ^|_^|  \_\^|_____^|^|_____/ ^|_^|\_\  #
    echo prompt #                                 #
    echo prompt #            jtsoya539            #
    echo prompt ###################################
    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Uninstallation started
    echo prompt ===================================
    echo prompt

    echo.
    echo prompt
    echo prompt Dropping triggers...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of trigger files for uninstall
    if exist "%%d\triggers\*.trg" (
        dir /b "%%d\triggers\*.trg" > "%TEMP_DIR%\triggers_uninstall.txt"
        sort "%TEMP_DIR%\triggers_uninstall.txt" /o "%TEMP_DIR%\triggers_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\triggers_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop trigger %%a;
        )
    )

    echo.
    echo prompt
    echo prompt Dropping packages...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of package body files for uninstall
    if exist "%%d\package_bodies\*.bdy" (
        dir /b "%%d\package_bodies\*.bdy" > "%TEMP_DIR%\package_bodies_uninstall.txt"
        sort "%TEMP_DIR%\package_bodies_uninstall.txt" /o "%TEMP_DIR%\package_bodies_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\package_bodies_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop package %%a;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping procedures...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of procedure files for uninstall
    if exist "%%d\procedures\*.prc" (
        dir /b "%%d\procedures\*.prc" > "%TEMP_DIR%\procedures_uninstall.txt"
        sort "%TEMP_DIR%\procedures_uninstall.txt" /o "%TEMP_DIR%\procedures_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\procedures_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop procedure %%a;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping functions...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of function files for uninstall
    if exist "%%d\functions\*.fnc" (
        dir /b "%%d\functions\*.fnc" > "%TEMP_DIR%\functions_uninstall.txt"
        sort "%TEMP_DIR%\functions_uninstall.txt" /o "%TEMP_DIR%\functions_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\functions_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop function %%a;
        )
    )

    echo.
    echo prompt
    echo prompt Dropping java sources...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of java source files for uninstall
    if exist "%%d\java\*.jsp" (
        dir /b "%%d\java\*.jsp" > "%TEMP_DIR%\java_uninstall.txt"
        sort "%TEMP_DIR%\java_uninstall.txt" /o "%TEMP_DIR%\java_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\java_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop java source %%a;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping types...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of type spec files for uninstall
    if exist "%%d\type_specs\*.tps" (
        dir /b "%%d\type_specs\*.tps" > "%TEMP_DIR%\type_specs_uninstall.txt"
        sort "%TEMP_DIR%\type_specs_uninstall.txt" /o "%TEMP_DIR%\type_specs_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\type_specs_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop type %%a force;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping views...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of view files for uninstall
    if exist "%%d\views\*.vw" (
        dir /b "%%d\views\*.vw" > "%TEMP_DIR%\views_uninstall.txt"
        sort "%TEMP_DIR%\views_uninstall.txt" /o "%TEMP_DIR%\views_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\views_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop view %%a cascade constraints;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping tables...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of table files for uninstall
    if exist "%%d\tables\*.tab" (
        dir /b "%%d\tables\*.tab" > "%TEMP_DIR%\tables_uninstall.txt"
        sort "%TEMP_DIR%\tables_uninstall.txt" /o "%TEMP_DIR%\tables_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\tables_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop table %%a cascade constraints purge;
        )
    )
    
    echo.
    echo prompt
    echo prompt Dropping sequences...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of sequence files for uninstall
    if exist "%%d\sequences\*.seq" (
        dir /b "%%d\sequences\*.seq" > "%TEMP_DIR%\sequences_uninstall.txt"
        sort "%TEMP_DIR%\sequences_uninstall.txt" /o "%TEMP_DIR%\sequences_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\sequences_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop sequence %%a;
        )
    )
    
    echo.
    echo prompt
    echo prompt Purging recycle bin...
    echo prompt -----------------------------------
    echo prompt
    echo purge recyclebin;
    
    echo.
    echo --@@../../packages/k_modulo.pck
    echo @@../../compile_schema.sql

    echo.
    echo prompt
    echo prompt Running additional scripts...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of additional uninstall script files
    if exist "%%d\uninstall_scripts*.sql" (
        dir /b "%%d\uninstall_scripts*.sql" > "%TEMP_DIR%\uninstall_scripts.txt"
        sort "%TEMP_DIR%\uninstall_scripts.txt" /o "%TEMP_DIR%\uninstall_scripts_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\uninstall_scripts_sorted.txt) do (
            echo @@%%f
        )
    )
    echo commit;
    echo /

    echo.
    echo prompt
    echo prompt Running scripts...
    echo prompt -----------------------------------
    echo prompt
    :: Create sorted list of operation uninstall script files
    if exist "%%d\scripts\operations\uninstall*.sql" (
        dir /b "%%d\scripts\operations\uninstall*.sql" > "%TEMP_DIR%\operations_uninstall.txt"
        sort "%TEMP_DIR%\operations_uninstall.txt" /o "%TEMP_DIR%\operations_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\operations_uninstall_sorted.txt) do (
            echo @@scripts/operations/%%f
        )
    )
    if not "%%~nxd"=="risk" (
        echo @@scripts/del_t_errores.sql
        echo @@scripts/del_t_aplicaciones.sql
        echo @@scripts/del_t_parametros.sql
        echo @@scripts/del_t_parametro_definiciones.sql
        echo @@scripts/del_t_significados.sql
        echo @@scripts/del_t_significado_dominios.sql
        echo @@scripts/del_t_dominios.sql
        echo @@scripts/del_t_modulos.sql
    )
    echo commit;
    echo /

    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Uninstallation completed
    echo prompt ===================================
    echo prompt
    echo.
    echo spool off
) > "%%d\uninstall.sql"
)

:: Generate tests install/uninstall scripts (only package specs / bodies)
set TEST_DIR=%~dp0test\database
if exist "%TEST_DIR%" (
    echo Generating tests install script...
(
    echo /*
    echo --------------------------------- MIT License ---------------------------------
    echo Copyright ^(c^) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
    echo.
    echo Permission is hereby granted, free of charge, to any person obtaining a copy
    echo of this software and associated documentation files ^(the ^"Software^"^), to deal
    echo in the Software without restriction, including without limitation the rights
    echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    echo copies of the Software, and to permit persons to whom the Software is
    echo furnished to do so, subject to the following conditions:
    echo.
    echo The above copyright notice and this permission notice shall be included in all
    echo copies or substantial portions of the Software.
    echo.
    echo THE SOFTWARE IS PROVIDED ^"AS IS^", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    echo SOFTWARE.
    echo -------------------------------------------------------------------------------
    echo */
    echo.
    echo spool install.log
    echo.
    echo set feedback off
    echo set define off
    echo.
    echo prompt ###################################
    echo prompt #   _____   _____   _____  _  __  #
    echo prompt #  ^|  __ \ ^|_   _^| / ____^|^| ^|/ /  #
    echo prompt #  ^| ^|__^) ^|  ^| ^|  ^| ^(___  ^| ' /   #
    echo prompt #  ^|  _  /   ^| ^|   \___ \ ^|  ^<    #
    echo prompt #  ^| ^| \ \  _^| ^|_  ____^) ^|^| . \   #
    echo prompt #  ^|_^|  \_\^|_____^|^|_____/ ^|_^|\_\  #
    echo prompt #                                 #
    echo prompt #            jtsoya539            #
    echo prompt ###################################
    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Tests installation started
    echo prompt ===================================
    echo prompt
    echo.
    echo prompt
    echo prompt Creating package specs...
    echo prompt -----------------------------------
    echo prompt
    if exist "%TEST_DIR%\package_specs\*.spc" (
        dir /b "%TEST_DIR%\package_specs\*.spc" > "%TEMP_DIR%\tests_package_specs.txt"
        sort "%TEMP_DIR%\tests_package_specs.txt" /o "%TEMP_DIR%\tests_package_specs_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\tests_package_specs_sorted.txt) do (
            echo @@package_specs/%%f
        )
    )

    echo.
    echo prompt
    echo prompt Creating package bodies...
    echo prompt -----------------------------------
    echo prompt
    if exist "%TEST_DIR%\package_bodies\*.bdy" (
        dir /b "%TEST_DIR%\package_bodies\*.bdy" > "%TEMP_DIR%\tests_package_bodies.txt"
        sort "%TEMP_DIR%\tests_package_bodies.txt" /o "%TEMP_DIR%\tests_package_bodies_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\tests_package_bodies_sorted.txt) do (
            echo @@package_bodies/%%f
        )
    )

    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Tests installation completed
    echo prompt ===================================
    echo prompt
    echo.
    echo spool off
) > "%TEST_DIR%\install.sql"

    echo Generating tests uninstall script...
(
    echo /*
    echo --------------------------------- MIT License ---------------------------------
    echo Copyright ^(c^) 2019 - 2025 jtsoya539, DamyGenius and the RISK Project contributors
    echo.
    echo Permission is hereby granted, free of charge, to any person obtaining a copy
    echo of this software and associated documentation files ^(the ^"Software^"^), to deal
    echo in the Software without restriction, including without limitation the rights
    echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    echo copies of the Software, and to permit persons to whom the Software is
    echo furnished to do so, subject to the following conditions:
    echo.
    echo The above copyright notice and this permission notice shall be included in all
    echo copies or substantial portions of the Software.
    echo.
    echo THE SOFTWARE IS PROVIDED ^"AS IS^", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    echo SOFTWARE.
    echo -------------------------------------------------------------------------------
    echo */
    echo.
    echo spool uninstall.log
    echo.
    echo set feedback off
    echo set define off
    echo.
    echo prompt ###################################
    echo prompt #   _____   _____   _____  _  __  #
    echo prompt #  ^|  __ \ ^|_   _^| / ____^|^| ^|/ /  #
    echo prompt #  ^| ^|__^) ^|  ^| ^|  ^| ^(___  ^| ' /   #
    echo prompt #  ^|  _  /   ^| ^|   \___ \ ^|  ^<    #
    echo prompt #  ^| ^| \ \  _^| ^|_  ____^) ^|^| . \   #
    echo prompt #  ^|_^|  \_\^|_____^|^|_____/ ^|_^|\_\  #
    echo prompt #                                 #
    echo prompt #            jtsoya539            #
    echo prompt ###################################
    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Tests uninstallation started
    echo prompt ===================================
    echo prompt
    echo.
    echo prompt
    echo prompt Dropping packages...
    echo prompt -----------------------------------
    echo prompt
    if exist "%TEST_DIR%\package_bodies\*.bdy" (
        dir /b "%TEST_DIR%\package_bodies\*.bdy" > "%TEMP_DIR%\tests_package_bodies_uninstall.txt"
        sort "%TEMP_DIR%\tests_package_bodies_uninstall.txt" /o "%TEMP_DIR%\tests_package_bodies_uninstall_sorted.txt"
        for /f "tokens=*" %%f in (%TEMP_DIR%\tests_package_bodies_uninstall_sorted.txt) do (
            for /f "tokens=1* delims=." %%a in ("%%~nf") do echo drop package %%a;
        )
    )

    echo.
    echo prompt
    echo prompt Purging recycle bin...
    echo prompt -----------------------------------
    echo prompt
    echo purge recyclebin;

    echo.
    echo prompt
    echo prompt ===================================
    echo prompt Tests uninstallation completed
    echo prompt ===================================
    echo prompt
    echo.
    echo spool off
) > "%TEST_DIR%\uninstall.sql"
)

:: Clean up temporary directory
rmdir /s /q "%TEMP_DIR%"

echo.
echo Generated files:
for /d %%d in ("%BASE_DIR%\*") do (
    echo Module: %%~nxd
    echo - %%d\install.sql
    echo - %%d\uninstall.sql
)
echo Done!
pause