#!/bin/sh

COMMAND="$1"
PARAMETER="$2"

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
CONFIG_DIR="$HOME/.git-audio"
TEMPLATE_DIR="$CONFIG_DIR/templates"
SRC_HOOK="$TEMPLATE_DIR/hooks/post-commit"
HOOKS_DIR="$REPO_ROOT/.git/hooks"
HOOK_FILE="$HOOKS_DIR/post-commit"

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
    case $PARAMETER in
      commit)
        if [ -f "$HOOK_FILE" ]; then
          cat $HOOK_FILE
          echo "\npost-commit hook already exists. Do you want to overwrite it? (y/N)"
          read -r answer

          if [ "$answer" = 'y' ]; then
            cp $SRC_HOOK $HOOKS_DIR
            chmod +x $HOOK_FILE

            echo 'post-commit hook installed.'
          else
            echo 'post-commit hook not installed.'
          fi
        else
          cp $SRC_HOOK $HOOKS_DIR
          chmod +x $HOOK_FILE

          echo 'post-commit hook installed.'
        fi
        ;;
      reset)
        if [ -f "$HOOK_FILE" ]; then
          cat $HOOK_FILE
          echo "\nDo you want to remove the post-commit hook? (y/N)"
          read -r answer

          if [ "$answer" = 'y' ]; then
            rm -f $HOOK_FILE
            echo 'post-commit hook removed.'
          else
            echo 'post-commit hook not removed.'
          fi
        else
          echo 'post-commit hook does not exist in this repository.'
        fi
        ;;
      *)
        if [ -z "$REPO_ROOT" ]; then
          echo 'Please run this command inside a Git repository.'
        else
          echo "\nREPOSITORY HOOK COMMANDS"
          echo "  commit  \tInstall post-commit hook"
          echo "  reset   \tUninstall post-commit hook"
        fi
        ;;
    esac
    ;;
  audio)
    echo $PARAMETER
    ;;
  *)
    echo "GCA"
    ;;
esac
