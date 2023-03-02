# my dotfiles

## introduction

```
sh install.sh
sh symlink.sh
```

## tmux

- tpm install

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## nvim

- neovim install

```
brew install neovim
pip install neovim
```

- node install

```
brew install nodebrew
mkdir -p ~/.nodebrew/src
nodebrew install-binary stable
```

- other

```
brew install tree-sitter
```

- plugin can be refresh `:call dein#update()` or `:call dein#recache_runtimepath()`.

## zsh

```
brew install zsh
```

- zplug install

```
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

- font install
  - https://gist.github.com/qrush/1595572

## fish

```
brew install fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

- completion for fish
  - ex. `poetry completions fish > ~/.config/fish/completions/poetry.fish`

## jupyter notebook

- https://github.com/lambdalisue/jupyter-vim-binding
- https://github.com/dunovank/jupyter-themes

- jupyter-vim-binding

```
# Create required directory in case (optional)
mkdir -p $(jupyter --data-dir)/nbextensions

# Clone the repository
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding

# Activate the extension
jupyter nbextension enable vim_binding/vim_binding
```

- jupyter-themes

```
pip install jupyterthemes
jt -t gruvboxd -vim -T -N -f meslo -nf latosans -nfs 10 -tfs 10
```

- write to ~/.jupyter/custom/custom.js

```
// Configure CodeMirror Keymap
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jj to <Esc>
  CodeMirror.Vim.map("jj", "<Esc>", "insert");
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");
});
```

## mac

```
chsh -s /usr/local/bin/fish
```
