# git checkout branchをfzfで選択
function co
  git checkout (git branch -a | tr -d " " | fzf --height 70% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")
  echo ""
  commandline -f repaint
end

function cop
 git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g" | read -l repository_path
 if [ $repository_path ]
    echo "git push origin $repository_path"
    git push origin $repository_path
 end
 echo ""
 commandline -f repaint
end

function jira --argument-names 'ID'
    if test -n "$ID"
        open "https://$ORGANIZATION.atlassian.net/browse/$ID"
    else
        set ID (git rev-parse --abbrev-ref HEAD | sed "s|^mob/||")
        open "https://$ORGANIZATION.atlassian.net/browse/$ID"
    end
end

function push
    git rev-parse --abbrev-ref HEAD | read -l branch_name
    echo "git push origin $branch_name"
    git push origin $branch_name
end

function fpush
    git rev-parse --abbrev-ref HEAD | read -l branch_name
    echo "git push -f origin $branch_name"
    git push -f origin $branch_name
end

function pull
    git rev-parse --abbrev-ref HEAD | read -l branch_name
    echo "git pull origin $branch_name"
    git pull origin $branch_name
end

function commitans
    set problem (pwd | rev | cut -d '/' -f 1,2 | rev | sed -e 's/\// /')
    echo git commit -m \"$problem\"
    git commit -m "$problem"
end

alias :q 'exit'
alias digdag '/bin/bash /usr/local/bin/digdag'
alias bazel 'bazelisk'
# alias notify 'osascript -e \'display notification "command has completed successfully." with title "Command finished"\''

# abbr
abbr -a gg 'open https://github.(git config remote.origin.url | cut -f2 -d. | tr ':' /)'
abbr -a devcon 'docker exec -it -u vscode -w "/workspaces/$(basename $(pwd))" $(devcontainer up --workspace-folder . | jq -r .containerId)'
abbr -a grr 'echo "git reset --hard origin/"(git rev-parse --abbrev-ref HEAD) && git reset --hard origin/(git rev-parse --abbrev-ref HEAD)'
abbr -a gg 'open https://github.(git config remote.origin.url | cut -f2 -d. | tr ':' /)'
abbr -a root 'cd (git rev-parse --show-toplevel)'
abbr -a df "df -h"
abbr -a vi vim
abbr -a del_swap "rm ~/.local/state/nvim/swap/*"
abbr -a ref source ~/.config/fish/config.fish
abbr -a dc docker-compose
abbr -a dokcer docker
abbr -a do cd ~/dotfiles/
abbr -a k kubectl
abbr -a kg kubectl get pod
abbr -a kd "kubectl get pod | fzf | cut -d ' ' -f 1 | xargs kubectl describe pod"
abbr -a kl "kubectl get pod | fzf | cut -d ' ' -f 1 | xargs kubectl logs"
abbr -a fd fd -H
abbr -a g "gctx activate (gctx list | sed 's/^\*//' | string trim | fzf)"
abbr -a ga git add
abbr -a gb git switch -c
abbr -a gbd git branch -D
abbr -a gc git commit -m
abbr -a gca git commit --amend
abbr -a gcf git commit --fixup
abbr -a gf git fetch
abbr -a gs git status
abbr -a gd git diff
abbr -a gp git pull
abbr -a gsh 'git stash; git pull --rebase; git stash pop'
abbr -a gr git rebase
abbr -a gra git rebase -i --autosquash HEAD~8
abbr -a grh git reset --hard
abbr -a grhh git reset --hard HEAD
abbr -a grs git restore --staged .
abbr -a rmbranch 'git branch --merged | grep -v master | grep -v production | grep -v "*" | xargs -I % git branch -d % && git remote prune origin'
abbr -a todo 'rg "TODO:|FIXME:"'
abbr -a awsdoc "aws ecr get-login-password | docker login --username AWS --password-stdin (aws sts get-caller-identity | jq -cr '.Account').dkr.ecr.ap-northeast-1.amazonaws.com"
abbr -a on tmux kill-pane -a -t
abbr -a ... '../../'
abbr -a .... '../../../'
abbr -a air 'remo aircon send --name エアコン'
abbr -a bl 'remo signal send AV機器 bluetooth'
abbr -a light 'remo signal send light_for_signal'
abbr -a temp 'sudo powermetrics --samplers smc | grep "CPU die temperature"'
abbr -a hg 'history | grep'
abbr -a history "history --show-time='%Y/%m/%d %H:%M:%S '"
abbr -a cr cargo run
abbr -a cb cargo build
abbr -a a awsctx
abbr -a mvuntrack backup_untracked
abbr -a docf "docker run -it --rm (docker image ls | sed -e '1d' | fzf --height 40% --reverse | awk '{print \$3}') bash"
abbr -a image "docker image ls | sed -e '1d' | fzf --height 40% --reverse | awk '{print \$3}'"
abbr -a jupyterssh "jupyter notebook --no-browser --ip="0.0.0.0" --allow-root"
abbr -a work "cd ~/work/"
abbr -a tmp "cd ~/tmp/"
abbr -a hobby "cd ~/work/hobby/"
abbr -a vs "tmux split-window -h"
abbr -a sp "tmux split-window -v"
abbr -a caf "chezmoi add --follow"
abbr -a kubectx "kubectl ctx"
abbr -a kubens "kubectl ns"
abbr -a c "chezmoi"
abbr -a ccd "chezmoi cd"

# abbr -a del "git branch --merged | grep -vE '^\\*|master|develop|staging' | xargs -I % git branch -d % && git remote prune origin"

if [ (command -v bat) ]
    abbr -a cat bat
    abbr -a less bat
end

if [ (command -v colordiff) ]
    abbr -a diff colordiff
end


if [ (command -v gomi) ]
    alias rm 'gomi'
else
    if [ (command -v trash) ]
        alias rm 'trash -r'
    else
        alias rm 'rm -i'
    end
end

if [ (command -v nvim) ]
    alias vim 'nvim'
else
    # echo "neovim is not installed"
end

if [ (command -v gcc-13) ]
    alias gcc '/opt/homebrew/bin/gcc-13'
end
if [ (command -v g++-13) ]
    alias g++ '/opt/homebrew/bin/g++-13 --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX14.2.sdk'
end
if [ (command -v tmux) ]
    abbr -a ta 'tmux a -d'
    abbr -a tn tmux new-session -s
else
    # echo "tmux is not installed"
end


if [ (command -v lsd) ]
    alias ls 'lsd -At'
    alias lsr 'lsd -AR'
    alias tree 'lsd --tree'
else
    # echo "lsd is not installed"
    if [ (command -v exa) ]
        alias ls 'exa -a --git'
        alias tree 'exa --tree'
    else
        alias ls 'ls -at --color=auto'
        # echo "exa is not installed"
    end
end

if [ -e "/Applications/CotEditor.app" ]
  alias cot 'open -a /Applications/'\''CotEditor.app'\'''
else
    # echo "CotEditer is not installed"
end

function ci
  set url (git config --get remote.origin.url)
  if test (echo $url | grep -c "https")
    set repo (echo $url | awk -F/ '{print $4"/"$5}')
  else
    set repo (echo $url | cut -f2 -d: | cut -f1 -d.)
  end
  open https://app.circleci.com/pipelines/github/(echo $repo)
end

function gvm
  bass source ~/.gvm/scripts/gvm ';' gvm $argv
end

function vr
  vim (rg -l $argv)
end

function vf
  vim (fd -H $argv)
end

function mk
  mkdir $argv && cd $_
end
function pb
  cat $argv | pbcopy
end

function swap
    set TMPFILE tmp."%self"
    mv "$argv[1]" $TMPFILE && mv "$argv[2]" "$argv[1]" && mv $TMPFILE "$argv[2]"
end

# diff があるファイルを開く
function vd
  vim (git diff --relative --name-only)
end

function fzf-git-diff-vim
  git diff --relative --name-only | fzf | read file
  if [ $file ]
     vim $file
  end
  echo ""
  commandline -f repaint
end

# fzfでリポジトリ以下のファイル名を検索して vim で開く
function fzf-git-vim
  git ls-files | fzf | read file
  if [ $file ]
     vim $file
  end
  echo ""
  commandline -f repaint
end

function where --argument-names 'cmdname'
  if test -n "$cmdname"
    which $cmdname  | sed -E 's/\/[^\/]+$//' | read -l dir
    if test -n "$dir"
      cd $dir
    else
      echo "$cmdname: command not found"
    end
  end
end

# fzf でリポジトリ以下のディレクトリ名を検索して cd する
function fzf-git-cd
  git ls-files | sed 's:\(.*\)/.*:\1:' | uniq | fzf | read dir
  if [ $dir ]
      cd $dir
  end
  echo ""
  commandline -f repaint
end

function fzf-cd
  fd --type=d -H -I -E .git | uniq | fzf | read dir
  if [ $dir ]
      cd $dir
  end
  echo ""
  commandline -f repaint
end

function docker_jupyter
  docker run -v $PWD:/tmp/workspace -w=/tmp/workspace -p 8988:8888 --rm -it "$argv" jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/workspace --allow-root
end
function docker_run
  docker run -v $PWD:/tmp/workspace -w=/tmp/workspace -p 8988:8888 --rm -it "$argv" bash
end

function kaggle_python
  docker run -v $PWD:/tmp/workspace -w=/tmp/workspace --rm -it kaggle/python python "$argv"
end
function kaggle_jupyter
  docker run -v $PWD:/tmp/workspace -w=/tmp/workspace -p 8988:8888 --rm -it kaggle/python jupyter notebook --no-browser --ip="0.0.0.0" --notebook-dir=/tmp/workspace --allow-root
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

function AZ --argument-names 'node_type'
  if test -n "$node_type"
      kubectl get nodes $(kubectl get pods -o wide | grep $node_type | awk '{print $7}' | uniq) --show-labels | perl -nle 'print $1 if /.*=(.+)/' | sort | uniq -c
  end
end

function nodegroup --argument-names 'nodegroup'
  if test -n "$nodegroup"
    kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.eks\.amazonaws\.com/nodegroup}{"\n"}{end}' | grep $nodegroup | sort -t'\t' -k2
  end
end

function nodepod --argument-names 'nodegroup'
  if test -n "$nodegroup"
    set nodes (kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.eks\.amazonaws\.com/nodegroup}{"\n"}{end}' | grep $nodegroup | sort -t'\t' -k2)
    for node in $nodes
        set node_name (echo $node | awk '{print $1}')
        set node_group (echo $node | awk '{print $2}')
        echo $node_name $node_group
        kubectl get pods --field-selector spec.nodeName=$node_name -o custom-columns=NAME:.metadata.name --no-headers | tr '\n' ' '
        echo -e "\n"
    end
  end
end


# https://github.com/fish-shell/fish-shell/issues/4869#issuecomment-377850086
# cd - を使うための設定 builtin cd の代わりに使用
functions -c cd standard_cd
function cd
    standard_cd $argv
    mkdir -p $HOME/.config/fish/tmp
    set recent_file $HOME/.config/fish/tmp/recent_dir.list
    touch $recent_file
    set current_dir (pwd)
    if not string match -q "$current_dir" < $recent_file
        echo $current_dir >> $recent_file
    end
end

function cdr
    cat $HOME/.config/fish/tmp/recent_dir.list | \
    fzf | read -l d
    if test -n "$d"
        cd $d
    end
    echo ""
    commandline -f repaint
end

function backup_untracked
    for file in (git ls-files --others --exclude-standard); mkdir -p backup/(dirname $file) ; mv $file backup/$file ; end
end


function docker-exec
    set name (docker ps --format "{{.Names}}" | fzf)
    docker exec -it $name $argv
end

function docker-run
    set name (docker image ls | sed -e '1d' | fzf --height 40% --reverse | awk -v 'OFS=:' '{print $1,$2}')
    docker run -v $PWD:/tmp/workspace -w=/tmp/workspace -it --rm $name $argv
end

# command not found の時，cd する (zsh の auto_cd 的な)
function __fish_command_not_found_handler --on-event fish_command_not_found
    cd $argv[1]
end


function amazon --argument-names 'amazon_url'
    if test -n "$amazon_url"
        echo $amazon_url | egrep --only-matching '/dp/[0-9A-Za-z]+/?' | read -l dp
        if test -n "$dp"
            set short_url "https://www.amazon.co.jp$dp"
            echo $short_url
            echo $short_url | pbcopy
        else
            echo "amazon_url: invalid"
        end
    else
        echo "Please Input Amazon URL."
    end
end

function comment
    echo -e (string split -n \\n -- $argv | sed -e 's/^# \s*//' -e 's/\n/ /g' -e 's/\s\+/ /g' -e 's/^\s*//' -e 's/\s*$//')
end


function memp
    ps -axo "rss,comm" |
    awk '
      {
        process = substr($0, index($0,$2));
        if (match(process, "^/Applications/[^/]*\\.app")) {
          split(process, parts, "/");
          process = parts[3];
        }
        memUsage[process] += $1;
        totalMemUsage += $1
      }
      END {
        for (i in memUsage) {
          if(memUsage[i]/1024 > 50) {
            printf("%d MB - %s\n", memUsage[i]/1024, i)
          }
        }
        printf("\nTotal memory usage: %d MB\n", totalMemUsage/1024)
      }
    ' | sort -rn
end
