bind \cg '__ghq_repository_search'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cg '__ghq_repository_search'
end

bind \ce 'fzf-git-diff-vim'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \ce 'fzf-git-diff-vim'
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

bind \co 'cop'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \co 'cop'
end
