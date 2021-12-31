#!/bin/sh
# Make sure the docker container name is correct by checking
# `docker container ls`
DEFAULT_DOCKER_CONTAINER_NAME=minecraft_docker_server-mc-1 

# Read the docker container name from an environment variable, or use the default.
DOCKER_CONTAINER_NAME="${DOCKER_CONTAINER_NAME-$DEFAULT_DOCKER_CONTAINER_NAME}"

# Starts the rcon command line interface for sending commands to the server
if [ $# -ne 1 ] || [ "$1" = "-h" ]; then
  echo "USAGE: $0 RCON-PASSWORD-FILE"
  echo
  echo "Do not write the password, instead store it in a protected file"
  echo "   Example:"
  echo "   $0 ~/encrypted/rcon-password"
  exit 0
fi

RCON_PASSWORD="$(cat "$1")"

echo "WARNING: this will run rcon as root in the docker container"
echo "         DO NOT EXPOSE rcon TO THE INTERNET"
echo docker exec -it "$DOCKER_CONTAINER_NAME" rcon-cli --password "[OMITTING CONTENTS OF $1]" 
docker exec -it "$DOCKER_CONTAINER_NAME" rcon-cli --password "$RCON_PASSWORD" 
