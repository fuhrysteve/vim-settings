#!/bin/bash -euo pipefail

if [[ $EUID = 0 ]]; then
    read -r -p "You're running as root. Are you sure you want to proceed? [y/N]" response
    response=${response,,} # tolower
    if [[ ! $response =~ ^(yes|y| ) ]]; then
        exit 1
    fi
fi

if [ -f "$HOME/.config/nvim/init.vim" ] && [ ! -L "$HOME/.config/nvim/init.vim" ]
then
    echo "Backing up existing $HOME/.config/nvim/init.vim to $HOME/.config/nvim/init.vim.bak"
    mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.bak"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -L "$HOME/.config/nvim/init.vim" ]
then
    echo "Already have $HOME/.config/nvim/init.vim symlink, we're good"
else
    echo "Creating symlink $HOME/.config/nvim/init.vim which points to $DIR/init.vim"
    ln -s "$DIR/init.vim" "$HOME/.config/nvim/init.vim"
fi

nvim +PlugInstall! +UpdateRemotePlugins! +qall
