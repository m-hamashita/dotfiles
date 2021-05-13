#!/bin/sh
# tpm install 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim install
if [ "$(uname)" == 'Darwin' ]; then
    brew install neovim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    curl -L https://github.com/neovim/neovim/releases/download/v0.4.0/nvim.appimage -o nvim
    mkdir -p ~/local/bin/
    mv ./nvim ~/local/bin/nvim
    rm nvim
fi

# dein install
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh

# zplug install
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# font install
