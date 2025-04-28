set encoding=utf-8
scriptencoding utf-8

" for nvim-notify(for colorscheme)
set termguicolors

lua if vim.loader then vim.loader.enable() end

" 各ファイルを読み込む
runtime init/pre_load.vim
runtime init/common_settings.vim
runtime init/common_mappings.vim
runtime init/common_settings.lua
runtime lua/config/lazy.lua
runtime init/plugin_settings.vim
runtime init/abbr.vim
runtime init/tmp.vim

if !exists('g:vscode')
  colorscheme gruvbox-material
endif

highlight DiffChange ctermbg=23
highlight DiffAdd ctermbg=64
