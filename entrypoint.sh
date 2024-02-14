#!/bin/bash -e

set -x

# If running the rails server then create or migrate existing database
if [ "${1}" == "./bin/rails" ] && [ "${2}" == "server" ]; then
    ./bin/rails db:prepare db:seed
else
    echo $1
    echo $2
fi

exec "${@}"
