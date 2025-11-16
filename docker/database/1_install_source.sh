#!/bin/bash

echo "BUILDER: Source installation started"

# Define SQLPATH if it is not already set
export SQLPATH=${SQLPATH:-""}

# Install headless
export SQLPATH="/usr/src/risk/source/:$SQLPATH"
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @install_headless.sql $RISK_DB_USER $RISK_DB_PASSWORD

# Install dependencies
sqlplus risk/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install_dependencies.sql

# Install modules
# https://unix.stackexchange.com/a/756952
modules=(
    # Module,Schema,Run Syn/Grant
    "risk,risk,false"
    "msj,risk,false"
)

for module in "${modules[@]}"; do
    modulename=$(echo "$module" | awk -F',' '{ print $1 }')
    moduleschema=$(echo "$module" | awk -F',' '{ print $2 }')
    runsyngrant=$(echo "$module" | awk -F',' '{ print $3 }')

    echo "============================================================"
    echo "Module $modulename"
    echo "============================================================"
    echo "Schema: $moduleschema"
    echo "Run Syn/Grant: $runsyngrant"

    export SQLPATH="/usr/src/risk/source/modules/$modulename/:$SQLPATH"
    sqlplus $moduleschema/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql

    if [ "$runsyngrant" == "true" ]; then
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @create_public_synonyms.sql
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects.sql
    fi;
done

sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @compile_schema.sql
