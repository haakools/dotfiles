

alias vim="nvim"
alias grep='grep --color=auto '

alias gs="git status"
alias gb="git branch -a"
alias gbc="git rev-parse --abbrev-ref HEAD" #Git Branch Current
alias gf="git fetch"
alias gcm="git commit -m "
alias gds="git diff --staged"
alias gba="git branch -a"


# Not really alias but git specific helpers
# ensure fzf is installed

gch() {
    git branch -a | fzf | sed 's/^[ *]*//' | xargs -I {} git checkout {}
}
