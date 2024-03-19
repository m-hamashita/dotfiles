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

# fish install
brew install fish
echo "Please add `/usr/local/bin/fish` to /etc/shells "
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# font install
echo "Please install powerline font"
echo "Font: menlo for powerline"
echo "Non-ASCII: Hack Nerd Font Mono for defx.nvim"

chsh -s /usr/local/bin/fish

# aqua install
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v2.3.0/aqua-installer | bash
