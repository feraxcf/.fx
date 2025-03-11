# Git Alias
alias ga='git add'
alias gl='git log --oneline'
alias gs='git status -s'
alias gc='git commit -m "'
alias gb='git branch'
alias gp='git push'
alias gj='git pull' # git [jalar/jerk]
alias gas='git add .; git status -s'
alias gck='git checkout'
alias gcb='git checkout -b'
alias gsr='git reset --soft HEAD^'
alias gcm='git commit'

# Git functions
gsa() {
    git add $@
    git status -s
}
