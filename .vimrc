set ambiwidth=double

syntax on
filetype plugin indent on
filetype indent on
set number

set smartindent
set tabstop=4
set shiftwidth=4
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /��/
set backspace=indent,eol,start
"---------------------------
"" Start Neobundle Settings.
"---------------------------
"" bundleã§ç®¡ç†ã™ã‚‹ãƒ‡ã‚£ãƒ¬ã‚¯ãƒˆãƒªã‚’æŒ‡å®š
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

noremap <C-e> <Esc>$a
noremap <C-a> <Esc>^a

inoremap <C-e> <Esc>$a
inoremap <C-a> <Esc>^a
" neobundleè‡ªä½“ã‚’neobundleã§ç®¡ç†
NeoBundleFetch 'Shougo/neobundle.vim'

"ã“ã“ã«è¿½åŠ ã®ãƒ—ãƒ©ã‚°ã‚¤ãƒ³ã‚’æ›¸ã

" neocompleteã‚’è¨­å®š
NeoBundle 'Shougo/neocomplete.vim'

" NERDTreeã‚’è¨­å®š
"NeoBundle 'scrooloose/nerdtree'

" autocloseã‚’è¨­å®š
NeoBundle 'Townk/vim-autoclose'

" neco-lookã‚’è¨­å®š
NeoBundle 'ujihisa/neco-look'


" neocompleteã®è¨­å®šå§‹ã¾ã‚Š

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"neocompleteã®è¨­å®šçµ‚ã‚ã‚Š





"Neco-lookã®è¨­å®š
  if !exists('g:neocomplete#text_mode_filetypes')
	      let g:neocomplete#text_mode_filetypes = {}
  endif
  let g:neocomplete#text_mode_filetypes = {
			    \ 'rst': 1,
			    \ 'markdown': 1,
			    \ 'gitrebase': 1,
			    \ 'gitcommit': 1,
			    \ 'vcs-commit': 1,
			    \ 'hybrid': 1,
			    \ 'text': 1,
			    \ 'help': 1,
			    \ 'tex': 1,
			    \ }
"Neco-lookã®è¨­å®šçµ‚ã‚ã‚Š







call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck

"---------------------------
" End Neobundle Settings.
"---------------------------



