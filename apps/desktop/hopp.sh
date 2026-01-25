#!/usr/bin/env bash

config() {
    local apps="$HOME/apps/"
    local start="$HOME/.config/autostart"
    
    mkdir -p "$apps" "$start"
    echo "" > "$start/Hoppscotch Agent.desktop"
    
    curl -L "https://github.com/hoppscotch/agent-releases/releases/latest/download/Hoppscotch_Agent_linux_x64.AppImage" -o "$apps/hopp.agent"
}

config
