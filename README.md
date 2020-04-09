# my dotfiles
## tmux
- tpm install  
`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
## nvim
- neovim install  
`$ brew install neovim` 
`$ pip install neovim`  
- init.vimに次を入力  
`let g:python3_host_prog = system('(type pyenv &>/dev/null && echo -n $(pyenv root)/versions/${ここにバージョンを入力}/bin/python) || echo -n $(which python3)')`  
- dein install  
`$ mkdir -p ~/.cache/dein`  
`$ cd ~/.cache/dein`  
`$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh`  
`$ sh ./installer.sh ~/.cache/dein`  
- node install  
`$ brew install node brew`
`$ mkdir -p ~/.nodebrew/src`
`$ nodebrew install-binary stable`
- black install
`$ pip install black`
## zsh
- brew install zsh
- zplug install  
    $ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
- font install  
  - https://gist.github.com/qrush/1595572

## mac
- chsh -s /bin/zsh
