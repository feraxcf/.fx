install-minecraft(){
    if command -v minecraft &> /dev/null; then
        echo "Ya esta instalado"
    else
        mpath="$HOME/.local/bin"

        echo "Creating folder"
        mkdir -p $mpath

        echo "Downloading..."
        curl 'https://launcher.mojang.com/download/Minecraft.tar.gz' --output $mpath/minecraft.tar.gz

        echo "Uncompresing..."
        last=$(pwd)
        cd $mpath
        tar -xvzf $mpath/minecraft.tar.gz
        mv $mpath/minecraft-launcher/minecraft-launcher $mpath/minecraft

        echo "Cleaning..."
        rm -rf $mpath/minecraft-launcher
        rm -f minecraft.tar.gz
        cd $last

        echo "Done!"
    fi
}