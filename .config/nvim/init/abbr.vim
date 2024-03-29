iabbrev improt import
cabbrev ger Germanium -b="\#32344a"
cabbrev gb GBrowse
cabbrev ga Git add %:p
cabbrev gs Git status
cabbrev gc Git commit -m
cabbrev gd Gdiff
cabbrev gp Git push
cabbrev bdo %bd\|e#\|bd#

" augroup abbr_sql
"   autocmd FileType sql iabbrev <buffer> select SELECT
"   autocmd FileType sql iabbrev <buffer> from FROM
"   autocmd FileType sql iabbrev <buffer> where WHERE
"   autocmd FileType sql iabbrev <buffer> order ORDER
"   autocmd FileType sql iabbrev <buffer> by BY
"   autocmd FileType sql iabbrev <buffer> as AS
"   autocmd FileType sql iabbrev <buffer> join JOIN
"   autocmd FileType sql iabbrev <buffer> left LEFT
"   autocmd FileType sql iabbrev <buffer> group GROUP
" augroup END
