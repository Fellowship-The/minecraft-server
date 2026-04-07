#!/usr/bin/bash
TIMEOUT=10  # Seconds
PARENT="$(realpath "$(dirname "$0")"/../)"

cd "$PARENT"

watch -n1 "./scripts/update.sh || sleep $TIMEOUT"