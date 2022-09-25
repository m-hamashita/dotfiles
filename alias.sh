#!/bin/sh
# shells
ln -sf ~/dotfiles/unused/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/unused/.bashrc ~/.bashrc
ln -sf ~/dotfiles/unused/.zshrc ~/.zshrc

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

#.config (fish, nvim, karabiner)
ln -sf ~/dotfiles/.config/ ~/.config

#.tigrc
ln -sf ~/dotfiles/.tigrc ~/.tigrc

# .pythonstartup
ln -sf ~/dotfiles/.pythonstartup ~/.pythonstartup

# .hammerspoon
ln -sf ~/dotfiles/.hammerspoon ~/.hammerspoon
