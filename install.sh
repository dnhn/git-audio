#!/bin/sh

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
  echo "Please run this script inside a Git repository."
  return
fi

AUDIO_PATH="$GIT_COMMIT_AUDIO"
if [ ! -f "$GIT_COMMIT_AUDIO" ]; then
  AUDIO_PATH="$(cd "$(dirname "$0")" && pwd)/audio.wav"
fi

# post-commit hook
HOOK_FILE="$REPO_ROOT/.git/hooks/post-commit"
cat > "$HOOK_FILE" <<EOF
#!/bin/sh

AUDIO="$AUDIO_PATH"
if [ ! -f "\$AUDIO" ]; then
  echo "Git Commit Audio: audio not found '\$AUDIO'"
  exit 1
fi

OS="\$(uname)"
case "\$OS" in
  Darwin)
    afplay "\$AUDIO" &
    ;;
  Linux)
    if command -v aplay >/dev/null 2>&1; then
      aplay "\$AUDIO" &
    elif command -v paplay >/dev/null 2>&1; then
      paplay "\$AUDIO" &
    else
      echo "Git Commit Audio: audio player not found."
      exit 1
    fi
    ;;
  *)
    echo "Git Commit Audio: unsupported OS \$OS"
    exit 1
esac
EOF

chmod +x "$HOOK_FILE"
echo "Git Commit Audio installed!"
