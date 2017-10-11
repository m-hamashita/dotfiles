export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export WORKON_HOME=$HOME/.virtualenvs

[[ -d ~/.rbenv  ]] && \
     export PATH=${HOME}/.rbenv/bin:${PATH} && \
   eval "$(rbenv init -)"	 

LANG=ja_JP.UTF-8
LC_CTYPE=ja_JP.UTF-8

