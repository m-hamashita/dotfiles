set encoding=utf-8
scriptencoding utf-8

" 各ファイルを読み込む
runtime init/common_settings.vim
runtime init/common_mappings.vim
runtime init/dein_install.vim
runtime init/dein_settings.vim
runtime init/abbr.vim

" colorscheme wombat256mod
" colorscheme everforest
" colorscheme miramare
" colorscheme zenburn
if !exists('g:vscode')
  colorscheme tokyonight
endif

highlight DiffChange ctermbg=23
highlight DiffAdd ctermbg=64
