# fish_user_paths を config.fish で設定するな - https://qiita.com/HelloRusk/items/ea0089bf80b07aa74d8d

# カーソルをプロンプトの次の行にする
set -g theme_newline_cursor yes
set -g theme_newline_prompt (set_color green; echo ' $ ')
set -g fish_prompt_pwd_dir_length 0

# git checkout branchをfzfで選択
alias co 'git checkout (git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

alias :q 'exit'
alias gd 'git diff'
alias ga 'git add'
alias gp 'git pull'
alias gc 'git commit -m'
alias gs 'git status'
alias ... 'cd ../../'
alias ref 'source ~/.config/fish/config.fish'

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

# alias grep 'grep --color'
if [ -e "/Applications/CotEditor.app" ]
  alias cot 'open -a /Applications/'\''CotEditor.app'\'''
end
# alias history='history -f'
# alias history 'cat ~/.zhistory'

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

# set -x LESSOPEN "| /usr/local/Cellar/source-highlight/3.1.9_2/bin/src-hilite-lesspipe.sh %s"
# set -x LESS '-R'

#—————————————————————————————————————————

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
			man "$argv[1]"
end



# # The next line updates PATH for the Google Cloud SDK.
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
