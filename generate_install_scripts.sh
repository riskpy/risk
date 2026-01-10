#!/bin/bash

# Base directory for modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/source/database/modules"

# Create a temporary directory for sorted files
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Function to sort files consistently
sort_files() {
    local dir="$1"
    local pattern="$2"
    local output_file="$3"
    
    if [ -d "$dir" ]; then
        find "$dir" -name "$pattern" -type f -printf "%f\n" | LC_ALL=C sort > "$output_file"
    fi
}

# Loop through each module directory
for module_dir in "$BASE_DIR"/*/ ; do
    if [ -d "$module_dir" ]; then
        module_name=$(basename "$module_dir")
        echo "Processing module: $module_name"
        
        # Generate module install.sql
        echo "Generating install script for $module_name..."
        cat > "$module_dir/install.sql" << 'INSTALL_EOF'
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

spool install.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Installation started
prompt ===================================
prompt
INSTALL_EOF

        # Add module-specific content
        echo "@@../../set_compiler_flags.sql $module_name" >> "$module_dir/install.sql"
        
        if [ "$module_name" != "risk" ]; then
            echo "alter package risk.k_modulo compile package;" >> "$module_dir/install.sql"
        fi

        # Sequences
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating sequences..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort sequence files
        if [ -d "$module_dir/sequences" ]; then
            sort_files "$module_dir/sequences" "*.seq" "$TEMP_DIR/sequences.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@sequences/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/sequences.txt"
        fi

        # Tables
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating tables..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort table files
        if [ -d "$module_dir/tables" ]; then
            sort_files "$module_dir/tables" "*.tab" "$TEMP_DIR/tables.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@tables/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/tables.txt"
        fi

        # Foreign keys
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating foreign keys..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort foreign key files
        if [ -d "$module_dir/foreign_keys" ]; then
            sort_files "$module_dir/foreign_keys" "*.sql" "$TEMP_DIR/foreign_keys.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@foreign_keys/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/foreign_keys.txt"
        fi

        # Views
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating views..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort view files
        if [ -d "$module_dir/views" ]; then
            sort_files "$module_dir/views" "*.vw" "$TEMP_DIR/views.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@views/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/views.txt"
        fi

        # Type specs
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating type specs..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort type spec files
        if [ -d "$module_dir/type_specs" ]; then
            sort_files "$module_dir/type_specs" "*.tps" "$TEMP_DIR/type_specs.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@type_specs/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/type_specs.txt"
        fi

        # Type bodies
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating type bodies..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort type body files
        if [ -d "$module_dir/type_bodies" ]; then
            sort_files "$module_dir/type_bodies" "*.tpb" "$TEMP_DIR/type_bodies.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@type_bodies/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/type_bodies.txt"
        fi

        # Java sources
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating java sources..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort java source files
        if [ -d "$module_dir/java" ]; then
            sort_files "$module_dir/java" "*.jsp" "$TEMP_DIR/java.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@java/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/java.txt"
        fi

        # Functions
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating functions..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort function files
        if [ -d "$module_dir/functions" ]; then
            sort_files "$module_dir/functions" "*.fnc" "$TEMP_DIR/functions.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@functions/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/functions.txt"
        fi

        # Procedures
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating procedures..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort procedure files
        if [ -d "$module_dir/procedures" ]; then
            sort_files "$module_dir/procedures" "*.prc" "$TEMP_DIR/procedures.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@procedures/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/procedures.txt"
        fi

        # Package specs
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating package specs..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort package spec files
        if [ -d "$module_dir/package_specs" ]; then
            sort_files "$module_dir/package_specs" "*.spc" "$TEMP_DIR/package_specs.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@package_specs/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/package_specs.txt"
        fi

        # Package bodies
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating package bodies..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort package body files
        if [ -d "$module_dir/package_bodies" ]; then
            sort_files "$module_dir/package_bodies" "*.bdy" "$TEMP_DIR/package_bodies.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@package_bodies/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/package_bodies.txt"
        fi

        # Triggers
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Creating triggers..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort trigger files
        if [ -d "$module_dir/triggers" ]; then
            sort_files "$module_dir/triggers" "*.trg" "$TEMP_DIR/triggers.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@triggers/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/triggers.txt"
        fi

        # Compile schema
        echo "" >> "$module_dir/install.sql"
        echo "@@../../compile_schema.sql" >> "$module_dir/install.sql"

        # Running scripts
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Running scripts..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        if [ "$module_name" = "auditorias" ]; then
            echo "begin p_configurar_modificacion(pin_aplicacion => 'SQLPLUS'); end;" >> "$module_dir/install.sql"
            echo "/" >> "$module_dir/install.sql"
        fi
        
        echo "@@scripts/ins_t_modulos.sql" >> "$module_dir/install.sql"
        echo "@@scripts/ins_t_dominios.sql" >> "$module_dir/install.sql"
        echo "@@scripts/ins_t_parametro_definiciones.sql" >> "$module_dir/install.sql"
        echo "@@scripts/ins_t_parametros.sql" >> "$module_dir/install.sql"
        echo "@@scripts/ins_t_aplicaciones.sql" >> "$module_dir/install.sql"
        echo "@@scripts/ins_t_errores.sql" >> "$module_dir/install.sql"
        
        if [ "$module_name" = "risk" ]; then
            echo "@@scripts/ins_t_autenticacion_origenes.sql" >> "$module_dir/install.sql"
            echo "@@scripts/ins_t_roles.sql" >> "$module_dir/install.sql"
        fi

        # Sort meaning install script files
        if [ -d "$module_dir/scripts/meanings" ]; then
            find "$module_dir/scripts/meanings" -name "install*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/meanings_install.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@scripts/meanings/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/meanings_install.txt"
        fi

        # Sort operation install script files
        if [ -d "$module_dir/scripts/operations" ]; then
            find "$module_dir/scripts/operations" -name "install*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/operations_install.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@scripts/operations/$filename" >> "$module_dir/install.sql"
                fi
            done < "$TEMP_DIR/operations_install.txt"
        fi
        
        echo "commit;" >> "$module_dir/install.sql"
        echo "/" >> "$module_dir/install.sql"

        # Additional scripts
        echo "" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        echo "prompt Running additional scripts..." >> "$module_dir/install.sql"
        echo "prompt -----------------------------------" >> "$module_dir/install.sql"
        echo "prompt" >> "$module_dir/install.sql"
        
        # Sort additional install script files
        find "$module_dir" -maxdepth 1 -name "install_scripts*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/install_scripts.txt"
        while IFS= read -r filename; do
            if [ -n "$filename" ]; then
                echo "@@$filename" >> "$module_dir/install.sql"
            fi
        done < "$TEMP_DIR/install_scripts.txt"
        
        echo "commit;" >> "$module_dir/install.sql"
        echo "/" >> "$module_dir/install.sql"

        # Footer
        cat >> "$module_dir/install.sql" << 'INSTALL_FOOTER'

prompt
prompt ===================================
prompt Installation completed
prompt ===================================
prompt

spool off
INSTALL_FOOTER

        # Generate module uninstall.sql
        echo "Generating uninstall script for $module_name..."
        cat > "$module_dir/uninstall.sql" << 'UNINSTALL_EOF'
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

spool uninstall.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Uninstallation started
prompt ===================================
prompt

UNINSTALL_EOF

        # Dropping triggers
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping triggers..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort trigger files for uninstall
        if [ -d "$module_dir/triggers" ]; then
            sort_files "$module_dir/triggers" "*.trg" "$TEMP_DIR/triggers_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.trg}" | cut -d'.' -f1)
                    echo "drop trigger $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/triggers_uninstall.txt"
        fi

        # Dropping packages
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping packages..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort package body files for uninstall
        if [ -d "$module_dir/package_bodies" ]; then
            sort_files "$module_dir/package_bodies" "*.bdy" "$TEMP_DIR/package_bodies_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.bdy}" | cut -d'.' -f1)
                    echo "drop package $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/package_bodies_uninstall.txt"
        fi

        # Dropping procedures
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping procedures..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort procedure files for uninstall
        if [ -d "$module_dir/procedures" ]; then
            sort_files "$module_dir/procedures" "*.prc" "$TEMP_DIR/procedures_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.prc}" | cut -d'.' -f1)
                    echo "drop procedure $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/procedures_uninstall.txt"
        fi

        # Dropping functions
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping functions..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort function files for uninstall
        if [ -d "$module_dir/functions" ]; then
            sort_files "$module_dir/functions" "*.fnc" "$TEMP_DIR/functions_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.fnc}" | cut -d'.' -f1)
                    echo "drop function $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/functions_uninstall.txt"
        fi

        # Dropping java sources
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping java sources..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort java source files for uninstall
        if [ -d "$module_dir/java" ]; then
            sort_files "$module_dir/java" "*.jsp" "$TEMP_DIR/java_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.jsp}" | cut -d'.' -f1)
                    echo "drop java source $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/java_uninstall.txt"
        fi

        # Dropping types
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping types..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort type spec files for uninstall
        if [ -d "$module_dir/type_specs" ]; then
            sort_files "$module_dir/type_specs" "*.tps" "$TEMP_DIR/type_specs_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.tps}" | cut -d'.' -f1)
                    echo "drop type $object_name force;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/type_specs_uninstall.txt"
        fi

        # Dropping views
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping views..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort view files for uninstall
        if [ -d "$module_dir/views" ]; then
            sort_files "$module_dir/views" "*.vw" "$TEMP_DIR/views_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.vw}" | cut -d'.' -f1)
                    echo "drop view $object_name cascade constraints;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/views_uninstall.txt"
        fi

        # Dropping tables
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping tables..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort table files for uninstall
        if [ -d "$module_dir/tables" ]; then
            sort_files "$module_dir/tables" "*.tab" "$TEMP_DIR/tables_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.tab}" | cut -d'.' -f1)
                    echo "drop table $object_name cascade constraints purge;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/tables_uninstall.txt"
        fi

        # Dropping sequences
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Dropping sequences..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort sequence files for uninstall
        if [ -d "$module_dir/sequences" ]; then
            sort_files "$module_dir/sequences" "*.seq" "$TEMP_DIR/sequences_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    object_name=$(echo "${filename%.seq}" | cut -d'.' -f1)
                    echo "drop sequence $object_name;" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/sequences_uninstall.txt"
        fi

        # Purge recycle bin
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Purging recycle bin..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "purge recyclebin;" >> "$module_dir/uninstall.sql"

        # Compile schema
        echo "" >> "$module_dir/uninstall.sql"
        echo "--@@../../packages/k_modulo.pck" >> "$module_dir/uninstall.sql"
        echo "@@../../compile_schema.sql" >> "$module_dir/uninstall.sql"

        # Additional scripts
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Running additional scripts..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort additional uninstall script files
        find "$module_dir" -maxdepth 1 -name "uninstall_scripts*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/uninstall_scripts.txt"
        while IFS= read -r filename; do
            if [ -n "$filename" ]; then
                echo "@@$filename" >> "$module_dir/uninstall.sql"
            fi
        done < "$TEMP_DIR/uninstall_scripts.txt"
        
        echo "commit;" >> "$module_dir/uninstall.sql"
        echo "/" >> "$module_dir/uninstall.sql"

        # Running scripts
        echo "" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        echo "prompt Running scripts..." >> "$module_dir/uninstall.sql"
        echo "prompt -----------------------------------" >> "$module_dir/uninstall.sql"
        echo "prompt" >> "$module_dir/uninstall.sql"
        
        # Sort operation uninstall script files
        if [ -d "$module_dir/scripts/operations" ]; then
            find "$module_dir/scripts/operations" -name "uninstall*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/operations_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@scripts/operations/$filename" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/operations_uninstall.txt"
        fi

        # Sort meaning uninstall script files
        if [ -d "$module_dir/scripts/meanings" ]; then
            find "$module_dir/scripts/meanings" -name "uninstall*.sql" -type f -printf "%f\n" | LC_ALL=C sort > "$TEMP_DIR/meanings_uninstall.txt"
            while IFS= read -r filename; do
                if [ -n "$filename" ]; then
                    echo "@@scripts/meanings/$filename" >> "$module_dir/uninstall.sql"
                fi
            done < "$TEMP_DIR/meanings_uninstall.txt"
        fi
        
        if [ "$module_name" != "risk" ]; then
            echo "@@scripts/del_t_errores.sql" >> "$module_dir/uninstall.sql"
            echo "@@scripts/del_t_aplicaciones.sql" >> "$module_dir/uninstall.sql"
            echo "@@scripts/del_t_parametros.sql" >> "$module_dir/uninstall.sql"
            echo "@@scripts/del_t_parametro_definiciones.sql" >> "$module_dir/uninstall.sql"
            echo "@@scripts/del_t_dominios.sql" >> "$module_dir/uninstall.sql"
            echo "@@scripts/del_t_modulos.sql" >> "$module_dir/uninstall.sql"
        fi
        
        echo "commit;" >> "$module_dir/uninstall.sql"
        echo "/" >> "$module_dir/uninstall.sql"

        # Footer
        cat >> "$module_dir/uninstall.sql" << 'UNINSTALL_FOOTER'

prompt
prompt ===================================
prompt Uninstallation completed
prompt ===================================
prompt

spool off
UNINSTALL_FOOTER

    fi
done

echo ""
echo "Generated files:"
for module_dir in "$BASE_DIR"/*/ ; do
    if [ -d "$module_dir" ]; then
        module_name=$(basename "$module_dir")
        echo "Module: $module_name"
        echo "- $module_dir/install.sql"
        echo "- $module_dir/uninstall.sql"
    fi
done
echo "Done!"

# Generate tests install/uninstall scripts (only package specs / bodies)
TEST_DIR="$SCRIPT_DIR/test/database"
if [ -d "$TEST_DIR" ]; then
    echo "Generating tests install script..."
    cat > "$TEST_DIR/install.sql" <<'TEST_INSTALL_EOF'
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

spool install.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Tests installation started
prompt ===================================
prompt

prompt
prompt Creating package specs...
prompt -----------------------------------
prompt
TEST_INSTALL_EOF

    # package specs
    if [ -d "$TEST_DIR/package_specs" ]; then
        find "$TEST_DIR/package_specs" -name "*.spc" -type f -printf "%f
" | LC_ALL=C sort | while read -r f; do
            echo "@@package_specs/$f" >> "$TEST_DIR/install.sql"
        done
    fi

    cat >> "$TEST_DIR/install.sql" <<'TEST_INSTALL_EOF'

prompt
prompt Creating package bodies...
prompt -----------------------------------
prompt
TEST_INSTALL_EOF

    # package bodies
    if [ -d "$TEST_DIR/package_bodies" ]; then
        find "$TEST_DIR/package_bodies" -name "*.bdy" -type f -printf "%f
" | LC_ALL=C sort | while read -r f; do
            echo "@@package_bodies/$f" >> "$TEST_DIR/install.sql"
        done
    fi

    cat >> "$TEST_DIR/install.sql" <<'TEST_INSTALL_EOF'

prompt
prompt ===================================
prompt Tests installation completed
prompt ===================================
prompt

spool off
TEST_INSTALL_EOF

    echo "Generating tests uninstall script..."
    cat > "$TEST_DIR/uninstall.sql" <<'TEST_UNINSTALL_EOF'
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

spool uninstall.log

set feedback off
set define off

prompt ###################################
prompt #   _____   _____   _____  _  __  #
prompt #  |  __ \ |_   _| / ____|| |/ /  #
prompt #  | |__) |  | |  | (___  | ' /   #
prompt #  |  _  /   | |   \___ \ |  <    #
prompt #  | | \ \  _| |_  ____) || . \   #
prompt #  |_|  \_\|_____||_____/ |_|\_\  #
prompt #                                 #
prompt #            jtsoya539            #
prompt ###################################

prompt
prompt ===================================
prompt Tests uninstallation started
prompt ===================================
prompt

prompt
prompt Dropping packages...
prompt -----------------------------------
prompt
TEST_UNINSTALL_EOF

    # drop package for each .bdy
    if [ -d "$TEST_DIR/package_bodies" ]; then
        find "$TEST_DIR/package_bodies" -name "*.bdy" -type f -printf "%f
" | LC_ALL=C sort | while read -r f; do
            name=${f%%.*}
            echo "drop package $name;" >> "$TEST_DIR/uninstall.sql"
        done
    fi

    cat >> "$TEST_DIR/uninstall.sql" <<'TEST_UNINSTALL_EOF'

prompt
prompt Purging recycle bin...
prompt -----------------------------------
prompt
purge recyclebin;

prompt
prompt ===================================
prompt Tests uninstallation completed
prompt ===================================
prompt

spool off
TEST_UNINSTALL_EOF
fi