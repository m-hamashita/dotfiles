# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && . "$HOME/.fig/shell/bash_profile.pre.bash"
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH=/usr/local/bin:$PATH
# if [ -f ~/.bashrc ]; then
# 	. ~/.bashrc
# fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
export PATH="$HOME/.pyenv/shims:$PATH"
export PYTHONSTARTUP=~/.pythonstartup

source "$HOME/.cargo/env"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && . "$HOME/.fig/shell/bash_profile.post.bash"