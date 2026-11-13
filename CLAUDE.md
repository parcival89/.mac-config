# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal macOS development environment configuration system. It manages Homebrew packages, zsh shell configuration (via oh-my-zsh), asdf runtime versions, and multiple work profiles for different organizations.

## Common Commands

```bash
# Update this repo
update-mac-config

# Install/update Homebrew packages from Brewfile
update-brew
# or directly:
brew bundle --file=homebrew/Brewfile

# Install asdf plugins and runtime versions (after a fresh install or version change)
setup-asdf

# Update zsh plugin/theme git submodules
update-zsh-submodules

# After cloning, initialize submodules
git submodule update --init --recursive
```

## Architecture

### Profile System

The core concept is a hierarchy of shell profiles sourced at login:

1. **`profiles/base/profile.sh`** — Shared utilities, aliases, and functions loaded by all profiles. Contains Docker cleanup helpers, GPG/git signing setup functions, and `update-*` maintenance commands.
2. **`profiles/<name>/profile.sh`** — Work-context profiles (home, kbc, kunlabora, sparkcentral, digipolis, vmm). Each sets `GIT_USER_NAME`, `GIT_USER_EMAIL`, and org-specific aliases/env vars.

**Active profile** is controlled by `zsh/03-profile.zsh`, which sources one profile directly (currently `profiles/kunlabora/profile.sh`). Change this file to switch active context.

### zsh Loading Order

Files in `zsh/` are sourced in alphabetical order via oh-my-zsh's `ZSH_CUSTOM` mechanism:
- `00-brew.zsh` — Homebrew PATH (`/opt/homebrew/bin`) and disables analytics
- `01-asdf.zsh` — asdf version manager setup (shims, completions, `JAVA_HOME` hook). Also defines `setup-asdf`, which installs plugins and pins versions for Java, Node, Python, pnpm, Gradle, AWS CLI, Terraform, sops, age. Installs are deliberately not run at shell start (they hang silently)
- `02-bash-completion.zsh` — Loads Homebrew bash completions
- `03-profile.zsh` — Sources the active work profile

### Runtime Version Management

All language runtimes are managed by **asdf** (not system packages or SDKMAN). Versions and plugins are defined in `zsh/01-asdf.zsh`. The `zsh/config/.asdfrc` enables `legacy_version_file = yes` so `.nvmrc`/`.python-version` files are respected.

### Git Submodules

Plugins and themes live as git submodules under `zsh/plugins/` and `zsh/themes/`:
- Plugins: `zsh-autosuggestions`, `zsh-completions`, `zsh-syntax-highlighting`
- Themes: `powerlevel9k`, `powerlevel10k`

### Upstream Relationship

- `origin` → personal fork (`parcival89/.mac-config`)
- `upstream` → original repo (`vanpeerdevelopment/.mac-config`)

Changes from upstream are merged in periodically. Personal customizations stay on `master`.
