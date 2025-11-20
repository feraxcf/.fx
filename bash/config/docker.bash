if command -v docker &> /dev/null; then
    alias aws='docker run --rm -it amazon/aws-cli'
# else
    # echo "Docker is not instaled is not in your path"
fi

dsm() {
    if ! command -v docker &> /dev/null; then
        echo "❌ docker no está instalado"
        return 1
    fi
    if [[ $# -ne 1 ]]; then
        echo "❌ Se requieren exactamente 1 argumentos: <docker id>"
        return 1
    fi
    
    docker rm $(docker stop $1)
}