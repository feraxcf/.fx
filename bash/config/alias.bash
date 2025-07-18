
# General aliases
alias cl='clear'
alias fx='cd ~/.fx'
alias fxd='$HOME/.fx'
alias x='exit 0'
alias rl='source ~/.bashrc'
alias pp='cd ~/projects/pprojects'
alias tp='cd ~/projects/tprojects'
alias dw='cd ~/Downloads || cd ~/downloads'
alias dc='cd ~/Documents || cd ~/documents'

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
