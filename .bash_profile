export PS1="\W $ "
eval "$(pyenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH=/usr/local/bin:$PATH
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi



export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
export PATH="$HOME/.pyenv/shims:$PATH"




if [ -d "${PYENV_ROOT}" ]; then
       export PATH=${PYENV_ROOT}/bin:$PATH
       eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi 

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"





