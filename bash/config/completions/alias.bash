_move_completion() {
    local base_dir prefix
    base_dir="$1"
    prefix="${COMP_WORDS[$COMP_CWORD]}"
    
    if [ "$COMP_CWORD" == 1 ]; then
        COMPREPLY=($(cd "$base_dir" && compgen -d "$prefix" | sed 's/$/\//'))
    fi
}

_fx_completion() { _move_completion "$HOME/.fx"; }
_pp_completion() { _move_completion "$HOME/projects/pprojects"; }
_jp_completion() { _move_completion "$HOME/projects/jprojects"; }
_tp_completion() { _move_completion "$HOME/projects/tprojects"; }
_cfg_completion() { _move_completion "$HOME/.config"; }
_home_completion() { _move_completion "$HOME"; }

complete  -o nospace -F _fx_completion fx
complete  -o nospace -F _pp_completion pp
complete  -o nospace -F _jp_completion jp
complete  -o nospace -F _tp_completion tp
complete  -o nospace -F _cfg_completion cfg
complete  -o nospace -F _home_completion home

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

complete -o nospace -F _dw_completion dw
complete -o nospace -F _dc_completion dc

_gc_completion() {
    local cur prev words
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=('feat' 'fix' 'publish' 'docs' 'rewrite' 'refactor' 'test' 'revert' 'release' ':root' 'chore')

    if [[ ${COMP_CWORD} -eq 1 ]]; then
            COMPREPLY=( $(compgen -W "${words[*]}" -- "$cur") )
            
            if [[ ${#COMPREPLY[@]} -eq 1 && "${COMPREPLY[0]}" != ":root" ]]; then
                COMPREPLY[0]="${COMPREPLY[0]}: "
            elif [[ "${COMPREPLY[0]}" == ":root" ]]; then
                COMPREPLY[0]="${COMPREPLY[0]}\""
            fi
            
            return 0
        fi

    # autocomplete with files
    if [[ ${COMP_CWORD} -ge 2 ]]; then
        COMPREPLY=( $(compgen -f -- "$cur") )

        # if its a directory add a /
        for i in "${!COMPREPLY[@]}"; do
            if [[ -d "${COMPREPLY[$i]}" ]]; then
                COMPREPLY[$i]="${COMPREPLY[$i]}/"
            fi
        done
        return 0
    fi
}

complete -o nospace -F _gc_completion gc

_run_completions() {
    local curr_word="${COMP_WORDS[COMP_CWORD]}"
    local scripts_dir="$HOME/.fx/bash/config/scripts"

    if [[ "${COMP_CWORD}" -eq 1 ]]; then
        local available_scripts=$(ls -1 "$scripts_dir" 2>/dev/null)
        COMPREPLY=( $(compgen -W "$available_scripts" -- "$curr_word") )
    else
        local target_script="${COMP_WORDS[1]}"
        
        if [[ -x "$scripts_dir/$target_script" ]]; then
            # Source the target script to load __internal_completer
            . "$scripts_dir/$target_script" 2>/dev/null
            
            # Check if the function was actually loaded
            if declare -f __internal_completer >/dev/null; then
                local orig_cword="$COMP_CWORD"
                local orig_words=("${COMP_WORDS[@]}")
                
                COMP_WORDS=( "${COMP_WORDS[@]:1}" ) 
                COMP_CWORD=$(( COMP_CWORD - 1 )) 
                __internal_completer
                
                unset -f __internal_completer
                
                COMP_WORDS=("${orig_words[@]}")
                COMP_CWORD="$orig_cword"
            else
                COMPREPLY=( $(compgen -f -- "$curr_word") )
            fi
        else
            COMPREPLY=( $(compgen -f -- "$curr_word") )
        fi
    fi
}

complete -F _run_completions run
