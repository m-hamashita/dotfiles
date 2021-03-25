

# git checkout branchをfzfで選択
alias co 'git checkout (git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'

function cop
 git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g" | read -l repository_path
 echo "git push origin $repository_path"
 git push origin $repository_path
end

alias :q 'exit'
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
alias root 'cd (git rev-parse --show-toplevel)'

# abbr
abbr gd git diff
abbr ga git add
abbr gp git pull
abbr gc git commit -m
abbr gs git status
abbr -a dc docker-compose
abbr -a awsdoc "aws ecr get-login-password | docker login --username AWS --password-stdin (aws sts get-caller-identity | jq -cr '.Account').dkr.ecr.ap-northeast-1.amazonaws.com"
abbr -a one onelogin-aws-login -d 32400 --config-name ads --username masakatsu.hamashita@gunosy.com --profile default



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

function fzf-git-editdiff
  vim (git diff --name-only | fzf)
end
function fish_user_key_bindings
    bind \ce fzf-git-editdiff
end

function kaggle_python
  docker run -v $PWD:/tmp/working -w=/tmp/working --rm -it kaggle/python python "$argv"
end
function kaggle_jupyter
  docker run -v $PWD:/tmp/working -w=/tmp/working -p 8988:8888 --rm -it kaggle/python jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/working --allow-root
end

function fshow
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
end

# fzfでリポジトリ以下のファイルの中身を検索してvimで開く
function fvim
  vim (git ls-files | fzf -m --preview 'head -100 {}')
end

# https://github.com/fish-shell/fish-shell/issues/4869#issuecomment-377850086
# cd - を使うための設定 builtin cd の代わりに使用
functions -c cd standard_cd
function cd
    standard_cd $argv;
    mkdir -p $HOME/.config/fish/tmp
    touch $HOME/.config/fish/tmp/recent_dir.list
    pwd >> $HOME/.config/fish/tmp/recent_dir.list
    sort -u $HOME/.config/fish/tmp/recent_dir.list -o $HOME/.config/fish/tmp/recent_dir.list
end
function cdr
	tail -500 $HOME/.config/fish/tmp/recent_dir.list | \
	ruby -ne 'BEGIN{$list=[]}; $list << $_; END{puts $list.reverse.uniq}' | \
	fzf | read d
	if [ $d ]
	   cd $d
	end
    commandline -f repaint
end
function fish_user_key_bindings
    bind \c] cdr
end
