# by feraxhp <https://github.com/feraxhp>

init() {
    export current=$(realpath ~/.fx)
    local inicio=$(date +%s.%N)
    
    [[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
    
    for rc in -d $current/bash/config/*.bash; do
        if [ -f "$rc" ]; then . "$rc"; fi
    done
    
    for rc in -d $current/bash/config/completions/*.bash; do
        if [ -f "$rc" ]; then . "$rc"; fi
    done
    
    . "$current/bash/_shell.bash"
    
    if [ -z "${ZED}" ] || [ "${ZED}" != "1" ]; then
        echo -e "\e[36m"
        echo "  ⡔⠉⢢"
        echo "  ⢣ ⡜         ⡔⠉⢢"
        echo "   ⣿            ⢸"
        echo "  ⡜ ⢣ ⡔⠉⢢   ⡇   ⡜"
        echo " ⡜   ⡇   ⠣⣀⠜ ⢣ ⡜"
        echo " ⡇            ⣿"
        echo " ⠣⣀⠜         ⡜ ⢣"
        echo "             ⠣⣀⠜"
        echo -e "≃ \e[32m$(sclc "$(date +%s.%N) - $inicio" | cut -c -5)s"
        echo -ne "\e[0m"
    fi
    
    unset rc
    unset SSH_ASKPASS
    unset current
}

if [[ -n "$PS1" ]]; then
    init
fi

if [ "${ZED}" == "1" ]; then
    init
fi