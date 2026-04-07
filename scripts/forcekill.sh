#!/bin/sh
set -x
echo "FORCE KILL WITH SIGTERM"
docker container kill $(docker ps -q)
