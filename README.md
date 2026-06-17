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

## JavaScript package managers

The Brewfile installs Corepack instead of standalone `pnpm` or `yarn`.
Use Corepack to pin the package manager per project:

```sh
corepack use pnpm@latest-11
```

After that, normal project commands like `pnpm install` use the version recorded
in `package.json`'s `packageManager` field. If a shell-level security wrapper is
installed for package-manager commands, it may wrap the command first; the
Homebrew-owned `pnpm`/`yarn` binaries underneath are Corepack shims.

## iTerm2 profile

[`iterm/Default.json`](iterm/Default.json) is an iTerm2 dynamic profile.
`setup.sh` symlinks it into iTerm's `DynamicProfiles` directory automatically, so
it appears under Preferences → Profiles after setup.

## macOS defaults

[`scripts/osx.sh`](scripts/osx.sh) applies opinionated macOS defaults (Finder,
Dock, Time Machine, etc.). It is **not** run by `setup.sh` by default — run it
manually when you want those settings:

```sh
scripts/osx.sh
```
