
current="$current"
if [ current == "" ]; then
    current="~/.fx"
fi

if uname -a | grep "microsoft" &> /dev/null; then 
    for rc in -d $current/bash/config/wsl/*.bash; do
        if [ -f "$rc" ]; then . "$rc"; fi
    done
fi

if [[ "$(uname -s)" == *MINGW* ]]; then 
    for rc in -d $current/bash/config/windows/*.bash; do
        if [ -f "$rc" ]; then . "$rc"; fi
    done
fi
