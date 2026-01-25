#!/usr/bin/env bash

config() {
    local origin="$HOME/.fx/apps/seafile/seaf.service"
    
    sudo cp "$origin" /etc/systemd/system/seaf-cli.service
    
    sudo systemctl daemon-reload
    sudo systemctl enable --now seaf-cli.service
    
    echo configured
}

config
