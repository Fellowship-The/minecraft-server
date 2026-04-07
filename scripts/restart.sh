#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"
"$PARENT/scripts/shutdown.sh"
"$PARENT/scripts/daemon.sh"
