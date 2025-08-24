#!/bin/sh
# Git Audio command line interface

COMMAND="$1"
PARAMETER="$2"

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
CONFIG_DIR="$HOME/.git-audio"
CONFIG_FILE="$CONFIG_DIR/config.sh"
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
        echo "  set    \tSet global hook"
        echo "  unset  \tUnset global hook"
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
    case $PARAMETER in
      "")
        source $CONFIG_FILE
        echo "Current audio: $GIT_COMMIT_AUDIO\n"
        echo "  reset             \tReset to default audio"
        echo "  /path/to/audio    \tCustom audio with absolute path"
        ;;
      reset)
        echo "export GIT_COMMIT_AUDIO=\"$CONFIG_DIR/audio.wav\"" > $CONFIG_FILE
        echo 'Audio reset to default' $CONFIG_DIR/audio.wav
        ;;
      *)
        if [ ! -f "$PARAMETER" ]; then
          echo "File $PARAMETER does not exist."
        else
          echo "export GIT_COMMIT_AUDIO=\"$PARAMETER\"" > $CONFIG_FILE
          echo 'Audio set to' $PARAMETER
        fi
        ;;
    esac
    ;;
  *)
    echo "\nCOMMANDS"
    echo "  global  \tGlobal hook"
    echo "  repo    \tRepository hook"
    echo "  audio   \tAudio configuration"
    ;;
esac
