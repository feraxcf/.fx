#!/usr/bin/env bash

config() {
    local origin="$HOME/.fx/apps/mime/mimeapps.list"
    local target="$HOME/.config/mimeapps.list"
    
    [[ -e "$target" ]] && rm -fr "$target"
    
    ln "$origin" "$target" && {
        echo "Created link '$origin' -> '$target'"
    }
}

config