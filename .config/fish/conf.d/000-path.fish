# vim のキーバインドでターミナルを操作
# fish_vi_key_bindings
set -U fish_key_bindings fish_default_key_bindings
# jj で normal に
#set fish_key_bindings fish_user_key_bindings

set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_ALL 'ja_JP.UTF-8'

# Postgres
set -x PGDATA /usr/local/var/postgres

# go
set -x GOPATH $HOME/go
set -x GOROOT ( go env GOROOT )
set -x PATH $GOPATH/bin $PATH

# ls color
set -x CLICOLOR 1
set -x LSCOLORS DxGxcxdxCxegedabagacad

# PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/usr/lib/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/git/bin $PATH
set -x PATH $HOME/extensions/coc-clangd-data/install/11.0.0/clangd_11.0.0/bin $PATH
set -x PATH $HOME/.poetry/bin $PATH
set -x PATH /usr/local/opt/binutils/bin $PATH

# set -x PATH /usr/local/opt/llvm/bin $PATH
# set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths

# ranger
#
set -x EDITOR nvim
set -x VISUAL nvim


# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH
set -x WORKON_HOME $HOME/.virtualenvs

set -x PYTHONPATH /Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python $PYTHONPATH
set -x PYTHONSTARTUP ~/.pythonstartup

set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH:/usr/local/include/c++/9.2.0/x86_64-apple-darwin18/

# cd, pwd などは history に登録しない
set -x HISTORY_IGNORE "(cd|pwd|ls)"

set -x FZF_DEFAULT_OPTS '--height 70% --layout=reverse --preview "bat --style=numbers --color=always --line-range :300 {}"'