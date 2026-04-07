#!/usr/bin/bash
TIMEOUT=10  # Seconds
PARENT="$(realpath "$(dirname "$0")"/../)"

cd "$PARENT"
watch -n1 "git pull && ./scripts/restart.sh || sleep $TIMEOUT"