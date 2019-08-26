export HOMEBREW_CASK_OPTS="--appdir=/Applications"

LANG=ja_JP.UTF-8
LC_CTYPE=ja_JP.UTF-8

# [[ -d ~/.rbenv  ]] && \
#      export PATH=${HOME}/.rbenv/bin:${PATH} && \
#    eval "$(rbenv init -)"	 
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin brew"


export PYENV_ROOT="$HOME/.pyenv"
#export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PYENV_ROOT/shims:$PATH

if [ -d "${PYENV_ROOT}" ]; then
       export PATH=${PYENV_ROOT}/bin:$PATH
       eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi 
