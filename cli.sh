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
    printf "Manage hook initialisation for new repositories\n"
    printf "\n\e[1mUsage:\e[22m git-audio global:<command>\n"
    printf "\n\e[1mCOMMANDS\e[22m\n"
    printf "  global:set    Initialise post-commit hook for new repositories\n"
    printf "  global:unset  Unset post-commit hook initialisation\n"
    ;;
  global:set)
    git config --global init.templateDir $TEMPLATE_DIR
    printf "Global hook set.\n"
    ;;
  global:unset)
    git config --global --unset init.templateDir
    printf "Global hook unset.\n"
    ;;
  repo)
    printf "Manage repository hook\n"
    printf "\n\e[1mUsage:\e[22m git-audio repo:<command>\n"
    printf "\n\e[1mCOMMANDS\e[22m\n"
    printf "  repo:commit  Install post-commit hook to current repository\n"
    printf "  repo:reset   Uninstall post-commit hook from current repository\n"
    ;;
  repo:commit)
    if [ -z "$REPO_ROOT" ]; then
      printf "Please run this command inside a Git repository.\n"
    elif [ -f "$HOOK_FILE" ]; then
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
  repo:reset)
    if [ -z "$REPO_ROOT" ]; then
      printf "Please run this command inside a Git repository.\n"
    elif [ -f "$HOOK_FILE" ]; then
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
  audio)
    check_config
    . $CONFIG_FILE
    printf "Configure audio\n"
    printf "\nCurrent audio: $GIT_AUDIO\n"
    printf "\n\e[1mUsage:\e[22m git-audio audio:<command>\n"
    printf "\n\e[1mCOMMANDS\e[22m\n"
    printf "  audio:default              Reset to default audio\n"
    printf "  audio:reset                Alias for audio:default\n"
    printf "  audio:set <absolute-path>  Set custom audio\n"
    ;;
  audio:default|audio:reset)
    check_config
    printf "export GIT_AUDIO=\"$CONFIG_DIR/audio.wav\"\n" > $CONFIG_FILE
    printf "Audio reset to default $CONFIG_DIR/audio.wav\n"
    ;;
  audio:set)
    if [ ! -f "$PARAMETER" ]; then
      printf "File not found $PARAMETER\n"
    else
      check_config
      printf "export GIT_AUDIO=\"$PARAMETER\"\n" > $CONFIG_FILE
      printf "Audio set to $PARAMETER\n"
    fi
    ;;
  *)
    printf "\e[1mGit Audio\e[22m command line interface\n"
    printf "\n\e[1mUsage:\e[22m git-audio <command>\n"
    printf "\n\e[1mCOMMANDS\e[22m\n"
    printf "  global  Manage hook initialisation for new repositories\n"
    printf "  repo    Manage hook for current repository\n"
    printf "  audio   Configure audio\n"
    ;;
esac
