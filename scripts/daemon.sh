#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"

exec "$PARENT/scripts/run.sh" --detach
