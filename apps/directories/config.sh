#!/usr/bin/env bash


config() {
    local origin="$HOME/.fx/apps/directories/user-dirs.dirs"
    local target="$HOME/.config/user-dirs.dirs"
    
    [[ -e "$target" ]] && rm -fr "$target"
    
    ln "$origin" "$target" && {
        echo "Created link '$origin' -> '$target'"
    }
}

config