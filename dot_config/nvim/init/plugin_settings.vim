scriptencoding utf-8

filetype off
filetype plugin indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dein.vimでのプラグイン削除, :call
" dein#recache_runtimepath()を実行すると良いらしい
" call map(dein#check_clean(), "delete(v:val, 'rf')")

set nofoldenable

" Copilot
let g:copilot_filetypes = {
      \ '*': 1,
      \ 'markdown': 1,
      \ 'yaml': 1,
      \ }

" back to definition: <C-o> - jump to original window on list create.
nmap <silent> gp <C-o>


" tint.nvim
" lua <<EOF
"   require("tint").setup()
" EOF

" translate.vim
let g:translate_source = 'en'
let g:translate_target = 'ja'
let g:translate_popup_window = 1 " if you want use popup window, set value 1
let g:translate_winsize = 5 " set buffer window height size if you doesn't use popup window

nmap <space>t <Plug>(Translate)
vmap <space>t <Plug>(VTranslate)

let $BAT_THEME                     = 'gruvbox-dark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox-dark'


" git-fugitive
function! s:GstatusToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitive'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git
  endif
endfunction

nmap <space>gs :call <SID>GstatusToggle()<CR>

function! s:BlameToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitiveblame'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git blame
  endif
endfunction

nmap <silent> <space>gb :call <SID>BlameToggle()<CR>

command! FzReadme call fzf#run(fzf#wrap(#{
          \ source: values(map(copy(dein#get()), {k,v-> k.' '.get(split(globpath(get(v,'dir',''), '\creadme.*'), '\n'), 0, '')})),
          \ options: ['--with-nth=1', '--preview', 'bat --color=always --plain {2}'],
          \ sink: funcref('s:DeinReadmeFzf')}))
function s:DeinReadmeFzf(name_and_path) abort
  execute 'DeinReadme' substitute(a:name_and_path, ' .*', '', '')
endfunction

" for copilot.vim
let g:copilot_node_command = "~/.nvm/versions/node/v17.9.1/bin/node"
