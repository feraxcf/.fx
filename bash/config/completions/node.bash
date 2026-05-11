__scripts_completion() {
    if [[ -f "package.json" ]]; then
        jq -r '.scripts | keys[]' package.json 2>/dev/null
    else
        if [[ "$COMP_TYPE" == "63" ]]; then
            echo -ne "$(tput sc)" >&2
            echo -e "\nNo \e[31mpackage.json\e[0m found in \e[33m$(pwd)\e[0m" >&2
            echo -ne "$(tput cuu1)$(tput rc)" >&2
        fi
    fi
}

_bun_completion() {
    local cur prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD - 1]}"

    case "$COMP_CWORD" in
        1)
            if [[ "$cur" == "." ]]; then
                # 'mapfile' maneja de forma segura archivos/rutas con espacios
                mapfile -t COMPREPLY < <(compgen -o filenames -f "./")
            elif [[ "$cur" == *"/"* ]]; then
                local opts
                mapfile -t opts < <(compgen -o filenames -f -- "$cur")
                for c in "${opts[@]}"; do
                    # Si es directorio y no termina en '/', lo agregamos
                    [[ -d "$c" && "${c: -1}" != "/" ]] && COMPREPLY+=("${c}/") || COMPREPLY+=("$c")
                done
            else
                mapfile -t COMPREPLY < <(compgen -W "run build exec install add update init create --watch --hot" -- "$cur")
            fi
            ;;
        2)
            if [[ "$prev" == "run" ]]; then
                mapfile -t COMPREPLY < <(compgen -W "$(__scripts_completion)" -- "$cur")
            fi
            ;;
    esac
}

_ppm_completions() {
    local cur
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    if [[ "$COMP_CWORD" == 1 ]]; then
        mapfile -t COMPREPLY < <(compgen -W "$(__scripts_completion)" -- "$cur")
    fi
}

complete -o nospace -F _bun_completion bun
complete -F _ppm_completions ppm
complete -F _ppm_completions nex
