_dremove_completion() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    
    [[ ${COMP_CWORD} -ge 1 ]] && \
        COMPREPLY=( $(compgen -W "$(docker ps -a --format "{{.ID}} {{.Names}}")" -- ${cur}) )
}

complete -F _dsm_completion dremove