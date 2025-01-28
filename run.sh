#!/bin/sh
ROOT="$(dirname $0)"
BACKUP_SERVER_DATA="${BACKUP_SERVER_DATA-"$ROOT"/test_server_data}"

set -x

# Make a backup before starting the server. The compression can be slow. You
# can safely cancel this command with CTRL-C.
####### ./scripts/complicated-backup.sh "$BACKUP_SERVER_DATA"

"$ROOT/scripts/backup.sh" "$BACKUP_SERVER_DATA"

# Use docker compose to build the container and then run it.
# `mc` is the service name in the docker-compose.yml file
set -a
source "$ROOT/private.env"
docker compose -f $ROOT/docker-compose.yml up --build 
