#!/bin/sh
# tpm install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim install
if [ "$(uname)" == 'Darwin' ]; then
    brew install neovim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    curl -L https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage -o nvim
    mkdir -p ~/local/bin/
    mv ./nvim ~/local/bin/nvim
    rm nvim
fi

# dein install
mkdir -p ~/.cache/dein
cd ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh

# fish install
brew install fish
echo "Please add `/usr/local/bin/fish` to /etc/shells "

# font install
echo "Please install powerline font"
echo "Font: menlo for powerline"
echo "Non-ASCII: Hack Nerd Font Mono for defx.nvim"
