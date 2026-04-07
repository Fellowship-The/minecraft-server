#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"
exec "$PARENT/run.sh" --detach
