# Git Commit Audio

A Git hook that plays a sound when you commit, by default, a sitcom laugh track.

[For the Love of Code 2025](https://github.blog/open-source/for-the-love-of-code-2025) hackathon entry.

## Features
- Cross-platform, uses `afplay` for macOS, `aplay` or `paplay` for Linux
- Easy to set up with a simple post-commit hook
- Customisable sound

## Installation

1. Clone this repository

1. Open [post-commit](./post-commit) and set the correct file path based on your system

   ```shell
   AUDIO="/path/to/gca/audio.wav"
   ```

1. Install the hook into a repository

   ```shell
   cd /path/to/your/repo
   cp /path/to/gca/post-commit .git/hooks/
   ```

1. Make the hooks executable

   ```shell
   chmod +x .git/hooks/post-commit
   ```

1. Commit!

## Thanks

- [GitHub Copilot](https://github.com/copilot) for co-piloting
- [Freesound](https://freesound.org/people/deleted_user_2104797/sounds/324894) for the audio

<div align="center">
<img src="https://github.blog/wp-content/uploads/2025/05/leereilly-copilot.gif?resize=250%2C315" alt="GitHub Copilot animation" width="250" height="315">
</div>
