#!/bin/sh
PARENT="$(realpath "$(dirname "$0")"/../)"
cd "$PARENT"

git fetch origin
# Compare the local branch (main) with its remote tracking branch (origin/main)
if [ $(git rev-parse HEAD) = $(git rev-parse @{u}) ]; then
    echo "No updates available. $(date)"
    exit 1
else
    git merge
    echo "Updates pulled successfully, restarting now. $(date)"
    ./scripts/restart.sh
fi

