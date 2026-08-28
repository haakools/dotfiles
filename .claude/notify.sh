#!/bin/bash
# Claude Code Notification/Stop hook: flags the tmux window (bell) and
# plays a sound, so you can tell which pane needs input or just finished
# without tabbing through every window.
#
# Sounds default to the files in ~/.claude/sounds (symlinked from this
# repo's .claude/sounds/ — swap them there to change the sound for good).
# Override per-event by exporting CLAUDE_NOTIFY_SOUND / CLAUDE_STOP_SOUND
# before launching tmux/claude instead, if you just want a one-off change.

EVENT_NAME="$1"

NEEDS_INPUT_SOUND="${CLAUDE_NOTIFY_SOUND:-$HOME/.claude/sounds/needs-input.oga}"
DONE_SOUND="${CLAUDE_STOP_SOUND:-$HOME/.claude/sounds/done.oga}"

if [ "$EVENT_NAME" = "Stop" ]; then
    SOUND_FILE="$DONE_SOUND"
else
    SOUND_FILE="$NEEDS_INPUT_SOUND"
fi

# Flag this pane's window in the tmux status bar (monitor-bell picks this up)
{ printf '\a' > /dev/tty; } 2>/dev/null

# Play the sound without blocking the hook (or Claude waiting on it)
if [ -f "$SOUND_FILE" ]; then
    (paplay "$SOUND_FILE" >/dev/null 2>&1 &)
fi

exit 0
