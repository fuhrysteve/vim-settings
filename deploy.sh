#!/bin/bash

if [ -f ~/.vimrc ] && [ ! -L ~/.vimrc ]
then
    echo "Backing up existing ~/.vimrc to ~/.vimrc.bak"
    mv ~/.vimrc ~/.vimrc.bak
fi
if [ -L ~/.vimrc ]
then
    echo "Already have ~/.vimrc symlink, we're good"
else
    echo "Creating symlink ~/.vimrc, which points to ~/.vim/vimrc"
    ln -s ~/.vim/vimrc ~/.vimrc
fi

VIMINFO_OWNER=$(stat -c "%U" ~/.viminfo)

if [ "$VIMINFO_OWNER" == "root" ]
then
    echo "Your .viminfo file is owned by root. Changing owner to $(whoami)"
    sudo chown $(whoami) ~/.viminfo
fi
git submodule init
git submodule update
vim +BundleInstall +qall
