" defx.nvim
if !exists('g:vscode')
    nnoremap <space>f :Defx<CR>
    augroup defxSettings
      autocmd!
      autocmd FileType defx call s:defx_my_settings()
      " 起動時に Defx 起動
      " autocmd VimEnter * execute 'Defx'
      " nnoremap <silent> <Leader>f :<C-u> Defx <CR>
    augroup END

    function! s:defx_my_settings() abort
      nnoremap <silent><buffer><expr> <CR>
      \ defx#do_action('drop')
      nnoremap <silent><buffer><expr> c
      \ defx#do_action('copy')
      nnoremap <silent><buffer><expr> m
      \ defx#do_action('move')
      nnoremap <silent><buffer><expr> p
      \ defx#do_action('paste')
      nnoremap <silent><buffer><expr> l
      \ defx#do_action('drop')
      nnoremap <silent><buffer><expr> t
      \ defx#do_action('open','tabnew')
      nnoremap <silent><buffer><expr> E
      \ defx#do_action('drop', 'vsplit')
      nnoremap <silent><buffer><expr> P
      \ defx#do_action('drop', 'pedit')
      nnoremap <silent><buffer><expr> o
      \ defx#do_action('open_or_close_tree')
      nnoremap <silent><buffer><expr> K
      \ defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N
      \ defx#do_action('new_file')
      nnoremap <silent><buffer><expr> M
      \ defx#do_action('new_multiple_files')
      nnoremap <silent><buffer><expr> C
      \ defx#do_action('toggle_columns',
      \                'mark:indent:icon:filename:type:size:time')
      nnoremap <silent><buffer><expr> S
      \ defx#do_action('toggle_sort', 'time')
      nnoremap <silent><buffer><expr> d
      \ defx#do_action('remove')
      nnoremap <silent><buffer><expr> r
      \ defx#do_action('rename')
      nnoremap <silent><buffer><expr> !
      \ defx#do_action('execute_command')
      nnoremap <silent><buffer><expr> x
      \ defx#do_action('execute_system')
      nnoremap <silent><buffer><expr> yy
      \ defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> .
      \ defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> ;
      \ defx#do_action('repeat')
      nnoremap <silent><buffer><expr> h
      \ defx#do_action('cd', ['..'])
      nnoremap <silent><buffer><expr> ~
      \ defx#do_action('cd')
      nnoremap <silent><buffer><expr> q
      \ defx#do_action('quit')
      nnoremap <silent><buffer><expr> <Space>
      \ defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> *
      \ defx#do_action('toggle_select_all')
      nnoremap <silent><buffer><expr> j
      \ line('.') == line('$') ? 'gg' : 'j'
      nnoremap <silent><buffer><expr> k
      \ line('.') == 1 ? 'G' : 'k'
      nnoremap <silent><buffer><expr> <C-l>
      \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> <C-g>
      \ defx#do_action('print')
      nnoremap <silent><buffer><expr> cd
      \ defx#do_action('change_vim_cwd')
    endfunction

    call defx#custom#option('_', {
          \ 'winwidth': 30,
          \ 'split': 'vertical',
          \ 'direction': 'topleft',
          \ 'show_ignored_files': 1,
          \ 'buffer_name': 'explorer',
          \ 'toggle': 1,
          \ 'resume': 1,
          \ 'columns': 'mark:indent:icons:filename',
          \ 'post_action': 'jump',
          \ })

    call defx#custom#column('mark', {
          \ 'readonly_icon': '✗',
          \ 'selected_icon': '✓',
          \ })

    " gelguy/wilder.nvim
    " Key bindings can be changed, see below
    autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()
    function! s:wilder_init() abort
      call wilder#setup({
            \ 'modes': [':', '/', '?'],
            \ 'next_key': '<C-n>',
            \ 'previous_key': '<C-p>',
            \ })
      call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline({
            \       'fuzzy': 1,
            \     }),
            \     wilder#python_search_pipeline({
            \       'pattern': 'fuzzy',
            \     }),
            \   ),
            \ ])
      call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
            \ 'highlights': {
            \    'border': 'Normal',
            \ },
            \ 'highlighter': wilder#basic_highlighter(),
            \ 'min_width': '10%',
            \ 'max_width': '20%',
            \ 'max_height': '15%',
            \ 'reverse': 0,
            \ 'left': [
            \   ' ', wilder#popupmenu_devicons(),
            \ ],
            \ 'right': [
            \   ' ', wilder#popupmenu_scrollbar(),
            \ ],
            \ 'border': 'rounded',
            \ })))
    endfunction
endif


" rnvimr plugin
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
let g:rnvimr_enable_picker = 1

let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.9 * &columns)),
            \ 'height': float2nr(round(0.9 * &lines)),
            \ 'col': float2nr(round(0.05 * &columns)),
            \ 'row': float2nr(round(0.05 * &lines)),
            \ 'style': 'minimal'
            \ }
