#!/usr/bin/bash

set -x
docker exec minecraft-server-mc-1 mc-send-to-console stop
sleep 5
docker stop --timeout 600 minecraft-server-mc-1
