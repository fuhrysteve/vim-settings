#!/bin/bash

if [ -f ~/.vimrc ] && [ ! -L ~/.vimrc ]
then
    echo "Backing up existing ~/.vimrc to ~/.vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
fi
if [ -L ~/.vimrc ]
then
    SYMLINK_LOCATION=$(readlink "$HOME/.vimrc")
    if [ "$SYMLINK_LOCATION" == "$HOME/.vim/vimrc" ]; then
        echo "Renaming symlink to point to ~/.vim/nvimrc"
        rm ~/.vimrc
        ln -s ~/.vim/nvimrc ~/.vimrc
    else
        echo "Already have ~/.vimrc symlink, we're good"
    fi
else
    echo "Creating symlink ~/.vimrc, which points to ~/.vim/vimrc"
    ln -s ~/.vim/nvimrc ~/.vimrc
fi
if [ ! -d ~/.nvim ] || [ ! -L ~/.nvim ]; then
    echo "Creating symlink ~/.nvim which points to ~/.vim"
    ln -s ~/.vim ~/.nvim
fi

VIMINFO_OWNER=$(stat -c "%U" ~/.viminfo)

if [ "$VIMINFO_OWNER" == "root" ]
then
    echo "Your .viminfo file is owned by root. Changing owner to $(whoami)"
    sudo chown $(whoami) ~/.viminfo
fi
git submodule init
git submodule update
vim +BundleInstall! +qall
