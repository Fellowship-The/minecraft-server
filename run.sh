#!/bin/sh
SERVER_DATA="${SERVER_DATA-./test_server_data}"

set -x
ROOT="$(dirname $0)"

# Make a backup before starting the server. The compression can be slow. You
# can safely cancel this command with CTRL-C.
./scripts/backup.sh "$SERVER_DATA"

# Use docker compose to build the container and then run it.
# `mc` is the service name in the docker-compose.yml file
docker-compose up --build
