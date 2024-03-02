# tmux
function attach_tmux_session_if_needed
    set existing_sessions (tmux list-sessions | cut -d: -f1)
    if test -z "$existing_sessions"
        tmux new-session
        return
    end

    set new_session "Create New Session"
    set ID work # (tmux list-sessions | fzf --reverse | cut -d: -f1)
    if test "$TERM_PROGRAM" = "vscode"
        set ID vscode
    end
    # if test "$ID" = "$new_session"
    #     tmux new-session
    # else if test -n "$ID"
    #     tmux attach-session -t "$ID"
    # end
    if contains $ID $existing_sessions
        tmux attach-session -t "$ID"
    else
        tmux new-session -s $ID
    end
end

if test -z $TMUX && status --is-login
    attach_tmux_session_if_needed
end
