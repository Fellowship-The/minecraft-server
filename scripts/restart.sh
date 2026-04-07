#!/usr/bin/bash
set -x
PARENT="$(realpath "$(dirname "$0")"/../)"

set -x
"$PARENT/scripts/shutdown.sh"
"$PARENT/scripts/daemon.sh"
