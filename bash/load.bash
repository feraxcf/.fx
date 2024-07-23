if uname -a | grep "microsoft" &> /dev/null; then 
    if [ -d ~/.fx/bash/wsl ]; then
        for rc in -d ~/.fx/bash/wsl/*.bash; do
            if [ -f "$rc" ]; then
                . "$rc"
            fi
        done
    fi
fi