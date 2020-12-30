" dein scripts-----------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " vim-gitgutter gitのHEADからのコード追加，削除，変更を左端に表示
  call dein#add('airblade/vim-gitgutter')

  " 括弧に色を付けるやつ
  call dein#add('luochen1990/rainbow')

  " ALE linter実行プラグイン　静的解析
  call dein#add('dense-analysis/ale')

  "sessionが保存されるらしい
  call dein#add('tpope/vim-obsession')

  "swiftのハイライト
  if has('mac')
    call dein#add('keith/swift.vim')
    call dein#add('landaire/deoplete-swift')
  endif

  call dein#load_toml('~/.config/nvim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/rc/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"End dein scripts -----------------------------------------------
