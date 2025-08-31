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

install_hook() {
  cp $SRC_HOOK $HOOKS_DIR
  chmod +x $HOOK_FILE
  printf "post-commit hook installed.\n"
}

check_config() {
  if [ ! -f "$CONFIG_FILE" ]; then
    touch $CONFIG_FILE
		printf "export GIT_AUDIO=\"$CONFIG_DIR/audio.wav\"\n" > $CONFIG_FILE
  fi
}

case $COMMAND in
  global)
    case $PARAMETER in
      set)
        git config --global init.templateDir $TEMPLATE_DIR
        printf "Global hook set.\n"
        ;;
      unset)
        git config --global --unset init.templateDir
        printf "Global hook unset.\n"
        ;;
      *)
        printf "\nGLOBAL HOOK COMMANDS\n"
        printf "  set    \tSet global hook\n"
        printf "  unset  \tUnset global hook\n"
        ;;
    esac
    ;;
  repo)
    case $PARAMETER in
      commit)
        if [ -f "$HOOK_FILE" ]; then
          cat $HOOK_FILE
          read -r -p "$(printf '\nA post-commit hook already exists. Overwrite it? (y/N) ')" answer
          if [ "$answer" = 'y' ]; then
            install_hook
          else
            printf "post-commit hook was not changed.\n"
          fi
        else
          install_hook
        fi
        ;;
      reset)
        if [ -f "$HOOK_FILE" ]; then
          cat $HOOK_FILE
          read -r -p "$(printf '\nRemove the post-commit hook? (y/N) ')" answer
          if [ "$answer" = 'y' ]; then
            rm -f $HOOK_FILE
            printf "post-commit hook removed.\n"
          else
            printf "post-commit hook was not removed.\n"
          fi
        else
          printf "No post-commit hook found in this repository.\n"
        fi
        ;;
      *)
        if [ -z "$REPO_ROOT" ]; then
          printf "Please run this command inside a Git repository.\n"
        else
          printf "\nREPOSITORY HOOK COMMANDS\n"
          printf "  commit  \tInstall post-commit hook\n"
          printf "  reset   \tUninstall post-commit hook\n"
        fi
        ;;
    esac
    ;;
  audio)
    case $PARAMETER in
      "")
        check_config
        . $CONFIG_FILE
        printf "Current audio: $GIT_AUDIO\n"
        printf "\nAUDIO COMMANDS\n"
        printf "  default           \tReset to default audio\n"
        printf "  reset             \tReset to default audio\n"
        printf "  /path/to/audio    \tSet custom audio (absolute path)\n"
        ;;
      default|reset)
        check_config
        printf "export GIT_AUDIO=\"$CONFIG_DIR/audio.wav\"\n" > $CONFIG_FILE
        printf "Audio reset to default $CONFIG_DIR/audio.wav\n"
        ;;
      *)
        if [ ! -f "$PARAMETER" ]; then
          printf "File not found $PARAMETER\n"
        else
          check_config
          printf "export GIT_AUDIO=\"$PARAMETER\"\n" > $CONFIG_FILE
          printf "Audio set to $PARAMETER\n"
        fi
        ;;
    esac
    ;;
  *)
    printf "\nCOMMANDS\n"
    printf "  global  \tManage global hook\n"
    printf "  repo    \tManage repository hook\n"
    printf "  audio   \tConfigure audio\n"
    ;;
esac
