if !exists('g:vscode')
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
