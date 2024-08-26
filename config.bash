#!/bin/bash

# Para probar el script ejecutar en docker: 
# docker run --rm -v ~/.fx:/root/.fx -it fedora:40 bash
# /root/.fx/config.fedora

# Variables de ejecución
omp=""
dock=""
zed=""
bsh="y"

# Verifica si se proporcionaron argumentos
if   [[ $# -eq 0 ]]; then omp="y"; dock="y"; zed="y"; bsh="y"
else
    if [[ "$1" == "--" ]]; then omp="n"; dock="n"; zed="n"; bsh="n"; fi
    for arg in "$@"; do
        if   [[ "$arg" == "--" ]]; then echo ""
        elif [[ "$arg" == "-h" || "$arg" == "--help" ]]; then 
            echo "se pueden usar variables para evitar la instalacion de uno o varios componentes"
            echo "ejemplo: ./config.fedora.sh --omp no instala oh-my-posh"
            echo "ejemplo: ./config.fedora.sh ++dock instala docker"
            echo -e "\n"
            echo "Argumentos:"
            echo "usa -- para inabilitar todos, solo es valido como primer argumento"
            echo " -b:  --bash: no agrega configuraciones a .bashrc"
            echo " -d:  --dock: no instala docker"
            echo " -o:  --omp: no instala oh-my-posh"
            echo " -z:  --zed: no instala zed"
            echo -e "\n"
            echo "Usa un '+' para instalar y un '-' para no instalar"
            echo "Usa '--' para instalar colocar todo en modo no instalar"
            echo "Los comandos son leidos en orden de izquierda a derecha"
            echo "Ejemplo: ./config.fedora.sh -o +o Instala oh-my-posh"
            echo -e "\n"
            echo "-h  --help: muestra este mensaje"
        
        elif [[ "$arg" == "-b" || "$arg" == "--bsh" ]]; then bsh="n"
        elif [[ "$arg" == "-d" || "$arg" == "--dock" ]]; then dock="n"
        elif [[ "$arg" == "-o" || "$arg" == "--omp" ]]; then omp="n"
        elif [[ "$arg" == "-z" || "$arg" == "--zed" ]]; then zed="n"
        
        elif [[ "$arg" == "+b" || "$arg" == "++bsh" ]]; then bsh="y"
        elif [[ "$arg" == "+d" || "$arg" == "++dock" ]]; then dock="y"
        elif [[ "$arg" == "+o" || "$arg" == "++omp" ]]; then omp="y"
        elif [[ "$arg" == "+z" || "$arg" == "++zed" ]]; then zed="y"
        else echo "Argumento desconocido: $arg"
        fi
    done
fi

# Configuracion instalacion
while [[ "$omp" != "y" && "$omp" != "n" && "$omp" != "Y" && "$omp" != "N" ]]; do
    read -p "¿Instalar oh-my-posh? (y/n): " omp
done

while [[ "$dock" != "y" && "$dock" != "n" && "$dock" != "Y" && "$dock" != "N" ]]; do
    read -p "¿Instalar Docker? (y/n): " dock
done

while [[ "$zed" != "y" && "$zed" != "n" && "$zed" != "Y" && "$zed" != "N" ]]; do
    read -p "¿Instalar zed? (y/n): " zed
done

while [[ "$bsh" != "y" && "$bsh" != "n" && "$bsh" != "Y" && "$bsh" != "N" ]]; do
    read -p "¿Agregar configuraciones a .bashrc? (y/n): " bsh
done

# Verficar dependencias

## Verficar OS

if command -v uname &> /dev/null; then
    echo "unknown OS"
    os="unknown"
else
    ### ferdora = 
    ### ubuntu = 
    ### debian = 
    ### windows = Msys
    ### wsl = WSL
    
    os=$(uname -a)
    
    if   [[ $os =~ "Msys" ]]; then os = "Msys"
    elif [[ $os =~ "WSL" ]]; then os = "WSL"
    elif [[ $os =~ "fedora" ]]; then os = "fedora"
    elif [[ $os =~ "ubuntu" ]]; then os = "ubuntu"
    elif [[ $os =~ "debian" ]]; then os = "debian"
    else 
        echo "unknown OS"
        os = "unknown"
    fi
