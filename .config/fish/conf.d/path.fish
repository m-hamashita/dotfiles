
# vimのキーバインドになる
# fish_vi_key_bindings
set -U fish_key_bindings fish_default_key_bindings
# jj で normal に
#set fish_key_bindings fish_user_key_bindings

# コマンドの色を緑に
set fish_color_command green

set -x WORKON_HOME $HOME/.virtualenvs
set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_ALL 'ja_JP.UTF-8'

# Postgres
set -x PGDATA /usr/local/var/postgres

set -x PYTHONPATH /Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python $PYTHONPATH

set -x GOPATH $HOME/go
set -x GOROOT ( go env GOROOT )
set -x PATH $GOPATH/bin $PATH


set -x PATH ~/usr/lib/bin $PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PATH /usr/local/git/bin $PATH
set -x PATH $HOME/.cargo/bin $PATH


# .bash_profile
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH
set -x PYTHONSTARTUP ~/.pythonstartup
set -x PATH /usr/local/bin $PATH
set -x SDKMAN_DIR "/Users/masakatsu.hamashita/.sdkman"
# .bashrc
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PATH $HOME/.bin $PATH
set -x CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH:/usr/local/include/c++/9.2.0/x86_64-apple-darwin18/

set -x PATH $HOME/bin $PATH


set -x CLICOLOR 1
set -x LSCOLORS DxGxcxdxCxegedabagacad


# cd, pwd などは history に登録しない
set -x HISTORY_IGNORE "(cd|pwd|ls)"

set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -100 {}"'
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
set -x SDKMAN_DIR "/Users/masakatsu.hamashita/.sdkman"
# [[ -s "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh"
set -x PATH "/usr/local/opt/llvm/bin $PATH"