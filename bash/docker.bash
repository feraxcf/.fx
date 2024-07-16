if command -v docker &> /dev/null; then
    alias aws='docker run --rm -it amazon/aws-cli'
else
    echo "Docker is not instaled is not in your path"
fi