#!/usr/bin/env bash

config() {
    local home=$HOME
    local target=$HOME
    local main="\nfile=\"\$HOME/.fx/bash/_init.bash\"\nif [ -f \$file ]; then . \$file; fi"
    
    [[ "$1" == "--root" ]] && {
        target="/root"
        
        echo "export HOME=$home" | sudo tee -a "$target/.bashrc" > /dev/null 
        echo -e "$main"  | sudo tee -a "$target/.bashrc" > /dev/null
        echo "export HOME=/root" | sudo tee -a "$target/.bashrc" > /dev/null
    
    } || {
        echo -e "$main" >> $target/.bashrc
    }
}

config "$@"
