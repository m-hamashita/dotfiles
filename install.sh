#!/bin/bash
# tpm install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim
if [ "$(uname)" == 'Darwin' ]; then
    brew install neovim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    curl -L  https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage -o nvim
    mkdir -p ~/.local/bin/
    mv ./nvim ~/.local/bin/nvim
    chmod +x ~/.local/bin/nvim
fi

# fish
if [ "$(uname)" == 'Darwin' ]; then
    brew install fish
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # TODO: debian 12 only
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
    sudo apt update
    sudo apt install fish
fi
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# for symlink
rm -rf ~/.config/fish

# font install
echo "Please install powerline font"
echo "Font: Meslo for powerline"
echo "Non-ASCII: Hack Nerd Font Mono for defx.nvim"
if [ "$(uname)" == 'Darwin' ]; then
    brew install font-hack-nerd-font
fi

echo "Please add `/usr/local/bin/fish` to /etc/shells"
# chsh -s /usr/local/bin/fish

# aqua install
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.2/aqua-installer | bash

mkdir -p ~/.local/share/aquaproj-aqua
