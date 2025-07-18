# by feraxhp <https://github.com/feraxhp>

export current=$(realpath .)

for rc in -d $current/bash/config/*.bash; do
    if [ -f "$rc" ]; then
        . "$rc"
    fi
done

. "$current/bash/_shell.bash"

if [ -z "${ZED}" ] || [ "${ZED}" != "1" ]; then
    echo -e "\e[36m"
    echo "  ∕⁀⧵             "
    echo "  \ ∕        ∕⁀⧵  "
    echo "   X            | "
    echo "  / \ ∕⁀⧵   |   | "
    echo " |   |   ⧵‿∕ \ /  "
    echo " |            X   "
    echo "  ⧵‿∕        ∕ \  "
    echo "             ⧵‿∕  "
fi

unset rc
unset SSH_ASKPASS
unset current