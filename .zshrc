HOMEBREW_CASK_OPTS="--appdir=/Applications"
export WORKON_HOME=$HOME/.virtualenvs
LANG=ja_JP.UTF-8
LC_CTYPE=ja_JP.UTF-8


# プロンプトを表示する際に最初に変数展開する
setopt prompt_subst
#色を付ける
autoload -Uz add-zsh-hook
autoload -U colors && colors

#https://gist.github.com/qrush/1595572でフォントをダウンロード
zstyle ':prezto:module:editor:info:keymap:primary' format '%B%F{blue}❯%f%b'
SEP=`echo -e "\xE2\xAE\x80"`
FONT_COL='233'
BACKGROUND_COL='111'
PROMPT="%{%F{$FONT_COL}%K{$BACKGROUND_COL}%}%T%{%k%f%}%{%F{$BACKGROUND_COL}%K{230}%}$SEP%{%f%k%}%{%F{$FONT_COL}%K{230}%}[%M]%{%f%k%}%{%F{230}%K{$BACKGROUND_COL}%}$SEP%{%k%f%}%{%K{$BACKGROUND_COL}%F{$FONT_COL}%}%~%{%f%k%}%F{$BACKGROUND_COL}$SEP%f
%(?.%F{green}.%F{red})%(?! OK ! NG )%f %F{155}$%f "

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
RPROMPT='`rprompt-git-current-branch`'

function _command_exists()
{
    which $1 &> /dev/null
}



#neovimのためのpath
export XDG_CONFIG_HOME="~/.config"


# export PATH=$PATH:/Users/mpeg/.nodebrew/current/bin
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/sbin:/usr/bin:$PATH
export PATH="$HOME/Library/Python/3.6/bin:$PATH"
export PATH=$PATH:/usr/local/lib/mecab/dic/ipadic
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


alias ls='ls -at'
alias df='df -h'
alias vi='vim'
_command_exists rmtrash || alias rm='rm -i'
! _command_exists rmtrash || alias rm='rmtrash' #実際はmv2trash(renameしてる)
! _command_exists nvim || alias vim='nvim'
! _command_exists gcc-9 || alias gcc='/usr/local/bin/gcc-9'
! _command_exists g++-9 || alias g++='/usr/local/bin/g++-9'
alias -g G='| grep'
alias grep='grep --color'
if [ -e "/Applications/CotEditor.app" ]; then
  alias cot='open -a /Applications/'\''CotEditor.app'\'''
fi
#alias history='history -f'
alias history='cat ~/.zhistory'
function mk (){ mkdir $@ && cd $_  }
function pb (){ cat $@ | pbcopy }


export LESSOPEN="| /usr/local/Cellar/source-highlight/3.1.8_9/bin/src-hilite-lesspipe.sh %s"
export LESS='-R'

#—————————————————————————————————————————

#補完
# autoload -U compinit
# compinit
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin /usr/local/git/bin


# cdrを有効にする
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# cdr の設定
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
export HISTFILE=${HOME}/.zhistory
# メモリに保存される履歴の件数
export HISTSIZE=100000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=1000000
# lsとhistoryのコマンドをhistoryから除外
export HISTIGNORE=ls:history
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
#コマンド自動修正
#setopt correct
#バックグラウンドジョブが終了したら知らせる
setopt no_tify
# m:{a-z}={A-Z}: 小文字を大文字に変えたものでも補完する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#移動したdirectoryを記憶
setopt auto_pushd
# ディレクトリスタックから重複を削除
setopt pushd_ignore_dups
#pecoの設定
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


function peco-find-file() {
    if git rev-parse 2> /dev/null; then
        source_files=$(git ls-files)
    else
        source_files=$(find . -type f)
    fi
    selected_files=$(echo $source_files | peco --prompt "[find file]")

    BUFFER="${BUFFER}${echo $selected_files | tr '\n' ' '}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-find-file
bindkey '^q' peco-find-file



#manに色を付ける

export MANPAGER='less -R'
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


export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview "head -100 {}"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/llvm/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
# export PATH="/Users/mpeg/cquery/build/release/bin:$PATH"
export CFLAGS="-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk -mmacosx-version-min=10.14"
zmodload zsh/zprof #&& zprof
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi


