set -x theme_color_scheme gruvbox

set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x LC_ALL 'ja_JP.UTF-8'

# Postgres
set -x PGDATA /usr/local/var/postgres

# ls color
set -x CLICOLOR 1
set -x LSCOLORS DxGxcxdxCxegedabagacad

# PATH
set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.local/bin $PATH
set -x PATH $HOME/usr/lib/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/git/bin $PATH
set -x PATH $HOME/extensions/coc-clangd-data/install/11.0.0/clangd_11.0.0/bin $PATH
set -x PATH $HOME/.poetry/bin $PATH
set -x PATH /usr/local/opt/binutils/bin $PATH
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /opt/homebrew/opt/openjdk@11/bin $PATH # for openjdk@11(for digdag)
set -x PATH $DENO_INSTALL/bin $PATH
set -x PATH ~/.fzf/bin $PATH
set -x PATH ~/.gvm/bin $PATH

set -x DENO_INSTALL /Users/masakatsu.hamashita/.deno
set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin

set -x XDG_DATA_HOME $HOME/.local/share
set -x PATH $XDG_DATA_HOME/aquaproj-aqua/bin $PATH
# set -x AQUA_GLOBAL_CONFIG $(aqua root-dir)/aqua.yaml
set -x AQUA_GLOBAL_CONFIG ~/.local/share/aquaproj-aqua/aqua.yaml
set -x AQUA_DISABLE_POLICY true  # TODO: AQUA_DISABLE_POLICY false
set -x AQUA_POLICY_CONFIG ~/.local/share/aquaproj-aqua/aqua-policy.yaml
set -x XDG_CONFIG_HOME $HOME/.config

set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x HOMEBREW_NO_INSTALL_CLEANUP 1

# tfenv TODO: make it good
set -x PATH $HOME/.local/share/aquaproj-aqua/pkgs/github_archive/github.com/tfutils/tfenv/v3.0.0/tfenv-3.0.0/bin $PATH

# TODO: make it good
set -x nvm_default_version v24.14.0

# set -x PATH /usr/local/opt/llvm/bin $PATH
# set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths

# ranger
set -x EDITOR nvim
set -x VISUAL nvim

function _delayed_load --on-event fish_postexec
    functions --erase _delayed_load
    if [ (command -v direnv) ]
        eval (direnv hook fish)
        set -x DIRENV_LOG_FORMAT
    end

    # go
    if [ (command -v go) ]
        set -x GOPATH $HOME/go
        set -x GOROOT ( go env GOROOT )
        set -x PATH $GOPATH/bin $PATH
    end
end

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH
set -x WORKON_HOME $HOME/.virtualenvs

set -x PYTHONPATH /Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Resources/Python $PYTHONPATH

set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"

# cd, pwd などは history に登録しない
set -x HISTORY_IGNORE "(cd *|pwd|ls|rm *)"

set -x FZF_DEFAULT_OPTS '--height 70% --layout=reverse --preview-window="wrap" --preview "bat --style=numbers --color=always --line-range :300 {}"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/masakatsu.hamashita/.local/google-cloud-sdk/path.fish.inc' ]; . '/Users/masakatsu.hamashita/.local/google-cloud-sdk/path.fish.inc'; end

# Added by Windsurf
fish_add_path /Users/masakatsu.hamashita/.codeium/windsurf/bin

if string match -q "$TERM_PROGRAM" "kiro"
    if type -q kiro
        . (kiro --locate-shell-integration-path fish)
    end
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Added by Antigravity
fish_add_path /Users/masakatsu.hamashita/.antigravity/antigravity/bin


# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
