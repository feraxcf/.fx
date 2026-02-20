if command -v docker &> /dev/null; then
    alias aws='docker run --rm -it amazon/aws-cli'
# else
    # echo "Docker is not instaled is not in your path"
fi

dremove() {
    if ! command -v docker &> /dev/null; then
        echo "❌ docker no está instalado"
        return 1
    fi
    if [[ $# -lt 1 ]]; then
        echo "❌ Se requiere al menos 1 argumento: <docker id>"
        return 1
    fi
    
    for a in "$@"; do
        echo "removed $(docker rm $(docker stop $a))"
    done
}

dps() {
    if ! command -v docker &> /dev/null; then
        echo "❌ Docker is not installed."
        return 1
    fi

    docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}"
}
