#!/usr/bin/env bash

dgrp() {
    [[ -f "$HOME/projects/pprojects/grp/target/debug/grp" ]] && {
        "$HOME/projects/pprojects/grp/target/debug/grp" "$@"
    } || {
        echo "Please compile grp on debug mode"
    }
}

die() {
    [[ -f "$HOME/projects/pprojects/ie/target/debug/ie" ]] && {
        "$HOME/projects/pprojects/ie/target/debug/ie" "$@"
    } || {
        echo "Please compile ie on debug mode"
    }
}
