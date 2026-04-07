#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"
git pull && "$PARENT/scripts/shutdown.sh" && "$PARENT/scripts/daemon.sh"
