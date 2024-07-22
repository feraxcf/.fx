mkcd() {
    mkdir $1
    cd $1
}

bd(){
    cd ..
}

reload(){
    source ~/.bashrc
}

activate() {
    venv=".venv"
    if [ "$1" != "" ]; then
        venv="$1"
    fi
    if [ -d "./$venv/bin" ]; then
        . "./$venv/bin/activate"
    elif [ -d "./$venv/Scripts" ]; then
        . "./$venv/Scripts/activate"
    else
        echo "There is not a venv directory"
        echo "Directory name: $venv"
    fi
}

fm(){

    path="$1"
    if [ path == "" ]; then
        path=$(pwd)
    fi

    if command -v gnome-shell &> /dev/null; then
        nautilus "$path"
    elif command -v explorer.exe &> /dev/null; then
        explorer.exe "$path"
    else
        echo "No file manager found"
    fi
}