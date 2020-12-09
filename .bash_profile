# export PS1="\W $ "
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PATH=/usr/local/bin:$PATH
# if [ -f ~/.bashrc ]; then
# 	. ~/.bashrc
# fi

# alias gcp_quora='gcloud compute --project "quora-kaggle-225317" ssh --zone "us-central1-c" "instance-1"'
# alias gci='gcloud compute instances'
# alias ctags='`brew --prefix`/bin/ctags'


export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PYENV_ROOT/bin:$PATH
export PATH="$HOME/.pyenv/shims:$PATH"
export PYTHONSTARTUP=~/.pythonstartup



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/masakatsu.hamashita/.sdkman"
[[ -s "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/masakatsu.hamashita/.sdkman/bin/sdkman-init.sh"
source "$HOME/.cargo/env"
