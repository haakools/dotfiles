#!/usr/bin/env bash
# Prints disk usage of installed Steam games for the tmux status bar.
# du is slow on large trees, so the result is cached for 10 minutes.
dir="$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common"
cache="${XDG_RUNTIME_DIR:-/tmp}/tmux-steam-usage"
if [[ ! -f $cache || $(( $(date +%s) - $(stat -c %Y "$cache") )) -gt 600 ]]; then
  du -sh "$dir" 2>/dev/null | cut -f1 > "$cache.tmp" && mv "$cache.tmp" "$cache"
fi
echo "steam $(cat "$cache" 2>/dev/null || echo '?')"
