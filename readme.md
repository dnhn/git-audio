<div align="center">

# Git Audio

[![Cover image](./cover.svg)](https://git-audio.nhan.dev)

[![Documentation](https://img.shields.io/badge/Documentation-none?style=for-the-badge&cacheSeconds=86400)](https://git-audio.nhan.dev)
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

## Installation

```shell
make install
```

That’s it! You can now use the `git-audio` command.

## Usage

### Per-repository

1. Install the hook into a repository
   ```shell
   git-audio repo commit
   ```
1. Commit!

### Global

1. Run
   ```shell
   git-audio global commit
   ```
1. `git init`
1. Commit!

## Configuration

Configuration is stored in `$HOME/.git-audio/`

```
$HOME/.git-audio/
  ├─ audio.wav
  ├─ cli.sh
  ├─ config.sh
  └─ templates
      └─ hooks
          └─ post-commit
```

To change the audio, run this command:

```shell
git-audio audio /path/to/your/audio
```

## Thanks

- :copilot: [GitHub Copilot](https://gh.io/copilot) for co-piloting
- 🔈 [Freesound](https://freesound.org/s/324894) for the audio
- 📔 [og.new](https://og.new) for the cover image

<div align="center">
<img src="https://github.blog/wp-content/uploads/2025/05/leereilly-copilot.gif" alt="Copilot animation" width="250" height="315">
</div>
