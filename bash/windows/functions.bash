pws() { powershell.exe -Command "$@"; }
cmd() { cmd.exe "/C $@"; }

wp() {
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