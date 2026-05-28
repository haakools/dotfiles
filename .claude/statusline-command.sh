#!/bin/bash
input=$(cat)

cwd=$(echo "$input"       | jq -r '.cwd // ""')
model=$(echo "$input"     | jq -r '.model.display_name // .model.id // .model // "?"')
used=$(echo "$input"      | jq -r '.context_window.total_input_tokens // 0')
limit=$(echo "$input"     | jq -r '.context_window.context_window_size // 0')
used_pct=$(echo "$input"  | jq -r '.context_window.used_percentage // 0')
rem_pct=$(echo "$input"   | jq -r '.context_window.remaining_percentage // 0')
dur_ms=$(echo "$input"    | jq -r '.cost.total_duration_ms // 0')

# Auth account
auth_json=$(claude auth status 2>/dev/null)
email=$(echo "$auth_json" | jq -r '.email // ""')
org=$(echo "$auth_json"   | jq -r '.orgName // ""')
account="${email} (${org})"

# Git branch
branch=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
fi

# Token display
used_k=$(awk "BEGIN { printf \"%.1fk\", $used/1000 }")
rem_k=$(awk  "BEGIN { printf \"%.1fk\", ($limit-$used)/1000 }")

# Duration
secs=$((dur_ms / 1000))
if [ "$secs" -ge 60 ]; then
  dur_str="$(( secs / 60 ))m$(( secs % 60 ))s"
else
  dur_str="${secs}s"
fi

printf " ⎇ %s  │  %s  │  %s / %s  (%s%%)  │  %s  │  %s" \
  "$branch" "$model" "$used_k" "$rem_k" "$used_pct" "$dur_str" "$account"
