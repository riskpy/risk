#!/bin/bash

if [ "${SKIP_TESTS_INSTALL}" == "true" ]; then
    echo "BUILDER: Tests installation ignored"
else
    echo "BUILDER: Tests installation started"

    # Install tests
    export SQLPATH="/usr/src/risk/test/:$SQLPATH"
    sqlplus $RISK_DEV_USER[$RISK_CODE_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql

fi;