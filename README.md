### Installation ###

This is currently optimized for Ubuntu.

`make install` will:

1. add the neovim/stable repo, if not already added, and apt-get install neovim & some dependencies
2. Install vim-plug (plugin manager) for your local user
3. create a symlink, ~/.config/nvim/init.vim to the init.vim in this directory

```bash
    git clone git@github.com:fuhrysteve/vim-settings.git
    make install
```
