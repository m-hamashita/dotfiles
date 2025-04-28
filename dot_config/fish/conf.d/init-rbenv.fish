# set up rbenv for fish (lazy load)
set -x RBENV_PATH /opt/homebrew/bin/rbenv

function rbenv
    echo "Lazy loading rbenv upon first invocation..."
    functions --erase rbenv

    if test -f $RBENV_PATH
        echo "Using rbenv installation found in $RBENV_PATH"

        set -x RBENV_ROOT "$HOME/.rbenv"
        set -x PATH $RBENV_ROOT/shims $PATH

        if command rbenv init - | grep --quiet "function"
            set -gx __RBENV_SUPPORTS_FISH true
            eval (rbenv init - | string collect)
        end

        rbenv $argv
        return
    end

    echo "No rbenv installation found in $RBENV_PATH"
end
