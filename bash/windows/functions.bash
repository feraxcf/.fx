pws() { powershell.exe -Command "$@"; }
cmd() { cmd.exe "/C $@"; }

u2w() {
    if [ -t 0 ]; then
        # stdin is a terminal, so use argument
        input="$1"
    else
        # stdin is piped, so read from it
        input=$(cat)
    fi
    output=$(echo "$input" | sed -E 's|^/([a-zA-Z])/|\1:\\|' | sed 's|/|\\|g')
    echo "$output"
}

wp() {
    for arg in "$@"; do
        local full_path=$(realpath "$arg" 2>/dev/null)
        
        if [ $? -eq 0 ] && [ -n "$full_path" ] && [ -e "$full_path" ]; then
            u2w $full_path
        fi
    done
}
