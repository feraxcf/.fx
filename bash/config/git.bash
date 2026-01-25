# Git helper functions

___git_add_tag() {
    [[ $# -eq 2 ]] || { 
        CYAN='\033[0;36m'
        YELLOW='\033[0;33m'
        NC='\033[0m' # No Color (para resetear)
        
        echo -e "usage rtag ${CYAN}<message>${NC}\" ${YELLOW}<tag>${NC}\n  -> ___git_add_tag \"${CYAN}<message>${NC}\" ${YELLOW}<tag>${NC}\n  -> git tag ${YELLOW}<tag>${NC} -m ${CYAN}<message>${NC}"
        return 1 
    }
    git tag "$2" -m "$1"
}


# Git Alias
alias ga='git add'
alias gs='git status -s'
alias gc='git commit -m "'
alias gb='git branch'
alias gr='git reset'
alias gas='git add .; git status -s'
alias gck='git checkout'
alias gcb='git switch -c'
alias gsr='git reset --soft HEAD^'
alias gcm='git commit'
alias gst='for i in $(ls -d */); do echo "* $i " && git -C $i log --oneline -n 1; done'
alias rtag='___git_add_tag "' 
alias lst='git tag -l'
alias stag="git tag -l --format='%(contents)'"
alias gnt="git update-index --assume-unchanged"

# grp
if command -v grp &> /dev/null; then
    alias gp='grp push'
    alias gj='grp pull'
    alias gcl='grp clone'
    source <(COMPLETE=bash grp)
else
    alias gp='git push'
    alias gj='git pull'
fi


# Git functions
gsa() {
    git add $@
    git status -s
}

gl() {
    amount=${1:-10}
    git --no-pager log --oneline --graph -n $amount
}

gd() {
    git --no-pager diff "$@"
}

# Set git autocompletion to bash 
if [ -f "$current/.tmp/.git-completion.bash" ]; then
    . "$current/.tmp/.git-completion.bash"
fi

# Autocompletion
if command -v __git_complete &> /dev/null; then
    export GIT_COMPLETION_CHECKOUT_NO_GUESS=1
    
    __git_complete ga  git_add
    # __git_complete gs  ---
    # __git_complete gc  ---
    __git_complete gb  git_branch
    __git_complete gr  git_reset
    # __git_complete gas ---
    __git_complete gck git_checkout
    # __git_complete gcb ---
    # __git_complete gsr ---
    # __git_complete gcm ---
    __git_complete gp  git_push
    __git_complete gj  git_pull
    __git_complete gsa git_add
    __git_complete gl  git_log
    __git_complete gd  git_diff
fi
