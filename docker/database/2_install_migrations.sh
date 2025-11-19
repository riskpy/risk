#!/bin/bash

echo "BUILDER: Migrations installation started"

# Define SQLPATH if it is not already set
export SQLPATH=${SQLPATH:-""}

# Install migrations
# https://stackoverflow.com/a/2108296
for dir in /usr/src/risk/source/migrations/mig_*/
do
    echo $dir;
    export SQLPATH="$dir:$SQLPATH"
    sqlplus $RISK_DEV_USER[$RISK_CODE_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql
done

export SQLPATH="/usr/src/risk/source/:$SQLPATH"
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @create_public_synonyms.sql
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects.sql

sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @compile_schema.sql
