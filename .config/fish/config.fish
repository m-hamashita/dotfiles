set -x WORKON_HOME=$HOME/.virtualenvs

set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_ALL 'ja_JP.UTF-8'

# Postgres
set -x PGDATA /usr/local/var/postgres

set -x PYTHONPATH "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python ${PYTHONPATH}"

set -x GOPATH $HOME/go
set -x GOROOT $( go env GOROOT )
set -x PATH $GOPATH/bin $PATH


set -x PATH ~/usr/lib/bin $PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PATH /usr/local/git/bin $PATH
# プロンプトを表示する際に最初に変数展開する
setopt prompt_subst
#色を付ける
autoload -Uz add-zsh-hook
autoload -U colors && colors

#https://gist.github.com/qrush/1595572でフォントをダウンロード
zstyle ':prezto:module:editor:info:keymap:primary' format '%B%F{blue}❯%f%b'
SEP=`echo -e "\xE2\xAE\x80"`
set -x FONT_COL '233'
set -x BACKGROUND_COL '111'

# PROMPT="%(?.%F{green}.%F{red})%(?!$ !$ )%f"
# PROMPT="%(?.%F{green}.%F{red})%(?!❯❯❯ !❯❯❯ )%f"

# PROMPT="%{%F{$FONT_COL}%K{$BACKGROUND_COL}%}%T%{%k%f%}%{%F{$BACKGROUND_COL}%K{230}%}$SEP%{%f%k%}%{%F{$FONT_COL}%K{230}%}[%M]%{%f%k%}%{%F{230}%K{$BACKGROUND_COL}%}$SEP%{%k%f%}%{%K{$BACKGROUND_COL}%F{$FONT_COL}%}%~%{%f%k%}%F{$BACKGROUND_COL}$SEP%f
# %(?.%F{green}.%F{red})%(?!OK !NG )%f%F{155}$%f "

# ctrl-sとctrl-qの無効化
setopt no_flow_control


# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # gitで管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全てcommitされてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # gitに管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git addされていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commitされていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合は青色で表示させる
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側(RPROMPT)にメソッドの結果を表示させる
set -x RPROMPT '`rprompt-git-current-branch`'

function _command_exists()
{
    which $1 &> /dev/null
}


typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='20'


#neovimのためのpath
set -x XDG_CONFIG_HOME "~/.config"


set -x CLICOLOR 1
set -x LSCOLORS DxGxcxdxCxegedabagacad



# git checkout branchをfzfで選択
alias co='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

alias :q='exit'
alias gd='git diff'
alias ga='git add'
alias gp='git pull'
alias gc='git commit'
alias gis='git status'
alias ...='cd ../../'
alias ref='source ~/.zshrc'

# alias gcl='gcloud compute ssh --zone us-west1-b pytorch-study-vm'
alias gcl='gcloud beta compute ssh --zone "us-west1-b" "global-wheat-detection-vm" --project "euphoric-diode-279610" -- -L 8080:localhost:8080 -L 8081:localhost:8081'
# alias cd='pushd'
# alias cdd='popd'
alias df='df -h'
alias vi='vim'
alias diff='colordiff'
alias his='history | fzf | awk -F ";" "{system($2)}"'
alias del_swap='rm ~/.local/share/nvim/swap/*'
_command_exists rmtrash || alias rm='rm -i'
! _command_exists rmtrash || alias rm='rmtrash' #実際はmv2trash(renameしてる)
! _command_exists nvim || alias vim='nvim'
! _command_exists gcc-10 || alias gcc='/usr/local/bin/gcc-10'
! _command_exists g++-10 || alias g++='/usr/local/bin/g++-10'
# ! _command_exists gcloud || alias gcl='gcloud compute ssh --zone us-west1-b "pytorch-study-vm" -- -L 8888:localhost:8888'
# ! _command_exists gcloud || alias gcli='gcloud compute ssh --zone us-central1-a "instance-2" -- -L 8888:localhost:8888'
! _command_exists tmux || alias ta='tmux a -d'
if [ $(command -v exa) ]; then
    alias ls='exa -a --git'
    alias tree='exa --tree'
else
    alias ls='ls -at'
fi
alias -g G='| grep'

alias grep='grep --color'
if [ -e "/Applications/CotEditor.app" ]; then
  alias cot='open -a /Applications/'\''CotEditor.app'\'''
fi
#alias history='history -f'
alias history='cat ~/.zhistory'
# cd, pwd などは history に登録しない
set -x HISTORY_IGNORE "(cd|pwd|ls)"
zshaddhistory() {
    emulate -L zsh
    [[ ${1%%$'\n'} != ${~HISTORY_IGNORE} ]]
}


function mk (){ mkdir $@ && cd $_  }
function pb (){ cat $@ | pbcopy }

kaggle_python(){
  docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it kaggle/python python "$@"
}
kaggle_jupyter() {
  docker run -v $PWD:/tmp/working -w=/tmp/working -p 8988:8888 --rm -it kaggle/python jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/working --allow-root
}

set -x LESSOPEN "| /usr/local/Cellar/source-highlight/3.1.9_2/bin/src-hilite-lesspipe.sh %s"
set -x LESS '-R'

#—————————————————————————————————————————

# 補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin /usr/local/git/bin

# fzf-cdr
alias cdd='fzf-cdr'
function fzf-cdr() {
    target_dir=`cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf`
    target_dir=`echo ${target_dir/\~/$HOME}`
    if [ -n "$target_dir" ]; then
        cd $target_dir
    fi
}

## z の設定
. `brew --prefix`/etc/profile.d/z.sh
    function precmd () {
    # z の設定
    _z --add "$(pwd -P)"

    # https://qiita.com/arks22/items/db8eb6a14223ce29219a
    if [ ! -z $TMUX ]; then
      tmux refresh-client -S
    fi
}

# cdrを有効にする
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# cdr の設定
if [ ! -e  "$HOME/.cache/shell/chpwd-recent-dirs" ]; then
  mkdir -p $HOME/.cache/shell/
  touch $HOME/.cache/shell/chpwd-recent-dirs
fi
zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

#カレントディレクトリが変更した時にする行動
#function chpwd() { ls_abbrev }
#ls_abbrev() {
#    if [[ ! -r $PWD ]]; then
#        return
#    fi
#    # -a : Do not ignore entries starting with ..
#    # -C : Force multi-column output.
#    # -F : Append indicator (one of */=>@|) to entries.
#    local cmd_ls='ls'
#    local -a opt_ls
#    opt_ls=('-aCF' '--color=always')
#    case "${OSTYPE}" in
#        freebsd*|darwin*)
#            if type gls > /dev/null 2>&1; then
#                cmd_ls='gls'
#            else
#                # -G : Enable colorized output.
#                opt_ls=('-aCFG')
#            fi
#            ;;
#    esac
#
#    local ls_result
#    ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')
#
#    local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
#
#    if [ $ls_lines -gt 10 ]; then
#        echo "$ls_result" | head -n 5
#        echo '...'
#        echo "$ls_result" | tail -n 5
#        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
#    else
#        echo "$ls_result"
#    fi
#}

#補完結果に色を付ける
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 履歴ファイルの保存先
set -x HISTFILE=${HOME}/.zhistory
# メモリに保存される履歴の件数
set -x HISTSIZE=100000
# 履歴ファイルに保存される履歴の件数
set -x SAVEHIST=1000000
# lsとhistoryのコマンドをhistoryから除外
set -x HISTIGNORE=ls:history
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt extended_history
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
#補完候補が複数ある時に、一覧表示
setopt auto_list
#補完候補が複数ある時に自動的に一覧表示する
setopt auto_menu
#ディレクトリ名だけでcd
setopt auto_cd
# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
#補完候補を詰めて表示
setopt list_packed
#ビープ音を鳴らさない設定
setopt nolistbeep
#バックグラウンドジョブが終了したら知らせる
setopt no_tify
# m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#移動したdirectoryを記憶
setopt auto_pushd
# ディレクトリスタックから重複を削除
setopt pushd_ignore_dups

# ctrl+矢印で単語単位の移動
bindkey "5C" forward-word
bindkey "5D" backward-word

# fzf の設定
function fzf-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | fzf)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history


function fzf-find-file() {
    if git rev-parse 2> /dev/null; then
        source_files=$(git ls-files)
    else
        source_files=$(find . -type f)
    fi
    selected_files=$(echo $source_files | fzf -m)

    BUFFER="${BUFFER}$(echo $selected_files | tr '\n' ' ')"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N fzf-find-file
bindkey '^q' fzf-find-file


# git diff のあるファイルを選ぶ
function fzf-git-editdiff {
  local dir=$(git diff --name-only | fzf)
  if [ ${#dir} -ne 0 ]; then
    BUFFER="vim ${dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N fzf-git-editdiff
bindkey '^e' fzf-git-editdiff


# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fzfでリポジトリ以下のファイルの中身を検索してvimで開く
fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}

gcd () {
    if [ -n "$1" ]; then
        dir="$(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]; then
            echo "no directroies found for '$1'"
            return 1
        fi
        cd "$dir"
        return
    fi
    echo 'usage: ghq-cd $repo'
    return 1
}

# ghq で管理されている リポジトリに fzf でジャンプ
fzf-src () {
local repo=$(ghq list | fzf)
    if [ -n "$repo" ]; then
        BUFFER="cd $(ghq root)/${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

# ctrl-zでbackground行ったり来たり出来る
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


# agの結果をfzfで絞り込み選択するとvimで開く
alias agg="_agAndVim"
function _agAndVim() {
    if [ -z "$1" ]; then
        echo 'Usage: agg PATTERN'
        return 0
    fi
    result=`ag $1 | fzf`
    line=`echo "$result" | awk -F ':' '{print $2}'`
    file=`echo "$result" | awk -F ':' '{print $1}'`
    if [ -n "$file" ]; then
        vim $file +$line
    fi
}


#manに色を付ける
set -x MANPAGER 'less -R'
man() {
	env \
			LESS_TERMCAP_mb=$(printf "\e[1;31m") \
			LESS_TERMCAP_md=$(printf "\e[1;31m") \
			LESS_TERMCAP_me=$(printf "\e[0m") \
			LESS_TERMCAP_se=$(printf "\e[0m") \
			LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
			LESS_TERMCAP_ue=$(printf "\e[0m") \
			LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}



# zplugの設定
source ~/.zplug/init.zsh

# 構文のハイライト defer:2にすることでcompinitの後に読み込まれる
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# タイプ補完
# 履歴から候補が出てくる，→，ctrl-f,ctrl-eで補完できる.
zplug "zsh-users/zsh-autosuggestions"
#補完の強化
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "ascii-soup/zsh-url-highlighter"
# mapとかeachのコマンド追加 https://github.com/Tarrasch/zsh-functional
zplug "Tarrasch/zsh-functional"


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# set -x FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --preview "head -100 {}"'


if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
[ -z "$ZSH_NAME" ] && [ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
zmodload zsh/zprof #&& zprof

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/masakatsu.hamashita/gcp/google-cloud-sdk/completion.zsh.inc'; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
set -x __conda_setup "$('/Users/masakatsu.hamashita/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/masakatsu.hamashita/opt/anaconda3/etc/profile.d/conda.sh"
    else
        set -x PATH "/Users/masakatsu.hamashita/opt/anaconda3/bin $PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
set -x SDKMAN_DIR "/Users/masakatsu.hamashita/.sdkman"
[[ -s "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh"
set -x PATH "/usr/local/opt/llvm/bin $PATH"

# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
