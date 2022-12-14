set encoding=utf-8
scriptencoding utf-8

" 各ファイルを読み込む
runtime init/pre_load.vim
runtime init/common_settings.vim
runtime init/common_mappings.vim
runtime init/plugin_install.vim
runtime init/plugin_settings.vim
runtime init/abbr.vim
runtime init/coc.vim
runtime init/filer.vim
runtime init/lsp.lua
runtime init/lsp_lines.lua

if !exists('g:vscode')
  colorscheme tokyonight
endif

highlight DiffChange ctermbg=23
highlight DiffAdd ctermbg=64
