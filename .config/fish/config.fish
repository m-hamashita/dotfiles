set -x WORKON_HOME $HOME/.virtualenvs

set fish_color_command green

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


function _command_exists
    which $1 &> /dev/null
end

# .bash_profile
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH $PYENV_ROOT/bin:$PATH
set -x PATH "$HOME/.pyenv/shims:$PATH"
set -x PYTHONSTARTUP ~/.pythonstartup
set -x PATH /usr/local/bin:$PATH
set -x SDKMAN_DIR "/Users/masakatsu.hamashita/.sdkman"
# .bashrc
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH $PYENV_ROOT/shims:$PATH
set -x PATH $HOME/.nodebrew/current/bin:$PATH
set -x CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH:/usr/local/include/c++/9.2.0/x86_64-apple-darwin18/
if [ -d "$PYENV_ROOT" ]
       set -x PATH $PYENV_ROOT/bin:$PATH
       source (pyenv init - | psub)
    source (pyenv virtualenv-init - | psub)
end

set -x PATH "$HOME/bin:$PATH"
set -U fish_user_paths $fish_user_paths $HOME/.cargo/bin

#neovimのためのpath
set -x XDG_CONFIG_HOME "~/.config"

set -x CLICOLOR 1
set -x LSCOLORS DxGxcxdxCxegedabagacad



# git checkout branchをfzfで選択
alias co 'git checkout (git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

alias :q 'exit'
alias gd 'git diff'
alias ga 'git add'
alias gp 'git pull'
alias gc 'git commit'
alias gis 'git status'
alias ... 'cd ../../'
alias ref 'source ~/.zshrc'

alias gcl 'gcloud beta compute ssh --zone "us-west1-b" "global-wheat-detection-vm" --project "euphoric-diode-279610" -- -L 8080:localhost:8080 -L 8081:localhost:8081'
# alias cd='pushd'
# alias cdd='popd'
alias df 'df -h'
alias vi 'vim'
alias diff 'colordiff'
alias his 'history | fzf | awk -F ";" "{system($2)}"'
alias del_swap 'rm ~/.local/share/nvim/swap/*'
if [ (command -v rmtrash) ]
    alias rm 'rmtrash'
else
    alias rm 'rm -i'
end
if [ (command -v nvim) ]
    alias vim 'nvim'
end
if [ (command -v gcc-10) ]
    alias gcc '/usr/local/bin/gcc-10'
end
if [ (command -v g++-10) ]
    alias g++ '/usr/local/bin/g++-10'
end
if [ (command -v tmux) ]
    alias ta 'tmux a -d'
end

if [ (command -v exa) ]
    alias ls 'exa -a --git'
    alias tree 'exa --tree'
else
    alias ls 'ls -at'
end

alias grep 'grep --color'
if [ -e "/Applications/CotEditor.app" ]
  alias cot 'open -a /Applications/'\''CotEditor.app'\'''
end
# alias history='history -f'
# alias history 'cat ~/.zhistory'
# cd, pwd などは history に登録しない
set -x HISTORY_IGNORE "(cd|pwd|ls)"

function mk
  mkdir $argv && cd $_
end
function pb
  cat $argv | pbcopy
end

function kaggle_python
  docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it kaggle/python python "$argv"
end
function kaggle_jupyter
  docker run -v $PWD:/tmp/working -w=/tmp/working -p 8988:8888 --rm -it kaggle/python jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/working --allow-root
end

set -x LESSOPEN "| /usr/local/Cellar/source-highlight/3.1.9_2/bin/src-hilite-lesspipe.sh %s"
set -x LESS '-R'

#—————————————————————————————————————————

# 補完

# fzf-cdr
alias cdd 'fzf-cdr'
function fzf-cdr
    set target_dir `cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf`
    set target_dir `echo $target_dir/\~/$HOME`
    if [ -n "$target_dir" ]
        cd $target_dir
    end
end


# cdr の設定
if [ ! -e  "$HOME/.cache/shell/chpwd-recent-dirs" ]
  mkdir -p $HOME/.cache/shell/
  touch $HOME/.cache/shell/chpwd-recent-dirs
end


# fshow - git commit browser
function fshow
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$argv" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
end

# fzfでリポジトリ以下のファイルの中身を検索してvimで開く
function fvim
  set files (git ls-files) &&
  set selected_files (echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
end

function gcd
    if [ -n "$1" ]
        set dir "(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]
            echo "no directroies found for '$1'"
            return 1
        end
        cd "$dir"
        return
    end
    echo 'usage: ghq-cd $repo'
    return 1
end



# agの結果をfzfで絞り込み選択するとvimで開く
alias agg="_agAndVim"
function _agAndVim
    if [ -z "$1" ]
        echo 'Usage: agg PATTERN'
        return 0
    end
    result=`ag $1 | fzf`
    line=`echo "$result" | awk -F ':' '{print $2}'`
    file=`echo "$result" | awk -F ':' '{print $1}'`
    if [ -n "$file" ]
        vim $file +$line
    end
end


#manに色を付ける
set -x MANPAGER 'less -R'
function man
	env \
			LESS_TERMCAP_mb=(printf "\e[1;31m") \
			LESS_TERMCAP_md=(printf "\e[1;31m") \
			LESS_TERMCAP_me=(printf "\e[0m") \
			LESS_TERMCAP_se=(printf "\e[0m") \
			LESS_TERMCAP_so=(printf "\e[1;44;33m") \
			LESS_TERMCAP_ue=(printf "\e[0m") \
			LESS_TERMCAP_us=(printf "\e[1;32m") \
			man "$argv"
end


# set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -100 {}"'



# The next line updates PATH for the Google Cloud SDK.
# if test -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc'
#     source '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc';
# end
#
# # The next line enables shell command completion for gcloud.
# if test -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc'
#     source '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc';
# end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# set -x __conda_setup "('/Users/masakatsu.hamashita/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $status -eq 0 ]
#     eval "$__conda_setup"
# else
#     if test -f '/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh'
#         . '/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh'
#     else
#         set -x PATH "/Users/masakatsu.hamashita/opt/anaconda3/bin $PATH"
#     end
# end
# set -e __conda_setup
# <<< conda initialize <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
set -x SDKMAN_DIR "/Users/masakatsu.hamashita/.sdkman"
# [[ -s "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh"
set -x PATH "/usr/local/opt/llvm/bin $PATH"
