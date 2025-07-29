# Git Commit Audio

![Cover image](./cover.svg)

Add a spark of joy to coding—hear a surprise sound every time you commit. By default, it’s a sitcom laugh track.

[For the Love of Code 2025](https://gh.io/ftloc) hackathon entry.

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
> This will affect your current Git configuration! Use with caution.

1. From this project, run
   ```shell
   make commit
   ```
1. `git init` will now include the hook in new repositories

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
  └─ template
      └─ hooks
          └─ post-commit
```

To change the audio, update the path in `config.sh`

```shell
export GIT_COMMIT_AUDIO="/path/to/your/audio"
```

## Demo

https://github.com/user-attachments/assets/9da2c4f6-9462-4074-a5d4-7a85f6c11e80

## Thanks

- :copilot: [GitHub Copilot](https://gh.io/copilot) for co-piloting
- 🔈 [Freesound](https://freesound.org/s/324894) for the audio
- 📔 [og.new](https://og.new) for the cover image

<div align="center">
<img src="https://github.blog/wp-content/uploads/2025/05/leereilly-copilot.gif" alt="Copilot animation" width="250" height="315">
</div>
