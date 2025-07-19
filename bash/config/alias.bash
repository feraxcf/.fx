
# General aliases
alias cl='clear'
alias x='exit 0'
alias rl='source ~/.bashrc'

# frecuent paths 
move_to() {
    path="$1/$2"
    cd $path
}

move_fb() {
    path1="$1/$3"
    path2="$2/$3"
    
    cd $path1 &> /dev/null || 
    cd $path2 &> /dev/null || 
    echo -e "paths not found:\n1. $path1\n2. $path2"
}

alias fx='move_to ~/.fx'
alias pp='move_to ~/projects/pprojects'
alias tp='move_to ~/projects/tprojects'
alias jp='move_to ~/projects/jprojects'
alias dw='move_fb ~/Downloads ~/downloads'
alias dc='move_fb ~/Documents ~/documents'

# Rust-related aliases
alias cw='bacon --headless run-long -- -q'

# Python
alias py='python'

# Web related
alias ppm='pnpm'

# Alternative commands
# if command -v eza &> /dev/null; then alias tree='eza -T'; fi
if command -v eza &> /dev/null; then 
    alias ls='eza --git --group-directories-first'
    alias tree='eza -T'
fi

if command -v bat &> /dev/null; then alias cat='bat'; fi
