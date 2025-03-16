#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup OSX defaults
# $SCRIPT_DIR/osx.sh

# Install Homebrew if needed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle

# Make zsh default shell
if [ "$(basename "$SHELL")" != "zsh" ]; then
    echo "Changing default shell to zsh"
    chsh -s "$(which zsh)"
fi

# Install Oh-My-ZSH
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    rm $HOME/.zshrc
fi

find "$SCRIPT_DIR/.." -type f -name "*.symlink" | while read -r file; do
    target="$HOME/$(basename "$file" .symlink)"
    source=$(realpath "$file")

    if [ ! -L "$target" ]; then
        ln -s "$source" "$target"
        echo "Symlink created: $source → $target"
    fi
done
