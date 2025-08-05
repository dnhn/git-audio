<div align="center">

# Git Commit Audio

[![Cover image](./cover.svg)](https://gca.nhan.dev)

[![Documentation](https://img.shields.io/badge/Documentation-none?style=for-the-badge&cacheSeconds=86400)](https://gca.nhan.dev)
[![License](https://img.shields.io/github/license/dnhn/gca?style=for-the-badge&cacheSeconds=86400)](./license)

Add a spark of joy to coding—hear a surprise sound every time you commit. By default, it’s a sitcom laugh track.

[For the Love of Code 2025](https://gh.io/ftloc) hackathon entry.

</div>

## Features

- Cross-platform
  - macOS (`afplay`)
  - Linux (`aplay` or `paplay`)
- Quick setup with a single command!
- Centralised configuration
- Easily customisable audio

| File | Description |
| - | - |
| [`audio.wav`](/audio.wav) | The audio |
| [`install.sh`](./install.sh) | Repository installation script |
| [`Makefile`](./Makefile) | Global hook commands |
| [`post-commit`](./post-commit) | [The hook](https://git-scm.com/docs/githooks#_post_commit) |

## Installation

Clone this project and follow the instructions.

### Per-repository

1. Install the hook into a repository
   ```shell
   cd /path/to/your/repo
   source /path/to/gca/install.sh
   ```
1. Commit!

To uninstall, simply delete `.git/hooks/post-commit` from the repository.

### Global

> [!WARNING]
> This will alter your global Git configuration. Use with caution.

1. From this project, run
   ```shell
   make commit
   ```
1. Initialise a repository with `git init`, new repositories will now include the hook
1. Commit

To stop including the hook in new repositories, run

```shell
make reset
```

This only de-registers the hook for newly initialised repositories, you need to delete the hook manually from existing repositories.

## Configuration

Configuration is stored in `$HOME/.git-commit-audio/`

```
$HOME/.git-commit-audio/
  ├─ audio.wav
  ├─ config.sh
  └─ templates
      └─ hooks
          └─ post-commit
```

To change the audio, update the absolute path in `config.sh`

```shell
export GIT_COMMIT_AUDIO="/path/to/your/audio"
```

## Demo

https://github.com/user-attachments/assets/572f65e2-3b84-4c3e-9d10-50e4a558c38e

## Thanks

- :copilot: [GitHub Copilot](https://gh.io/copilot) for co-piloting
- 🔈 [Freesound](https://freesound.org/s/324894) for the audio
- 📔 [og.new](https://og.new) for the cover image
- [ZURB Foundation](https://github.com/zurb/foundation-icon-fonts) for the logo icon

<div align="center">
<img src="https://github.blog/wp-content/uploads/2025/05/leereilly-copilot.gif" alt="Copilot animation" width="250" height="315">
</div>
