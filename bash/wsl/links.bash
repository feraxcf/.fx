export rpath="$HOME/.fx/.wsl"
mkdir -p $rpath

export PATH=$rpath:$PATH

lnk() {
    if [ -z "$1" ]; then
        echo "Usage: lnk <source.exe>"
        echo "Usage: lnk <source.exe> <target>"
        echo ""
        echo "Use \$rpath to store a custom link"
        return 1
    fi
    
    dir=$(dirname $(which $1))
    if [[ ! -d $dir ]]; then
        echo "No file found"
        return 1
    fi
    
    if [[ -z $2 ]]; then
        ln -s $dir/$1 $rpath/${1%%.*}
    else
        ln -s $dir/$1 $rpath/$2
    fi
}