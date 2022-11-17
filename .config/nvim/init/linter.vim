" エラー行に表示するマーク
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1

" ファイルを開いたときにlint実行しない
let g:ale_lint_on_enter = 0
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'

" lint結果をロケーションリストとQuickFixには表示しない
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" 有効にするlinter
let g:ale_linters = {
  \   'python': ['flake8', 'mypy'],
  \   'cpp': ['clangd'],
  \   'vim': ['vint'],
  \   'rust': [],
  \   'markdown': ['textlint'],
  \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black', 'isort'],
  \   'cpp': ['clang-format'],
  \   'go': ['goimports'],
  \ }
let g:ale_fix_on_save = 1

" 各ツールの実行オプションを変更してPythonパスを固定
let g:ale_python_flake8_executable = g:pip_command_path . 'flake8'
" let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_flake8_use_global = 1
let g:ale_python_mypy_executable = g:pip_command_path . 'mypy'
" let g:ale_python_mypy_options = '-m mypy'
let g:ale_python_isort_executable = g:pip_command_path . 'isort'
let g:ale_python_isort_options = '--line-length=110 --ensure-newline-before-comments --force-grid-wrap=0 --trailing-comma --multi-line=3 --use-parentheses'
let g:ale_python_black_executable = g:pip_command_path . 'black'
let g:ale_python_black_options = '-t py310 --line-length=110'
let g:ale_list_window_size = 5


" ALE用プレフィックス
nmap [ale] <Nop>
nmap <C-n> [ale]
" エラー行にジャンプ
nmap <silent> [ale]<C-p> <Plug>(ale_previous)
nmap <silent> [ale]<C-n> <Plug>(ale_next)
