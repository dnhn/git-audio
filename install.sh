#!/bin/sh

GCA="\033[1mGit Commit Audio\033[0m"

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
  echo "Please run this script inside a Git repository."
  return
fi

CONFIG_DIR="$HOME/.git-commit-audio"
CONFIG_FILE="$CONFIG_DIR/config.sh"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_AUDIO="$SRC_DIR/audio.wav"
SRC_HOOK="$SRC_DIR/post-commit"
HOOKS_DIR="$REPO_ROOT/.git/hooks"
HOOK_FILE="$HOOKS_DIR/post-commit"

mkdir -p $CONFIG_DIR

if [ ! -f $CONFIG_FILE ]; then
  touch $CONFIG_FILE
  echo "export GIT_COMMIT_AUDIO=\"$CONFIG_DIR/audio.wav\"" > $CONFIG_FILE
fi

cp $SRC_AUDIO $CONFIG_DIR
cp $SRC_HOOK $HOOKS_DIR
chmod +x $HOOK_FILE

echo "$GCA installed! Find your configuration at $CONFIG_DIR"
