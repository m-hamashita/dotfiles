#!/bin/sh

pane_id="$1"

[ -n "$pane_id" ] || exit 0

colors="
#282828
#242a2e
#2a262f
#262d25
#302822
#222b2f
#2d2630
#293024
#302a24
#242630
#2f2527
#23302d
"

pane_number="${pane_id#%}"
color_count=$(printf '%s\n' "$colors" | sed '/^$/d' | wc -l | tr -d ' ')
color_index=$((pane_number % color_count + 1))
color=$(printf '%s\n' "$colors" | sed '/^$/d' | sed -n "${color_index}p")

tmux select-pane -t "$pane_id" -P "bg=$color"
