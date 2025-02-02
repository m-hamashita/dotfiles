if not command -s pyenv > /dev/null
    # echo "Install <github.com/yyuu/pyenv> to use 'pyenv'."
    exit 1
end

set -l pyenv_root ""

if test -z "$PYENV_ROOT"
    set pyenv_root ~/.pyenv
    set -x PYENV_ROOT "$pyenv_root"
else
    set pyenv_root "$PYENV_ROOT"
end

if status --is-login
    set -x PATH "$pyenv_root/shims" $PATH
    set -x PYENV_SHELL fish
end
command mkdir -p "$pyenv_root/"{shims,versions}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f ~/miniconda3/bin/conda
    eval /Users/masakatsu.hamashita/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/masakatsu.hamashita/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/masakatsu.hamashita/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/masakatsu.hamashita/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

