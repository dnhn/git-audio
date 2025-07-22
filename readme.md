# Git Commit Audio

A Git hook that plays a sound when you commit.

[For the Love of Code 2025](https://github.blog/open-source/for-the-love-of-code-2025) hackathon entry.

## Features
- Easy to set up with a simple post-commit hook
- Customisable sound

## Installation

1. Clone this repository

2. Open [post-commit](./post-commit) and set the correct file path based on your system

   ```
   FILE="/path/to/gca/file.wav"
   ```

3. Install the hook into your repository

   ```shell
   cd /path/to/your/repo
   cp /path/to/gca/post-commit .git/hooks/
   ```

4. Make the hooks executable

   ```shell
   chmod +x .git/hooks/post-commit
   ```

5. Commit!

## Thanks

- [GitHub Copilot](https://github.com/copilot) for assisting with the code
- [Freesound](https://freesound.org/people/deleted_user_2104797/sounds/324894) for the audio file
