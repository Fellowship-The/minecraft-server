#!/bin/sh
MAP="${MAP:-IMPERIUS_FELINUS_server_data}"
ROOT="$(dirname $(dirname $0))"
BACKUP_SERVER_DATA="${BACKUP_SERVER_DATA-"$ROOT/$MAP"}"

touch "$ROOT/private.env"
set -a  # Load env vars globally
# Load private config settings
. "$ROOT/private.env"

set -x
# Backup data
"$ROOT/scripts/backup.sh" "$BACKUP_SERVER_DATA"

# Use docker compose to build the container and then run it.
# `mc` is the service name in the docker-compose.yml file
docker compose -f $ROOT/docker-compose.yml up --build $@
