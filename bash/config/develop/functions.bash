#!/usr/bin/env bash

dgrp() {
    [[ -f "$HOME/projects/pprojects/grp/target/debug/grp" ]] && {
        "$HOME/projects/pprojects/grp/target/debug/grp" "$@"
    } || {
        echo "Please compile grp on debug mode"
    }
}
