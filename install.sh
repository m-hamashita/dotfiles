#!/bin/sh
# shells
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

# tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# ssh
mkdir -p ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config 

#.config (nvim, karabiner)
ln -sf ~/dotfiles/.config/ ~/.config


