bind \cg '__ghq_repository_search'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cg '__ghq_repository_search'
end

bind \ce 'fzf-git-editdiff'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \ce 'fzf-git-editdiff'
end

bind \c] 'cdr'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \c] 'cdr'
end

bind \cv 'fzf-git-vim'
if bind -M insert >/dev/null 2>/dev/null
    bind -M insert \cv 'fzf-git-vim'
end
