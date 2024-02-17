#!/bin/bash -e

# If running the rails server, then attempt to prepare the database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
    while ! nc -z db 5432; do
        echo "Waiting for database"
        sleep 1 # wait for 1 second before check again
    done

    ./bin/rails db:prepare
fi

exec "${@}"
