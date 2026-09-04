#!/bin/sh

pane_id="$1"

[ -n "$pane_id" ] || exit 0

colors="
#2b3a3a
#49362b
#333954
#34452b
#443552
#4b3f2c
#28414a
#4a3334
#3a3248
#3b4630
#2d4a45
#52372f
#30384a
#4d3145
#434024
#3f3150
#2c4438
#432f3a
#2f3f52
"

window_id=$(tmux display-message -p -t "$pane_id" '#{window_id}' 2>/dev/null) || exit 0
pane_number=$(tmux display-message -p -t "$pane_id" '#{pane_index}' 2>/dev/null) || exit 0

case "$pane_number" in
    ''|*[!0-9]*) pane_number="${pane_id#%}" ;;
esac

color_count=$(printf '%s\n' "$colors" | sed '/^$/d' | wc -l | tr -d ' ')
nearby_colors=$(
    tmux list-panes -t "$window_id" -F '#{pane_id} #{pane_index} #{pane_bg}' |
    while read -r other_pane other_index other_bg; do
        [ "$other_pane" != "$pane_id" ] || continue
        [ "$other_bg" != "default" ] || continue

        distance=$((other_index - pane_number))
        [ "$distance" -ge 0 ] || distance=$((0 - distance))
        [ "$distance" -le 2 ] || continue

        printf '%s\n' "$other_bg"
    done
)

offset=0
while [ "$offset" -lt "$color_count" ]; do
    color_index=$(((pane_number + offset * 7) % color_count + 1))
    color=$(printf '%s\n' "$colors" | sed '/^$/d' | sed -n "${color_index}p")

    if ! printf '%s\n' "$nearby_colors" | grep -qxF "$color"; then
        break
    fi

    offset=$((offset + 1))
done

# Pane-scoped options avoid select-pane focus changes.
tmux set-option -pt "$pane_id" window-style "bg=$color" 2>/dev/null
tmux set-option -pt "$pane_id" window-active-style "bg=$color" 2>/dev/null
