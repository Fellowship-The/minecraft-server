#!/bin/sh
PARENT="$(realpath "$(dirname "$0")"/../)"
cd "$PARENT"

set -x

git fetch origin
# Compare the local branch (main) with its remote tracking branch (origin/main)
if [ $(git rev-parse HEAD) = $(git rev-parse @{u}) ]; then
    echo "No updates available. $(date)"
else
    git merge
    echo "Updates pulled successfully."
    echo "Restarting now. $(date)"
    ./scripts/shutdown.sh
    ./scripts/daemon.sh
fi

# Make sure server is running no matter what
# This script MUST exit after any git operations conclude
## TODO TODO TODO ./scripts/daemon.sh
