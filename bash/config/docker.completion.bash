_dsm_completion() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    
    if [ ${COMP_CWORD} > 1 ]; then
        # Complete with running container IDs or names
        opts=$(docker ps -a --format "{{.ID}} {{.Names}}")
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    fi
}

complete -F _dsm_completion dsm