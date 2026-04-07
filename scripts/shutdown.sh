#!/usr/bin/bash

set -x
docker exec minecraft-server-mc-1 mc-send-to-console stop
docker stop minecraft-server-mc-1
