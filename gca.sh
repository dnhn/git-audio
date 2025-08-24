#!/bin/sh

COMMAND="$1"
PARAMETER="$2"

case "$COMMAND" in
  init)
    echo "init"
    ;;
  global)
    case $PARAMETER in
      commit)
        echo "commit"
        ;;
      reset)
        echo "reset"
        ;;
    esac
    ;;
  repo)
    source $HOME/.git-commit-audio/install.sh
    ;;
  audio)
    echo $PARAMETER
    ;;
  *)
    echo "GCA"
    ;;
esac
