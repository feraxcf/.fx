__scripts_completion() {
    # echo "$COMP_TYPE"  >&2
    [[ -f "package.json" ]] && {
        cat package.json | jq ".scripts | keys[]" -r
    } || {
        [[ "$COMP_TYPE" == "63" ]] && {
            # 1. Guardar la posición actual del cursor
            echo -ne "$(tput sc)" >&2
            
            echo -e "\nNo \e[31mpackage.json\e[0m found in \e[33m$(pwd)\e[0m" >&2
            # 3. Mover el cursor una línea hacia arriba
            #    Esto lo pone en la misma línea donde se imprimió el error,
            #    pero antes de que se restaurara.
            echo -ne "$(tput cuu1)" >&2

            # 4. Restaurar la posición del cursor a donde estaba antes de todo
            echo -ne "$(tput rc)" >&2
        }
    }
}

_bun_completion() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    
    [[ "${COMP_CWORD}" == 2 && "${COMP_WORDS[COMP_CWORD - 1]}" == "run" ]] && {
        COMPREPLY=( $(compgen -W "$(__scripts_completion)" -- ${cur}) )
    }
    
    [[ "${COMP_CWORD}" == 1 && "$cur" == "." ]] && {
        COMPREPLY=( $(compgen -o filenames -f "./") )
        return 0
    }
    
    [[ "${COMP_CWORD}" == 1 && "$cur" == *"/"* ]] && {
        COMPREPLY=( $(
            local IFS=$'\n' # Importante para manejar nombres con espacios
            for c in $(compgen -o filenames -f "$cur"); do
                # Si 'c' es un directorio Y no termina ya en '/', imprime 'c/'
                # De lo contrario, imprime 'c' tal cual.
                [[ -d "$c" && "${c: -1}" != "/" ]] && echo "${c}/" || echo "$c"
            done
        ) )
        return 0
    }
    
    [[ "${COMP_CWORD}" == 1 ]] && {
        COMPREPLY=( $(compgen -W "run build exec install add update init create --watch --hot" -- ${cur}) )
    }
    
}

complete -o nospace -F _bun_completion bun
