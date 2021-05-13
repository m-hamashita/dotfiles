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
ln -sf ~/dotfiles/.tmux ~/.tmux

# ssh
mkdir -p ~/.ssh
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config

#.config (nvim, karabiner)
ln -sf ~/dotfiles/.config/ ~/.config

#.tigrc #gitのやつ
ln -sf ~/dotfiles/.tigrc ~/.tigrc

ln -sf ~/cheatsheet/.work_cheatsheet ~/.work_cheatsheet
ln -sf ~/cheatsheet/.prog_cheatsheet ~/.prog_cheatsheet
ln -sf ~/cheatsheet/.vim_cheatsheet ~/.vim_cheatsheet
ln -sf ~/cheatsheet/.tmux_cheatsheet ~/.tmux_cheatsheet
ln -sf ~/cheatsheet/.shell_cheatsheet ~/.shell_cheatsheet
ln -sf ~/cheatsheet/.goal_cheatsheet ~/.goal_cheatsheet
ln -sf ~/cheatsheet/.todo_cheatsheet ~/.todo_cheatsheet
