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
