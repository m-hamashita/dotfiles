#!/bin/sh
# shells
ln -sf ~/dotfiles/unused/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/unused/.bashrc ~/.bashrc
ln -sf ~/dotfiles/unused/.zshrc ~/.zshrc

# vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

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

# compile_flags.txt
ln -sf ~/dotfiles/compile_flags.txt ~/compile_flags.txt

# aqua.yaml
ln -sf ~/dotfiles/aqua.yaml ~/.local/share/aquaproj-aqua/aqua.yaml
ln -sf ~/dotfiles/registry.yaml ~/.local/share/aquaproj-aqua/registry.yaml
ln -sf ~/dotfiles/aqua-policy.yaml ~/.local/share/aquaproj-aqua/aqua-policy.yaml

# .textlintrc
ln -sf ~/dotfiles/.textlintrc ~/.textlintrc
