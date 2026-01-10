#!/bin/bash

if [ "${SKIP_TESTS_INSTALL}" == "true" ]; then
    echo "BUILDER: Tests installation ignored"
else
    echo "BUILDER: Tests installation started"

    # Get the url to latest release "zip" file
    #UTPLSQL_DOWNLOAD_URL=$(curl --silent https://api.github.com/repos/utPLSQL/utPLSQL/releases/latest | awk '/browser_download_url/ { print $2 }' | grep ".zip\"" | sed 's/"//g')
    UTPLSQL_DOWNLOAD_URL=https://github.com/utPLSQL/utPLSQL/releases/download/v3.1.14/utPLSQL.zip
    # Download the latest release "zip" file
    curl -Lk "${UTPLSQL_DOWNLOAD_URL}" -o utPLSQL.zip
    # Extract downloaded "zip" file
    unzip utPLSQL.zip

    export SQLPATH="$PWD/utPLSQL/source:$SQLPATH"
    sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @utPLSQL/source/install_headless.sql

fi;