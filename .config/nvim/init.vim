set encoding=utf-8
scriptencoding utf-8

" for nvim-notify(for colorscheme)
set termguicolors

" 各ファイルを読み込む
runtime init/pre_load.vim
runtime init/common_settings.vim
runtime init/common_mappings.vim
runtime lua/config/lazy.lua
runtime init/plugin_settings.vim
runtime init/abbr.vim

if !exists('g:vscode')
  colorscheme melange
endif

highlight DiffChange ctermbg=23
highlight DiffAdd ctermbg=64
