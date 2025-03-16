#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup OSX defaults
$SCRIPT_DIR/osx.sh

# Install Homebrew if needed
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle

# Make zsh default shell
chsh -s $(which zsh)

# Install Oh-My-ZSH
ZSH= sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

for file in .zprofile .zshrc .gitconfig; do
    if [ ! -e ~/$file ]; then
        ln -s "$SCRIPT_DIR/../$file" ~/$file
        source ~/$file
        echo "$file symlink created."
    fi
done