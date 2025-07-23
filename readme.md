# Git Commit Audio

A Git hook that plays a sound when you commit. By default, it uses a sitcom laugh track.

[For the Love of Code 2025](https://github.blog/open-source/for-the-love-of-code-2025) hackathon entry.

## Features
- Cross-platform
  - macOS (`afplay`)
  - Linux (`aplay` or `paplay`)
- Quick setup with a single script
- Easily customisable sound (use your own audio)

| File | Description |
| - | - |
| [`audio.wav`](/audio.wav) | The audio |
| [`install.sh`](./install.sh) | Installation script |
| [`post-commit`](./post-commit) | Git hook for manual setup |

## How it works

This project installs a Git `post-commit` hook that plays an audio file after every commit. You can use the provided laugh track or replace it with your own sound.

## Installation

Clone this repository and choose one of the installation methods below.

### Automatic (Recommended)

1. **[OPTIONAL]** Set your own audio file or skip this step to use the provided audio

   ```shell
   # .bashrc, .zshrc, etc.
   export GIT_COMMIT_AUDIO="/path/to/your/audio"
   ```

1. Install the hook into a repository

   ```shell
   cd /path/to/your/repo
   source /path/to/gca/install.sh
   ```

1. Commit!

### Manual

1. **[REQUIRED]** Link to the provided audio or your own sound

   ```shell
   # .bashrc, .zshrc, etc.
   export GIT_COMMIT_AUDIO="/path/to/gca/audio.wav"
   ```

1. Copy the hook into a repository and make it executable

   ```shell
   cd /path/to/your/repo
   cp /path/to/gca/post-commit .git/hooks/
   chmod +x .git/hooks/post-commit
   ```

1. Commit!

## Thanks

- :copilot: [GitHub Copilot](https://github.com/copilot) for co-piloting
- 🔈 [Freesound](https://freesound.org/people/deleted_user_2104797/sounds/324894) for the audio

<div align="center">
<img src="https://github.blog/wp-content/uploads/2025/05/leereilly-copilot.gif?resize=250%2C315" alt="GitHub Copilot animation" width="250" height="315">
</div>
