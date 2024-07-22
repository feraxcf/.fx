gt() {
    if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "No hay un repositorio de git en este directorio"
        z=""
        while [[ "$z" != "y" && "$z" != "n" && "$z" != "Y" && "$z" != "N" ]]; do
            z="Y"
            read -p "¿Desea crear un repositorio de git? (Y/n): " z
        done
    else
        if [[ $# -eq 0 ]]; then
            echo "help:"
            
            echo "gt h: for help"
            echo "gt st: git status"
            echo "gt a: git add ."
            echo "gt cm <mensaje>: git commit -m <mensaje>"
            echo "gt ck <rama>: git checkout <rama>"
            
        else
            case $1 in
                "h")
                    git --help
                    ;;
                "st")
                    git status -s
                    ;;
                "a")
                    git add .
                    git status -s
                    ;;
                "cm")
                    if [[ $# -le 1 ]]; then
                        echo "Falta el mensaje del commit"
                    else
                        git commit -m "$2"
                    fi
                    ;;
                "ck")
                    # pasa los argumentos del 2 en adelante
                    git checkout ${@:2}
                    ;;
                *)
                    echo "Comando no reconocido"
                    echo "gt h: for help"
                    ;;
            esac
        fi
    fi
}