#!/bin/bash -e

set -x

retry_count=0
max_retries=2

# Function to check database connection and prepare it
prepare_database() {
    if ! ./bin/rails db:prepare; then
        echo "Failed to connect to the database."
        return 1
    fi
}

# If running the rails server, then attempt to prepare the database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
    until prepare_database; do
        ((retry_count++))
        echo "Attempting to reconnect to the database. Attempt: ${retry_count}"
        if [ "$retry_count" -ge "$max_retries" ]; then
            echo "Failed to connect to the database after ${max_retries} attempts."
            exit 1
        fi
        sleep 5 # Wait for 5 seconds before retrying
    done
else
    echo $1
    echo $2
fi

exec "${@}"
