#!/bin/sh
set -eo pipefail
BASE="$(dirname "$(dirname "$0"))")"
GAME_DATA="${1:-$BASE/test_server_data}"
BACKUP_DIR="$BASE/backup/$(date --iso-8601)"
set -x
cp -r "$GAME_DATA" "$BACKUP_DIR"
