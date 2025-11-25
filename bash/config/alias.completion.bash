_move_completion() {
    local base_dir prefix
    base_dir="$1"
    prefix="${COMP_WORDS[$COMP_CWORD]}"
    
    if [ "$COMP_CWORD" == 1 ]; then
        COMPREPLY=($(cd "$base_dir" && compgen -d "$prefix"))
    fi
}

_fx_completion() { _move_completion "$HOME/.fx"; }
_pp_completion() { _move_completion "$HOME/projects/pprojects"; }
_jp_completion() { _move_completion "$HOME/projects/jprojects"; }
_tp_completion() { _move_completion "$HOME/projects/tprojects"; }

complete -F _fx_completion fx
complete -F _pp_completion pp
complete -F _jp_completion jp
complete -F _tp_completion tp

_dw_completion() {
    if   [ -d "$HOME/Downloads" ]; then _move_completion "$HOME/Downloads";
    elif [ -d "$HOME/downloads" ]; then _move_completion "$HOME/downloads";
    fi
}

_dc_completion() {
    if   [ -d "$HOME/Documents" ]; then _move_completion "$HOME/Documents";
    elif [ -d "$HOME/documents" ]; then _move_completion "$HOME/documents";
    fi
}

complete -F _dw_completion dw
complete -F _dc_completion dc
