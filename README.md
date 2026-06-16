# Matej's dotfiles

## Getting started

```sh
xcode-select --install
git clone git@github.com:Meemaw/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
scripts/setup.sh
```

`scripts/setup.sh` installs Homebrew, runs `brew bundle` (see [`Brewfile`](Brewfile)),
sets `zsh` as the default shell, installs oh-my-zsh, and symlinks every `*.symlink`
file into `$HOME` (e.g. `.zshrc.symlink` → `~/.zshrc`).

> Sign in to the Mac App Store before running setup — `brew bundle` uses `mas`
> for App Store apps (e.g. Magnet) and will fail otherwise.

## iTerm2 profile

[`iterm/Default.json`](iterm/Default.json) is an iTerm2 dynamic profile. Load it by
symlinking it into iTerm's dynamic profiles directory, then it appears under
Preferences → Profiles:

```sh
mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
ln -sf "$PWD/iterm/Default.json" \
  "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Default.json"
```

## macOS defaults

[`scripts/osx.sh`](scripts/osx.sh) applies opinionated macOS defaults (Finder,
Dock, Time Machine, etc.). It is **not** run by `setup.sh` by default — run it
manually when you want those settings:

```sh
scripts/osx.sh
```
