#!/bin/bash

# Initialize timer for tracking execution time
START_TIME=$(date +%s)

echo "BUILDER: Starting database setup"

# Function to display elapsed time
display_elapsed_time() {
    local end_time=$(date +%s)
    local elapsed=$((end_time - START_TIME))
    local hours=$((elapsed / 3600))
    local minutes=$(((elapsed % 3600) / 60))
    local seconds=$((elapsed % 60))
    echo "BUILDER: Elapsed time: ${hours}h ${minutes}m ${seconds}s"
}

# Define SQLPATH if it is not already set
export SQLPATH=${SQLPATH:-""}

# Function to download, extract and install audit_utility
download_and_install_audit_utility() {
    if [ "${SKIP_AUDIT_INSTALL}" == "true" ]; then
        echo "BUILDER: audit_utility download and installation ignored"
    else
        echo "BUILDER: Downloading audit_utility in parallel"
        DOWNLOAD_URL=https://github.com/connormcd/audit_utility/archive/refs/heads/master.zip
        curl -Lk "${DOWNLOAD_URL}" -o audit_utility.zip
        unzip audit_utility.zip
        echo "BUILDER: audit_utility download and extraction completed"
        
        # Install audit_utility immediately after download
        echo "BUILDER: Installing audit_utility"
        export SQLPATH="$PWD/audit_utility/audit_utility-master/v2:$SQLPATH"
        sed -i 's/^[[:space:]]*pause/-- pause/I' audit_utility-master/v2/audit_util_setup.sql
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @audit_utility-master/v2/audit_util_setup.sql
        
        echo "BUILDER: audit_utility installation completed"
    fi
}

# Function to download, extract and install utPLSQL
download_and_install_utplsql() {
    if [ "${SKIP_TESTS_INSTALL}" == "true" ]; then
        echo "BUILDER: utPLSQL download and installation ignored"
    else
        echo "BUILDER: Downloading utPLSQL in parallel"
        DOWNLOAD_URL=https://github.com/utPLSQL/utPLSQL/releases/download/v3.1.14/utPLSQL.zip
        curl -Lk "${DOWNLOAD_URL}" -o utPLSQL.zip
        unzip utPLSQL.zip
        echo "BUILDER: utPLSQL download and extraction completed"
        
        # Install utPLSQL immediately after download
        echo "BUILDER: Installing utPLSQL"
        export SQLPATH="$PWD/utPLSQL/source:$SQLPATH"
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @utPLSQL/source/install_headless.sql
        
        echo "BUILDER: utPLSQL installation completed"
    fi
}

# Function to download and extract utPLSQL-cli
download_utplsql_cli() {
    if [[ "${SKIP_TESTS}" == "true" || "${SKIP_TESTS_INSTALL}" == "true" ]]; then
        echo "BUILDER: utPLSQL-cli download ignored"
    else
        echo "BUILDER: Downloading utPLSQL-cli in parallel"
        DOWNLOAD_URL=https://github.com/utPLSQL/utPLSQL-cli/releases/download/3.1.9/utPLSQL-cli.zip
        curl -Lk "${DOWNLOAD_URL}" -o utPLSQL-cli.zip
        unzip utPLSQL-cli.zip
        echo "BUILDER: utPLSQL-cli download and extraction completed"
    fi
}

# Start downloads in background
download_and_install_audit_utility &
AUDIT_UTILITY_PID=$!
download_and_install_utplsql &
UTPLSQL_PID=$!
download_utplsql_cli &
UTPLSQL_CLI_PID=$!

export SQLPATH="/usr/src/risk/source/:$SQLPATH"

# Create schemas
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @install_headless.sql $RISK_APP_NAME $RISK_DB_PASSWORD
echo "BUILDER: Schemas creation completed"
display_elapsed_time

# Install dependencies
sqlplus $RISK_DEV_USER[$RISK_UTIL_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install_dependencies.sql

sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @create_public_synonyms.sql $RISK_APP_NAME
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects.sql $RISK_APP_NAME

echo "BUILDER: Dependencies installation completed"
display_elapsed_time

# Install modules sequentially
modules=(
    # Module,Schema,Run Syn/Grant
    "risk,$RISK_MODULE_USER,true"
    "msj,$MSJ_MODULE_USER,true"
    "flj,$FLJ_MODULE_USER,true"
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
    sqlplus $RISK_DEV_USER[$moduleschema]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql

    if [ "$runsyngrant" == "true" ]; then
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @create_public_synonyms.sql $RISK_APP_NAME
        sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects.sql $RISK_APP_NAME
    fi
done
echo "BUILDER: Modules installation completed"
display_elapsed_time

# Compile all schemas
echo "BUILDER: Compiling schemas"
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @compile_schema.sql
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects_access_role.sql $RISK_APP_NAME

# Install migrations
echo "BUILDER: Migrations installation started"
for dir in /usr/src/risk/source/migrations/mig_*/
do
    echo $dir;
    export SQLPATH="$dir:$SQLPATH"
    sqlplus $RISK_DEV_USER[$RISK_MODULE_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql
done

export SQLPATH="/usr/src/risk/source/:$SQLPATH"
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @create_public_synonyms.sql $RISK_APP_NAME
sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @grant_objects.sql $RISK_APP_NAME

sqlplus sys/$ORACLE_PASSWORD@//localhost/$DB_SERVICE_NAME as sysdba @compile_schema.sql
echo "BUILDER: Migrations installation completed"
display_elapsed_time

# Wait for utPLSQL installation to complete
if [ "${SKIP_TESTS_INSTALL}" != "true" ]; then
    echo "BUILDER: Waiting for utPLSQL installation to complete"
    wait $UTPLSQL_PID

    # Install tests
    echo "BUILDER: Tests installation started"
    export SQLPATH="/usr/src/risk/test/:$SQLPATH"
    sqlplus $RISK_DEV_USER[$RISK_MODULE_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME @install.sql
    echo "BUILDER: Tests installation completed"
    display_elapsed_time
fi

# Wait for utPLSQL-cli download to complete and run tests
if [ "${SKIP_TESTS}" != "true" ]; then
    echo "BUILDER: Waiting for utPLSQL-cli download to complete"
    wait $UTPLSQL_CLI_PID
    
    # Run tests
    echo "BUILDER: Tests execution started"
    utPLSQL-cli/bin/utplsql run $RISK_DEV_USER[$RISK_MODULE_USER]/$RISK_DB_PASSWORD@//localhost/$DB_SERVICE_NAME -f=ut_documentation_reporter -f=ut_junit_reporter -o=report.xml || true
    echo "BUILDER: Tests execution completed"
    display_elapsed_time
fi

echo "BUILDER: Database setup completed"

# Display total execution time
display_elapsed_time
