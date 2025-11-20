#!/bin/bash

# Define SQLPATH if it is not already set
export SQLPATH=${SQLPATH:-""}

if [ "${IGNORE_APEX}" == "TRUE" ]; then
    echo "BUILDER: APEX applications installation ignored"
else
    echo "BUILDER: APEX applications installation started in $DB_HOST_NAME:1521/$DB_SERVICE_NAME"

    # Install APEX workspaces
    export SQLPATH="/usr/src/risk/source/apex/:$SQLPATH"
    sql SYSTEM/$ORACLE_PASSWORD@$DB_HOST_NAME:1521/$DB_SERVICE_NAME @RISK_WKSP.sql

    # Install APEX applications
    # https://stackoverflow.com/a/2108296
    for dir in /usr/src/risk/source/apex/apps/*/
    do
        echo $dir;
        export SQLPATH="$dir:$SQLPATH"
        sql SYSTEM/$ORACLE_PASSWORD@$DB_HOST_NAME:1521/$DB_SERVICE_NAME @install_with_sup_obj.sql
    done

fi;