#!/bin/sh

COMMAND="$1"
PARAMETER="$2"

CONFIG_DIR="$HOME/.git-audio"
TEMPLATE_DIR="$CONFIG_DIR/templates"

case "$COMMAND" in
  global)
    case $PARAMETER in
      set)
        git config --global init.templateDir $TEMPLATE_DIR
        echo 'Global hook set.'
        ;;
      unset)
        git config --global --unset init.templateDir
        echo 'Global hook unset.'
        ;;
      *)
        echo "\nGLOBAL HOOK COMMANDS"
        echo "  set    \tSet global commit hook"
        echo "  unset  \tUnset global commit hook"
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
