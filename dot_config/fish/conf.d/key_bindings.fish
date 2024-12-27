bind \cg '__ghq_repository_search'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cg '__ghq_repository_search'
end

bind \cw 'fzf-git-diff-vim'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cw 'fzf-git-diff-vim'
end

bind \c] 'cdr'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \c] 'cdr'
end

bind \cv 'fzf-git-vim'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cv 'fzf-git-vim'
end

bind \cb 'co'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cb 'co'
end

bind \cp 'cop'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cp 'cop'
end

bind \cd 'fzf-git-cd'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cd 'fzf-git-cd'
end

bind \cf 'fzf-cd'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cf 'fzf-cd'
end

bind \eH 'backward-word'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \eH 'backward-word'
end

bind \eL 'forward-word'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \eL 'forward-word'
end
