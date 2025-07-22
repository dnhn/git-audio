# Git Commit Audio

Post-commit hook that plays a sound on every commit.

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

Sound credit: https://freesound.org/people/deleted_user_2104797/sounds/324894
