netscan() {
    mkdir $HOME/.temp
    
    time=1
    url="$1"
    if [[ $url = "" ]]; then
        url="www.google.com"
    fi
    
    echo "Pinging at {$url} ..."
    
    try(){
        ping -w 600 $url > $HOME/.temp/net 2>&1
        if [ $? -eq 0 ]; then
            echo -e "\e[32m* ¡Conexion established!\e[0m"
        else
            echo -e "\e[31m* Error: \e[33m$(cat $HOME/.temp/net)$reset \e[0m"
        fi
    }
    
    request=0
    while true
    do
        echo ""
        echo "request: $request"
        try
        
        (( request++ ))
        sleep $time
    done
}
