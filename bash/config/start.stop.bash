
start() {
    if [[ $1 == "docker" ]]; then
        echo "Starting Docker daemon..."
        sudo systemctl start docker
        echo "Done"
    else
        echo "$1: is not a valid option"
    fi
}

stop() {
    if [[ $1 == "docker" ]]; then
        echo "Stoping Docker daemon..."
        sudo systemctl stop docker.socket
        sudo systemctl stop docker.service
        echo "Done"
    else
        echo "$1: is not a valid option"
    fi
}