#!/bin/bash

if [ "${SKIP_TESTS}" == "true" ]; then
    echo "BUILDER: Tests execution ignored"
else
    echo "BUILDER: Tests execution started"

    # Get the url to latest release "zip" file
    DOWNLOAD_URL=$(curl --silent https://api.github.com/repos/utPLSQL/utPLSQL-cli/releases/latest | awk '/browser_download_url/ { print $2 }' | grep ".zip\"" | sed 's/"//g')
    # Download the latest release "zip" file
    curl -Lk "${DOWNLOAD_URL}" -o utPLSQL-cli.zip
    # Extract downloaded "zip" file
    unzip utPLSQL-cli.zip

    # export JAVA_TOOL_OPTIONS='-Dfile.encoding=utf8'
    utPLSQL-cli/bin/utplsql run risk/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME -f=ut_documentation_reporter -f=ut_junit_reporter -o=report.xml || true

fi;