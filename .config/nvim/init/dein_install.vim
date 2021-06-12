scriptencoding utf-8

if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " syntax highlight for swift
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
