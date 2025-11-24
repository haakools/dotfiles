
alias vim="nvim"
alias grep='grep --color=auto '

alias gs="git status"
alias gb="git branch -a"
alias gbc="git rev-parse --abbrev-ref HEAD" #Git Branch Current
alias gf="git fetch"
alias gcm="git commit -m "
alias gd="git diff"
alias gds="git diff --staged"
alias gba="git branch -a"


## Shell utilities - REQUIRES FZF
# Not really alias but git specific helpers
# ensure fzf is installed

gch() {
    git branch -a | fzf | sed 's/^[ *]*//' | xargs -I {} git checkout {}
}


# Process killing with fzf
kp() {
    # kp -> kill process abbrev
    # TODO add log statement which processed was killed to stdout
    ps -aux | fzf | awk '{print $2}' | xargs kill 
}


auto_venv() {
    # Deactivate if we're currently in a venv
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate 2>/dev/null
    fi
    # Activate if new directory has a venv
    if [[ -f venv/bin/activate ]]; then
        source venv/bin/activate
    fi
}

# Replace alias with function
cd() {
    builtin cd "$@" && auto_venv
}

# on shell startup (for tmux)
auto_venv

# requires zoxide 
# curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/refs/heads/main/install.sh | bash 

eval "$(zoxide init bash)"

# Your custom 'o' function using zoxide
o() {
    local dir
    dir=$(zoxide query -l | fzf --height 40% --reverse --border --preview 'ls -la {}' --preview-window=right:50%:wrap)
    if [[ -n "$dir" ]]; then
        cd "$dir"
    fi
}

