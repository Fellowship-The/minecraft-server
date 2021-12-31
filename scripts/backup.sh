#!/bin/bash
# TODO use tar manually instead of relying on a hack to ignore $IN/plugins/dynmap/
# TODO how to do with zip command?
# TODO how to ignore a list of filenames or patterns?
DEFAULT_BACKUP_DIRECTORY=~/Dropbox/Games/Minecraft
BACKUP_DIRECTORY="${BACKUP_DIRECTORY-$DEFAULT_BACKUP_DIRECTORY}"

########### Read arguments. Show help or run backup.
if [ $# -ne 1 ] || [ "$1" = "-h" ]; then
  echo "USAGE: $0 MINECRAFT_DIR"
  echo
  echo "MINECRAFT_DIR - A path to a world directory or an entire server data directory."
  echo "    This directory will be compressed with the very efficient ZPAQ algorithm"
  echo "    and it will be placed in a .tar.lrz file with a timestamp in the filename."
  echo "    If a server data dir, will ignore ALL of MINECRAFT_DIR/plugins/dynmap"
  echo 
  echo "To decompress a .tar.lrz file, run lrztar -d as follows:"
  echo "    lrztar -d MINECRAFT_BACKUP.2018-08.tar.lrz"
  echo
  echo "    This command will place the backed up minecraft directory into the"
  echo "    current directory."
  echo
  echo "Will copy backup to environment variable BACKUP_DIRECTORY"
  echo "    If not set, default is: $DEFAULT_BACKUP_DIRECTORY"
  exit 0
fi

# Get the first argument and treat it as the input directory
# Remove trailing newline
IN="$(echo "$1" | sed 's/\/*$//g')"

########### Code for ignoring dynmap/ directory in plugins
# Temporary directory
TMP="$(mktemp -d)"
DYNMAP_TMP="$TMP/dynmap"

# When we are interrupted or when we are done, restore the dynmap files
function restore_ignored() {
  if [ -d "$DYNMAP_TMP" ]; then
    mv "$DYNMAP_TMP" "$IN/plugins/dynmap"
  fi
}

function interrupt_handler() {
  restore_ignored
  set +x
  echo Backup cancelled
}

function move_ignored_to_tmp() {
  if [ -d "$IN/plugins/dynmap" ]; then
    mv "$IN/plugins/dynmap" "$DYNMAP_TMP"
  fi
}

# Some options to fail when a command fails
set -e -o pipefail

trap interrupt_handler INT

if [ -d "$IN/plugins/dynmap" ]; then
  # Show commands being run
  set -x
  move_ignored_to_tmp
  # Run restoration function when the user presses CTRL-C

  # Stop showing commands being run
  set +x
fi

########### Make the backup!

# Backup name will have a year, month, and week number
BACKUP_DATE_FORMAT="+%Y-%m-week%W"
OUT="$IN.$(date "$BACKUP_DATE_FORMAT").tar.lrz"


# Show commands being run
set -x

# Use highly efficient ZPAQ compression algorithm
# -f -- force create a backup
lrztar -f -z -o "$OUT" "$IN"

# Alternate command:
# zip -r "$OUT" "$1"

cp "$OUT" "$BACKUP_DIRECTORY"

# Restore ignored files
restore_ignored
