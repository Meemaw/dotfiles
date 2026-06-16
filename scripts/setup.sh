#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup OSX defaults
# $SCRIPT_DIR/osx.sh

# Install Homebrew if needed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is on PATH for the rest of this script. A freshly installed
# Homebrew isn't on PATH yet in the current shell (it's only wired up by the
# eval in .zprofile), so `brew bundle` below would fail with "command not found".
if ! command -v brew &>/dev/null; then
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

brew bundle --file="$SCRIPT_DIR/../Brewfile"

# Make zsh default shell
if [ "$(basename "$SHELL")" != "zsh" ]; then
    echo "Changing default shell to zsh"
    chsh -s "$(which zsh)"
fi

# Install Oh-My-ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # oh-my-zsh drops its own ~/.zshrc; back it up instead of deleting so we
    # don't clobber a pre-existing config before our symlink takes over.
    if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.pre-dotfiles"
        echo "Backed up existing ~/.zshrc to ~/.zshrc.pre-dotfiles"
    fi
fi

find "$SCRIPT_DIR/.." -type f -name "*.symlink" | while read -r file; do
    target="$HOME/$(basename "$file" .symlink)"
    source=$(realpath "$file")

    if [ ! -L "$target" ]; then
        ln -s "$source" "$target"
        echo "Symlink created: $source → $target"
    fi
done
