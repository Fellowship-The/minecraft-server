#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"
"$PARENT/scripts/shutdown.sh"
git pull
"$PARENT/scripts/daemon.sh"
