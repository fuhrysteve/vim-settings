SHELL := /bin/bash -euo pipefail

install-neovim:
	sudo -H bash ./install_neovim.sh

install-vim-plug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install: install-neovim install-vim-plug deploy

deploy:
	bash ./deploy.sh
