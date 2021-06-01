export HOMEBREW_CASK_OPTS="--appdir=/Applications"

LANG=ja_JP.UTF-8
LC_CTYPE=ja_JP.UTF-8

alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"

export PYENV_ROOT="$HOME/.pyenv"
#export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PYENV_ROOT/shims:$PATH
# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH


export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/include/c++/9.2.0/x86_64-apple-darwin18/
if [ -d "${PYENV_ROOT}" ]; then
       export PATH=${PYENV_ROOT}/bin:$PATH
       eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

export PATH="$HOME/bin:$PATH"
source "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
