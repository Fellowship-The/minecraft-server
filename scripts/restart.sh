#!/usr/bin/bash
PARENT="$(realpath "$(dirname "$0")"/../)"

# Pull latest changes and restart
cd "$PARENT"
git pull

"$PARENT/scripts/shutdown.sh"
"$PARENT/scripts/daemon.sh"
